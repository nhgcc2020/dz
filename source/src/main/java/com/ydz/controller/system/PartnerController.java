package com.ydz.controller.system;

import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.common.SmsLogMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.exception.CompanyException;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by ydz on 2016/7/6.
 */
@Controller
@RequestMapping(value = "system/partner", produces = "application/json;charset=UTF-8")
public class PartnerController extends BaseController {
	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private PartnerService partnerService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private PartnerMapper partnerMapper;
	@Autowired
	private UserService userService;
	@Autowired
	private SmsLogMapper smsLogMapper;

	@Autowired
	private CommonService commonService;
	@Autowired
	private RedisUtil redisUtil;

    /////////新流程分割线 start////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * 跳转添加合作伙伴页面
     *
     * @return
     */
    @RequestMapping(value = "frameAddPartner")
    public ModelAndView frameAddPartner() {
        return new ModelAndView("/jsp/company/addPartner");
    }

    /**
     * 搜索可以添加为合作伙伴的公司
     *
     * @param addQueryKey
     * @return
     */
    @RequestMapping(value = "getPartnerByKey", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String getPartnerByKey(String addQueryKey) {

        UserVo userVo = getSessionUservo();
        if ("".equals(addQueryKey)) {
            return "0";
        }
        PageData pd = new PageData();
        pd.put("searchkey", addQueryKey);
        pd.put("currentComKey", userVo.getComKey());
        List<Company> companies = partnerService.getInfoByKey(pd);
        for (Company company : companies) {
            PageData pageData = new PageData();
            pageData.put("myComKey", userVo.getComKey());
            pageData.put("partnerComKey", company.getComKey());
            PartnerVO partner1 = partnerMapper.checkPartner(pageData);
            if (partner1 != null) {
                company.setPartnerStatus(partner1.getPartnerStatus());
            } else {
                //非好友
                company.setPartnerStatus(CompanyEnum.PARTNER_STATUS_FRIEND_NO.getCode());
            }
        }
        return JsonUtil.toCompatibleJSONString(companies);
    }

    /**
     * 合作伙伴列表
     *
     * @return
     */
    @RequestMapping(value = "partnerList")
    @ResponseBody
    public String partnerList() {
        UserVo userVo = getSessionUservo();
        PageData pageData = getPageData();
        if (userVo.getComKey() == null) {
            return "0";
        }
        pageData.put("comKey", userVo.getComKey());
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(1000);
            page.setPd(pageData);
            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,false);
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("$entityCount", page.getTotalResult());
            mapPage.put("$data", partnerVOs);
            return JsonUtil.toCompatibleJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * 
     * @Title: sendInviteMsg 
     * @param partnerKey
     * @param phone
     * @return
     * @throws Exception
     * @return Map<String,Object>
     * @throws 
     * @Description: 发送邀请短信
     */
    @RequestMapping(value = "sendInviteMsg")
    @ResponseBody
    public Map<String,Object> sendInviteMsg(String partnerKey,String phone) throws Exception {
        UserVo userVo = getSessionUservo();
        //返回值
        Map<String, Object> callback = new HashMap<>();
        if (partnerKey == null || "".equals(partnerKey)) {
            callback.put("state", false);
            callback.put("msg", "参数错误");
            return callback;
        }
        if(phone == null || "".equals(phone)){
            callback.put("state", false);
            callback.put("msg", "请填写正确手机号");
            return callback;
        }

        PageData pd = new PageData();
        pd.put("myComKey", userVo.getComKey());
        pd.put("partnerKey", partnerKey);
        PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd);
        
        //1.判断有没有注册
        List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pd);
        PartnerContacter partnerContacter = partnerContacters.get(0);

        //判断手机号是否进行进行了修改
        if(! partnerContacter.getTel1().equals(phone.trim())){
            PartnerContacter partnerContacterMod = new PartnerContacter();
            partnerContacterMod.setUid(partnerContacter.getUid());
            partnerContacterMod.setTel1(phone);
            partnerService.updateOnePartnerContacter(partnerContacterMod);
            
            partnerContacter.setTel1(partnerContacterMod.getTel1());
        }

