package com.ydz.service.system;

import com.alibaba.fastjson.JSON;
import com.sun.tools.javac.comp.Todo;
import com.ydz.dao.advert.CheckingInvoiceMapper;
import com.ydz.dao.assignment.AssignWorkshopServicePriceMapper;
import com.ydz.dao.common.MessageMapper;
import com.ydz.dao.system.*;
import com.ydz.entity.assignment.AssignWorkshopServicePrice;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.common.Message;
import com.ydz.entity.init.DepartmentInit;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.exception.CompanyException;
import com.ydz.service.common.CommonService;
import com.ydz.util.*;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.math.BigDecimal;
import java.util.*;


@Service("companyService")
public class CompanyService {

    private final static Logger logger = Logger.getLogger(CompanyService.class);

    @Resource
    CompanyMapper companyMapper;

    @Autowired private ProductPriceMapper productPriceMapper;
    @Autowired private ComProPriceMapper comProPriceMapper;
    @Autowired private ComProPriceLevelMapper comProPriceLevelMapper;
    @Autowired private ComPartnerProPriceMapper comPartnerProPriceMapper;

    @Autowired private PartnerMapper partnerMapper;
    @Autowired private ComPartnerMapper comPartnerMapper;

    @Autowired private MessageMapper messageMapper;

    @Autowired private DepartmentInitMapper departmentInitMapper;
    @Autowired private DepartmentMapper departmentMapper;

    @Autowired private RoleInitMapper roleInitMapper;
    @Autowired private RoleMapper roleMapper;
    @Autowired private UserMapper userMapper;

    @Autowired private ComEmployeeMapper comEmployeeMapper;
    @Autowired private EmployeeMapper employeeMapper;
    
    @Resource private RoleService roleService;
    
    @Resource 
    @Lazy
    private EmployeeService employeeService;
    
    @Resource 
    @Lazy
    private PartnerService partnerService;
    @Resource private CommonService commonService;
    
    @Autowired private AssignWorkshopServicePriceMapper assignWorkshopServicePriceMapper;

    @Resource(name = "redisUtil")
    private RedisUtil redisUtil;

    /**
     * @param company
     * @param userVo
     * @param bossOrAdmin
     * @return Object
     * @throws Exception
     * @throws
     * @Title: saveCompany
     * @Description: 1. 创建企业 并把该创建者添加到用户表中
     * 2. 默认部门为总经办  001
     * 3. 初始化部门  通用行业 在部门初始化表中查询出需要初始化的数据
     * 4. 初始化角色  根据角色 在角色初始化表中查询出需要初始化的数据
     * 5. 合作伙伴操作
     */
    public Object insertNewCompany(Company company, UserVo userVo, String bossOrAdmin) throws Exception {

        PageData pageDataPara = new PageData();
        pageDataPara.put("userKey",userVo.getUserKey());
        pageDataPara.put("comName",company.getComName().trim());
        List<Company> companiesDuplicate = companyMapper.getByEmpUserKey(pageDataPara);
        if(companiesDuplicate.size() > 0){
            return null;  //判断是否创建过公司
        }

        PageData pageData = new PageData();
        pageData.put("creator",userVo.getUserKey());
        pageData.put("comType",CompanyEnum.COM_TYPE_PERSONAL.getCode()); //个人
        List<Company> companies = companyMapper.selectByComKey(pageData);
        if(companies.size() > 0 && companies.get(0).getRefereeName() != null){
            company.setRefereeName(companies.get(0).getRefereeName()); //获取邀请人
        }
        //
        
        Date nowData = new Date();
        company.setComKey(UuidUtil.get32UUID());
        company.setComId(CodeBuilderUtil.getInstance().getCompanyCode());
        company.setWithinComId(CodeBuilderUtil.getInstance().getCompanyInvitationCode());
        if (StringUtil.isNotEmpty(company.getComShortname())) {
            company.setMnemonicCode(GetPinyin.getPinYinHeadChar(company.getComShortname()).toUpperCase()); //公司简称的首字母大写作为助记码
        }
        company.setCreator(userVo.getUserKey());
        company.setIsValid("1");
        company.setComAttr(CompanyEnum.PARTNER_ATTR_COMPANY.getCode());
        company.setCreateTime(nowData);
        //公司类型 公司
        company.setComType(CompanyEnum.COM_TYPE_ENTERPRISE.getCode());

        //注册时 默认(通用行业)
        company.setIndustryId(Const.INDUSTRY_GENERAL);
        companyMapper.insertSelective(company);
        
        //公司创建成功后 更新用户表中的默认公司字段。即新建的公司总是作为默认公司
        User userPara = new User();
        userPara.setUserKey(userVo.getUserKey());
        userPara.setDefaultCom(company.getComKey());
        userMapper.updateByUserKey(userPara);
        
        Employee employee = new Employee();
        employee.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10));
        employee.setComKey(company.getComKey());
        employee.setUserKey(userVo.getUserKey());
        employee.setUserId(userVo.getUserId());
        employee.setRealName(userVo.getRealName());
        //默认部门为总经办  001
        employee.setDeptId("001");
        if ("boss".equals(bossOrAdmin)) {
            employee.setIsBoss("1");
            employee.setIsAdmin("1");
        }
        if ("admin".equals(bossOrAdmin)) {
            employee.setIsAdmin("1");
        }
        employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());//1邀请中 2待审核 3正常 4已注销
        employee.setIsValid("1");//启用
        employee.setCreator(userVo.getUserKey());
        employee.setCreateTime(nowData);
        employee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+Const.INDUSTRY_GENERAL));
		employee.setPermissionCode("");
        employeeMapper.insertSelective(employee);

        //注册时角色初始化
//        roleService.insertComRolesRegisterInit(company.getComKey(), company.getIndustryId(), userVo.getUserKey());

//        if (addResult > 0) {
//            //初始化部门  根据小行业 在部门初始化表中查询出需要初始化的数据
//            this.insertCompanyDept(Const.INDUSTRY_GENERAL, company.getComKey(), "create");
//        }
        
        //当前公司信息放入session
        //公司相关
        userVo.setComKey(company.getComKey());
        userVo.setDefaultCom(company.getComKey());
        userVo.setComName(company.getComName());
        userVo.setComShortname(company.getComShortname());
        userVo.setDetailIndustryId(company.getIndustryId());
        userVo.setComType(company.getComType());
        userVo.setComId(company.getComId());
        userVo.setIsAdmin(employee.getIsAdmin());
        userVo.setIsBoss(userVo.getIsBoss());
        userVo.setComIsvalid("1");
        return userVo;
    }


    /**
     * 
     * @Title: insertNewCompanyForInvite 
     * @param company
     * @param userVo
     * @param bossOrAdmin
     * @param sessionMap
     * @return
     * @throws Exception
     * @return Object
     * @throws 
     * @Description: 通过邀请注册公司。（邀请企业合作伙伴注册）
     *  2017年06月28日15:44:25修改逻辑：
     * 	被邀请方注册公司后自动更新邀请方的合作伙伴状态，成为合作伙伴的好友
     *  被邀请方公司的合作伙伴中增加邀请方的公司信息，自动互为好友。合作级别为普通客户，价格级别为标准价
     *  被邀请方所看到的message信息被自动agree，成为已接受邀请并记录好友状态
     *  
     */
    public void insertNewCompanyForInvite(Company company, UserVo userVo, String bossOrAdmin, Map sessionMap) throws Exception {
        Date nowDate = new Date();

//============================设置新建公司信息
        company.setComKey(UuidUtil.get32UUID());
        company.setComId(CodeBuilderUtil.getInstance().getCompanyCode());
        company.setWithinComId(CodeBuilderUtil.getInstance().getCompanyInvitationCode());
        if (StringUtil.isNotEmpty(company.getComShortname())) {
            company.setMnemonicCode(GetPinyin.getPinYinHeadChar(company.getComShortname()).toUpperCase()); //公司简称的首字母大写作为助记码
        }
        company.setCreator(userVo.getUserKey());
        company.setIsValid("1");
        company.setCreateTime(nowDate);
        //公司类型 公司
        company.setComType(CompanyEnum.COM_TYPE_ENTERPRISE.getCode());
        company.setComAttr(CompanyEnum.PARTNER_ATTR_COMPANY.getCode());
        //注册时 默认都个人（通用行业）
        company.setIndustryId(Const.INDUSTRY_GENERAL);
        Integer addResult = companyMapper.insertSelective(company); //新建公司
        
        //注册时角色初始化
        roleService.insertComRolesRegisterInit(company.getComKey(), company.getIndustryId(), userVo.getUserKey());
        
        if (addResult > 0) {
        	//初始化部门  根据小行业 在部门初始化表中查询出需要初始化的数据
        	this.insertCompanyDept(Const.INDUSTRY_GENERAL, company.getComKey(), "create");
        }
        
        //公司创建成功后 更新用户表中的默认公司字段。即新建的公司总是作为默认公司
        User userPara = new User();
        userPara.setUserKey(userVo.getUserKey());
        userPara.setDefaultCom(company.getComKey());
        userMapper.updateByUserKey(userPara);
//============================增加公司员工信息        
        //注册人作为公司管理员或老板
        Employee employee = new Employee();
        employee.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10));
        employee.setComKey(company.getComKey());
        employee.setUserKey(userVo.getUserKey());
        
        employee.setUserId(userVo.getUserId());
        employee.setRealName(userVo.getRealName());
        
        //默认部门为总经办  001
        employee.setDeptId("001");
        if ("boss".equals(bossOrAdmin)) {
            employee.setIsBoss("1");
            employee.setIsAdmin("1");
        }
        if ("admin".equals(bossOrAdmin)) {
            employee.setIsAdmin("1");
        }
        employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode()); //1邀请中 2待审核 3正常 4已注销
        employee.setIsValid("1");
        employee.setCreator(userVo.getUserKey());
        employee.setCreateTime(nowDate);
        
        employee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+Const.INDUSTRY_GENERAL));
        employee.setPermissionCode("");
        
        employeeMapper.insertSelective(employee);

