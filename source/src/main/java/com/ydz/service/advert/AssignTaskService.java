package com.ydz.service.advert;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.assignment.AssignTaskDetailMapper;
import com.ydz.dao.assignment.AssignTaskMapper;
import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.assignment.AssignTaskDetail;
import com.ydz.entity.system.Employee;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;

/** 
 * @ClassName: AssignTaskService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月30日 下午3:56:32 
 * @Description: 广告派工服务类
 */
@Service
public class AssignTaskService {
	
	@Autowired private AssignTaskMapper assignTaskMapper;
	@Autowired private AssignTaskDetailMapper assignTaskDetailMapper;
	
	@Resource private EmployeeService employeeService;
	
	
	/**
	 * 
	 * @Title: listTaskEmployees 
	 * @param pd
	 * @return
	 * @return List<Employee>
	 * @throws 
	 * @Description: 允许派工的员工只能是注册过账号的
	 */
	public List<Employee> listTaskEmployees(PageData pd){
		return employeeService.getRegisteEmployeesForDropdown(pd);
	}
	
	public List<AssignTaskDetail> listDoingTaskEmployees(String taskNo){
		PageData pd = new PageData();
		pd.put("taskNo", taskNo);
		return assignTaskDetailMapper.selectDoingTaskEmployee(pd);
	}
	
//	public Employee getOneTaskEmployee(String comKey,String status, String staff){
//		List<Employee> employees= this.listTaskEmployees(comKey, status, staff);
//		if(employees!=null && employees.size()==1){
//			return employees.get(0);
//		}
//		return null;
//	}
	
	/**
	 * 
	 * @Title: listTodoTask 
	 * @param comKey
	 * @return
	 * @return List<AssignTask>
	 * @throws 
	 * @Description: 待分派的列表。从待对账已对账的销售订单中查询获取
	 */
	public List<AssignTask> listTodoTask(Page page){
		return assignTaskMapper.listPageTodoTask(page);
	}
	
	/**
	 * 
	 * @Title: listAssignTask 
	 * @param taskUserKey,comKey,status,startDate,endDate,partnerKey
	 * @return
	 * @return List<AssignTask>
	 * @throws 
	 * @Description: 查询派工任务列表
	 */
	public List<AssignTask> listPageAssignTasks(Page page){
		return assignTaskMapper.listPageAssignTasks(page);
	}
	
	public int insertAssignTaskAndDetail(AssignTask assignTask,List<AssignTaskDetail> assignTaskDetails){
		Date nowDate = new Date();
		assignTask.setTaskNo(CodeBuilderUtil.getInstance().getAnyId(10));
		assignTask.setStatus(AssignEnum.ASSIGN_STATUS_DESIGNING.getCode());
		assignTask.setTaskDate(nowDate);
		assignTask.setCreateTime(nowDate);
		assignTask.setIsDel("0");
		assignTask.setIsValid("1");
		
		int i = 1;
		for (AssignTaskDetail detail : assignTaskDetails) {
			detail.setItemNo(i++);
			detail.setTaskNo(assignTask.getTaskNo());
			detail.setStatus(AssignEnum.ASSIGN_STATUS_DESIGNING.getCode());
			detail.setCreator(assignTask.getCreator());
			detail.setCreateTime(nowDate);
		}
		
		assignTaskDetailMapper.insertList(assignTaskDetails);
		int result = assignTaskMapper.insertSelective(assignTask);
		return result;
	}
	
	public void updateBatchDoneTaskByStaff(String taskNoIns,String comKey,String taskUserKey){
		List<String> taskNoList = Tools.strArray2List(StringUtil.StrList(taskNoIns));
		for (String taskNo : taskNoList) {
			this.updateDoneAssignTaskAndDetail(taskNo, comKey, taskUserKey);
		}
	}
	
	/**
	 * 
	 * @Title: updateDoneAssignTaskAndDetail 
	 * @param taskNo
	 * @param comKey
	 * @param taskUserKey
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 更新派工任务——》已完工
	 */
	public int updateDoneAssignTaskAndDetail(String taskNo,String comKey,String taskUserKey){
		if(StringUtil.isEmpty(taskNo)
				&&StringUtil.isEmpty(taskUserKey)){
			return 0;
		}
		Date nowDate = new Date();
		
		AssignTaskDetail detailNew = new AssignTaskDetail();
		detailNew.setTaskNo(taskNo);
		detailNew.setTaskUserKey(taskUserKey);
		detailNew.setFinishDate(nowDate);
		detailNew.setStatus(AssignEnum.ASSIGN_STATUS_DONE.getCode());
		assignTaskDetailMapper.updateByPrimaryKeySelective(detailNew);
		
		PageData pd = new PageData();
		pd.put("taskNo", taskNo);
		Page page = new Page();
		page.setShowCount(300);
		page.setPd(pd);
		List<AssignTaskDetail> details = assignTaskDetailMapper.listPageByPrimaryKey(page);
		boolean doneAll = true;
		for (AssignTaskDetail detail : details) {
			if(!AssignEnum.ASSIGN_STATUS_DONE.getCode()
					.equalsIgnoreCase(detail.getStatus())){
				doneAll = false;
			}
		}
		if (!doneAll) {
			return 1;
		}else{
			AssignTask assignTask = new AssignTask();
			assignTask.setTaskNo(taskNo);
			assignTask.setComKey(comKey);
			assignTask.setFinishDate(nowDate);
			assignTask.setStatus(AssignEnum.ASSIGN_STATUS_DONE.getCode());
			return assignTaskMapper.updateByPrimaryKeySelective(assignTask);
		}
	}
	
