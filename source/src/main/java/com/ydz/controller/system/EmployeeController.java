package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.system.RoleUserMapper;
import com.ydz.entity.advert.SalesMan;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.RoleUser;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.RoleService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pxy on 2016/6/16.
 */
@Controller
@RequestMapping(value = "employee",produces = "plain/text; charset=UTF-8")
public class EmployeeController extends BaseController {

    @Resource(name = "employeeService")
    EmployeeService employeeService;
    
    @Resource(name = "commonService")
    private CommonService commonService;
    @Resource
    RoleService roleService;

    @RequestMapping(value = "empPage")
    public ModelAndView empPage(){
        return new ModelAndView("jsp/company/employee");
    }


    @RequestMapping(value = "toAdd")
    public ModelAndView toAddPage(){
        return new ModelAndView("jsp/company/add-employee");
    }


    @RequestMapping(value = "info")
    @ResponseBody
    public String getAllEmployee(HttpServletRequest request){

        UserVo operator = getSessionUservo();
        List<EmployeeVo> employees = null;
        try {
            PageData pd = new PageData();
            pd.put("comKey",operator.getComKey());
            String[] statusList = {"1","3","0"};
            pd.put("statusList",statusList);
            employees  =  employeeService.getAllEmployee(pd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonUtil.toCompatibleJSONString(employees);
    }
    
    @RequestMapping(value = "getMenuIdInit")
    @ResponseBody
    public String getMenuIdInit(){
    	UserVo userVo = this.getSessionUservo();
    	String menuId = commonService.getDictValue(Const.MENU_ID_INIT+userVo.getDetailIndustryId());
    	return JsonUtil.toCompatibleJSONString(Tools.str2StrArray(menuId, ","));
    }

    /**
     * 
     * @Title: getAllEmployeeAsVo 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 查询除自己之外其他已经注册加入的员工列表，用于管理员转移业务
     */
    @RequestMapping(value = "infoVo")
    @ResponseBody
    public String getAllEmployeeAsVo(HttpServletRequest request) throws Exception{
        UserVo userVo = getSessionUservo();
        PageData pageData = new PageData();
        pageData.put("comKey", userVo.getComKey());
//        pageData.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
        pageData.put("userKey",userVo.getUserKey());
        //查询除自己外的员工
        List<SalesMan> salesMens = employeeService.getList4order(pageData);
        return JSON.toJSONString(salesMens);
    }

    /**
     * 邀请员工加入公司:
     * @return
     */
    @RequestMapping(value = "inviteEmployee")
    @ResponseBody
    public String inviteEmployee(HttpServletRequest request,Employee employee){
        UserVo userVo = getSessionUservo();
        Map<String,Object> callback = new HashMap<>();
//        if(employee.getRoleKey() == null || "".equals(employee.getRoleKey())){
//            callback.put("code","0");
//            callback.put("msg","请选择角色");
//            return JSON.toJSONString(callback);
//        }
//        if(employee.getDeptId() == null || "".equals(employee.getDeptId())){
//            callback.put("code","0");
//            callback.put("msg","请选择部门");
//            return JSON.toJSONString(callback);
//        }
        try {
            Map<String,Object> result = employeeService.inviteEmployee(userVo,employee);
            return JSON.toJSONString(result);
        } catch (Exception e) {
            e.printStackTrace();
            //失败则返回0
            callback.put("code","0");
            callback.put("msg","操作失败");
            return JSON.toJSONString(callback);
        }
    }
    //发送验证码给管理员或者法人
    @RequestMapping(value = "sendVerificationCode")
    @ResponseBody
    public String sendVerificationCode(HttpServletRequest request){

      return "";
    }


    /**
     * 权限转移
     * @param request
     * @return
     */
    @RequestMapping(value = "transferOfRights")
    @ResponseBody
    public String transferOfRights(HttpServletRequest request,String newAdminUserKey,String roleKey){
         UserVo userVo = getSessionUservo();
        //判断短信验证是否成功

        //
        try {
            Map<String,Object>  map = employeeService.updateTransferOfRights(userVo,newAdminUserKey,roleKey);
            if(map.get("state") != null && (boolean)map.get("state")){
                //shiro管理的session
                Session session = getShiroSession();
                session.removeAttribute(Const.SESSION_USER);
                session.removeAttribute(Const.SESSION_QX);
                session.removeAttribute(Const.SESSION_userpds);
                session.removeAttribute(Const.SESSION_USERNAME);
                //shiro销毁登录
                request.getSession().invalidate();
                SecurityUtils.getSubject().logout();
            }
            return JSON.toJSONString(map);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @RequestMapping(value = "getAdmin")
    @ResponseBody
    public String getAdmin(){
        UserVo userVo  = getSessionUservo();
        try {
             EmployeeVo employeeVo = employeeService.getAdmin(userVo.getComKey());
            return JSON.toJSONString(employeeVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }

    }

    /**
     * 调整部门
     * @param users
     * @param modDeptId
     * @return
     */
    @RequestMapping(value = "changeDept")
    @ResponseBody
    public String changeDept(@RequestParam(value = "users") String[] users, String modDeptId){
        Map<String, String> callBack = new HashMap<>();
        if(modDeptId == null || "".equals(modDeptId)){
            callBack.put("code","0");
            callBack.put("msg","请选择部门");
            return JSON.toJSONString(callBack);
        }
        if(users.length == 0){
            callBack.put("code","0");
            callBack.put("msg","请选择需要修改的员工");
            return JSON.toJSONString(callBack);
        }
        UserVo userVo = getSessionUservo();
        String comKey = userVo.getComKey();

        PageData modPd = new PageData();
        modPd.put("deptId",modDeptId);
        modPd.put("comKey",comKey);
        modPd.put("userKeys",users);
        employeeService.updateBatchByMap(modPd);
        callBack.put("code","1");
        callBack.put("msg","修改成功");
        return JSON.toJSONString(callBack);
    }

    /**
     * 调整角色
     * @param users
     * @param modRoleKey
     * @return
     */
    @RequestMapping(value = "changeRole")
    @ResponseBody
    public String changeRole(@RequestParam(value = "users") String[] users, String modRoleKey,HttpServletRequest request) throws Exception {
        Map<String, String> callBack = new HashMap<>();
        if(modRoleKey == null || "".equals(modRoleKey)){
            callBack.put("code","0");
            callBack.put("msg","请选择角色");
            return JSON.toJSONString(callBack);
        }
        if(users.length == 0){
            callBack.put("code","0");
            callBack.put("msg","请选择需要修改的员工");
            return JSON.toJSONString(callBack);
        }
        UserVo userVo = getSessionUservo();
        //
        for(int i = 0;i<users.length;i++){
            RoleUser roleUserMod = new RoleUser();
            roleUserMod.setUserKey(users[i]);
            roleUserMod.setComKey(userVo.getComKey());
            roleUserMod.setRoleKey(modRoleKey);
            roleService.updateRoleUser(roleUserMod);
        }
        callBack.put("code","1");
        callBack.put("msg","操作成功");
        return JSON.toJSONString(callBack);
    }
    
    @RequestMapping(value = "modifyPermission")
    @ResponseBody
    public String modifyPermission() throws Exception{
    	Map<String, String> callBack = new HashMap<>();
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
        if(StringUtil.isEmpty(pd.getString("userKey"))){
            callBack.put("code","0");
            callBack.put("msg","调整权限失败");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
        Employee employee = new Employee();
        employee.setUserKey(pd.getString("userKey"));
        employee.setMenuId(pd.getString("menuId"));
        employee.setComKey(userVo.getComKey());
        if(Const.INDUSTRY_GENERAL.equals(userVo.getDetailIndustryId())){
        	employee.setMenuId("RS-00,"+employee.getMenuId());
        }else{
        	employee.setMenuId("1-00,"+employee.getMenuId());
        }
    	Integer i = employeeService.updateEmployee(employee);
    	if(i.intValue() == 0){
    		callBack.put("code","0");
            callBack.put("msg","调整权限失败");
    	}else {
    		callBack.put("code","1");
            callBack.put("msg","调整权限成功");
		}
    	return JsonUtil.toCompatibleJSONString(callBack);
    }
    
    @RequestMapping(value = "updateEmployee")
    @ResponseBody
    public String updateEmployee(@RequestBody Employee employee) throws Exception{
    	Map<String, String> callBack = new HashMap<>();
    	UserVo userVo = this.getSessionUservo();
        if(employee==null){
            callBack.put("code","0");
            callBack.put("msg","修改失败");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
        employee.setRealName(employee.getName());
        employee.setUserId(employee.getPhone());
        employee.setComKey(userVo.getComKey());
        if (StringUtil.isEmpty(employee.getUserKey())) {
			employee.setUserKey(null);
		}
    	int result = employeeService.updateEmployee(employee);
    	if(result <=0 ){
    		callBack.put("code","0");
            callBack.put("msg","修改失败");
    	}else {
    		callBack.put("code","1");
            callBack.put("msg","修改成功");
		}
    	return JsonUtil.toCompatibleJSONString(callBack);
    }
    
    /**
     * 
     * @Title: updateEmployeeByParam 
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 修改员工信息，通过参数方式
     * 1. operType 
     */
    @RequestMapping(value = "updateEmployeeByParam", method = RequestMethod.PUT)
    @ResponseBody
    public String updateEmployeeByParam() throws Exception{
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("employeeId"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
    	int result = 0;
    	pd.put("comKey", this.getSessionUservo().getComKey());
    	if (CompanyEnum.EMPLOYEE_STATUS_DISMISSION.getCode().equalsIgnoreCase(pd.getString("operType"))) {
    		result = employeeService.updateDimissionEmployee(pd);
		}
    	if (result>0) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
    	}else{
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
    	}
    }
    
    @RequestMapping(value = "getMenuIdInitByIndustry")
    @ResponseBody
    public String getMenuIdInitByIndustry(){
    	UserVo userVo = this.getSessionUservo();
    	String industryId = userVo.getDetailIndustryId();
    	if (RentalTradeEnum.VERSION_FREE_EDITION.getCode().equalsIgnoreCase(userVo.getRentalVersion())) {
    		industryId = RentalTradeEnum.VERSION_FREE_EDITION.getCode();
		}
    	return JsonUtil.toCompatibleJSONString(employeeService.getMenuInitByIndustry(industryId));
    }
    
    @RequestMapping(value = "addEmployee")
    @ResponseBody
    public String newEmployee(@RequestBody Employee employee) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	Employee employeeValid = employeeService.getEmployeeByModel(employee.getPhone(), userVo.getComKey());
    	if (employeeValid!=null
    			&&!CompanyEnum.EMPLOYEE_STATUS_DISMISSION.getCode().equals(employeeValid.getStatus())) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error("已经创建该员工"));
		}
    	employee.setComKey(userVo.getComKey());
    	employee.setCreator(userVo.getUserKey());
    	employee.setIsValid("1");
    	employee.setIsAdmin("0");
    	employee.setIsBoss("0");
    	employee.setRealName(employee.getName());
    	employee.setUserId(employee.getPhone());
    	employee.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10)); //生成10位employeeId
    	employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_PENDING_INVITE.getCode()); //待邀请
    	int result = employeeService.insertEmployee(employee);
    	
    	if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("创建成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "创建失败"));
		}
    }
    
    @RequestMapping(value = "delEmployee")
    @ResponseBody
    public String deleteEmployee() throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	if (StringUtil.isEmpty(pd.getString("employeeId"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("请选择需要删除的员工"));
		}
    	int result = employeeService.deleteEmployee(pd);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除成功"));
    }
    
    

}
