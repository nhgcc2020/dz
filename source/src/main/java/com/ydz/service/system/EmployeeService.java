package com.ydz.service.system;

import com.alibaba.fastjson.JSON;
import com.ydz.dao.common.MenuInitDictMapper;
import com.ydz.dao.common.SmsLogMapper;
import com.ydz.dao.system.CompanyMapper;
import com.ydz.dao.system.EmployeeMapper;
import com.ydz.dao.system.RoleUserMapper;
import com.ydz.dao.system.UserMapper;
import com.ydz.entity.advert.SalesMan;
import com.ydz.entity.common.MenuInitDict;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.exception.CompanyException;
import com.ydz.service.common.CommonService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.SelectVo;
import com.ydz.vo.UserVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


@Service("employeeService")
public class EmployeeService {

	@Resource
	private RedisUtil redisUtil;
	
	@Lazy
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Autowired 
	@Lazy
	private UserService userService;
	
	@Autowired private RoleUserMapper roleUserMapper;
	
	@Autowired private EmployeeMapper employeeMapper;
	@Resource  private SmsLogMapper smsLogMapper;
	
	@Autowired private MenuInitDictMapper menuInitDictMapper;
	
	@Autowired private CompanyMapper companyMapper;

	/**
	 * 
	 * @Title: getEmployees 
	 * @param pd
	 * @return
	 * @return List<Employee>
	 * @throws 
	 * @Description: 获取公司的员工信息，单表获取，支持获取非管理员非老板的所有员工
	 */
	public List<Employee> getEmployees(PageData pd){
		return employeeMapper.selectByPrimaryKey(pd);
	}


	/**
	 * 批量修改员工信息
	 * @param pd
	 * @return
	 */
	public int updateBatchByMap(PageData pd){
		return employeeMapper.updateBatchByMap(pd);
	}

	//注册员工
	public int saveEmpBySignIn(Employee employee){
		return employeeMapper.insertSelective(employee);
	}

	/**
	 * 
	* @Title: getList4order 
	* @param pd comKey，status
	* @return
	* @throws Exception
	* @return List<SalesMan>
	* @throws 
	* @Description: 查询销售代表列表，作为下拉框使用。
	 */
	public List<SalesMan> getList4order(PageData pd) throws Exception {
		pd.put("statusValid", Tools.strSqlIn("0,1,2,3"));
		return employeeMapper.getList4order(pd);
	}
	
	/**
	 * 
	 * @Title: getAllEmployeesForDropdown 
	 * @param pd comKey
	 * @return
	 * @return List<Employee>
	 * @throws 
	 * @Description: 获取所有公司员工列表
	 */
	public List<Employee> getAllEmployeesForDropdown(PageData pd){
		pd.put("statusValid", Tools.strSqlIn("0,1,2,3"));
		return employeeMapper.getEmployeesForDropdown(pd);
	}
	
	/**
	 * 
	 * @Title: getAllEmployeesForDropdown 
	 * @param pd comKey
	 * @return
	 * @return List<Employee>
	 * @throws 
	 * @Description: 获取所有公司员工列表
	 */
	public List<Employee> getRegisteEmployeesForDropdown(PageData pd){
		pd.put("statusValid", Tools.strSqlIn("3"));
		return employeeMapper.getEmployeesForDropdown(pd);
	}
	
	/**
	 * 
	 * @Title: getAdminEmployee 
	 * @param pd
	 * @return
	 * @return Employee
	 * @throws 
	 * @Description: 获取公司的管理员
	 */
	public Employee getAdminEmployee(PageData pd){
		List<Employee> employees = employeeMapper.getEmployeesForDropdown(pd);
		if(employees!=null&&employees.size()>0){
			return employees.get(0);
		}else{
			return null;
		}
	}
	
	/**
	 * 
	 * @Title: getStaffEmployeesForDropdown 
	 * @param pd comKey
	 * @return
	 * @return List<Employee>
	 * @throws 
	 * @Description: 获取非管理员及非老板的全部普通员工
	 */
	public List<Employee> getStaffEmployeesForDropdown(PageData pd){
		pd.put("staff", "1");
		return this.getAllEmployeesForDropdown(pd);
	}