//============================合作伙伴操作
       
        String comKeyInvite = (String) sessionMap.get("comKey");  //邀请方公司key
        String partnerKey = (String) sessionMap.get("partnerKey"); //被邀请方的合作伙伴Key
        
        //找到邀请方的的那条合作伙伴记录(com_partner)，
        //确认状态为互为好友 ,
        //把被邀请方的comKey维护到邀请方的partnerComKey中，并且修改对方的状态为互为好友
        PageData pageData = new PageData();
        pageData.put("comKey", comKeyInvite);
        pageData.put("partnerKey", partnerKey);
        List<ComPartner> comPartners = comPartnerMapper.selectByPrimaryKey(pageData);
        ComPartner comPartner = comPartners.get(0);
        comPartner.setStatus(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()); //互为好友
        comPartnerMapper.updateByPrimaryKeySelective(comPartner);
        //维护公司key
        Partner partnerMod = new Partner();
        partnerMod.setPartnerKey(partnerKey);
        partnerMod.setPartnerComKey(company.getComKey());
        partnerMapper.updateByPrimaryKeySelective(partnerMod);
        
//============================为当前新注册公司添加邀请方为合作伙伴
      //根据对方公司key 查询邀请方公司信息
        PageData pdCom = new PageData();
        pdCom.put("comKey", comKeyInvite);
        List<Company> companies = companyMapper.selectByComKey(pdCom);
        Company companyInvite = companies.get(0);
        
        Partner partnerAdd = new Partner();
        partnerAdd.setPartnerComKey(companyInvite.getComKey());
        partnerAdd.setPartnerLevel(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode());

        partnerAdd.setPartnerShortname(companyInvite.getComShortname());
        partnerAdd.setPartnerName(companyInvite.getComName());
        //助记码
        partnerAdd.setMnemonicCode(GetPinyin.getPinYinHeadChar(partnerAdd.getPartnerShortname()));

        partnerAdd.setPartnerTel(companyInvite.getComTel());
        partnerAdd.setPartnerAddress(companyInvite.getComAddress());
        partnerAdd.setPartnerAttr(companyInvite.getComType());
        partnerAdd.setPartnerQQ(companyInvite.getComQQ());
        
        partnerAdd.setPartnerProvince(companyInvite.getComProvince());
        partnerAdd.setPartnerCity(companyInvite.getComCity());
        partnerAdd.setPartnerCountry(companyInvite.getComCountry());
        partnerAdd.setPartnerAddress(companyInvite.getComAddress());

        EmployeeVo employeeVo1 = employeeService.getAdmin(companyInvite.getComKey());
        if(employeeVo1 != null){
            partnerAdd.setTel11(employeeVo1.getUserPhone());
            partnerAdd.setContacterName11(employeeVo1.getUserName());
        }

        EmployeeVo employeeVo2 = employeeService.getBoss(companyInvite.getComKey());
        if(employeeVo2 != null && !employeeVo2.getUserPhone().equals(employeeVo1.getUserPhone())){
            partnerAdd.setTel12(employeeVo2.getUserPhone());
            partnerAdd.setContacterName12(employeeVo2.getUserName());
        }

        partnerAdd.setPartnerKey(UuidUtil.get32UUID());
        partnerAdd.setIsValid("1");
        partnerAdd.setPartnerType(CompanyEnum.PARTNER_TYPE_ALL.getCode()); //合作伙伴的类型 即使客户又是供应商
        partnerAdd.setCreator("system");
        partnerAdd.setCreateTime(nowDate);
        partnerService.insertPartner(partnerAdd);


        ComPartner comPartnerNew = new ComPartner();
        comPartnerNew.setComKey(company.getComKey());
        comPartnerNew.setPartnerKey(partnerAdd.getPartnerKey());
        comPartnerNew.setStatus(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode());
        comPartnerNew.setIsValid("1");
        comPartnerNew.setCreateTime(nowDate);
        comPartnerNew.setCreator(userVo.getUserKey());
        partnerService.insertComPartner(comPartnerNew); //新建公司合作伙伴关系

        //添加联系人一
        if(partnerAdd.getTel11() != null){
            PartnerContacter contacter1 = partnerService.fillPartner(partnerAdd,userVo);
            partnerService.insertOnePartnerContacter(contacter1);
        }
        //添加联系人二
//        if(partnerAdd.getTel12() != null){
//            PartnerContacter contacter2 = partnerService.fillPartner(partnerAdd,userVo);
//            partnerService.insertPartnerContacter(contacter2);
//        }
        
