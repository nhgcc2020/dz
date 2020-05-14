/**   
 * @Title: AppDesignAssignController.java 
 * @Package com.ydz.app.controller 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 7, 2017 10:03:07 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.app.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.service.advert.AssignTaskService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppDesignAssignController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 7, 2017 10:03:07 AM 
 * @Description: App设计派工控制器
 */
@RestController
@RequestMapping(value = "app/assign", produces = "application/json;charset=UTF-8")
public class AppDesignAssignController extends BaseController{
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Resource
	private AssignTaskService assignTaskService;
	
	//查询设计派工列表
	@RequestMapping(value = "design/listAssignTasks")
	public String listAssignTasks() throws Exception{
		UserVo userVo = this.getAppCurrentUserVo();
		ResultMap resultMap = ResultUtil.getResultMap();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		
		pd.put("staff", null);
		pd.put("taskEmployeeId", null);
		
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		if (StringUtil.isEmpty(pd.getString("status"))) {
			pd.put("status", "1");
		}
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		
		page.setPd(pd);
		resultMap.setData(assignTaskService.listPageAssignTasks(page));
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "design/updateAssignTask",method = RequestMethod.POST)
	public String updateAssignTask(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = this.getPageData();
		String taskNo = pd.getString("taskNo");
		if(StringUtil.isEmpty(taskNo)){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "请选择有效的派工单"));
		}
		
//		pd.put("taskUserKeyIns", Tools.strSqlIn(pd.getString("taskUserKey"))); //被勾选的员工，包括已完工的
		pd.put("taskEmployeeIdIns", Tools.strSqlIn(pd.getString("taskEmployeeId"))); //被勾选的员工，包括已完工的
		pd.put("comKey", userVo.getComKey());
		pd.put("userKey", userVo.getUserKey());
//		pd.put("taskDesc",  new String(pd.getString("taskDesc").getBytes("ISO-8859-1"),"UTF-8"));
		assignTaskService.updateNewAssignTask(pd);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	
	@RequestMapping(value = "design/listAssignEmployee")
	public String listAssignEmployee(HttpServletRequest request){
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		if(StringUtil.isNotEmpty(pd.getString("taskNo"))){
			resultMap.put("doingTaskEmployee",assignTaskService.listDoingTaskEmployees(pd.getString("taskNo")));
		}
		resultMap.put("taskEmployees",assignTaskService.listTaskEmployees(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
}