	/**
	 * 
	* @Title: getAllEmployee 
	* @param pd
	* @return
	* @throws Exception
	* @return List<EmployeeVo>
	* @throws 
	* @Description: 根据指定的参数值查询公司员工列表
	 */
	public List<EmployeeVo> getAllEmployee(PageData pd)throws Exception{
		List<EmployeeVo> employees = employeeMapper.getAllInfo(pd);
		for (EmployeeVo employeeVo : employees) {
			employeeVo.setStatusView(commonService.formatEmployeeStatus(employeeVo.getStatus()));
		}
		return employees;
	}

	/**
	 * 
	* @Title: getAllEmployeeAsVo 
	* @param comKey
	* @return
	* @throws Exception
	* @return List<SelectVo>
	* @throws 
	* @Description: 查询公司员工的列表值对象 userKey=value，realName=text
	 */
	public List<SelectVo> getAllEmployeeAsVo(String comKey)throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		return employeeMapper.getAllInfoAsVo(pd);
	}
	
	public int insertEmployee(Employee employee) throws Exception{
		Date nowDate = new Date();
		employee.setCreateTime(nowDate);
		return employeeMapper.insertSelective(employee);
	}

	/**
	 * 
	* @Title: modifyEmployee 
	* @param employee
	* @return
	* @throws Exception
	* @return Integer
	* @throws 
	* @Description: 修改员工信息
	 */
	public int updateEmployee(Employee employee) throws Exception {
		return employeeMapper.updateByPrimaryKeySelective(employee);
	}

    public Integer modifyByUserIdSelective(Employee employee) throws Exception {
        return (Integer) employeeMapper.updateByUserIdSelective(employee);
    }
    
    public int deleteEmployee(PageData pd) throws Exception{
    	if (StringUtil.isNotEmpty(pd.getString("userKey"))) {
    		this.updateDefaultCompany(pd);
		}
    	return employeeMapper.deleteByPrimaryKey(pd);
    }
    
    public int updateDefaultCompany(PageData pd) throws Exception{
    	Employee employee = employeeMapper.selectOneByKey(pd);
    	pd.put("comType", CompanyEnum.COM_TYPE_PERSONAL.getCode());
    	pd.put("creator", employee.getUserKey());
    	pd.put("comKey", null);
    	Company company= companyMapper.selectByComKey(pd).get(0);
    	User user = new User();
    	user.setUserKey(employee.getUserKey());
    	user.setDefaultCom(company.getComKey());
//    	userMapper.updateByUserKey(user);
    	userService.updateUser(user);
    	return 0;
    }

	//后台管理员邀请操作
	public Map<String,Object> inviteEmployee(UserVo userVo, Employee employee) throws Exception {
		//回调
		Map<String,Object> callback = new HashMap<>();
		
//		//判断该用户是否已经为员工
//		PageData pdDuplicate = new PageData();
//		pdDuplicate.put("userId",employee.getUserId());
//		pdDuplicate.put("comKey",userVo.getComKey());
//		List<Employee> empList = employeeMapper.selectByPrimaryKey(pdDuplicate);
//		if(empList.size() > 0){
//			callback.put("state","0");
//			callback.put("msg","您已邀请该员工");
//			return callback;
//		}

//		//查看该用户是否为新用户
//		PageData pd = new PageData();
//		pd.put("userId",employee.getUserId());
//		User userResult = userMapper.selectAuthorByUserId(pd);
//		if(userResult != null){
//			//2.如果不是则获取该用户信息 直接添加至员工表并赋予 部门和角色
//			callback.put("state","0");
//			callback.put("type","registered");
//			callback.put("msg","该员工已为系统用户");
//			return callback;
//		}else{
//			Date nowDate = new Date();
//			//1.首先添加员工信息 并 设置员工信息的状态为邀请中
//			employee.setComKey(userVo.getComKey());
//			employee.setRealName(employee.getName());
//			employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_INVITING.getCode());
//			employee.setIsValid("1");
//			employee.setCreator(userVo.getUserKey());
//			employee.setCreateTime(nowDate);
//			
//			employee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+userVo.getDetailIndustryId()));
//			employee.setPermissionCode("");
//			
//			employeeMapper.insertSelective(employee);
//			
//			//如果是发送邀请注册连接（部门录入DB，角色则加密串放入邀请url中）
//			//生成參數
//			//查询参数
//			Map<String,Object> map = new HashMap<>();
//			map.put("invitee",employee.getUserId()); //被邀请者
//			map.put("comKey",userVo.getComKey());
//			map.put("roleKey",employee.getRoleKey());
//			map.put("inviter",userVo.getUserKey()); //邀请者
//			map.put("name", employee.getName());
//			String json = JSON.toJSONString(map);
//			String key = CipherUtil.encrypt(json);
//			
//			String para =  "/invite/emp/signUpPage?key="+key;
//			String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
//			String codeKey = "j_"+ranCode;
//			redisUtil.setIntervalDay(codeKey,para,30);
//			Map resultMap =  SMSUtil.sendInviteEmpMsg(userVo.getComName(),userVo.getRealName(),"jh/"+ranCode+" ",employee.getUserId());
//			
//			SmsLog smsLog = new SmsLog(); 					//新建一条短信记录
//			smsLog.setSmsType(MessageEnum.SMS_INVITE_EMPLOYEE.getCode()); //邀请员工
//			smsLog.setSmsFrom(userVo.getComKey()); //发送者
//			smsLog.setSmsTo(employee.getUserId()); //接收者
//			smsLog.setSmsContent(codeKey); //短信内容 如果是邀请类型 存放redis中的短连接的KEY
//			smsLog.setSmsResult(JSON.toJSONString(resultMap)); //短信返回值
//			smsLog.setCreator(userVo.getUserKey()); //创建人
//			smsLog.setCreateTime(new Date()); //创建时间
//			smsLogMapper.insert(smsLog);
//			
//			callback.put("state","1");
//			callback.put("msg","邀请成功");
//		}
		
//		//查看该用户是否为新用户
		PageData pd = new PageData();
		pd.put("userId",employee.getUserId());
//		User userResult = userMapper.selectAuthorByUserId(pd);
		User userResult = userService.getAuthorByUserId(pd);
		if(userResult != null){
			//2.如果不是则获取该用户信息 直接添加至员工表并赋予 部门和角色
			callback.put("code","0");
			callback.put("type","registered");
			callback.put("msg","该员工已为系统用户");
			return callback;
		}
		
		Employee newEmployee = new Employee();
		newEmployee.setComKey(userVo.getComKey());
		newEmployee.setStatus(CompanyEnum.EMPLOYEE_STATUS_INVITING.getCode());
//		newEmployee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+userVo.getDetailIndustryId()));
		newEmployee.setMenuId("1-00"); //员工默认只有工作台
		newEmployee.setPermissionCode("");
		newEmployee.setUserId(employee.getUserId());
		employeeMapper.updateByPrimaryKeySelective(newEmployee);
		
		//如果是发送邀请注册连接（部门录入DB，角色则加密串放入邀请url中）
		//生成參數
		//查询参数
		Map<String,Object> map = new HashMap<>();
		map.put("invitee",employee.getUserId()); //被邀请者
		map.put("comKey",userVo.getComKey());
		map.put("roleKey",employee.getRoleKey());
		map.put("inviter",userVo.getUserKey()); //邀请者
		map.put("name", employee.getName());
		String json = JSON.toJSONString(map);
		String key = CipherUtil.encrypt(json);

		String para =  "/invite/emp/signUpPage?key="+key;
		String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
		String codeKey = "j_"+ranCode;
		redisUtil.setIntervalDay(codeKey,para,30);
		Map resultMap =  SMSUtil.sendInviteEmpMsg(userVo.getComName(),userVo.getRealName(),"jh/"+ranCode+" ",employee.getUserId());
		
		SmsLog smsLog = new SmsLog(); 					//新建一条短信记录
		smsLog.setSmsType(MessageEnum.SMS_INVITE_EMPLOYEE.getCode()); //邀请员工
		smsLog.setSmsFrom(userVo.getComKey()); //发送者
		smsLog.setSmsTo(employee.getUserId()); //接收者
		smsLog.setSmsContent(codeKey); //短信内容 如果是邀请类型 存放redis中的短连接的KEY
		smsLog.setSmsResult(JSON.toJSONString(resultMap)); //短信返回值
		smsLog.setCreator(userVo.getUserKey()); //创建人
		smsLog.setCreateTime(new Date()); //创建时间
		smsLogMapper.insert(smsLog);

		callback.put("code","1");
		callback.put("msg","邀请成功");
		
		return callback;
	}

	//根据用户手机号在员工表中查询员工信息
	public Employee getEmployeeByModel(String userId,String comKey) throws Exception {
		PageData pd = new PageData();
		pd.put("userId",userId);
		pd.put("comKey",comKey);
		List<Employee>	employees = employeeMapper.selectByPrimaryKey(pd);
		if(employees.size() == 1){
			return employees.get(0);
		}else{
			return null;
		}
	}

	/**
	 * 
	 * @Title: getEmployeeByDoubleKey 
	 * @param userKey
	 * @param comKey
	 * @return
	 * @throws Exception
	 * @return Employee
	 * @throws 
	 * @Description: 根据comKey和userKey和employeeId查询员工信息
	 */
	public Employee getEmployeeByDoubleKey(String userKey,String comKey,String employeeId){
		PageData pd = new PageData();
		pd.put("userKey",userKey);
		pd.put("employeeId",employeeId);
		pd.put("comKey",comKey);
		List<Employee>	employees = employeeMapper.selectByPrimaryKey(pd);
		if(employees.size() == 1){
			return employees.get(0);
		}else{
			return null;
		}
	}

	public EmployeeVo getAdmin(String comKey) throws Exception {
		PageData pd = new PageData();
		pd.put("isAdmin","1");
		pd.put("comKey",comKey);
		List<EmployeeVo> employees = employeeMapper.getAllInfo(pd);
		if(employees!=null&&employees.size()>0){
			return employees.get(0);
		}else{
			return null;
		}
	}

	public EmployeeVo getBoss(String comKey) throws Exception {
		PageData pd = new PageData();
		pd.put("isBoss","1");
		pd.put("comKey",comKey);
		List<EmployeeVo> employees = employeeMapper.getAllInfo(pd);
		if(employees!=null && employees.size() > 0){
			return employees.get(0);
		}else{
			return null;
		}
	}

	/**
	 * 转移管理员权限
	 * @return
     */
	public Map<String,Object> updateTransferOfRights(UserVo userVo,String newAdminUserKey,String roleKey) throws Exception {
		Map<String,Object> result = new HashMap<>();
		//查询当前操作人
		PageData pageData =  new PageData();
		pageData.put("comKey",userVo.getComKey());
		pageData.put("userKey",userVo.getUserKey());
		List<Employee> employees = employeeMapper.selectByPrimaryKey(pageData);
		if(employees.size() == 0){
			return null;
		}

		Employee employee = employees.get(0);
		//新管理员的查询条件
		PageData pd = new PageData();
		pd.put("comKey",userVo.getComKey());
		pd.put("userKey",newAdminUserKey);

		List<Employee> newEmployees = employeeMapper.selectByPrimaryKey(pd);
		Employee newAdminEmployee = newEmployees.get(0);

		if(newAdminEmployee != null && newAdminEmployee.equals(userVo.getUserKey())){
			result.put("state",false);
			result.put("msg","不能转移自己");
		}
		if("1".equals(employee.getIsBoss())){
			//即是法人 又是管理员
			if("1".equals(employee.getIsAdmin())){
				return this.transferOfRights(employee,newAdminEmployee);
			}else{
				//是法人但不是管理员
				//查看当前管理员是否有角色
				EmployeeVo employeeVo = this.getAdmin(userVo.getComKey());

				Employee employee1 = new Employee();
				employee1.setComKey(employeeVo.getComKey());
				employee1.setUserKey(employeeVo.getUserKey());

				PageData pdRole = new PageData();
				pdRole.put("comKey",userVo.getComKey());
				pdRole.put("userKey",employeeVo.getUserKey());
				List<RoleUser> roleUsers = roleUserMapper.selectByPrimaryKey(pdRole);
				if(roleUsers.size()>0){
					return this.transferOfRights(employee1,newAdminEmployee);
				}else{
					if(roleKey == null || "".equals(roleKey)){
						result.put("state",false);
						result.put("type","needRole");
						result.put("msg","当前用户不为管理员或者法人");
						return result;
					}else{
						result = this.transferOfRights(employee1,newAdminEmployee);
						//给当前管理员赋予角色
						RoleUser roleUser = new RoleUser();
						roleUser.setUserKey(employee1.getUserKey());
						roleUser.setRoleKey(roleKey);
						roleUser.setComKey(employee1.getComKey());
						roleUser.setCreator(userVo.getUserKey());
						roleUser.setCreateTime(new Date());
						roleUserMapper.insertSelective(roleUser);
						return result;
					}
				}
			}
		}else if("1".equals(employee.getIsAdmin())){
			//查看当前管理员是否有角色
			PageData pdRole = new PageData();
			pdRole.put("comKey",userVo.getComKey());
			pdRole.put("userKey",userVo.getUserKey());
			List<RoleUser> roleUsers = roleUserMapper.selectByPrimaryKey(pdRole);
			if(roleUsers.size()>0){
				return this.transferOfRights(employee,newAdminEmployee);
			}else{
				if(roleKey == null || "".equals(roleKey)){
					result.put("state",false);
					result.put("type","needRole");
					result.put("msg","请赋予当前管理员角色");
					return result;
				}else{
					result = this.transferOfRights(employee,newAdminEmployee);
					//给当前管理员赋予角色
					RoleUser roleUser = new RoleUser();
					roleUser.setUserKey(employee.getUserKey());
					roleUser.setRoleKey(roleKey);
					roleUser.setComKey(employee.getComKey());
					roleUser.setCreator(userVo.getUserKey());
					roleUser.setCreateTime(new Date());
					roleUserMapper.insertSelective(roleUser);
					return result;
				}
			}
		}else{
			result.put("state",false);
			result.put("msg","当前用户不为管理员或者法人");
			return result;
		}
	}

	public Map<String,Object> transferOfRights(Employee oldEmployee,Employee newAdminEmployee) throws Exception {
		Map<String,Object> result = new HashMap<>();
		//1.当前操作用户为法人
		//修改当前管理员 对应员工信息的isAdmin字段为0
		Employee employeePara = new Employee();
		employeePara.setComKey(oldEmployee.getComKey());
		employeePara.setUserKey(oldEmployee.getUserKey());
		employeePara.setIsAdmin("0");
		Integer oldResult = (Integer) employeeMapper.updateByPrimaryKeySelective(employeePara);

		//修改新管理员  对应员工信息的isAdmin字段为1
		Employee  newAdminEmployeePara = new Employee();
		newAdminEmployeePara.setUserKey(newAdminEmployee.getUserKey());
		newAdminEmployeePara.setComKey(newAdminEmployee.getComKey());
		newAdminEmployeePara.setIsAdmin("1");
		Integer newResult = (Integer) employeeMapper.updateByPrimaryKeySelective(newAdminEmployeePara);
		if(oldResult < 1 || newResult < 1){
			result.put("state",false);
			result.put("msg","SQL执行出错");
		}else {
			result.put("state",true);
			result.put("msg","权限成功转移");
		}
		return result;
	}

	public LinkedList<MenuInitDict> getMenuInitByIndustry(String industryId){
		PageData pd = new PageData();
		String menuIdIndustry = commonService.getDictValue(Const.MENU_ID_INIT+industryId);
		List<String> menuIdPara = Tools.strArray2List(Tools.str2StrArray(menuIdIndustry, ","));
		
		pd.put("menuIdList", menuIdPara);
		return menuInitDictMapper.selectMenuByInit(pd);
	}
	
	/**
	 * 
	 * @Title: updateDimissionEmployee 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 员工离职处理
	 */
	public int updateDimissionEmployee(PageData pd) throws Exception{
		//员工状态修改为离职
		//用户表的isValid=0
		pd.put("status", CompanyEnum.EMPLOYEE_STATUS_DISMISSION.getCode());
		int result = this.updateBatchByMap(pd);
		if (result>0) {
//			Employee employee = this.getEmployeeByDoubleKey(null, pd.getString("comKey"), pd.getString("employeeId"));
//			if (employee!=null) {
//				User user = new User();
//				user.setUserKey(employee.getUserKey());
////				user.setIsValid("0");
//				
////				result = userService.updateUser(user);
//				if (result<0) {
//					throw new CompanyException("员工离职失败");
//				}
//			}
		}else{
			throw new CompanyException("员工离职失败");
		}
		return result;
	}

}