//============================注册公司完成后产生好友申请消息，并自动agree
        Message message = new Message();
        message.setMsgId(UuidUtil.get32UUID());
        
        message.setMsgTitle("接受好友申请");
        message.setComKey(comKeyInvite);
        message.setMsgContent(companyInvite.getComName() + "申请加您(" + company.getComName() + ")为好友。");

        message.setSendKey("system");
        message.setSendName(companyInvite.getComName());
        message.setSendTime(nowDate);
        message.setAcceptComKey(company.getComKey());
        message.setStatus(MessageEnum.UNREAD.getCode()); //未读
        
        message.setType(MessageEnum.MESSAGE_TYPE_PARTNER_ALERT.getCode()); //好友申请
        message.setIsDel("0");
        
        message.setFriendStatus(MessageEnum.FRIEND_YES.getCode()); //操作状态
        message.setReason("通过邀请链接注册，系统自动同意");
        message.setCreator("system");
        message.setCreateTime(nowDate);
        messageMapper.insertSelective(message);
    }

    /**
     * 通过邀请注册的公司创建（个人类型）
     *
     * @param user
     * @param comIsValid
     * @return
     * @throws Exception
     */
    public UserVo saveNormalSignUpForInvite(User user, String comIsValid, Map sessionMap) throws Exception {
        //创建一个类型是个体商户的公司
        Date nowDate = new Date();

        Company company = new Company();
        if (StringUtil.isNotEmpty(user.getRefereeName())) {
            company.setRefereeName(user.getRefereeName());
        }
        company.setComKey(UuidUtil.get32UUID());
        company.setComId(CodeBuilderUtil.getInstance().getCompanyCode());
        company.setWithinComId(CodeBuilderUtil.getInstance().getCompanyInvitationCode());
        company.setComName(user.getRealName());
        company.setComShortname(company.getComName());
        if (StringUtil.isNotEmpty(company.getComShortname())) {
            company.setMnemonicCode(GetPinyin.getPinYinHeadChar(company.getComShortname()).toUpperCase()); //公司简称的首字母大写作为助记码
        }
        //公司类型 个人
        company.setComType(CompanyEnum.COM_TYPE_PERSONAL.getCode());
        company.setComAttr(CompanyEnum.PARTNER_ATTR_PERSONAL.getCode());
        company.setCreator(user.getUserKey());
        //新建个人类型的公司时，该字段应为 0 ，当用户在第一次选择身份后，该字段值更新为"1"
        company.setIsValid(comIsValid);
        company.setCreateTime(nowDate);
        company.setIndustryId(Const.INDUSTRY_GENERAL);
        companyMapper.insertSelective(company);
        //添加用户
        user.setDefaultCom(company.getComKey());
        userMapper.insertUser(user);

        //员工
        Employee employee = new Employee();
        employee.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10));
        employee.setComKey(company.getComKey());
        employee.setUserKey(user.getUserKey());
        employee.setUserId(user.getUserId());
        employee.setRealName(user.getRealName());
        employee.setIsBoss("1");
        employee.setIsAdmin("1");
        employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());//正常
        employee.setCreator(user.getUserKey());
        employee.setCreateTime(nowDate);
        employee.setIsValid("1");
        
        employee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+Const.INDUSTRY_GENERAL));
        employee.setPermissionCode("");
        
        employeeMapper.insertSelective(employee);

        //session中存放字段
        UserVo userVo = new UserVo();
        userVo.setUid(user.getUid());
        userVo.setUserKey(user.getUserKey());
        userVo.setUserId(user.getUserId());
        userVo.setNickName(user.getNickName());
        userVo.setRealName(user.getRealName());
        userVo.setAvatarPath(user.getAvatarPath());
        userVo.setRegisterIp(user.getRegisterIp());
        userVo.setRoleKeys("ADMIN");

        //公司相关
        userVo.setComKey(company.getComKey());
        userVo.setDefaultCom(company.getComKey());
        userVo.setComName(company.getComName());
        userVo.setComShortname(company.getComShortname());
        userVo.setDetailIndustryId(company.getIndustryId());
        userVo.setComType(company.getComType());

        //合作伙伴操作
        //邀请方公司key
        String comKeyInvite = (String) sessionMap.get("comKey");
        //被邀请放的合作伙伴Key
        String partnerKey = (String) sessionMap.get("partnerKey");
        //找到对方的那条合作伙伴记录(com_partner)，确认状态为邀请中 ,把当前公司key维护到对方记录中，并且修改对方的状态为申请中
        PageData pageData = new PageData();
        pageData.put("comKey", comKeyInvite);
        pageData.put("partnerKey", partnerKey);
        List<ComPartner> comPartners = comPartnerMapper.selectByPrimaryKey(pageData);
        if (comPartners.size() != 1) {
//            logger.warn("用戶:" + userVo.getUserKey() + "在创建公司:" + company.getComKey() + "时，合作伙伴查询<数量>出现异常.");
        }
        ComPartner comPartner = comPartners.get(0);
        //确认当前状态为邀请中
        if (!CompanyEnum.PARTNER_STATUS_INVITING.getCode().equals(comPartner.getStatus())) {
//            logger.warn("用戶:" + userVo.getUserKey() + "在创建公司:" + company.getComKey() + "时，合作伙伴查询<状态>出现异常.");
        }
        //修改状态 申请中
        comPartner.setStatus(CompanyEnum.PARTNER_STATUS_APPLYING.getCode());
        comPartnerMapper.updateByPrimaryKeySelective(comPartner);
        //维护公司key
        Partner partnerMod = new Partner();
        partnerMod.setPartnerKey(partnerKey);
        partnerMod.setPartnerComKey(company.getComKey());
        partnerMapper.updateByPrimaryKeySelective(partnerMod);
        //根据对方公司key 查询对方公司信息
        PageData pdCom = new PageData();
        pdCom.put("comKey", comKeyInvite);
        List<Company> companies = companyMapper.selectByComKey(pdCom);
        Company companyInvite = companies.get(0);
        //发送消息
        //产生消息
        Date date = new Date();
        //发送消息模块
        Message message = new Message();
        message.setMsgId(UuidUtil.get32UUID());
        message.setMsgTitle("接受好友申请");

        message.setComKey(comKeyInvite);
        message.setMsgContent(companyInvite.getComName() + "申请加您(" + company.getComName() + ")为好友。");

        message.setSendKey("system");
        message.setSendName(companyInvite.getComName());
        message.setSendTime(date);
        message.setAcceptComKey(company.getComKey());
        message.setStatus(MessageEnum.UNREAD.getCode());
        //好友申请
        message.setType(MessageEnum.MESSAGE_TYPE_PARTNER_ALERT.getCode());
        message.setIsDel("0");
        //操作状态
        message.setFriendStatus("0");
        message.setCreator("system");
        message.setCreateTime(date);
        messageMapper.insertSelective(message);

        return userVo;
    }

    /**
     * @param industryId
     * @param comKey
     * @param type       upgrade/create
     * @return int
     * @throws
     * @Title: insertCompanyDept
     * @Description: 插入公司部门表
     * 1.如果type=upgrade时，表示升级行业，升级时需要删除原有的部门
     * 2.如果type=create时，表示新建企业，直接插入部门即可
     */
    public int insertCompanyDept(String industryId, String comKey, String type) {
        Date nowData = new Date();

        PageData pdPara = new PageData();
        if (StringUtil.isNotEmpty(type)
                && "upgrade".equalsIgnoreCase(type)) {
            //删除原有通用行业的部门
            pdPara.put("comKey", comKey);
            departmentMapper.deleteByPrimaryKey(pdPara);
        }

        //根据行业获取初始化的部门并写入公司部门表
        pdPara.put("comKey", null);
        pdPara.put("industryId", industryId);
        List<DepartmentInit> departmentInits = departmentInitMapper.selectByPrimaryKey(pdPara);
        int deptResult = 0;
        for (int i = 0; i < departmentInits.size(); i++) {
            DepartmentInit departmentInit = departmentInits.get(i);
            Department department = new Department();
            department.setDeptId(departmentInit.getDeptId());
            department.setDeptName(departmentInit.getDeptName());
            department.setSortItem(departmentInit.getSortItem());
            department.setComKey(comKey);
            department.setIsValid("1");
            department.setCreateTime(nowData);
            int num = departmentMapper.insertSelective(department);
            deptResult = deptResult + num;
        }

        return deptResult;
    }

    /**
     * @param withinComId 或 comKey 或 comId
     * @return Company
     * @throws Exception
     * @throws
     * @Title: getCompanyByKey
     * @Description: 通过 withinComId 或 comKey 或 comId 查询公司。带省市县名称
     */
    public Company getCompanyByKey(PageData pd) {
        PageData pdPara = new PageData();
        if (StringUtil.isNotEmpty(pd.getString("withinComId"))) {
            pdPara.put("withinComId", pd.getString("withinComId"));
        }
        if (StringUtil.isNotEmpty(pd.getString("comKey"))) {
            pdPara.put("comKey", pd.getString("comKey"));
        }
        if (StringUtil.isNotEmpty(pd.getString("comId"))) {
            pdPara.put("comId", pd.getString("comId"));
        }
        if (StringUtil.isNotEmpty(pd.getString("comType"))) {
            pdPara.put("comType", pd.getString("comType"));
        }
        if (StringUtil.isNotEmpty(pd.getString("comProvince"))) {
            pdPara.put("comProvince", pd.getString("comProvince"));

        }
        return companyMapper.selectByPrimaryKey(pdPara);
    }

    /**
     * @param comKey
     * @return Company
     * @throws Exception
     * @throws
     * @Title: getCompanyByUserKey
     * @Description: 根据comKey获取公司对象
     */
    public Company getCompanyByUserKey(String comKey) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("comKey", comKey);
        List<Company> companies = companyMapper.selectByComKey(pdPara);
        return companies != null && companies.size() == 1 ? companies.get(0) : null;
    }

    /**
     * @param comKey
     * @return Company
     * @throws Exception
     * @throws
     * @Title: getComLogoByKey
     * @Description: 根据comKey获取公司logo信息
     */
    public Company getComLogoByKey(String comKey) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("comKey", comKey);
        return companyMapper.selectComLogoByKey(pdPara);
    }


    /**
     * @param userKey
     * @return List<Company>
     * @throws Exception
     * @throws
     * @Title: getComByUserKey
     * @Description: 根据userKey获取所创建的公司
     */
    public List<Company> getCompaniesByUserKey(String userKey) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("creator", userKey);
        return companyMapper.selectByComKey(pdPara);
    }
    
    /**
     * 
     * @Title: listAllCompanies 
     * @return
     * @return List<Company>
     * @throws 
     * @Description: 查询所有的有效公司，包括个人和企业
     */
    public List<Company> listAllCompanies(){
    	PageData pdPara = new PageData();
    	return companyMapper.selectByComKey(pdPara);
    }
    public List<Company> listEnterpriseCompanies(){
    	PageData pdPara = new PageData();
    	pdPara.put("comType", CompanyEnum.COM_TYPE_ENTERPRISE.getCode());
    	return companyMapper.selectByComKey(pdPara);
    }

    /**
     * @param company
     * @return Integer
     * @throws Exception
     * @throws
     * @Title: updateCompany
     * @Description: 更新公司信息
     */
    public int updateCompany(Company company) throws Exception {
        return companyMapper.updateByPrimaryKeySelective(company);
    }
    
    /**
     * 
     * @Title: updateCompanyAndAll 
     * @param company
     * @return
     * @throws Exception
     * @return int
     * @throws 
     * @Description: 更新公司信息，同时更新相关的其他表中使用了comName和comShortname的信息
     * 
     */
    public int updateCompanyAndAll(Company company) throws Exception{
    	int result = this.updateCompany(company);
    	return result;
    }

    /**
     * @param userVo
     * @return List<Company>
     * @throws Exception
     * @throws
     * @Title: getCompanyByUserKey
     * @Description: 获取该用户所属的所有公司
     */
    public List<Company> getByEmpUserKey(UserVo userVo) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("userKey", userVo.getUserKey());
        return companyMapper.getByEmpUserKey(pdPara);
    }


    public List<ComEmployee> getComEmployee(PageData pd) throws Exception {
        return comEmployeeMapper.selectByPrimaryKey(pd);
    }
    
    public ComEmployee getOneComEmployee(String comKey,String userKey) throws Exception {
    	PageData pd = new PageData();
    	pd.put("comKey",comKey);
        pd.put("userKey",userKey);
    	List<ComEmployee> employees = comEmployeeMapper.selectByPrimaryKey(pd);
    	if(employees!=null&&employees.size()>=0){
    		return employees.get(0);
    	}else{
    		return null;
    	}
    }


    public List<Company> getByDirector(PageData pageData) {
        return companyMapper.getByDirector(pageData);
    }

    public List<CompanyVO> getByRefereeName(PageData pageData) {
        return companyMapper.getByRefereeName(pageData);
    }

    /**
     * @param pageData comId, comName
     * @return Company
     * @throws Exception
     * @throws
     * @Title: getByComId
     * @Description: 合作伙伴查询使用
     */
    public Company getByComId(String comId) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("comId", comId);
        List<Company> companies = companyMapper.getByComId(pdPara);
        return companies != null && companies.size() == 1 ? companies.get(0) : null;

    }

    public List<Company> getByComName(String comName) throws Exception {
        PageData pdPara = new PageData();
        pdPara.put("comName", comName);
        return companyMapper.getByComId(pdPara);
    }

    /**
     * @param @param  pd
     * @param @return
     * @param @throws Exception
     * @return List<ComProPrice>
     * @throws
     * @Title: listComProPrice
     * @Description: 根据参数 industryId，comKey，pricingType获取公司服务定价列表
     */