        String userId = partnerContacter.getTel1();
        PageData pd2 = new PageData();
        pd2.put("userId", userId);
        User user = userService.getUserById(pd2);
        
        //2.如果已经注册
        if (user != null) {
            callback.put("state", false);
            callback.put("msg", "已经注册");
            return callback;
        } else {
            //3.如果没有注册 发送短信

            PageData pd3 = new PageData();
            pd3.put("comKey", userVo.getComKey());
            Company company = companyService.getCompanyByKey(pd3);
            //生成參數
            Map<String, Object> map = new HashMap<>();
            map.put("userKey", userVo.getUserKey());
            map.put("comKey", userVo.getComKey());
            map.put("invitee", partnerContacter.getTel1());
            map.put("partnerKey", partnerVO.getPartnerKey());
            map.put("inviteType", partnerVO.getPartnerAttr());
            String json = JsonUtil.toCompatibleJSONString(map);

            String key = CipherUtil.encrypt(json);

            String para = "/invite/com/signUpPage?key=" + key;
            String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
            String codeKey = "j_" + ranCode;
            redisUtil.setIntervalDay(codeKey, para, 30);
            
            Map<String, Object> mesResult = null;
            //判断合作伙伴是1公司/2个人
            if(CompanyEnum.PARTNER_ATTR_COMPANY.getCode().equals(partnerVO.getPartnerAttr())){
            	SMSUtil.sendInviteMsg4Com(company.getComName(), userVo.getRealName(), partnerVO.getPartnerName(), "jh/" + ranCode + " ", partnerContacter.getTel1());
            }else{
            	mesResult = SMSUtil.sendInviteMsg(company.getComName(), userVo.getRealName(), "jh/" + ranCode + " ", partnerContacter.getTel1());
            }
            
            SmsLog smsLog = new SmsLog();  //新建一条短信记录
            smsLog.setSmsType(MessageEnum.SMS_INVITE_PARTNER.getCode());  //邀请合作伙伴
            smsLog.setSmsFrom(userVo.getComKey());  //发送者 
            smsLog.setSmsTo(partnerContacter.getTel1()); //接收者
            smsLog.setSmsContent(codeKey); //短信内容 如果是邀请类型 存放redis中的短连接的KEY
            smsLog.setSmsResult(JsonUtil.toCompatibleJSONString(mesResult)); //短信返回值
            smsLog.setCreator(userVo.getUserKey());
            smsLog.setCreateTime(new Date());
            smsLogMapper.insert(smsLog);

            //修改状态
            ComPartner comPartner = new ComPartner();
            comPartner.setPartnerKey(partnerVO.getPartnerKey());
            comPartner.setComKey(userVo.getComKey());
            comPartner.setStatus(CompanyEnum.PARTNER_STATUS_INVITING.getCode());
            partnerService.updateByPrimaryKeySelective(comPartner);
            
            callback.put("state", true);
            callback.put("msg", "操作成功");
            return callback;
        }
    }

    /**
     * 删除待邀请状态下的合作伙伴()
     *
     * @return
     */
    @RequestMapping(value = "delPartner", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String delPartner(String partnerKey) {
        UserVo userVo = getSessionUservo();
        Map<String, String> callback = new HashMap<>();
        if (partnerKey == null || "".equals(partnerKey)) {
            callback.put("state", "0");
            callback.put("msg", "请选择生意伙伴");
            return JsonUtil.toCompatibleJSONString(callback);
        }
        //查询是否已经对该生意伙伴建单
        callback = partnerService.delPartner(partnerKey, userVo);
        return JsonUtil.toCompatibleJSONString(callback);
    }

    /////////新流程分割线 end////////////////////////////////////////////////////////////////////////////////////////////

    /**
     * @return ModelAndView
     * @throws
     * @Title: frameAddPage
     * @Description:
     */
    @RequestMapping(value = "frameAddCust")
    public ModelAndView frameAddCust() {
        return new ModelAndView("/jsp/company/addCust");
    }

    /**
     * 新建供应商
     *
     * @return
     */
    @RequestMapping(value = "frameAddSupplier")
    public ModelAndView frameAddSupplier() {
        return new ModelAndView("jsp/company/addSupplier");
    }


    /**
     * @return String
     * @throws
     * @Title: customerList
     * @Description: 查询我的客户列表
     */
    @RequestMapping(value = "customerList")
    @ResponseBody
    public String customerList() {
        UserVo userVo = getSessionUservo();
        PageData pd = getPageData();
        String type = pd.getString("type");
        if (userVo.getComKey() == null) {
            return "0";
        }
        pd.put("comKey", userVo.getComKey());
        pd.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode());
        String partnerStatus = pd.getString("partnerStatus"); 
        try {
            Page page = this.getPageWithParameter();
            page.setShowCount(1000);
            if (StringUtil.isEmpty(partnerStatus)) {
				pd.put("partnerStatus", null);
			}
            if ("-1".equals(partnerStatus)) { //非好友
            	pd.remove("partnerStatus");
            	pd.put("notFriend", "true");
            }
            page.setPd(pd);
            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,true);
            int nowTotal = page.getTotalResult();
            
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("total", page.getTotalResult());
            mapPage.put("rows", partnerVOs);
            mapPage.put("nowTotal", nowTotal);
            return JsonUtil.toCompatibleJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    @RequestMapping(value = "simpleCustomerList")
    @ResponseBody
    public String simpleCustomerList(){
    	UserVo userVo = getSessionUservo();
        PageData pd = getPageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode());
        pd.put("isTemp", "0");
        List<PartnerVO> partnerVOs = partnerService.partnerVOList(pd);
        return JsonUtil.toJsonString(partnerVOs);
    }

    /**
     * @return String
     * @throws
     * @Title: supplierList
     * @Description: 查询我的供应商列表
     */
    @RequestMapping(value = "supplierList")
    @ResponseBody
    public String supplierList() {
        UserVo userVo = getSessionUservo();
        PageData pageData = getPageData();
        String type = pageData.getString("type");
        if (userVo.getComKey() == null) {
            return "0";
        }
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode());
        String partnerStatus = pageData.getString("partnerStatus"); 
        try {
            Page page = this.getPageWithParameter();
            page.setShowCount(1000);
            if (StringUtil.isEmpty(partnerStatus)) {
            	pageData.put("partnerStatus", null);
			}
            if ("-1".equals(pageData.get("partnerStatus"))) {
                pageData.remove("partnerStatus");
                pageData.put("notFriend", "true");
            }

            page.setPd(pageData);
            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,true);
            int nowTotal = page.getTotalResult();
           
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("total", page.getTotalResult());
            mapPage.put("rows", partnerVOs);
            mapPage.put("nowTotal", nowTotal);
            return JsonUtil.toCompatibleJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * @param phone
     * @return boolean
     * @throws
     * @Title: getCustListByPhone
     * @Description: 根据手机号 查询其身份为法人或者管理员的公司。
     * 用于新建合作伙伴时，是否是已经使用易对账的系统用户
     */
    @RequestMapping(value = "isRegistered")
    @ResponseBody
    public boolean getCustListByPhone(String phone) {
        //负责人手机号 查询公司信息
        PageData pageData = new PageData();
        pageData.put("userId", phone);
        List<Company> companies = companyService.getByDirector(pageData);
        boolean falg = false;
        if (companies.size() > 0) {
            falg = true;
        }
        return falg;
    }


    /**
     * 根据
     *  公司对账号
     *  负责人手机号
     *  企业名称
     *  负责人名称
     * 查询公司信息
     * @param addQueryKey  公司对账号或者 负责人手机号
     * @return
     */
    /**
     * @param addQueryKey
     * @return String
     * @throws
     * @Title: getCustListByKey
     * @Description: 用于查询已经注册易对账的公司信息
     */
    @RequestMapping(value = "getCustByKey", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String getCustListByKey(String addQueryKey) {
        //todo 查询用户当前公司信息（所属城市 citykey）
        // 如果addQueryKey为公司对账号
       /* Company companyPara =  new Company();
        companyPara.setComId(addQueryKey);*/
        Company companyByObj;
        if ("".equals(addQueryKey)) {
            return "0";
        }
        try {
            //根据公司对账号 查询公司信息
            PageData pd = new PageData();
            pd.put("comId", addQueryKey);
            companyByObj = companyService.getCompanyByKey(pd);

            //负责人手机号 查询公司信息
            PageData pageData = new PageData();
            pageData.put("userId", addQueryKey);
            List<Company> companies = companyService.getByDirector(pageData);

            //根据负责人姓名
            PageData pageData2 = new PageData();
            pageData2.put("realName", addQueryKey);
            //todo  根据区域 搜索
            List<Company> companies2 = companyService.getByDirector(pageData2);

            //根据企业名称
            PageData pageData3 = new PageData();
            pageData3.put("comName", addQueryKey);
            //todo  根据区域 搜索
            List<Company> companies3 = companyService.getByComName(addQueryKey);

            List<Company> companyList = new ArrayList<>();
            if (companyByObj != null) {
                companyList.add(companyByObj);
            }
            companyList.addAll(companies);
            companyList.addAll(companies2);
            companyList.addAll(companies3);
            if (companyList.size() == 0) {
                return "0";
            }

            for (int i = 0; i < companyList.size(); i++) {
                Company companyResult = companyList.get(i);
                EmployeeVo employeeVo1 = employeeService.getAdmin(companyResult.getComKey());
                if (employeeVo1 != null) {
                    companyResult.setAdminName(employeeVo1.getUserName());
                    companyResult.setAdminPhone(employeeVo1.getUserPhone());
                } else {
                    companyResult.setAdminName("无");
                    companyResult.setAdminPhone("无");
                }

                EmployeeVo employeeVo2 = employeeService.getBoss(companyResult.getComKey());
                if (employeeVo2 != null) {
                    companyResult.setBossName(employeeVo2.getUserName());
                    companyResult.setBossPhone(employeeVo2.getUserPhone());
                } else {
                    companyResult.setBossName("无");
                    companyResult.setBossPhone("无");
                }
            }
            return JsonUtil.toCompatibleJSONString(companyList);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * @param partner
     * @return String
     * @throws Exception
     * @throws
     * @Title: saveSltPartner
     * @Description: 添加已选择合作伙伴
     */
    @RequestMapping(value = "saveSltPartner", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String saveSltPartner(Partner partner) throws Exception {
        UserVo userVo = getSessionUservo();
        //用于回调的map
        Map<String, Object> callBack = new HashMap<>();
        if (partner.getPartnerLevel() == null || "".equals(partner.getPartnerLevel())) {
            callBack.put("status", "0");
            callBack.put("msg", "合作级别不能为空");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
        //不在需要设置伙伴分类
        /*if(partner.getPartnerType()==null || "".equals(partner.getPartnerType())){
            callBack.put("status","0");
            callBack.put("msg","伙伴分类不能为空");
            return JsonUtil.toCompatibleJSONString(callBack);
        }*/

        //查询该公司信息
        String partnerComKey = partner.getPartnerComKey();
        if (partnerComKey.equals(userVo.getComKey())) {
            callBack.put("status", "0");
            callBack.put("msg", "不能添加相同公司");
            return JsonUtil.toCompatibleJSONString(callBack);
        }

        Company company = companyService.getCompanyByUserKey(partnerComKey);
        partner.setPartnerShortname(company.getComShortname().trim());
        partner.setPartnerName(company.getComName().trim());

        partner.setPartnerTel(company.getComTel());
        partner.setPartnerAddress(company.getComAddress());
        partner.setPartnerAttr(company.getComType());
        partner.setPartnerQQ(company.getComQQ());

        EmployeeVo employeeVo1 = employeeService.getAdmin(company.getComKey());
        if (employeeVo1 != null) {
            partner.setTel11(employeeVo1.getUserPhone());
            partner.setContacterName11(employeeVo1.getUserName());
        }

        EmployeeVo employeeVo2 = employeeService.getBoss(company.getComKey());
        if (employeeVo2 != null && !employeeVo2.getUserPhone().equals(employeeVo1.getUserPhone())) {
            partner.setTel12(employeeVo2.getUserPhone());
            partner.setContacterName12(employeeVo2.getUserName());
        }

        //新建合作伙伴操作
        callBack = partnerService.savePartner(userVo, partner);
        if(callBack.get("sendsms")!=null
        	&&"1".equals(callBack.get("sendsms"))){
        	SMSUtil.sendApplyTobeFriend(partner.getTel11(), userVo.getComName()); //给合作伙伴管理员发短信通知有好友申请
        }
        //String result = "0";
        return JsonUtil.toCompatibleJSONString(callBack);
    }


    /**
     * @param partner
     * @return String
     * @throws Exception
     * @throws
     * @Title: savePartnerWithout
     * @Description: 新建不存在的合作伙伴
     */
    @RequestMapping(value = "savePartnerWithout", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String savePartnerWithout(Partner partner) throws Exception {
        UserVo userVo = getSessionUservo();
        //用于回调的map
        Map<String, Object> callBack = new HashMap<>();

        if (partner.getPartnerComKey() != null) {
            callBack.put("code", "0");
            callBack.put("msg", "该手机用户已使用易对账，通过申请好友去加他吧");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
        String partnerAttr = partner.getPartnerAttr();
        //企业属性为个人时
        if ("2".equals(partnerAttr)) {
            //判断是否已经邀请过
            PageData pd = new PageData();
            pd.put("phone", partner.getTel11());
            pd.put("partnerAttr", "2");
            pd.put("comKey", userVo.getComKey());
            List<PartnerVO> partnerVOs = partnerMapper.listByPhone(pd);
            if (partnerVOs.size() > 0) {
                callBack.put("code", "0");
                callBack.put("msg", "该手机用户已在伙伴名单中，无法重复邀请");
                return JsonUtil.toCompatibleJSONString(callBack);
            }
            partner.setPartnerName(partner.getContacterName11().trim());
            partner.setPartnerShortname(partner.getPartnerName().trim());
        }else{
            //属性为企业时 1
            if(partner.getPartnerName() == null || "".equals(partner.getPartnerName().trim())){
                callBack.put("code", "0");
                callBack.put("msg", "请填写企业全称!");
                return JsonUtil.toCompatibleJSONString(callBack);
            }
            String partnerName = partner.getPartnerName().trim();
            PageData pd = new PageData();
            pd.put("phone", partner.getTel11());
            pd.put("partnerAttr", "1");
            pd.put("comKey", userVo.getComKey());
            pd.put("partnerName",partnerName);
            List<PartnerVO> partnerVOs = partnerMapper.listByPhone(pd);
            if (partnerVOs.size() > 0) {
                callBack.put("code", "0");
                callBack.put("msg", "该手机用户已在伙伴名单中，无法重复邀请");
                return JsonUtil.toCompatibleJSONString(callBack);
            }
            partner.setPartnerName(partnerName);
        }

        //查询联系人是否有公司
        String phone = partner.getTel11();
        //负责人手机号 查询公司信息
        PageData pageData = new PageData();
        pageData.put("userId", phone);
        try {
            List<Company> companies = companyService.getByDirector(pageData);
            if (companies.size() > 0) {
                callBack.put("code", "0");
                callBack.put("msg", "该手机用户已使用易对账，通过申请好友去加他吧");
                return JsonUtil.toCompatibleJSONString(callBack);

            }
        } catch (Exception e) {
            e.printStackTrace();
            callBack.put("code", "0");
            callBack.put("msg", "服务出错");
            return JsonUtil.toCompatibleJSONString(callBack);
        }

        callBack = partnerService.savePartnerCom(userVo, partner);

        return JsonUtil.toCompatibleJSONString(callBack);
    }


    /**
     * @param request
     * @return String
     * @throws Exception
     * @throws
     * @Title: listDropdownPartner
     * @Description: 合作伙伴的下拉框
     */
    @RequestMapping(value = "dropdownPartner", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listDropdownPartner(HttpServletRequest request) throws Exception {
        UserVo userVo = this.getSessionUservo();
        PageData pdPara = this.getPageData();
        pdPara.put("comKey", userVo.getComKey());
        pdPara.put("partnerType", request.getParameter("partnerType"));
        return JSONArray.toJSONString(partnerService.listDropdownPartner(pdPara));
    }


    /**
     * 
     * @Title: modPage 
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 修改合作伙伴公司信息
     */
    @RequestMapping(value = "modPageCom")
    public ModelAndView modPage() {
		return new ModelAndView("jsp/company/partner-mod-com").addObject(
				"partnerKey", this.getPageData().getString("partnerKey"))
				.addObject("contacterId",
						this.getPageData().getString("contacterId"));
    }

    /**
     * 
     * @Title: modPageFriend 
     * @param partnerKey
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 修改个人合作伙伴信息(暂停使用)
     */
    @RequestMapping(value = "modPagePerson")
    public ModelAndView modPageFriend(String partnerKey) {
        return new ModelAndView("jsp/company/partner-mod-person").addObject("partnerKey", partnerKey);
    }

    @RequestMapping(value = "partnerInfo")
    @ResponseBody
    public String partnerInfo() {
    	PageData pd = this.getPageData();
    	PartnerVO partnerVO = null;
    	if (StringUtil.isNotEmpty(pd.getString("contacterId"))) {
    		partnerVO = partnerService.selectOnePartnerAndContacterByPartnerKey(pd);
		}else{
			pd.put("comKey", this.getSessionUservo().getComKey());
			partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
		}
    	partnerVO.setCreateTime(null);//TODO 关于fastjson时间问题的全局配置
        return JSONArray.toJSONString(partnerVO);
    }

    @RequestMapping(value = "modPartner")
    @ResponseBody
    public String modPartner(PartnerVO partnerVO) {
        UserVo userVo = getSessionUservo();

        Map map = partnerService.modPartner(partnerVO,userVo);
        String keyString = Const.REDIS_PRODUCTSERVICE_DROPDOWN+userVo.getComKey()+"_"+partnerVO.getPartnerKey();
        redisUtil.set(keyString, null);
        return JsonUtil.toCompatibleJSONString(map);
    }

    /**
     * 修改好友
     *
     * @param partnerVO
     * @return
     */
    @RequestMapping(value = "modFriend")
    @ResponseBody
    public Map modFriend(PartnerVO partnerVO) {
        UserVo userVo = getSessionUservo();
        Map map = partnerService.updateFriend(partnerVO, userVo);
        return map;
    }

    /**
     * 修改非好友
     *
     * @param partnerVO
     * @return
     */
    @RequestMapping(value = "modNonFriend")
    @ResponseBody
    public Map modNonFriend(PartnerVO partnerVO) {
        UserVo userVo = getSessionUservo();
        Map map = partnerService.updateNonFriend(partnerVO, userVo);
        return map;
    }

    @RequestMapping(value = "customer/permissionButton")
    @ResponseBody
    public String permissionButton() {
        Map<String, String> jsonMap = new HashMap<String, String>();
        String btnModify = "<div c-widget=\"button;class:primary;caption:修改;click:{{showModPartner(item)}}\" style=\"padding:0 10px; height: 20px; font-size: 12px; line-height: 20px; font-weight: normal;\"></div>";
        jsonMap.put("btnModify", btnModify);
        return JsonUtil.toCompatibleJSONString(jsonMap);
    }
    
    //列表查询联系人
    @RequestMapping(value = "listPartnerContacter", method = RequestMethod.GET)
    @ResponseBody
    public String listPartnerContacter(){
         return JsonUtil.toCompatibleJSONString(partnerService.listPartnerContacter(this.getPageData()));
    }
    
    //列表查询联系人
    @RequestMapping(value = "getOnePartnerContacter", method = RequestMethod.GET)
    @ResponseBody
    public String getOnePartnerContacter(){
    	return JsonUtil.toCompatibleJSONString(partnerService.selectOnePartnerContacter(this.getPageData()));
    }
    
    
    //插入新联系人
    @RequestMapping(value = "newContacter", method = RequestMethod.POST)
    @ResponseBody
	public String newContacter(@RequestBody PartnerContacter contacter)
			throws Exception {
		if (contacter == null || StringUtil.isEmpty(contacter.getPartnerKey())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建联系人失败"));
		}
    	UserVo userVo = this.getSessionUservo();
    	contacter.setContacterId(CodeBuilderUtil.getInstance().getAnyId(10));
    	contacter.setCreateTime(new Date());
    	contacter.setCreator(userVo.getUserKey());
    	contacter.setIsValid("1");
    	int result = 0;
		try {
			result = partnerService.insertOnePartnerContacter(contacter);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new CompanyException("新建联系人失败");
		}
    	if (result > 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("新建成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建联系人失败"));
		}
	}
    
    //修改联系人
    @RequestMapping(value = "updateContacter", method = RequestMethod.PUT)
    @ResponseBody
    public String updatePartnerContacter(@RequestBody PartnerContacter contacter) throws Exception{
    	if (contacter == null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改联系人失败"));
		}
    	int result = 0;
		try {
			result = partnerService.updateOnePartnerContacter(contacter);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new CompanyException("修改联系人失败");
		}
    	if (result > 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改联系人失败"));
		}
    }
    
    //删除联系人
    @RequestMapping(value = "deleteContacter", method = RequestMethod.DELETE)
    @ResponseBody
    public String deletePartnerContacter() throws Exception{
    	PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("contacterId"))
				|| StringUtil.isEmpty(pd.getString("partnerKey"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除联系人失败"));
		}
    	int result = 0 ;
    	try {
			result = partnerService.deletePartnerContacter(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new CompanyException("删除联系人失败");
		}
    	if (result > 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除联系人失败"));
		}
    }
   
    
    
  //=====================================客户充值业务=====================================
    
    /**
     * 
     * @Title: openRecharge 
     * @return
     * @return String
     * @throws 
     * @Description: 开启预充值功能
     */
    @RequestMapping(value = "recharge/openbusiness")
    @ResponseBody
    public String openRecharge(){
    	UserVo userVo = this.getSessionUservo();
    	ComConfig comConfig = new ComConfig();
    	comConfig.setComKey(userVo.getComKey());
    	comConfig.setConfigKey(Const.COMPANY_CONFIG_RECHARGE);
    	comConfig.setConfigValue("1");
    	comConfig.setCreateTime(new Date());
    	int result = commonService.insertComConfig(comConfig);
    	if (result<1) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("开启失败"));
		}
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("开启成功"));
    }
    
    /**
     * 
     * @Title: customerListForRecharge 
     * @return
     * @return String
     * @throws 
     * @Description: 充值
     */
    @RequestMapping(value = "recharge/customerList")
    @ResponseBody
    public String customerListForRecharge(){
    	UserVo userVo = this.getSessionUservo();
    	Page page = this.getPageWithParameter();
    	page.setShowCount(1000);
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	page.setPd(pd);
    	List<PartnerVO> partnerVOs = partnerService.listPageComPartenrForRecharge(page);
    	return JsonUtil.toCompatibleJSONString(partnerVOs);
    }
    
    @RequestMapping(value = "recharge/sumTotalVo")
    @ResponseBody
    public String sumChargeTotalVo(){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	OrderTotalVO orderTotalVO = partnerService.selectSumComPartnerRechargeTotalVO(pd);
    	OrderTotalVO consumeOrderTotalVO = partnerService.getSumConsumeLogTotalVO(pd);
    	if(orderTotalVO!=null){
	    	orderTotalVO.setSumConsumeMoney(consumeOrderTotalVO==null?BigDecimal.ZERO:consumeOrderTotalVO.getSumConsumeMoney());
	    	orderTotalVO.setSumBalanceMoney(orderTotalVO.getSumRechargeMoney().add(orderTotalVO.getSumPresentMoney()).subtract(orderTotalVO.getSumConsumeMoney())
	    			.setScale(2, BigDecimal.ROUND_HALF_UP));
    	}
    	return JsonUtil.toCompatibleJSONString(orderTotalVO);
    }
    
    /**
     * 
     * @Title: inRechargeMoney 
     * @param comPartnerRechargeLog
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 预充值
     */
    @RequestMapping(value = "recharge/in-recharge")
    @ResponseBody
    public String inRechargeMoney(ComPartnerRechargeLog comPartnerRechargeLog) 
    		throws Exception{
    	if (comPartnerRechargeLog==null
    			||StringUtil.isEmpty(comPartnerRechargeLog.getPartnerKey())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("充值失败"));
		}
    	UserVo userVo = this.getSessionUservo();
    	
    	int result = partnerService.insertRechargeAndUpdateBalanceForPartner(userVo, comPartnerRechargeLog);
    	if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("充值成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("充值失败"));
		}
    }
    
    /**
     * 
     * @Title: forwardListRechargeLog 
     * @param partnerKey
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 跳转查看充值记录
     */
    @RequestMapping(value = "recharge/forward-listrechargelog")
    public ModelAndView forwardListRechargeLog(String partnerKey){
    	return new ModelAndView("jsp/prepaid/prepaid-rechargelog-list").addObject("partnerKey", partnerKey);
    }
    
    /**
     * 
     * @Title: listInRechargeLog 
     * @return
     * @return String
     * @throws 
     * @Description: 充值记录查看
     */
    @RequestMapping(value = "recharge/listrechargelog")
    @ResponseBody
    public String listInRechargeLog(){
    	UserVo userVo = this.getSessionUservo();
    	Page page = this.getPageWithParameter();
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("partnerKey"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("查询失败"));
		}
    	pd.put("comKey", userVo.getComKey());
    	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
    	page.setPd(pd);
    	List<ComPartnerRechargeLog> rechargeLogs = partnerService.listPageComPartnerRechargeLogs(page);
    	OrderTotalVO orderTotalVO = partnerService.selectSumComPartnerRechargeTotalVO(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setRows(rechargeLogs);
    	resultMap.setTotalCount(page.getTotalResult());
    	resultMap.put("bottomInfo", orderTotalVO);
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 
     * @Title: forwardListConsumeLog 
     * @param partnerKey
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 跳转消费记录查看
     */
    @RequestMapping(value = "recharge/forward-listconsumelog")
    public ModelAndView forwardListConsumeLog(String partnerKey){
    	return new ModelAndView("jsp/prepaid/prepaid-consumelog-list").addObject("partnerKey", partnerKey);
    }
    
    /**
     * 
     * @Title: listConsumeLog 
     * @return
     * @return String
     * @throws 
     * @Description: 客户预付款消费记录
     */
    @RequestMapping(value = "recharge/listconsumelog")
    @ResponseBody
    public String listConsumeLog(){
    	UserVo userVo = this.getSessionUservo();
    	Page page = this.getPageWithParameter();
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("partnerKey"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("查询失败"));
		}
    	pd.put("comKey", userVo.getComKey());
    	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
    	page.setPd(pd);
    	List<ComPartnerConsumeLog> consumeLogs = partnerService.listPageComPartnerConsumeLogs(page);
    	OrderTotalVO orderTotalVO = partnerService.getSumConsumeLogTotalVO(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setRows(consumeLogs);
    	resultMap.setTotalCount(page.getTotalResult());
    	resultMap.put("bottomInfo", orderTotalVO);
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
}
