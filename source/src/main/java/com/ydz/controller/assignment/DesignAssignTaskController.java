package com.ydz.controller.assignment;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.sql.CommonDataSource;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import sun.tools.tree.NewArrayExpression;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.assignment.AssignTaskDetail;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.system.Employee;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.AssignTaskService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AssignTaskController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月1日 下午4:42:08 
 * @Description: 任务派工控制器 
 */
@RestController
@RequestMapping(value = "order/assignment", produces = "plain/text; charset=UTF-8")
public class DesignAssignTaskController extends BaseController{
	
	@Resource private AssignTaskService assignTaskService;
	@Resource private EmployeeService employeeService;
	@Resource private CommonService commonService;
	
	/**
	 * 
	 * @Title: openAssignDesign 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 开启设计派工
	 */
	@RequestMapping(value = "openAssignDesign")
	public String openAssignDesign(){
		UserVo userVo = this.getSessionUservo();
		ComConfig comConfig = new ComConfig();
		comConfig.setComKey(userVo.getComKey());
		comConfig.setConfigKey(Const.COMPANY_CONFIG_ASSIGN_DESIGN);
		comConfig.setConfigValue("1");
		int result = commonService.insertComConfig(comConfig);
		if (result<1) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "开启失败"));
		}
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	
	@RequestMapping(value = "listDesignEmployee")
	public String listDesignEmployee(){
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("taskEmployees",assignTaskService.listTaskEmployees(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listAssignStandingBy 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 返回派工待办列表。
	 */
	@RequestMapping(value = "/listAssignStandingBy")
	public String listAssignStandingBy(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		if (StringUtil.isEmpty(pd.getString("startDate"))) {
			pd.put("startDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("endDate"))) {
			pd.put("endDate", null);
		}
		pd.put("orderType", OrderEnum.ATTR_TYPE_ASSIGN_DESIGN.getCode()); //开启了设计派工的才能被查询出来
		page.setPd(pd);
		page.setShowCount(50);
		List<AssignTask> assignTasks = assignTaskService.listTodoTask(page);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(assignTasks));
	}
	
	/**
	 * 
	 * @Title: listAssignEmployee 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 返回等待领工的员工列表
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/listAssignEmployee")
	public String listAssignEmployee(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		if(StringUtil.isNotEmpty(pd.getString("taskNo"))){
			resultMap.put("doingTaskEmployee",assignTaskService.listDoingTaskEmployees(pd.getString("taskNo")));
		}
		resultMap.put("taskEmployees",assignTaskService.listTaskEmployees(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listAssignTasks 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * 
	 * 1. type=1 任务分派 此处可以看到所有任务列表，包括不是自己的。相当于管理员委托
	 * 2. type=2 我的派工 只能看到属于自己的
	 * 
	 */
	@RequestMapping(value = "/listAssignTasks")
	public String listAssignTasks(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		ResultMap resultMap = ResultUtil.getResultMap();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		page.setShowCount(50);
		pd.put("comKey", userVo.getComKey());
		pd.put("staff", "1");
		if (userVo.getIsAdmin().equals("1")
				||userVo.getIsBoss().equals("1")) {
			resultMap.put("isAdmin", "1");
			if ("ALL".equalsIgnoreCase(pd.getString("taskEmployeeId"))) {
				pd.put("staff", null);
				pd.put("taskEmployeeId", null);
			}
		}else{
			if ("1".equalsIgnoreCase(pd.getString("type"))) {
				if ("ALL".equalsIgnoreCase(pd.getString("taskEmployeeId"))) {
					pd.put("staff", null);
					pd.put("taskEmployeeId", null);
				}
			}
			resultMap.put("isAdmin", "0");
			resultMap.put("userName", userVo.getRealName());
			Employee employee = employeeService.getEmployeeByDoubleKey(userVo.getUserKey(), userVo.getComKey(), null);
			pd.put("taskEmployeeId", employee.getEmployeeId());
		}
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		if (StringUtil.isEmpty(pd.getString("startDate"))) {
			pd.put("startDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("endDate"))) {
			pd.put("endDate", null);
		}
		page.setPd(pd);
		resultMap.setData(assignTaskService.listPageAssignTasks(page));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "/assignTask")
	public String assignTask(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		String salesNo = pd.getString("salesNo");
		String taskEmployeeIdIns = pd.getString("taskEmployeeId");
		String taskDesc = pd.getString("taskDesc");
		if (StringUtil.isEmpty(salesNo)||StringUtil.isEmpty(taskEmployeeIdIns)) {
			return JsonUtil.toJsonString(ResultUtil.error(1, "必须选择需要派工的员工"));
		}
		
		pd.put("comKey", userVo.getComKey());
		Page page = this.getPage();
		page.setShowCount(1);
		page.setPd(pd);
		List<AssignTask> assignTaskList = assignTaskService.listTodoTask(page);
		if(assignTaskList==null||assignTaskList.size()==0){
			return JsonUtil.toJsonString(ResultUtil.error(1, "派工失败请联系管理员"));
		}
		AssignTask assignTask = assignTaskList.get(0);
		assignTask.setTaskDesc(taskDesc);
		assignTask.setCreator(userVo.getUserKey());
		assignTask.setIndustryId(userVo.getDetailIndustryId());
		List<String> employeeIdList = Tools.strArray2List(StringUtil.StrList(taskEmployeeIdIns));
		List<AssignTaskDetail> assignTaskDetails = new ArrayList<>();
		AssignTaskDetail detail = null;
		for (String taskEmployeeId : employeeIdList) {
			detail = new AssignTaskDetail();
			detail.setTaskEmployeeId(taskEmployeeId);
			
			Employee employee = employeeService.getEmployeeByDoubleKey(null, userVo.getComKey(),taskEmployeeId);
			detail.setTaskUserName(employee.getRealName());
			detail.setTaskUserKey(employee.getUserKey());
			assignTaskDetails.add(detail);
		}
		assignTaskService.insertAssignTaskAndDetail(assignTask, assignTaskDetails);
		
		return JsonUtil.toJsonString(ResultUtil.successExec());
 	}
	
	/**
	 * 
	 * @Title: updateAssignTask 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改派工员工。已完工的不能修改
	 */
	@RequestMapping(value = "/updateAssignTask")
	public String updateAssignTask(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		String taskNo = pd.getString("taskNo");
		if(StringUtil.isEmpty(taskNo)){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "请选择有效的派工单"));
		}
		
//		pd.put("taskUserKeyIns", Tools.strSqlIn(pd.getString("taskUserKey"))); //被勾选的员工，包括已完工的
		pd.put("taskEmployeeIdIns", Tools.strSqlIn(pd.getString("taskEmployeeId"))); //被勾选的员工，包括已完工的
		pd.put("comKey", userVo.getComKey());
		pd.put("userKey", userVo.getUserKey());
		
		assignTaskService.updateNewAssignTask(pd);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	/**
	 * 
	 * @Title: doneTask 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 完成派工的操作
	 */
	@RequestMapping(value = "/doneTask")
	public String doneTask(HttpServletRequest request){
		PageData pd = this.getPageData();
		if(StringUtil.isEmpty(pd.getString("taskNo"))){
			
		}
		pd.put("taskNoIns", Tools.strSqlIn(pd.getString("taskNo")));
		UserVo userVo = this.getSessionUservo();
		try {
			if (userVo.getIsAdmin().equals("1")
					||userVo.getIsBoss().equals("1")) { //老板或管理员操作批量完成
				pd.put("comKey", userVo.getComKey());
				pd.put("status", AssignEnum.ASSIGN_STATUS_DONE.getCode());
				pd.put("finishDate", new Date());
				assignTaskService.updateDoneTaskByAdmin(pd);
			}else {
				assignTaskService.updateBatchDoneTaskByStaff(pd.getString("taskNo"), userVo.getComKey(), userVo.getUserKey());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	

}
