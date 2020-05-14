/**   
 * @Title: AppOpportunityController.java 
 * @Package com.ydz.app.controller 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 2, 2018 7:46:03 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.app.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.ProjectEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.OpportunityService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.DateUtil;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppOpportunityController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 2, 2018 7:46:03 PM 
 * @Description: 商机报价的App控制器
 */
@RestController
@RequestMapping(value = "app/opportunity", produces = "application/json;charset=UTF-8")
public class AppOpportunityController extends BaseController{
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private OpportunityService opportunityService;
	@Autowired
	private PartnerService partnerService;
	@Autowired
	private CommonService commonService;
	
	//商机单列表
	@RequestMapping(value="listOpportunity", method = RequestMethod.GET)
	public String listOpportunity(){
		UserVo userVo = this.getAppCurrentUserVo();
		ResultMap resultMap = ResultUtil.getResultMap();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (StringUtil.isNotEmpty(pd.getString("orderSectionIn"))) {
			pd.put("orderSectionIn", Tools.strSqlIn(pd.getString("orderSectionIn")));
		}else {
			pd.put("orderSectionIn", null);
		}
        if (StringUtil.isEmpty(pd.getString("orderSection"))) {
			pd.put("orderSection", null);
		}
        if (StringUtil.isEmpty(pd.getString("salesId"))) {
        	pd.put("salesId", null);
		}
        page.setPd(pd);
		List<OpportunityOrder> opportOrderList = opportunityService.listPageOpportunityOrders(page);
		
		resultMap.setRows(opportOrderList);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//修改商机阶段
	@RequestMapping(value="updateOppoSection", method = RequestMethod.GET)
	public String updateOppoSection(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("oppoNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
		int result = 0;
		try {
			result = opportunityService.updateOpportunityOrderByParam(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
		}
	}
	//商机单详情
	@RequestMapping(value="queryOneOpportunityOrder", method = RequestMethod.GET)
	public String queryOneOpportunityOrder()
		throws Exception{
		PageData pd = this.getPageData();
		UserVo userVo = this.getAppCurrentUserVo();
		ResultMap resultMap = ResultUtil.getResultMap();
		pd.put("comKey", userVo.getComKey());
		OpportunityOrder opportunityOrder = opportunityService.selectOneOpportunityOrder(pd);
		pd.clear();
		pd.put("partnerKey", opportunityOrder.getPartnerKey());
		pd.put("contacterId", opportunityOrder.getContactId());
		PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
		if (contacter!=null) {
			opportunityOrder.setContactTel(contacter.getTel1());
		}
		int upToNow = DateUtil.getIntervalDays(opportunityOrder.getStartDate(), new Date());
		opportunityOrder.setUpToNow(upToNow < 0 ? 0 : upToNow); //距今日期<0的，按0处理。
		resultMap.setData(opportunityOrder);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//报价列表
	@RequestMapping(value="listVersions", method = RequestMethod.GET)
	public String listVersions() throws Exception {
		UserVo userVo = this.getAppCurrentUserVo();
		ResultMap resultMap = ResultUtil.getResultMap();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		List<OpportunityQuotation> oqsList = opportunityService
				.listQuotations(pd);
		resultMap.setData(oqsList);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//查看单条报价单及明细
	@RequestMapping(value="queryOneQuotationOrderAndDetail", method = RequestMethod.GET)
	public String queryOnequotationOrderAndDetail(){
		UserVo userVo = this.getAppCurrentUserVo();
		ResultMap resultMap = ResultUtil.getResultMap();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		OpportunityQuotation order = opportunityService.getOneOpportunityQuotation(pd);
		resultMap.setData(order);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//联系记录列表
	@RequestMapping(value="opportChatList", method = RequestMethod.GET)
	public String getOpportChatList(){
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		UserVo userVo = this.getAppCurrentUserVo();
		pd.put("comKey", userVo.getComKey());
		pd.put("chatType", ProjectEnum.CHAT_TYPE_OPPORTUNITY.getCode());
		page.setPd(pd);
		List<OpportunityChat> chats = opportunityService.listPageOpportunityChats(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(chats);
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//新增联系记录
	@RequestMapping(value="addOpportChat", method = RequestMethod.POST)
	public String addOpportChat(@RequestBody OpportunityChat chat)
		throws Exception{
		if (chat==null
				||StringUtil.isEmpty(chat.getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		chat.setChatEmployeeId(userVo.getEmployeeId());
		chat.setChatEmployeeName(userVo.getRealName());
		chat.setComKey(userVo.getComKey());
		chat.setCreator(userVo.getUserKey());
		chat.setCreateTime(new Date());
		chat.setChatType(ProjectEnum.CHAT_TYPE_OPPORTUNITY.getCode());
		chat.setIsValid("1");
		chat.setIsDel("0");
		int result = opportunityService.insertOpportunityChat(chat);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	@RequestMapping(value = "listParticipanEmployees", method = RequestMethod.GET)
	public String listParticipanEmployees(){
		PageData pd = this.getPageData();
		OpportunityOrder opportunityOrder=opportunityService.selectOneOpportunityOrder(pd);
		if (opportunityOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有参与人"));
		}
		pd.clear();
		UserVo userVo = this.getAppCurrentUserVo();
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(Tools.strSqlIn(opportunityOrder.getParticipantEmployeeId()))) {
			pd.put("employeeIdIns", "('')");
		}else{
			pd.put("employeeIdIns", Tools.strSqlIn(opportunityOrder.getParticipantEmployeeId()));
		}
		List<Employee> employees = opportunityService.listParticipanEmployees(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}
	
	@RequestMapping(value = "shareUrl", method = RequestMethod.GET)
	public String getShareUrl(String orderNo){
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("oppoNo", orderNo);
		OpportunityOrder order = opportunityService.selectOneOpportunityOrder(pd);
		if (order==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此订单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/opportunity-quotation-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, order.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
}
