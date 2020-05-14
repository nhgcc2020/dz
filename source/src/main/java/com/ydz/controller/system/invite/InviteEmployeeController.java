package com.ydz.controller.system.invite;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.system.CompanyMapper;
import com.ydz.dao.system.EmployeeMapper;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.RoleMenu;
import com.ydz.entity.system.RoleUser;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.RoleService;
import com.ydz.service.system.UserService;
import com.ydz.util.*;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 邀请员工注册控制器
 * 注册
 * Created by ydz on 2016/6/24.
 */
@Controller
@RequestMapping(value = "invite/emp/")
public class InviteEmployeeController extends BaseController {
	
	@Resource(name="commonService")
	private CommonService commonService;

    //用户业务层
    @Resource(name = "userService")
    private UserService userService;
    //雇员业务层
    @Resource(name = "employeeService")
    private EmployeeService employeeService;
    //角色业务层
    @Resource(name = "roleService")
    private RoleService roleService;
    
    @Resource
    private CompanyService companyService;
    @Resource
    private CompanyMapper companyMapper;
    @Resource
    private EmployeeMapper employeeMapper;
    
    @Resource
    private RedisUtil redisUtil;


    /**
     * 跳转邀请注册
     *
     * @return
     */
    @RequestMapping(value = "signUpPage")
    public ModelAndView register(HttpServletRequest request) {
        String key = request.getParameter("key");
        Map<String, Object> map = new HashMap<String, Object>();
        if (key != null && !"".equals(key)) {
            String json = CipherUtil.decryptForChn(key);
            JSONObject jsonObject = JSONObject.parseObject(json);
            map.put("invitee", jsonObject.getString("invitee"));
            map.put("comKey", jsonObject.getString("comKey"));
            map.put("roleKey", jsonObject.getString("roleKey"));
            map.put("inviter", jsonObject.getString("inviter"));
            map.put("name", jsonObject.getString("name"));
        }
        PageData pd = new PageData();
        pd.put("comKey", map.get("comKey"));
        try {
            Company company = companyService.getCompanyByKey(pd);
            map.put("comName", company.getComName());
            pd.put("userKey", map.get("inviter"));
            User user = userService.getUserById(pd);
            map.put("inviterName", user.getRealName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getSession().setAttribute(Const.SESSION_INVITE, map);
        return new ModelAndView("/jsp/register/invite");
    }

    /**
     * 
     * @Title: saveRegist 
     * @param user
     * @param request
     * @param roleKey
     * @param comKey 邀请的公司KEY
     * @param response
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 被邀请的员工通过邀请页面确认加入
     */
    @RequestMapping(value = "completeRegist", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String saveRegist(User user, HttpServletRequest request, String roleKey, String comKey, HttpServletResponse response) 
    		throws Exception {
    	UserVo userVo = this.getSessionUservo();
        Map<String, String> callback = new HashMap<>();
        //手机号重复校验
        PageData pdPara = new PageData();
        String userId = user.getUserId();

        pdPara.put("userId", userId);
        User userRsl = null;
        try {
            userRsl = userService.getUserById(pdPara);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (userRsl != null) {
            callback.put("state", "0");
            callback.put("msg", "您已注册");
            return JSON.toJSONString(callback);
        }
        //解密roleId
        if (roleKey == null || "".equals(roleKey)) {
            callback.put("state", "0");
            callback.put("msg", "无角色信息");
            return JSON.toJSONString(callback);
        }
        String userKey = UuidUtil.get32UUID();
        String password = user.getPassword();
        String salt = CypherUtil.getSalt(userKey.substring(0, 11));
        user.setSalt(salt);
        user.setPassword(CypherUtil.getEncryptedPassword(password, salt));
        user.setUserKey(userKey);
        user.setCreateTime(new Date());
        String ip = getIpAddr(request);
        user.setRegisterIp(ip);
        user.setIsValid("1");
        String result = "0";
        user.setDefaultCom(comKey); //被邀请员工把邀请公司KEY作为默认公司KEY
        Integer i = userService.saveUser(user);

        //首先创建一个 个人公司
        //创建一个类型是个体商户的公司
        Date nowDate = new Date();

        Company company = new Company();
        if(StringUtil.isNotEmpty(user.getRefereeName())){
            company.setRefereeName(user.getRefereeName());
        }
        company.setComKey(UuidUtil.get32UUID());
        company.setComId(CodeBuilderUtil.getInstance().getCompanyCode());
        company.setWithinComId(CodeBuilderUtil.getInstance().getCompanyInvitationCode());
        company.setComName(user.getRealName());
        company.setComShortname(company.getComName());
        if(StringUtil.isNotEmpty(company.getComShortname())){
            company.setMnemonicCode(GetPinyin.getPinYinHeadChar(company.getComShortname()).toUpperCase()); //公司简称的首字母大写作为助记码
        }
        //公司类型 个人
        company.setComType(CompanyEnum.COM_TYPE_PERSONAL.getCode());
        company.setCreator(user.getUserKey());
        //新建个人类型的公司时，该字段应为 0 ，当用户在第一次选择身份后，该字段值更新为"1"
        company.setIsValid("1");
        company.setCreateTime(nowDate);
        company.setIndustryId(Const.INDUSTRY_GENERAL);
        companyMapper.insertSelective(company);

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


        if (i >= 1) {
            //注册完成后，首先根据 userId（手机号） 找到对应的员工信息
            Employee employee2 = employeeService.getEmployeeByModel(user.getUserId(), comKey);
            //修改员工的状态并且  从邀请中 改为正常状态
            employee2.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
            employee2.setUserKey(user.getUserKey());
            employee2.setRealName(user.getRealName());
            employeeService.modifyByUserIdSelective(employee2);
            //并且在用户角色表中添加一条信息
            RoleUser roleUser = new RoleUser();
            roleUser.setUserKey(user.getUserKey());
            roleUser.setComKey(employee2.getComKey());
            roleUser.setCreator(user.getUserKey());
            roleUser.setRoleKey(roleKey);
            int addResult = roleService.insertRoleUser(roleUser);
            
            //插入邀请的员工成功后
            if(addResult>=0){
	            List<RoleMenu> roleMenusExclude = roleService.getHasRoleMenusExclude(comKey,roleKey); // 判断该公司是否已经初始化当前角色的菜单信息
	            if(roleMenusExclude==null){
		            roleService.insertComRolesRegisterInit(comKey, userVo.getDetailIndustryId(), userKey); //插入默认配置的角色菜单排除
	            }
	            
	            callback.put("state", "1");
            }
            return JSON.toJSONString(callback);
        } else {
            callback.put("state", "0");
            callback.put("msg", "注册失败");
            return JSON.toJSONString(result);
        }
    }
    
    @RequestMapping(value = "success", produces = "plain/text; charset=UTF-8")
    public ModelAndView sucess(HttpServletRequest request) {
    	
    	return new ModelAndView("/jsp/register/join-success");
    }
}
