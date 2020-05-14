package com.ydz.controller.commissions;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion.User;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.assignment.AssignTaskDetail;
import com.ydz.entity.assignment.InstallationCheckingOrder;
import com.ydz.entity.commissions.CommissionsCheckingOrder;
import com.ydz.entity.commissions.CommissionsCheckingOrderDetail;
import com.ydz.entity.commissions.CommissionsCheckingOrderVO;
import com.ydz.entity.commissions.OrderCommissions;
import com.ydz.entity.system.Employee;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.CommissionsService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: CommissionsController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 24, 2017 1:49:08 PM 
 * @Description: 提成业务控制器
 */
@Controller
@RequestMapping(value = "ydz/commission", produces = "plain/text; charset=UTF-8")
public class CommissionsController extends BaseController{

	@Resource private CommissionsService commissionsService;
	@Resource private DZConfig dzConfig;
	
	@Resource private CompanyService companyService;
	@Resource private EmployeeService employeeService;
	@Resource private CommonService commonService;
	
	/**
	 * 
	 * @Title: listPageSalesCheckingOrderForCommissions 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查询已收款的对账单是否进行提成核算过
	 * 0未核算 1已核算
	 */
	@RequestMapping(value = "listPageSalesCheckingOrderForCommissions")
    @ResponseBody
	public String listPageSalesCheckingOrderForCommissions(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
        		||"".equals(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if("ALL".equalsIgnoreCase(pd.getString("salesId"))
        		||"".equals(pd.getString("salesId"))){
        	pd.put("salesId", null);
        }
        pd.put("orderStatus", OrderEnum.STATUS_YISHOUKUAN.getCode());
        if ("1".equalsIgnoreCase(pd.getString("isSettlement"))) { //已分派之后才产生isChecking数据
        	pd.put("isChecking", "0");
		}
        page.setPd(pd);
		List<CommissionsCheckingOrderDetail> checkingOrderDetails = commissionsService.listPageSalesCheckingOrderForCommissions(page);
		OrderTotalVO orderTotalVO = commissionsService.selectSumSalesCheckingOrderAndSettlement(pd);
		orderTotalVO.setSumDepositRequested(orderTotalVO.getSumDepositRequested()==null?BigDecimal.ZERO:orderTotalVO.getSumDepositRequested());
		orderTotalVO.setSumPaidUp(orderTotalVO.getSumPaidUp()==null?BigDecimal.ZERO:orderTotalVO.getSumPaidUp());
		orderTotalVO.setSumPaidUp(orderTotalVO.getSumDepositRequested().add(orderTotalVO.getSumPaidUp()).setScale(2, BigDecimal.ROUND_HALF_UP));
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(checkingOrderDetails);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo", orderTotalVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: allocationCommission 
	 * @param orderCommissions
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 新增分配绩效
	 * 1.每收款对账单分配一次。
	 * 2.分配后更新对账单为已核算提成
	 */
	@RequestMapping(value = "allocationCommission")
    @ResponseBody
    public String allocationCommission(OrderCommissions orderCommissions) throws Exception{
		if (orderCommissions==null||StringUtil.isEmpty(orderCommissions.getOrderNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = commissionsService.insertNewOrderCommissions(userVo, orderCommissions);
		
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("完成分配"));
		}
	}
	
	@RequestMapping(value = "updatecommission")
    @ResponseBody
    public String updateAllocationCommission(OrderCommissions orderCommissions) throws Exception{
		if (orderCommissions==null||StringUtil.isEmpty(orderCommissions.getOrderNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		orderCommissions.setComKey(userVo.getComKey());
		int result = commissionsService.updateOrderCommissions(orderCommissions);
		
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	@RequestMapping(value = "ordercommission-info")
    @ResponseBody
    public String getOrderCommission(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("orderNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法修改"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		OrderCommissions orderCommissions = commissionsService.selectOneOrderCommissions(pd);
		orderCommissions.setCommissionsRate(orderCommissions.getCommissionsRate().multiply(new BigDecimal(100)));
		return JsonUtil.toCompatibleJSONString(orderCommissions);
	}
	
	//生成提成结算单
	@RequestMapping(value = "createCommissionChecking")
    @ResponseBody
    public String createCommissionChecking() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("orderNoIns"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法生成提成结算单"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = 0;
		if ("2".equals(pd.getString("orderType"))) {
			result = commissionsService.saveNewDesignCommissionCheckingAndDetail(pd.getString("orderNoIns"), userVo);
		} else {
			result = commissionsService.saveNewCommissionCheckingAndDetail(pd.getString("orderNoIns"), userVo);
		}
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("已创建提成结算单"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法生成提成结算单"));
		}
	}
	
	//查询提成结算单
	@RequestMapping(value = "listCommissionChecking")
    @ResponseBody
    public String listCommissionChecking(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
        		||"".equals(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if ("2".equals(pd.getString("orderType"))) {
        	if("ALL".equalsIgnoreCase(pd.getString("taskEmployeeId"))
            		||"".equals(pd.getString("taskEmployeeId"))){
            	pd.put("taskEmployeeId", null);
            }
		}else{
			if("ALL".equalsIgnoreCase(pd.getString("salesId"))
					||"".equals(pd.getString("salesId"))){
				pd.put("salesId", null);
			}
		}
        pd.put("orderType", StringUtil.isEmpty(pd.getString("orderType"))==true?"1":pd.getString("orderType"));
		page.setPd(pd);
		List<CommissionsCheckingOrderVO> checkingOrderVOs = commissionsService.listPageByPrimaryKeyConcat(page);
		OrderTotalVO orderTotalVO = commissionsService.selectSumCommissionCheckingOrder(page);
		if (!"2".equals(pd.getString("orderType"))) {
			orderTotalVO.setSumDepositRequested(orderTotalVO.getSumDepositRequested()==null?BigDecimal.ZERO:orderTotalVO.getSumDepositRequested());
			orderTotalVO.setSumPaidUp(orderTotalVO.getSumPaidUp()==null?BigDecimal.ZERO:orderTotalVO.getSumPaidUp());
			orderTotalVO.setSumPaidUp(orderTotalVO.getSumDepositRequested().add(orderTotalVO.getSumPaidUp()).setScale(2, BigDecimal.ROUND_HALF_UP));
		}
				
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(checkingOrderVOs);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo", orderTotalVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//跳转查看提成结算单明细
	@RequestMapping(value = "forward-commissionchecking-detail")
	public ModelAndView forwardCommissionCheckingDetail(String commissionsCheckingNo){
		return new ModelAndView("jsp/advert/salescommissions-checking-list-detail").addObject("commissionsCheckingNo", commissionsCheckingNo);
	}
	//跳转查看提成结算单明细
	@RequestMapping(value = "forward-design-commissionchecking-detail")
	public ModelAndView forwardDesignCommissionCheckingDetail(String commissionsCheckingNo){
		return new ModelAndView("jsp/assignment/design-commission-checking-list-detail").addObject("commissionsCheckingNo", commissionsCheckingNo);
	}
	
	//查询提成结算单
	@RequestMapping(value = "commissionCheckingOrderAndDetail")
    @ResponseBody
    public String commissionCheckingOrderAndDetail() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("commissionsCheckingNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法查看结算单详情"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		CommissionsCheckingOrder checkingOrder = commissionsService.selectOneCommissionsCheckingOrder(pd);
		Employee employee = employeeService.getEmployeeByDoubleKey(null, checkingOrder.getComKey(), checkingOrder.getTaskEmployeeId());
		if (employee!=null) {
			checkingOrder.setTaskUserTel(employee.getUserId());
		}
		pd.put("checkingNo", checkingOrder.getCommissionsCheckingNo());
		ReceiptPayment receiptPayment = commissionsService.selectOneReceiptPayment(pd);
		Page page = new Page();
		page.setCurrentPage(1);
		page.setShowCount(3000);
		page.setPd(pd);
		List<CommissionsCheckingOrderDetail> checkingOrderDetails = commissionsService.listPageCommissionsCheckingOrderDetails(page);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(), checkingOrder.getPartnerKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("order",checkingOrder);
		resultMap.put("payment", receiptPayment);
		resultMap.put("details",checkingOrderDetails);
		resultMap.put("bottomComInfo", companyVO);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: getShareUrl 
	 * @param orderNo
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 获取分享短地址连接
	 */
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
		pd.put("commissionsCheckingNo", orderNo);
		CommissionsCheckingOrder checkingOrder = commissionsService.selectOneCommissionsCheckingOrder(pd);
		if (checkingOrder==null) {
			JsonUtil.toCompatibleJSONString(ResultUtil.error("无此结算单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/sales-commission-checking-list-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, checkingOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: addPayment 
	 * @param receiptPayment
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 添加销售提成对账单的结算付款费用
	 */
	@RequestMapping("addPayment")
	@ResponseBody
	public String addPayment(ReceiptPayment receiptPayment) throws Exception{
		if (receiptPayment==null||StringUtil.isEmpty(receiptPayment.getCheckingNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		 UserVo userVo = getSessionUservo();
		 PageData pd = this.getPageData();
        int result = commissionsService.savePaymentSettlement(userVo.getComKey(), receiptPayment,pd.getString("orderType"));
        if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	/**
	 * 
	 * @Title: updatePayment 
	 * @param receiptPayment
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改销售提成对账单的结算付款费用
	 */
	@RequestMapping("udpatePayment")
	@ResponseBody
	public String updatePayment(ReceiptPayment receiptPayment) throws Exception{
		UserVo userVo = getSessionUservo();
		int result = commissionsService.updatePaymentSettlement(userVo.getComKey(), receiptPayment);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	//========设计提成
	
	/**
	 * 
	 * @Title: listPageAssignTaskForCommissions 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 待分派的设计派工单
	 */
	@RequestMapping("listPageAssignTaskForCommissions")
	@ResponseBody
	public String listPageAssignTaskForCommissions(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		if (userVo.getIsAdmin().equals("1")
				||userVo.getIsBoss().equals("1")) {
			if ("ALL".equalsIgnoreCase(pd.getString("taskEmployeeId"))
					||StringUtil.isEmpty(pd.getString("taskEmployeeId"))) {
				pd.put("staff", null);
				pd.put("taskEmployeeId", null);
			}else{
				pd.put("staff", "1");
			}
		}else{
			pd.put("staff", "1");
			Employee employee = employeeService.getEmployeeByDoubleKey(userVo.getUserKey(), userVo.getComKey(), null);
			pd.put("taskEmployeeId", employee.getEmployeeId());
		}
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
				||StringUtil.isEmpty(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getStartDate(pd.getString("endTime")));
		page.setPd(pd);
		List<OrderCommissions> assignTasks = commissionsService.listPageAssignTasksForCommission(page);
		
		OrderTotalVO orderTotalVO = new OrderTotalVO();
		BigDecimal sumTotalPrice = BigDecimal.ZERO;
		for (OrderCommissions orderCommissions : assignTasks) {
			sumTotalPrice = sumTotalPrice.add(orderCommissions.getTotalPrice());
		}
		orderTotalVO.setSumTotalPrice(sumTotalPrice);
		orderTotalVO.setOrderCount(assignTasks.size());
		
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(assignTasks);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo", orderTotalVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listAssignDesigners 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 已派工的设计师
	 */
	@RequestMapping("listAssignDesigners")
	@ResponseBody
	public String listAssignDesigners(){
		PageData pd = this.getPageData();
		List<AssignTaskDetail> designers = commissionsService.listAssignDesigners(pd.getString("taskNo"));
		List<OrderCommissions>  orderCommissionsList = new ArrayList<>();
		OrderCommissions commissions = null;
		for (AssignTaskDetail designer : designers) {
			commissions = new OrderCommissions();
			BeanutilsCopy.apacheCopyProperties(commissions, designer);
			orderCommissionsList.add(commissions);
		}
		return JsonUtil.toJsonString(orderCommissionsList);
	}
	
	/**
	 * 
	 * @Title: listSettlementDesigners 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 已核算的设计师
	 */
	@RequestMapping("listSettlementDesigners")
	@ResponseBody
	public String listSettlementDesigners(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPage();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		page.setShowCount(100);
		page.setPd(pd);
		List<OrderCommissions> designers = commissionsService.listSettlementDesigners(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		for (OrderCommissions designer : designers) {
			if ("1".equals(designer.getIsChecking())) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("已有设计师结算，无法修改"));
			}
		}
		resultMap.setData(designers);
		return JsonUtil.toJsonString(resultMap);
	}
	
	@RequestMapping(value = "allocationDesignerCommission")
    @ResponseBody
    public String allocationDesignerCommission(@RequestBody List<OrderCommissions> orderCommissionsList) 
    		throws Exception{
		if (orderCommissionsList==null||orderCommissionsList.size()<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = commissionsService.insertNewAssignTaskCommissions(userVo, orderCommissionsList);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("分配成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}
		
	}
	
	@RequestMapping("listPageOrderCommissionForDesign")
	@ResponseBody
	public String listPageOrderCommissionForDesign(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("isChecking", "0"); //未生成结算单
		if (userVo.getIsAdmin().equals("1")
				||userVo.getIsBoss().equals("1")) {
			if ("ALL".equalsIgnoreCase(pd.getString("taskEmployeeId"))
					||StringUtil.isEmpty(pd.getString("taskEmployeeId"))) {
				pd.put("taskEmployeeId", null);
			}
		}else{
			Employee employee = employeeService.getEmployeeByDoubleKey(userVo.getUserKey(), userVo.getComKey(), null);
			pd.put("taskEmployeeId", employee.getEmployeeId());
		}
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
				||StringUtil.isEmpty(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		page.setPd(pd);
		List<OrderCommissions> assignTasks = commissionsService.listPageOrderCommissionByDesign(page);
		OrderTotalVO orderTotalVO = commissionsService.selectSumDesignerCommission(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(assignTasks);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo", orderTotalVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: reAllocationDesignerCommission 
	 * @param orderCommissionsList
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改设计重新分配
	 */
	@RequestMapping(value = "reAllocationDesignerCommission")
    @ResponseBody
    public String reAllocationDesignerCommission(@RequestBody List<OrderCommissions> orderCommissionsList) 
    		throws Exception{
		if (orderCommissionsList==null||orderCommissionsList.size()<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = commissionsService.updateReAssignTaskCommissions(userVo, orderCommissionsList);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("分配成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("分配失败"));
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("design/shareUrl")
	@ResponseBody
	public String getDesignShareUrl(String orderNo){
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("commissionsCheckingNo", orderNo);
		CommissionsCheckingOrder checkingOrder = commissionsService.selectOneCommissionsCheckingOrder(pd);
		if (checkingOrder==null) {
			JsonUtil.toCompatibleJSONString(ResultUtil.error("无此结算单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/design-commission-checking-list-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, checkingOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
}
