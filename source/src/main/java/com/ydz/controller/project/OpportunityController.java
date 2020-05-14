/**   
 * @Title: OpportunityController.java 
 * @Package com.ydz.controller.opportunity 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 3:13:52 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.project;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.entity.project.OpportunityQuotationParaVO;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Partner;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.ProjectEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.exception.YdzBusinessException;
import com.ydz.service.advert.OpportunityService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: OpportunityController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 3:13:52 PM 
 * @Description: 商机报价控制器
 */
@Controller
@RequestMapping(value = "ydz/opportunity", produces = "application/json;charset=UTF-8")
public class OpportunityController extends BaseController{
	
	@Resource
	private OpportunityService opportunityService;
	@Resource
	private CommonService commonService;
	@Resource
	private CompanyService companyService;
	@Resource
	private PartnerService partnerService;
	
//	新建商机概要
	
	@RequestMapping(value="addOpportunity")
	@ResponseBody
	public String addOpportunity(@RequestBody OpportunityOrder opportunityOrder)
		throws Exception{
		if (opportunityOrder==null||StringUtil.isEmpty(opportunityOrder.getPartnerKey())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建商机失败"));
		}
		UserVo userVo = this.getSessionUservo();
		
		int result = opportunityService.saveOpportunityOrder(opportunityOrder, userVo);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建商机失败"));
		}else{
			ResultMap resultMap = ResultUtil.getResultMap();
			resultMap.setCode(1);
			resultMap.setMsg("新建商机成功");
			resultMap.put("oppoNo", opportunityOrder.getOppoNo());
			return JsonUtil.toCompatibleJSONString(resultMap);
		}
	}
	
	//	跳传修改商机概要页面
	@RequestMapping(value="forward-updateOpportunity")
	public ModelAndView forwardUpdateOpportunity(){
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/project/opportunity-add-update").addObject("oppoNo", pd.getString("oppoNo"));
	}
	
	//	查询单条商机记录
	@RequestMapping(value="queryOneOpportunityOrder")
	@ResponseBody
	public String queryOneOpportunityOrder()
		throws Exception{
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
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
		CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),opportunityOrder.getPartnerKey()); //详情页底部信息
		resultMap.put("bottomComInfo", companyVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	
	//	修改商机概要
	@RequestMapping(value="updateOpportunity")
	@ResponseBody
	public String updateOpportunity(@RequestBody OpportunityOrder opportunityOrder)
		throws Exception{
		if (opportunityOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改商机失败"));
		}
		opportunityOrder.setStartDate(DateUtil.StringToDate(opportunityOrder.getStartDateValue(), DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
		opportunityOrder.setEndDate(DateUtil.StringToDate(opportunityOrder.getEndDateValue(), DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
		
		PageData pd = this.getPageData();
		pd.put("partnerKey", opportunityOrder.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		if (partner!=null) {
			opportunityOrder.setPartnerName(partner.getPartnerName());
			opportunityOrder.setPartnerShortname(partner.getPartnerShortname());
		}
		int result = opportunityService.updateOpportunityOrder(opportunityOrder);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改商机失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改商机成功"));
		}
	}
	
	/**
	 * 
	 * @Title: updateOpportunityByParam 
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 采用参数式修改商机概要，用于调整商机阶段
	 */
	@RequestMapping(value="updateOpportunityByParam")
	@ResponseBody
	public String updateOpportunityByParam() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("oppoNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
		int result = opportunityService.updateOpportunityOrderByParam(pd);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
		}
	}
	
	
	//	跳传新建/修改报价页面
	@RequestMapping(value="forward-AddorUpdateOpportunity")
	public ModelAndView forwardAddorUpdateOpportunity() {
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/project/quotation-add-update").addObject(
				"oppoNo", pd.getString("oppoNo")).addObject("quotationNo",
				pd.getString("quotationNo"));
	}
	
//	新建商机报价单及报价明细
	@RequestMapping(value="addOpportQuotation")
	@ResponseBody
	public String addOpportunityQuotation(@RequestBody OpportunityQuotationParaVO paraVO) 
			throws Exception{
		if (paraVO.getOpportunityQuotation()==null
				||paraVO.getDetails()==null
				||StringUtil.isEmpty(paraVO.getOpportunityQuotation().getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存报价单失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = opportunityService.saveOpportunityQuotation(paraVO, userVo);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存报价单失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存报价单成功"));
		}
		
	}
	
//	修改报价单及明细
	@RequestMapping(value="updateOpportQuotation")
	@ResponseBody
	public String updateOpportQuotation(@RequestBody OpportunityQuotationParaVO paraVO)
			throws YdzBusinessException{
		if (paraVO.getOpportunityQuotation()==null
				||paraVO.getDetails()==null
				||StringUtil.isEmpty(paraVO.getOpportunityQuotation().getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改报价单失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = opportunityService.updateOpportunityQuotation(paraVO,userVo);
		
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改报价单失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改报价单成功"));
		}
	}
	
//	查看商机概要列表
	@RequestMapping(value="listOpportunity")
	@ResponseBody
	public String listOpportunity(){
		UserVo userVo = this.getSessionUservo();
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
        if (StringUtil.isEmpty(pd.getString("salesId"))) {
        	pd.put("salesId", null);
		}
        if (StringUtil.isEmpty(pd.getString("state"))) { //state为空时表示全部商机
        	pd.put("participantEmployeeId", null);
		}else if("1".equals(pd.getString("state"))){ //我负责的
			pd.put("salesId", userVo.getEmployeeId()); //销售代表编码
		}else if ("2".equals(pd.getString("state"))) { //我参与的
			pd.put("participantEmployeeId", userVo.getEmployeeId()); //参与人员
		}
        
        page.setPd(pd);
		List<OpportunityOrder> opportOrderList = opportunityService.listPageOpportunityOrders(page);
		
		resultMap.setRows(opportOrderList);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo",opportunityService.getSumOpportQuotMoney(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
//	
//	跳传查看商机概要页面
	@RequestMapping(value="forward-OpportQuotationDetail")
	public ModelAndView forwardOpportQuotationDetail(){
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/project/opportunity-quotation-list-detail").addObject("oppoNo", pd.getString("oppoNo"));
	}
	
	//分享转发短地址
	@SuppressWarnings("unchecked")
	@RequestMapping("shareUrl")
	@ResponseBody
	public String getShareUrl(String orderNo){
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
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
	
	//获取报价版本列表
	@RequestMapping(value="listVersions")
	@ResponseBody
	public String listVersions()
			throws YdzBusinessException{
		UserVo userVo = this.getSessionUservo();
		ResultMap resultMap = ResultUtil.getResultMap();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		List<OpportunityQuotation> oqsList = opportunityService.listQuotations(pd);
		resultMap.setData(oqsList);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//	查看单条报价单及明细
	@RequestMapping(value="queryOneQuotationOrderAndDetail")
	@ResponseBody
	public String queryOnequotationOrderAndDetail(){
		UserVo userVo = this.getSessionUservo();
		ResultMap resultMap = ResultUtil.getResultMap();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		OpportunityQuotation order = opportunityService.getOneOpportunityQuotation(pd);
		resultMap.setData(order);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
//	删除单条报价单及明细
	@RequestMapping(value="deleteQuotationOrderAndDetail")
	@ResponseBody
	public String deleteQuotationOrderAndDetail() throws Exception{
		PageData pd = this.getPageData();
		int result = opportunityService.deleteOpportunityQuotationAndDetail(pd);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除报价单失败"));
		}else {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除报价单成功"));
		}
	}
	
//	设置默认报价单
	@RequestMapping(value="setDefaultVersion")
	@ResponseBody
	public String setDefaultVersion() throws YdzBusinessException{
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		//先把所有设置为
		int result = opportunityService.updateSetDefaultVersion(pd);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("设置默认版本失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("设置默认版本成功"));
		}
	}

//	添加联系记录
	@RequestMapping(value="addOpportChat")
	@ResponseBody
	public String addOpportChat(@RequestBody OpportunityChat chat)
		throws Exception{
		if (chat==null
				||StringUtil.isEmpty(chat.getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
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
//	
//	查看联系记录
	@RequestMapping(value="getOpportChatList")
	@ResponseBody
	public String getOpportChatList(){
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("chatType", ProjectEnum.CHAT_TYPE_OPPORTUNITY.getCode());
		page.setPd(pd);
		List<OpportunityChat> chats = opportunityService.listPageOpportunityChats(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(chats);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listParticipanEmployees 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 获取参与人
	 */
	@RequestMapping(value = "listParticipanEmployees")
	@ResponseBody
	public String listParticipanEmployees(){
		PageData pd = this.getPageData();
		OpportunityOrder opportunityOrder=opportunityService.selectOneOpportunityOrder(pd);
		if (opportunityOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有参与人"));
		}
		pd.clear();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("employeeIdIns", Tools.strSqlIn(opportunityOrder.getParticipantEmployeeId()));
		List<Employee> employees = opportunityService.listParticipanEmployees(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}
	
//	
//	转发报价单
//	
	
//	复制报价订单
	
	
//	=======================商机/报价类型维护================
	
	/**
	 * 
	 * @Title: listOpportTypeDesc 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查询项目类型列表
	 */
	@RequestMapping(value="listOpportTypeDesc")
	@ResponseBody
	public String listOpportTypeDesc(){
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
//		pd.put("settingClass", "OPPORT_TYPE");
		List<ComSettingClass> opportTypes = commonService.listComSettingClasses(pd);
		return JsonUtil.toCompatibleJSONString(opportTypes);
	}
	
	/**
	 * 
	 * @Title: addOpportTypeDesc 
	 * @param comSettingClass
	 * @return
	 * @throws YdzBusinessException
	 * @return String
	 * @throws 
	 * @Description: 新增项目类型
	 */
	@RequestMapping(value="addOpportTypeDesc")
	@ResponseBody
	public String addOpportTypeDesc(@RequestBody ComSettingClass comSettingClass)
		throws YdzBusinessException{
		if (comSettingClass==null
				||StringUtil.isEmpty(comSettingClass.getTypeDesc())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("settingClass", comSettingClass.getSettingClass());
		comSettingClass.setComKey(userVo.getComKey());
		comSettingClass.setIndustryId(userVo.getDetailIndustryId());
		comSettingClass.setCreateTime(new Date());
//		comSettingClass.setSettingClass("OPPORT_TYPE");
		comSettingClass.setIsDel("0");

		int maxTypeCode = commonService.selectMaxTypeCodeByPrimaryKey(pd);
		String typeCode = (maxTypeCode + 1) < 10 ? "0"
				+ Integer.toString(maxTypeCode + 1) : Integer
				.toString((maxTypeCode + 1));
		comSettingClass.setTypeCode(typeCode);
		int result = commonService.insertComSettingClass(comSettingClass);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("保存成功"));
		}
	}
	
	/**
	 * 
	 * @Title: updateOpportTypeDesc 
	 * @param comSettingClass
	 * @return
	 * @throws YdzBusinessException
	 * @return String
	 * @throws 
	 * @Description: 修改项目类型
	 */
	@RequestMapping(value="updateOpportTypeDesc")
	@ResponseBody
	public String updateOpportTypeDesc(@RequestBody ComSettingClass comSettingClass)
		throws YdzBusinessException{
		if (comSettingClass==null
				||StringUtil.isEmpty(comSettingClass.getTypeDesc())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
		UserVo userVo = this.getSessionUservo();
		comSettingClass.setComKey(userVo.getComKey());
		comSettingClass.setIndustryId(userVo.getDetailIndustryId());
		comSettingClass.setCreateTime(new Date());
//		comSettingClass.setSettingClass("OPPORT_TYPE");
		comSettingClass.setIsDel("0");
		int result = commonService.updateComSettingClass(comSettingClass);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("修改成功"));
		}
	}
	
	/**
	 * 
	 * @Title: deleteOpportTypeDesc 
	 * @return
	 * @throws YdzBusinessException
	 * @return String
	 * @throws 
	 * @Description: 删除项目类型
	 */
	@RequestMapping(value="deleteOpportTypeDesc")
	@ResponseBody
	public String deleteOpportTypeDesc() throws YdzBusinessException {
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
//		pd.put("settingClass", "OPPORT_TYPE");
		int result = commonService.deleteComSettingClass(pd);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("删除成功"));
		}
	}
	
	
	

}