	/**
	 * 
	 * @Title: doneTaskByAdmin 
	 * @param status,finishDate,comKey,taskNoIns
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 管理员或老板进行的批量完工操作
	 */
	public int updateDoneTaskByAdmin(PageData pd){
		assignTaskDetailMapper.updateBatch(pd);
		return assignTaskMapper.updateBatch(pd);
	}
	
	public int updateBatchAssignTask(PageData pd){
		return assignTaskMapper.updateBatch(pd);
	}
	
	/**
	 * 
	 * @Title: listValidDetail 
	 * @param pd
	 * @return
	 * @return List<AssignTaskDetail>
	 * @throws 
	 * @Description: 查询有效的派工员工记录。
	 * 1. 被勾选的员工中，如果已经存在的，需要查询出来。
	 * 2. 无论是否被勾选，已完工的要被查询出来
	 */
	public List<AssignTaskDetail> listValidDetail(PageData pd){
		return assignTaskDetailMapper.selectValidTaskDetail(pd);
	}
	
	public int updateNewAssignTask(PageData pd){
		List<AssignTaskDetail> validDetails = this.listValidDetail(pd);
		Map<String, AssignTaskDetail> validMap = new HashMap<String, AssignTaskDetail>();
		for (AssignTaskDetail assignTaskDetail : validDetails) {
			validMap.put(assignTaskDetail.getTaskEmployeeId(), assignTaskDetail);
		}
		
		List<AssignTaskDetail> newAssignTaskDetails = new ArrayList<>();
		AssignTaskDetail newDetail = null;
		Date nowDate = new Date();
		List<String> newEmpList = Tools.strArray2List(StringUtil.StrList(pd.getString("taskEmployeeId")));
		int i = 1;
		for (String taskEmployeeId : newEmpList) {
			newDetail = new AssignTaskDetail();
			if (validMap.get(taskEmployeeId)!=null) {
				BeanutilsCopy.apacheCopyProperties(newDetail, validMap.get(taskEmployeeId));
			}else{
				newDetail.setTaskNo(pd.getString("taskNo"));
				newDetail.setStatus(AssignEnum.ASSIGN_STATUS_DESIGNING.getCode());
				newDetail.setCreateTime(nowDate);
				newDetail.setCreator(pd.getString("userKey"));
				newDetail.setTaskEmployeeId(taskEmployeeId);
				Employee employee = employeeService.getEmployeeByDoubleKey(null, pd.getString("comKey"),taskEmployeeId);
				newDetail.setTaskUserName(employee.getRealName());
				newDetail.setTaskUserKey(employee.getUserKey());
			}
			newDetail.setItemNo(i++);
			newAssignTaskDetails.add(newDetail);
		}
		AssignTask assignTask = new AssignTask();
		assignTask.setTaskNo(newAssignTaskDetails.get(0).getTaskNo());
		assignTask.setTaskDesc(pd.getString("taskDesc"));
		assignTask.setComKey(pd.getString("comKey"));
		//先删除原派工单明细
		pd.clear();
		pd.put("taskNo", newAssignTaskDetails.get(0).getTaskNo());
		assignTaskDetailMapper.deleteByPrimaryKey(pd);
		assignTaskDetailMapper.insertList(newAssignTaskDetails);
		assignTaskMapper.updateByPrimaryKeySelective(assignTask);
		
		//如果新的派工分配人中都已经完工了，那么该派工单也应该完工。
		boolean doneAll = true;
		for (AssignTaskDetail detail : newAssignTaskDetails) {
			if(!AssignEnum.ASSIGN_STATUS_DONE.getCode()
					.equalsIgnoreCase(detail.getStatus())){
				doneAll = false;
			}
		}
		if (!doneAll) {
			return 1;
		}else{
			AssignTask assignTaskNew = new AssignTask();
			assignTaskNew.setTaskNo(assignTask.getTaskNo());
			assignTaskNew.setComKey(assignTask.getComKey());
			assignTaskNew.setFinishDate(nowDate);
			assignTaskNew.setStatus(AssignEnum.ASSIGN_STATUS_DONE.getCode());
			return assignTaskMapper.updateByPrimaryKeySelective(assignTaskNew);
		}
	}

}
