/**   
 * @Title: AppWorkingAssignController.java 
 * @Package com.ydz.app.controller 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 12, 2018 8:08:27 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.app.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.assignment.WorkingAssignTaskController;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.assignment.AssignWorkingTask;
import com.ydz.entity.assignment.AssignWorkingTaskDetail;
import com.ydz.entity.assignment.AssignWorkingTaskDetailVO;
import com.ydz.service.advert.WorkingAssignTaskService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppWorkingAssignController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 12, 2018 8:08:27 PM 
 * @Description: 制作派工App控制器  
 */
@RestController
@RequestMapping(value = "app/assign", produces = "application/json;charset=UTF-8")
public class AppWorkingAssignController extends BaseController{
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private WorkingAssignTaskService workingAssignTaskService;
	
	//制作派工列表
	@RequestMapping(value = "working/listWorkingAssignTasks", method = RequestMethod.GET)
	public String listWorkingAssignTasks(){
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = this.getPageData();
		Page page = this.getPageWithParameter();
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
		page.setPd(pd);
		List<AssignWorkingTask> assignWorkingTasks = workingAssignTaskService.selectListAssignWorkingTasks(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(assignWorkingTasks);
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//制作派工单和明细
	@RequestMapping(value = "working/detailWorkingAssignTask", method = RequestMethod.GET)
	public String detailWorkingAssignTask(){
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		AssignWorkingTask task = workingAssignTaskService.selectOneAssignWorkingTask(pd);
		List<AssignWorkingTaskDetail> details = workingAssignTaskService.selectListAssignWorkingTaskDetail(pd);
		
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("order", task);
		resultMap.put("details", details);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listAssignWorkingTaskAndDetails 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 协同采购单查看制作派工详情
	 */
	@RequestMapping(value = "working/listAssignWorkingTaskAndDetails", method = RequestMethod.GET)
	public String listAssignWorkingTaskAndDetails(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("salesNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无数据"));
		}
		Page page = this.getPageWithParameter();
		pd.put("detail", "1");
		page.setPd(pd);
		List<AssignWorkingTaskDetailVO> detailVOs = workingAssignTaskService.listAssignWorkingTaskDetailVOs(page);
		ResultMap resultMap =ResultUtil.getResultMap();
		resultMap.setRows(detailVOs);
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
}