//    public List<ComProPrice> listComProPrice(PageData pd) throws Exception {
//        PageData pdPara = new PageData();
//        pdPara.put("industryId", pd.getString("industryId"));
//        pdPara.put("comKey", pd.getString("comKey"));
//        pdPara.put("pricingType", pd.getString("pricingType"));
//        pdPara.put("tier", pd.getString("tier"));
//        if (pd.getString("pCodeComPro") != null) {
//            pdPara.put("pCodeComPro", pd.getString("pCodeComPro"));
//        }
//        if (pd.getString("pCodeTop") != null) {
//            pdPara.put("pCodeTop", pd.getString("pCodeTop"));
//        }
//        return comProPriceMapper.listComProPrice(pdPara);
//    }
    
    /**
     * @param @param  pd
     * @param @return
     * @param @throws Exception
     * @return List<ProductPrice>
     * @throws
     * @Title: listAllProductPrice
     * @Description: pd.put("industryId", "1C");
     * pd.put("pricingType", "1");
     * pd.put("pCodeTop", "0");
     * pd.put("comKey", "d1e704269bd646e79a8186f07c26098f");
     * pd.put("partnerKey", "8f295af258c040ff9fe305a7942ca1bc");
     */

    //修改处理，优化加载速度
//    @SuppressWarnings("unchecked")
//    public List<ComProPriceVO> listAllProductPrice(PageData pd) throws Exception {
//        List<ComProPriceVO> cppvos1 = null;
//        if (cppvos1 == null) {
//            //获取第一层级
//            cppvos1 = productPriceMapper.listFastProductPrice(pd);
//            pd.put("pCodeTop", null);
//            for (ComProPriceVO cppvo1 : cppvos1) {
//                pd.put("pCode", cppvo1.getCategoryId());
//                cppvo1.setComKey(pd.getString("comKey"));
//                cppvo1.setPartnerKey(pd.getString("partnerKey"));
//                List<ComProPriceVO> cppvos2 = productPriceMapper.listFastProductPrice(pd); //获取第二层级
//                cppvo1.setComProPriceVOs(cppvos2);
//                for (ComProPriceVO cppvo2 : cppvos2) {
//                    pd.put("pCode", cppvo2.getCategoryId());
//                    cppvo2.setComKey(pd.getString("comKey"));
//                    cppvo2.setPartnerKey(pd.getString("partnerKey"));
//                    List<ComProPriceVO> cppvos3 = productPriceMapper.listFastProductPriceUnion(pd); //获取第三层级
//                    cppvo2.setComProPriceVOs(cppvos3);
//                }
//            }
//        }
//        return cppvos1;
//    }

    /**
     * @param pd
     * @return List<ComProPriceVO>
     * @throws
     * @Title: listProductPriceLevel
     * @Description: 获取指定层级的产品定价列表
     * pd.put("industryId", "1C");
     * pd.put("pricingType", "1");
     * pd.put("tier", "3");
     */

    public List<ComProPriceVO> listProductPriceLevel(PageData pd) {
        List<ComProPriceVO> cppvos = productPriceMapper.listFastProductPrice(pd);
        return cppvos;
    }

    /**
     * @param @param  cpps
     * @param @throws Exception
     * @return void
     * @throws
     * @Title: insertBatchComProPrice
     * @Description: 批量插入选择的服务定价要素
     */
    public void insertBatchComProPrice(List<ComProPrice> records)
            throws Exception {
        comProPriceMapper.insertBatch(records);
    }

    /**
     * @param @param  cppls
     * @param @throws Exception
     * @return void
     * @throws
     * @Title: insertBatchComProPriceLevel
     * @Description: 批量插入服务定价要素的三种价格级别
     */
    public void insertBatchComProPriceLevel(List<ComProPriceLevel> cppls)
            throws Exception {
        comProPriceLevelMapper.insertBatch(cppls);
    }

    public void deleteComProPrice(PageData pd)
            throws Exception {
        comProPriceMapper.deleteAllCompany(pd);
    }

    public void deleteComProPriceLevel(PageData pd)
            throws Exception {
        comProPriceLevelMapper.deleteAllCompany(pd);
    }

    /**
     * @param pd industryId，comKey
     * @return void
     * @throws Exception
     * @throws
     * @Title: insertInitComServicePrice
     * @Description: 初始化注册公司的服务定价列表
     */
    public void insertInitComServicePrice(PageData pd) throws Exception {
        List<ComProPrice> cpps = new ArrayList<ComProPrice>();
        List<ComProPriceLevel> cppls = new ArrayList<ComProPriceLevel>();
        
        Date nowDate = new Date();
        try {
        	ComProPrice cpp = null;
        	ComProPriceLevel cppl = null;
	        List<ProductPrice> productPricesInit = this.listAllProductPriceInit(pd.getString("industryId"), CompanyEnum.PRICING_TYPE_SERVICE.getCode());
	        for (ProductPrice productPrice : productPricesInit) {
	        	cpp = new ComProPrice();
	        	BeanutilsCopy.apacheCopyProperties(cpp, productPrice);
                cpp.setComKey(pd.getString("comKey"));
                cpp.setCreateType("0");
                cpp.setCreateTime(nowDate);
                if (cpp.getTier()==2) {
                	for (int i = 1; i <= 3; i++) {
                		cppl = new ComProPriceLevel();
                		cppl.setCategoryId(cpp.getCategoryId());
                		cppl.setComKey(pd.getString("comKey"));
                		cppl.setIndustryId(pd.getString("industryId"));
                		cppl.setPriceLevel(Integer.toString(i));
                		cppl.setCreateTime(nowDate);
                		cppls.add(cppl);
                	}
				}
                cpp.setIsChecked("1");
                cpps.add(cpp);
          }
          this.insertBatchComProPrice(cpps);
          this.insertBatchComProPriceLevel(cppls);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cpps.clear();
			cppls.clear();
		}
    }

    /**
     * @param pd comKey,priceLevel,pricingType,tier
     * @return List<ComProPrice>
     * @throws
     * @Title: selectComProPricesToExcel
     * @Description: TODO(这里用一句话描述这个方法的作用)
     */
    public List<ComProPrice> selectComProPricesToExcel(PageData pd) {
        return comProPriceMapper.selectComProPricesToExcel(pd);
    }

    /**
     * @param comKey
     * @return CompanyVO
     * @throws Exception
     * @throws
     * @Title: selectOrderDetailCompany
     * @Description: 获取公司的订单详情页中底部信息
     */
    public CompanyVO selectOrderDetailCompany(String comKey,String partnerKey) throws Exception {
        PageData pdData = new PageData();
        pdData.put("comKey", comKey);
        if(StringUtil.isNotEmpty(partnerKey)){
        	pdData.put("partnerKey", partnerKey);
        }
        CompanyVO companyVO = companyMapper.selectOrderDetailCompany(pdData);
        if (companyVO!=null) {
        	String area = companyVO.getAreaCode() != null?companyVO.getAreaCode():"";
        	area = area + "-";
        	String tel = companyVO.getComTel() != null?companyVO.getComTel():"";
            companyVO.setComTel(area+tel);
            
            if(StringUtil.isEmpty(companyVO.getComTel())){
            	companyVO.setComTel(" - ");
            }
            if (StringUtil.isEmpty(companyVO.getComQQ())) {
				companyVO.setComQQ(" - ");
			}
            if (StringUtil.isEmpty(companyVO.getComAddress())) {
				companyVO.setComAddress(" - ");
			}
        }
        return companyVO;
    }

    /**
     * @param pd comKey, userKey
     * @return String
     * @throws
     * @Title: insertTempComPartner
     * @Description: 创建公司初始化时为公司分配一家过路客
     */
    public int insertTempComPartner(PageData pd) {
        if (StringUtil.isEmpty(pd.getString("comKey"))) {
            return 0;
        }
        try {
            ComPartner cpTemp = new ComPartner();
            cpTemp.setComKey(pd.getString("comKey"));
            cpTemp.setPartnerKey("temp-customer");
            cpTemp.setIsValid("1");
            cpTemp.setStatus("0");
            cpTemp.setCreator(pd.getString("userKey"));
            cpTemp.setCreateTime(new Date());
            comPartnerMapper.insertSelective(cpTemp);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

        return 1;
    }
    
    /**
     * 
     * @Title: insertInitExpenseTypes 
     * @param pd
     * @return
     * @throws Exception
     * @return int
     * @throws 
     * @Description: 公司初始化费用类型值。
     */
    public int insertInitExpenseTypes(PageData pd){
    	int result = 0;
    	String expenseTypeString = commonService.getDictValue("EXPENSE_TYPE");
    	if(StringUtil.isEmpty(expenseTypeString)){
    		return 0;
    	}
		List<ComSettingClass> comSettingClasses = JSON.parseArray(expenseTypeString, ComSettingClass.class);
		if (comSettingClasses!=null&&comSettingClasses.size()>0) {
			for (ComSettingClass comSettingClass : comSettingClasses) {
				comSettingClass.setComKey(pd.getString("comKey"));
				comSettingClass.setIndustryId(pd.getString("industryId"));
				comSettingClass.setSettingClass(Const.COMPANY_SETTING_CLASS_PREFIX_STRING+comSettingClass.getSettingClass());
				comSettingClass.setIsDel("0");
			}
			try {
				result = commonService.insertListComSettingClass(comSettingClasses);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}
    	return result;
    }
    
    //初始化媒体资源业务的媒体资源类型和表现形式 
    public int insertInitMediaSetting(PageData pd) throws Exception{
    	int result = 0;
    	//初始化媒体资源类型
    	String mediaSettingJson = commonService.getDictValue("MEDIA_TYPE");
    	if (StringUtil.isEmpty(mediaSettingJson)) {
			return 0;
		}
    	List<ComSettingClass> comSettingClasses = JSON.parseArray(mediaSettingJson, ComSettingClass.class);
		if (comSettingClasses!=null&&comSettingClasses.size()>0) {
			for (ComSettingClass comSettingClass : comSettingClasses) {
				comSettingClass.setComKey(pd.getString("comKey"));
				comSettingClass.setIndustryId(pd.getString("industryId"));
				comSettingClass.setSettingClass("MEDIA_TYPE");
				comSettingClass.setIsDel("0");
			}
			try {
				result = commonService.insertListComSettingClass(comSettingClasses);
			} catch (Exception e) {
				logger.error(e.getMessage());
				throw new CompanyException("初始化媒体资源类型失败");
			}
		}
    	//初始化媒体资源表现形式
		mediaSettingJson = commonService.getDictValue("MEDIA_SHOW");
    	if (StringUtil.isEmpty(mediaSettingJson)) {
			return 0;
		}
    	comSettingClasses = JSON.parseArray(mediaSettingJson, ComSettingClass.class);
		if (comSettingClasses!=null&&comSettingClasses.size()>0) {
			for (ComSettingClass comSettingClass : comSettingClasses) {
				comSettingClass.setComKey(pd.getString("comKey"));
				comSettingClass.setIndustryId(pd.getString("industryId"));
				comSettingClass.setSettingClass("MEDIA_SHOW");
				comSettingClass.setIsDel("0");
			}
			try {
				result = commonService.insertListComSettingClass(comSettingClasses);
			} catch (Exception e) {
				logger.error(e.getMessage());
				throw new CompanyException("初始化媒体资源表现形式失败");
			}
		}
		return result;
    }
    
//    ==============修改新版服务定价==========================
    
    /**
     * 
     * @Title: listAllProductPriceInit 
     * @param industryId
     * @param pricingType
     * @return
     * @return List<ProductPrice>
     * @throws 
     * @Description: 根据行业和定价类型查询所有的服务定价
     */
    public List<ProductPrice> listAllProductPriceInit(String industryId, String pricingType){
    	PageData pd = new PageData();
    	pd.put("industryId", industryId);
    	pd.put("pricingType", pricingType);
    	return productPriceMapper.listAllProductPriceInit(pd);
    }
    
    /**
     * 
     * @Title: insertComProPriceByInit 
     * @param productPriceInits
     * @param comKey
     * @return
     * @throws Exception
     * @return int
     * @throws 
     * @Description: 将初始化的服务定价数据插入公司的服务定价库中
     */
//    public int insertComProPriceByInit(List<ProductPrice> productPriceInits,String comKey) throws Exception{
//    	int result = 0;
//    	if(productPriceInits==null||productPriceInits.size()==0){
//    		return 0;
//    	}
//    	Date nowDate = new Date();
//    	ComProPrice comProPrice = null;
//    	List<ComProPrice> comProPriceList = new ArrayList<>();
//    	
//    	ComProPriceLevel cppl = null;
//    	List<ComProPriceLevel> cppls = new ArrayList<>();
//    	for (ProductPrice productPrice : productPriceInits) {
//			comProPrice = new ComProPrice();
//			BeanutilsCopy.apacheCopyProperties(comProPrice, productPrice);
//			comProPrice.setComKey(comKey);
//			comProPrice.setCreateTime(nowDate);
//			comProPrice.setCreateType("0");
//			if(comProPrice.getTier()==3){ //第三级需要插入价格分类
//				for(int i=1;i<=3;i++){
//					cppl = new ComProPriceLevel();
//					cppl.setComKey(comKey);
//					cppl.setCategoryId(comProPrice.getCategoryId());
//					cppl.setCreateTime(nowDate);
//					cppl.setSortItem(i);
//					if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(Integer.toString(i))){
//						cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_VIP.getCode());
//						cppl.setUnitPrice(BigDecimal.ZERO);
//					}else if(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(Integer.toString(i))){
//						cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode());
//						cppl.setUnitPrice(BigDecimal.ZERO);
//					}else if(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(Integer.toString(i))){
//						cppl.setPriceLevel(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode());
//						cppl.setUnitPrice(BigDecimal.ZERO);
//					}
//					cppl.setIndustryId(comProPrice.getIndustryId());
//					cppls.add(cppl);
//				}
//			}
//			comProPriceList.add(comProPrice);
//		}
//    	
//    	this.insertBatchComProPrice(comProPriceList);
//    	this.insertBatchComProPriceLevel(cppls);
//    	
//    	
//    	return result;
//    }
    
    /**
     * 
     * @Title: listComProPrice 
     * @param industryId
     * @param comKey
     * @param categoryId
     * @return
     * @return List<ComProPrice>
     * @throws Exception 
     * @throws 
     * @Description: 根据行业，公司，定价分类，服务编码获取下级分类的服务定价
     */
    public List<ComProPrice> listComProPrice(String industryId,String comKey,String pricingType, 
    		String pCode,String isChecked,String searchKey) 
    		throws Exception{
    	PageData pd = new PageData();
    	pd.put("industryId", industryId);
    	pd.put("comKey", comKey);
    	pd.put("pricingType", pricingType);
    	pd.put("pCode", pCode);
    	pd.put("isChecked", isChecked);
    	pd.put("searchKey", searchKey);
    	List<ComProPrice> comProPriceList =comProPriceMapper.listComProPrice(pd);//第一级
    	return comProPriceList;
    }
    
    /**
     * 
     * @Title: listComProPriceAndPriceLevel 
     * @param industryId
     * @param comKey
     * @param pricingType
     * @param pCode
     * @param categoryDesc
     * @param tier
     * @param partnerLevel
     * @return
     * @return List<ComProPrice>
     * @throws 
     * @Description: 根据行业，公司，定价分类，服务编码获取下级分类的服务定价，本方法包含第三级的价格分类。并根据客户级别进行价格处理
     */
    public List<ComProPrice> listComProPriceAndPriceLevel(String industryId, String comKey, String pricingType, 
    		String pCode, String categoryDesc, String tier,String partnerLevel){
    	PageData pd = new PageData();
    	pd.put("industryId", industryId);
    	pd.put("comKey", comKey);
    	pd.put("pricingType", pricingType);
    	pd.put("pCode", pCode);
    	pd.put("categoryDesc", categoryDesc);
    	pd.put("tier",tier);
    	List<ComProPrice> comProPrices = comProPriceMapper.selectComProPriceAndPriceLevel(pd);
    	if(comProPrices!=null&&comProPrices.size()>0){
    		for (ComProPrice comProPrice : comProPrices) {
				List<ComProPriceLevel> cppls = comProPrice.getComProPriceLevels();
				for (ComProPriceLevel cppl : cppls) {
					if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(cppl.getPriceLevel())){
						comProPrice.setPrice1(cppl.getUnitPrice());
					}else if (CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(cppl.getPriceLevel())) {
						comProPrice.setPrice2(cppl.getUnitPrice());
					}else if (CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(cppl.getPriceLevel())) {
						comProPrice.setPrice3(cppl.getUnitPrice());
					}
					if (cppl.getPriceLevel().equalsIgnoreCase(partnerLevel)) {
						comProPrice.setUnitPrice(cppl.getUnitPrice());
					}
				}
				
			}
    	}
    	return comProPrices;
    }
    
    /**
     * 
     * @Title: insertNewComProPrice 
     * @param comProPrice
     * @return
     * @return int
     * @throws Exception 
     * @throws 
     * @Description: 用户创建新的服务定价记录
     * 1.新建第一级第二级时直接操作
     * 2.新建第三级时候需要插入价格分类
     */
    public int insertNewComProPrice(ComProPrice comProPrice,int tier) throws Exception{
    	int result = 0;
    	if(tier==2){
    		ComProPriceLevel cppl = null;
        	List<ComProPriceLevel> cppls = new ArrayList<>();
    		for(int i=1;i<=3;i++){
				cppl = new ComProPriceLevel();
				cppl.setComKey(comProPrice.getComKey());
				cppl.setCategoryId(comProPrice.getCategoryId());
				cppl.setCreateTime(comProPrice.getCreateTime());
				cppl.setSortItem(i);
				if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_VIP.getCode());
					cppl.setUnitPrice(comProPrice.getPrice1());
				}else if(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode());
					cppl.setUnitPrice(comProPrice.getPrice2());
				}else if(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode());
					cppl.setUnitPrice(comProPrice.getPrice3());
				}
				cppl.setIndustryId(comProPrice.getIndustryId());
				cppls.add(cppl);
			}
    		this.insertBatchComProPriceLevel(cppls);
    		//检查是否存在专有客户，如果有的情况下需要为所有配置专有客户的部分添加新的服务定价,仅限于第2级
    		List<ComPartnerProPrice> cppps = this.selectComParnter(comProPrice.getComKey(),null);
			List<ComPartnerProPrice> newcppps = new ArrayList<ComPartnerProPrice>();
	    	ComPartnerProPrice newcppp = null;
			if(cppps!=null&&cppps.size()>0){
				for (ComPartnerProPrice cppp : cppps) {
					newcppp = new ComPartnerProPrice();
					newcppp.setComKey(comProPrice.getComKey());
					newcppp.setPartnerKey(cppp.getPartnerKey());
					newcppp.setCategoryId(comProPrice.getCategoryId());
					newcppp.setPricingType(comProPrice.getPricingType());
					newcppp.setIsChecked(comProPrice.getIsChecked());
					newcppp.setCreateTime(comProPrice.getCreateTime());
					newcppp.setPartnerLevel(cppp.getPartnerLevel());
					if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(cppp.getPartnerLevel())) {
						newcppp.setUnitPrice(comProPrice.getPrice1());
					} else if (CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(cppp.getPartnerLevel())) {
						newcppp.setUnitPrice(comProPrice.getPrice2());
					} else if (CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(cppp.getPartnerLevel())) {
						newcppp.setUnitPrice(comProPrice.getPrice3());
					}
					newcppps.add(newcppp);
				}
				this.insertComPartnerProPrice(newcppps); //为已经成为专有客户服务定价的客户批量插入新增的第2级定价
			}
			result= comProPriceMapper.insertSelective(comProPrice);
    	}else{
    		result = comProPriceMapper.insertSelective(comProPrice);
    	}
    	this.clearRedisComProPrice(comProPrice.getComKey(), comProPrice.getPartnerKey());
    	return result;
    }
    
    /**
     * 
     * @Title: updateComProPrice 
     * @param comProPrice
     * @return
     * @throws Exception
     * @return int
     * @throws 
     * @Description: 修改服务定价
     * 1.修改第一级第二级的时候直接修改
     * 2.修改第三级的时候，需要构造新的价格记录，先删除原有的价格，再插入新的价格
     */
    public int updateComProPrice(ComProPrice comProPrice) throws Exception{
    	int result = 0;
    	int tier = comProPrice.getTier();
    	if(tier==2){
    		ComProPriceLevel cppl = null;
        	List<ComProPriceLevel> cppls = new ArrayList<>();
    		for(int i=1;i<=3;i++){
				cppl = new ComProPriceLevel();
				cppl.setComKey(comProPrice.getComKey());
				cppl.setCategoryId(comProPrice.getCategoryId());
				cppl.setCreateTime(new Date());
				cppl.setSortItem(i);
				if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_VIP.getCode());
					cppl.setUnitPrice(comProPrice.getPrice1());
				}else if(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode());
					cppl.setUnitPrice(comProPrice.getPrice2());
				}else if(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(Integer.toString(i))){
					cppl.setPriceLevel(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode());
					cppl.setUnitPrice(comProPrice.getPrice3());
				}
				cppl.setIndustryId(comProPrice.getIndustryId());
				cppls.add(cppl);
			}
    		PageData pd = new PageData();
    		pd.put("comKey", comProPrice.getComKey());
    		pd.put("industryId", comProPrice.getIndustryId());
    		pd.put("categoryId", comProPrice.getCategoryId());
    		comProPriceLevelMapper.deleteByPrimaryKey(pd); //删除原有的价格
    		this.insertBatchComProPriceLevel(cppls); //插入新的价格
    		result = comProPriceMapper.updateByPrimaryKeySelective(comProPrice);
    	}else if (tier==1) {
    		PageData pd = new PageData();
    		pd.put("comKey", comProPrice.getComKey());
    		pd.put("industryId", comProPrice.getIndustryId());
    		pd.put("categoryId", comProPrice.getCategoryId());
    		pd.put("pricingType", CompanyEnum.PRICING_TYPE_SERVICE.getCode());
    		ComProPrice comProPriceNew = comProPriceMapper.selectByPrimaryKey(pd); //查询最新的服务定价内容
    		
    		result = comProPriceMapper.updateByPrimaryKeySelective(comProPrice); //修改一级服务定价的内容
    		
    		if (!comProPriceNew.getIsChecked()
    				.equalsIgnoreCase(comProPrice.getIsChecked())) { //如果修改了是否选中，则需要修改其下的二级服务及专有定价
    			pd.put("pCode", comProPrice.getCategoryId());
    			pd.put("categoryId", null);
    			pd.put("isChecked", comProPrice.getIsChecked());
    			result = comProPriceMapper.updateByPrimaryKey(pd); //修改二级目录的isChecked
    			
    			pd.clear();
    			pd.put("comKey", comProPrice.getComKey());
        		pd.put("industryId", comProPrice.getIndustryId());
        		pd.put("pricingType", CompanyEnum.PRICING_TYPE_SERVICE.getCode());
        		pd.put("pCode", comProPrice.getCategoryId());
    			List<ComProPrice> comProPrices = comProPriceMapper.listComProPrice(pd);
    			List<String> categoryIdIns = null;
    			if(comProPrices!=null&&comProPrices.size()>0){
    				categoryIdIns = new ArrayList<>();
    				for (ComProPrice comProPrice2 : comProPrices) {
    					categoryIdIns.add(comProPrice2.getCategoryId());
    				}
    				
    				pd.put("categoryIdIns", Tools.strSqlIn(Tools.list2InString(categoryIdIns)));
    				pd.put("isChecked", comProPrice.getIsChecked());
    				comPartnerProPriceMapper.updateByPrimaryKey(pd); //修改公司的所有客户专有定价的isChecked
    			}
				
			}
    		
    	}
    	this.clearRedisComProPrice(comProPrice.getComKey(), comProPrice.getPartnerKey());
    	return result;
    }
    
    /**
     * 
     * @Title: getNewCategoryIdByMax 
     * @param comKey
     * @param pCode
     * @param industryId
     * @param pricingType
     * @param partnerKey
     * @return
     * @return String
     * @throws 
     * @Description: 根据参数条件获取本级别最大的categoryId编号+1后得到最新的categoryId
     */
    public String getNewCategoryIdByMax(String comKey,String pCode,String industryId,
    		String pricingType,String partnerKey){
    	String newCategoryId = null;
    	PageData pd = new PageData();
    	pd.put("industryId", industryId);
    	pd.put("comKey", comKey);
    	pd.put("pricingType", pricingType);
    	pd.put("pCode", pCode);
    	pd.put("partnerKey", partnerKey);
    	ComProPrice comProPrice = comProPriceMapper.selectMaxCategoryId(pd);
    	if(comProPrice!=null){
    		String maxCategoryIdStr = comProPrice.getMaxCategoryId();
    		int maxCategoryId = new Integer(maxCategoryIdStr.substring(maxCategoryIdStr.length()-2, maxCategoryIdStr.length()))
										.intValue();
			maxCategoryId = maxCategoryId+1;
			if(maxCategoryId>=10){
				newCategoryId = maxCategoryIdStr.substring(0, maxCategoryIdStr.length()-2)+maxCategoryId;
			}else if(maxCategoryId<10){
				newCategoryId = maxCategoryIdStr.substring(0, maxCategoryIdStr.length()-2)+"0"+maxCategoryId;
			}
    		
    	}else {
    			newCategoryId = pCode+"01"; //如果为null表示这一级为新建，默认序号从01开始
		}
    	return newCategoryId;
    }
    
    
    /**
     * 
     * @Title: insertListComPartnerProPrice 
     * @param comPartnerProPrices
     * @return
     * @return int
     * @throws 
     * @Description: 插入公司客户单独服务定价表。支持批量插入或单条插入
     */
    public int insertComPartnerProPrice(List<ComPartnerProPrice> comPartnerProPrices){
    	int result = 0;
    	if (comPartnerProPrices.size()>1) {
			result = comPartnerProPriceMapper.insertList(comPartnerProPrices);
		} else {
			result = comPartnerProPriceMapper.insertSelective(comPartnerProPrices.get(0));
		}
    	ComPartnerProPrice cppp = comPartnerProPrices.get(0);
    	this.clearRedisComProPrice(cppp.getComKey(), cppp.getPartnerKey());
    	return result;
    }
    
    /**
     * 
     * @Title: updateComPartnerProPrice 
     * @param comPartnerProPrice
     * @return
     * @return int
     * @throws 
     * @Description: 公司客户单独服务定价表
     */
    public int updateComPartnerProPrice(ComPartnerProPrice comPartnerProPrice){
    	return comPartnerProPriceMapper.updateByPrimaryKeySelective(comPartnerProPrice);
    }
    
    /**
     * 
     * @Title: selectComParnter 
     * @param comKey
     * @param partnerKey
     * @return
     * @return List<ComPartnerProPrice>
     * @throws 
     * @Description: 去重查询已经存在的专有客户服务定价的专有客户列表
     */
    public List<ComPartnerProPrice> selectComParnter(String comKey,String partnerKey){
    	PageData pd = new PageData();
    	pd.put("comKey", comKey);
    	pd.put("partnerKey", partnerKey);
    	return comPartnerProPriceMapper.selectComParnter(pd);
    }
    
    /**
     * 
     * @Title: listComPartnerProPriceAndPriceLevel 
     * @param industryId
     * @param comKey
     * @param partnerKey
     * @param pricingType
     * @return
     * @return List<ComProPrice>
     * @throws 
     * @Description: 综合查询专有客户定价列表，只查询第三级价格，并获取公共定价部分的三类价格，根据专有客户的级别获取参考价
     */
    public List<ComProPrice> listComPartnerProPriceAndPriceLevel(String industryId, String comKey,String partnerKey,
    		String pCode, String searchKey, String pricingType){
    	PageData pd = new PageData();
    	pd.put("industryId", industryId);
    	pd.put("comKey", comKey);
    	pd.put("partnerKey", partnerKey);
    	pd.put("pricingType", CompanyEnum.PRICING_TYPE_SERVICE.getCode());
    	pd.put("pCode", pCode);
    	pd.put("searchKey", searchKey);
    	List<ComProPrice> comProPrices = comProPriceMapper.selectComPartnerProPriceAndPriceLevel(pd);
    	for (ComProPrice comProPrice : comProPrices) {
    		List<ComProPriceLevel> cppls = comProPrice.getComProPriceLevels();
			for (ComProPriceLevel cppl : cppls) {
				if (cppl.getPriceLevel().equalsIgnoreCase(comProPrice.getPartnerLevel())) {
					comProPrice.setRefUnitPrice(cppl.getUnitPrice()); //参考价
				}
			}
			comProPrice.setComProPriceLevels(null);
		}
    	return comProPrices;
    }
    
    /**
     * 
     * @Title: getMapComPartnerProPriceAndPriceLevel 
     * @param industryId
     * @param comKey
     * @param partnerKey
     * @param pCode
     * @param searchKey
     * @param pricingType
     * @return
     * @return Map<String,ComProPrice>
     * @throws 
     * @Description: 获取带有客户专有定价的第三级价格Map对象，用于构造数据供弹出框使用
     */
    public Map<String, ComProPrice> getMapComPartnerProPriceAndPriceLevel(String industryId, String comKey,String partnerKey,
    		String pCode, String searchKey, String pricingType){
    	List<ComProPrice> comProPrices = this.listComPartnerProPriceAndPriceLevel(industryId, comKey, partnerKey, pCode, searchKey, pricingType);
    	if(comProPrices==null||comProPrices.size() < 1){
    		return null;
    	}
    	Map<String,ComProPrice> map = new HashMap<String, ComProPrice>();
    	for (ComProPrice comProPrice : comProPrices) {
			map.put(comProPrice.getCategoryId(), comProPrice);
		}
    	return map;
    }
    
    /**
     * 
     * @Title: dropdownComProPrices 
     * @param pd
     * @return
     * @throws Exception
     * @return List<ComProPrice>
     * @throws 
     * @Description: 获取服务定价的下拉框拼装结果集。支持判断是否有专有客户定价。支持从redis缓存中读取数据
     */
    @SuppressWarnings("unchecked")
	public List<ComProPrice> dropdownComProPrices(PageData pd) throws Exception{
    	String industryId = pd.getString("industryId");
    	String comKey = pd.getString("comKey");
    	String partnerKey = pd.getString("partnerKey");
    	String partnerLevel = pd.getString("partnerLevel");
    	
    	String keyString = Const.REDIS_PRODUCTSERVICE_DROPDOWN+comKey+"_"+partnerKey;
    	List<ComPartnerProPrice> cppps = this.selectComParnter(comKey,partnerKey);
    	List<ComProPrice> comProPrices = null;
    	comProPrices = (List<ComProPrice>)redisUtil.get(keyString);
    	if(comProPrices==null){
	    	comProPrices = this.listComProPrice(industryId, comKey, pd.getString("pricingType"), "0", "1",null);
			List<ComProPrice> comProPrices3Level = null;
			List<ComProPrice> comProPrices2 = null;
			for (ComProPrice comProPrice1 : comProPrices) { //第一层
				comProPrices2 = comProPrice1.getComProPrices(); 
				for (ComProPrice comProPrice2 : comProPrices2) { //第二层
					if (cppps==null
							||cppps.size()==0) { //该客户不存在专有定价
						comProPrices3Level = this.listComProPriceAndPriceLevel(industryId, comKey, pd.getString("pricingType"), comProPrice2.getCategoryId(), null, "3",partnerLevel);
					} else { //客户存在专有定价
						comProPrices3Level = this.listComPartnerProPriceAndPriceLevel(industryId, comKey, partnerKey, comProPrice2.getCategoryId(), null, pd.getString("pricingType"));
					}
					Iterator<ComProPrice> it = comProPrices3Level.iterator();
					while(it.hasNext()){
						ComProPrice cpp3 = it.next();
						if("0".equalsIgnoreCase(cpp3.getIsChecked())){
							it.remove();
						}
					}
					comProPrice2.setComProPrices(comProPrices3Level);
				}
				comProPrice1.setComProPrices(comProPrices2);
			}
			this.setRedisComProPrice(comKey, partnerKey, comProPrices);
    	}
		return comProPrices;
    }
    
    /**
     * 
     * @Title: clearRedisComProPrice 
     * @param comKey
     * @param partnerKey
     * @return void
     * @throws 
     * @Description: 清除服务定价的缓存
     */
    public void clearRedisComProPrice(String comKey,String partnerKey){
    	PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("partnerKey", partnerKey);
		List<ComPartner> comPartners= comPartnerMapper.selectByPrimaryKey(pd);
		for (ComPartner comPartner : comPartners) {
			redisUtil.del(Const.REDIS_PRODUCTSERVICE_DROPDOWN+comKey+"_"+comPartner.getPartnerKey());
		}
    }
    public void setRedisComProPrice(String comKey,String partnerKey,List<ComProPrice> cpps){
    	redisUtil.setIntervalDay(Const.REDIS_PRODUCTSERVICE_DROPDOWN+comKey+"_"+partnerKey,cpps,365);
    }
    
    /**
     * 
     * @Title: getDropdownComProPricesByDesc 
     * @param comKey
     * @param industryId
     * @param partnerKey
     * @param pCode
     * @param sortItem
     * @param categoryDesc
     * @return
     * @return List<ComProPrice>
     * @throws 
     * @Description: 通过制作要求的模糊输入进行查询。用于新建或修改订单的快速下拉框查询
     */
    public List<ComProPrice> getDropdownComProPricesByDesc(String comKey,String industryId, 
    		String partnerKey,String pCode, String priceLevel,String categoryDesc){
    	PageData pd = new PageData();
    	pd.put("comKey", comKey);
    	pd.put("industryId", industryId);
		pd.put("partnerKey", partnerKey);
		pd.put("pCode", pCode);
		pd.put("categoryDesc", categoryDesc);
		pd.put("pricingType", CompanyEnum.PRICING_TYPE_SERVICE.getCode());
		pd.put("isChecked", "1");
		List<ComProPrice> comProPrices = null;
		if(StringUtil.isEmpty(partnerKey)){
			pd.put("partnerKey", partnerKey);
			pd.put("priceLevel", priceLevel);
			comProPrices = comProPriceMapper.listComProPricesByDesc(pd);
		}else{
			comProPrices = comProPriceMapper.listComPartnerProPricesByDesc(pd);
		}
		
		//===========为服务定价项增加工序处理 2017-07-24 16:05:44
		pd.clear();
		pd.put("comKey", comKey);
		List<AssignWorkshopServicePrice> servicePrices = assignWorkshopServicePriceMapper.selectListByPrimaryKey(pd);
		Map<String, AssignWorkshopServicePrice> mapServicePrice = new HashMap<String, AssignWorkshopServicePrice>();
		for (AssignWorkshopServicePrice servicePrice : servicePrices) {
			mapServicePrice.put(servicePrice.getCategoryId(), servicePrice);
		}
		for (ComProPrice comProPrice : comProPrices) {
			AssignWorkshopServicePrice servicePrice = mapServicePrice.get(comProPrice.getCategoryId());
			if(servicePrice!=null){
				comProPrice.setWorkingProcedure(servicePrice.getWorkingProcedure());
			}
		}
		return comProPrices;
    }
    
    public int deleteComProPriceAndPartner(PageData pd){
    	int result = 0;
    	String categoryId = pd.getString("categoryId");
    	String tier = pd.getString("tier");
    	pd.put("tier", null);
    	if ("2".equals(tier)) {
    		result = comProPriceLevelMapper.deleteByPrimaryKey(pd);
    		result = comProPriceMapper.deleteByPrimaryKey(pd);
    		comPartnerProPriceMapper.deleteByPrimaryKey(pd); //删除专有客户的对应定价
		}else if("1".equals(tier)){
			pd.put("categoryId", null);
			pd.put("pCode", categoryId);
			List<ComProPrice> comProPrices = comProPriceMapper.listComProPrice(pd);
			List<String> categoryIdList = null;
			if (comProPrices!=null&&comProPrices.size()>0) {
				categoryIdList = new ArrayList<>();
				for (ComProPrice comProPrice : comProPrices) {
					categoryIdList.add(comProPrice.getCategoryId());
				}
				
				pd.put("categoryId", null);
				pd.put("pCode", categoryId);
				result = comProPriceMapper.deleteByPrimaryKey(pd); //删除二级服务定价
				pd.put("categoryIdIns", Tools.strSqlIn(Tools.list2InString(categoryIdList)));
				result = comProPriceLevelMapper.deleteByPrimaryKey(pd); //删除服务定价级别
				comPartnerProPriceMapper.deleteByPrimaryKey(pd); //删除专有客户的对应定价
			}
			pd.put("pCode", null);
			pd.put("categoryId", categoryId);
			pd.put("categoryIdIns", null);
			result = comProPriceMapper.deleteByPrimaryKey(pd); //删除一级服务定价目录
		}
    	
    	return result;
    }
}