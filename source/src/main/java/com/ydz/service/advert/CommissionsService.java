package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.advert.ReceiptPaymentMapper;
import com.ydz.dao.commissions.CommissionsCheckingOrderDetailMapper;
import com.ydz.dao.commissions.CommissionsCheckingOrderMapper;
import com.ydz.dao.commissions.OrderCommissionsMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.assignment.AssignTaskDetail;
import com.ydz.entity.commissions.CommissionsCheckingOrder;
import com.ydz.entity.commissions.CommissionsCheckingOrderDetail;
import com.ydz.entity.commissions.CommissionsCheckingOrderVO;
import com.ydz.entity.commissions.OrderCommissions;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: CommissionsService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 24, 2017 1:01:49 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
@Service
public class CommissionsService {
	
	@Autowired private OrderCommissionsMapper orderCommissionsMapper;
	@Autowired private CommissionsCheckingOrderMapper commissionsCheckingOrderMapper;
	@Autowired private CommissionsCheckingOrderDetailMapper commissionsCheckingOrderDetailMapper;
	
	@Autowired private ReceiptPaymentMapper receiptPaymentMapper;
	
	@Resource private SalesOrderService salesOrderService;
	@Resource private AssignTaskService assignTaskService;
	
	public OrderCommissions selectOneOrderCommissions(PageData pd){
		return orderCommissionsMapper.selectByPrimaryKey(pd);
	}
	
	public int insertOrderCommissions(OrderCommissions orderCommissions){
		return orderCommissionsMapper.insertSelective(orderCommissions);
	}
	
	public int insertListOrderCommissions(List<OrderCommissions> commissionsList){
		return orderCommissionsMapper.insertList(commissionsList);
	}
	
	public int updateOrderCommissions(OrderCommissions orderCommissions){
		return orderCommissionsMapper.updateByPrimaryKeySelective(orderCommissions);
	}
	
	public int updateBatchOrderCommissionStatusByPrimaryKey(PageData pd){
		return orderCommissionsMapper.updateBatchStatusByPrimaryKey(pd);
	}
	
	public int deleteOrderCommissions(PageData pd){
		return orderCommissionsMapper.deleteByPrimaryKey(pd);
	}
	
	public CommissionsCheckingOrder selectOneCommissionsCheckingOrder(PageData pd){
		return commissionsCheckingOrderMapper.selectByPrimaryKey(pd);
	}
	
	public List<CommissionsCheckingOrder> listPageCommissionsCheckingOrder(Page page){
		return commissionsCheckingOrderMapper.listPageByPrimaryKey(page);
	}
	
	public List<CommissionsCheckingOrderVO> listPageByPrimaryKeyConcat(Page page){
		return commissionsCheckingOrderMapper.listPageByPrimaryKeyConcat(page);
	}
	
	public int insertCommissionsCheckingOrder(CommissionsCheckingOrder checkingOrder){
		return commissionsCheckingOrderMapper.insertSelective(checkingOrder);
	}
	
	public int updateCommissionsCheckingOrder(CommissionsCheckingOrder checkingOrder){
		return commissionsCheckingOrderMapper.updateByPrimaryKeySelective(checkingOrder);
	}
	
	public List<CommissionsCheckingOrderDetail> listPageCommissionsCheckingOrderDetails(Page page){
		return commissionsCheckingOrderDetailMapper.listPageDetailsByPrimaryKey(page);
	}
	
	public int insertListCommissionsCheckingOrderDetail(List<CommissionsCheckingOrderDetail> checkingOrderDetails){
		return commissionsCheckingOrderDetailMapper.insertList(checkingOrderDetails);
	}
	
	public List<CommissionsCheckingOrderDetail> listPageSalesCheckingOrderForCommissions(Page page){
		return orderCommissionsMapper.listPageSalesCheckingOrderForCommissions(page);
	}
	
	public OrderTotalVO selectSumSalesCheckingOrderAndSettlement(PageData pd){
		return orderCommissionsMapper.selectSumSalesCheckingOrderAndSettlement(pd);
	}
	
	public ReceiptPayment selectOneReceiptPayment(PageData pd){
		return receiptPaymentMapper.selectByPrimaryKey(pd);
	}
	
	public OrderTotalVO selectSumCommissionCheckingOrder(Page page){
		return commissionsCheckingOrderMapper.getSumTotalVO(page);
	}
	
	/**
	 * 
	 * @Title: insertNewOrderCommissions 
	 * @param userVo
	 * @param orderCommissions
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 新增提成分配
	 */
	public int insertNewOrderCommissions(UserVo userVo,OrderCommissions orderCommissions) throws Exception{
		PageData pd = new PageData();
		pd.put("salescheckingNo", orderCommissions.getOrderNo());
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return 0;
		}
		BigDecimal salesPrice = checkingOrder.getPaidUp().add(checkingOrder.getDepositRequested()).setScale(2, BigDecimal.ROUND_HALF_UP);
		if (orderCommissions.getCommissionsMoney()
				.compareTo(salesPrice.multiply(orderCommissions.getCommissionsRate()).setScale(2, BigDecimal.ROUND_HALF_UP))!=0) {
			return -1;
		}
		orderCommissions.setComKey(userVo.getComKey());
		orderCommissions.setIndustryId(userVo.getDetailIndustryId());
		orderCommissions.setIsChecking("0");
		orderCommissions.setOrderType("1");
		orderCommissions.setIsValid("1");
		orderCommissions.setCreateTime(new Date());
		orderCommissions.setCreator(userVo.getUserKey());
		int result = this.insertOrderCommissions(orderCommissions);
		if (result>0) {
			pd.put("salescheckingNoIn", Tools.str2StrArray(orderCommissions.getOrderNo()));
			pd.put("isSettlement", AssignEnum.COMMISSION_SETTLEMENT_YES.getCode());
			result = salesOrderService.updateBatchBySalesCheckingNoIn(pd);
		}
		return result;
	}
	
	public int upateOrderCommissions(OrderCommissions orderCommissions) throws Exception{
		PageData pd = new PageData();
		pd.put("salescheckingNo", orderCommissions.getOrderNo());
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return 0;
		}
		BigDecimal paidup = checkingOrder.getPaidUp();
		if (orderCommissions.getCommissionsMoney()
				.compareTo(paidup.multiply(orderCommissions.getCommissionsRate()).setScale(2, BigDecimal.ROUND_HALF_UP))!=0) {
			return -1;
		}
		return this.updateOrderCommissions(orderCommissions);
	}
	
	public int saveNewCommissionCheckingAndDetail(String checkingNoIns,UserVo userVo) throws Exception{
		
		Page page = new Page();
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("salescheckingNoIns", Tools.strSqlIn(checkingNoIns));
		page.setShowCount(10000);
		page.setPd(pd);
		List<CommissionsCheckingOrderDetail> checkingOrderDetails = this.listPageSalesCheckingOrderForCommissions(page); //获取需要提成结算的销售对账单信息
		
		if (checkingOrderDetails==null||checkingOrderDetails.size()<=0) {
			return 0;
		}
		CommissionsCheckingOrderDetail checkingOrderDetail = checkingOrderDetails.get(0);
		pd.put("userKey", userVo.getUserKey());
		pd.put("industryId", userVo.getDetailIndustryId());
		pd.put("partnerKey", checkingOrderDetail.getPartnerKey());
		pd.put("partnerName", checkingOrderDetail.getPartnerName());
		pd.put("partnerShortname", checkingOrderDetail.getPartnerShortname());
		pd.put("contactId", checkingOrderDetail.getContactId());
		pd.put("contactName", checkingOrderDetail.getContactName());
		pd.put("orderType", "1");
		
		pd.put("salesId", checkingOrderDetail.getSalesId());
		pd.put("salesName", checkingOrderDetail.getSalesName());
		pd.put("salescheckingNoList", Tools.str2StrArray(checkingNoIns));
		if (checkingOrderDetails.size()>1) {
			pd.put("caseDesc", "多笔");
		}else{
			pd.put("caseDesc", checkingOrderDetail.getCaseDesc());
		}
		
		CommissionsCheckingOrder commissionsCheckingOrder = this.fillDataForCommissionsCheckingOrder(pd);
		OrderTotalVO orderTotalVO = this.selectSumSalesCheckingOrderAndSettlement(pd); //获取需要核算提成的销售对账单的金额统计
		
		commissionsCheckingOrder.setDepositRequested(orderTotalVO.getSumDepositRequested());
		commissionsCheckingOrder.setPaidUp(orderTotalVO.getSumPaidUp());
		commissionsCheckingOrder.setCommissionsMoney(orderTotalVO.getSumCommissionsMoney());
		//计算所有结算单对应的销售订单的订单周期
		String salesNoIns = salesOrderService.selectSalesNoInsBySalesCheckingOrder(pd);
		String orderCycle = salesOrderService.getOrderCycle(Tools.strSqlIn(salesNoIns));
		commissionsCheckingOrder.setOrderCycle(orderCycle);
		
		List<CommissionsCheckingOrderDetail> newDetailList = new ArrayList<>();
		CommissionsCheckingOrderDetail newDetail = null;
		int itemNo = 1;
		for (CommissionsCheckingOrderDetail detail : checkingOrderDetails) {
			newDetail = new CommissionsCheckingOrderDetail();
			BeanutilsCopy.apacheCopyProperties(newDetail, detail);
			newDetail.setUid(null);
			newDetail.setItemNo(itemNo++);
			newDetail.setCommissionsCheckingNo(commissionsCheckingOrder.getCommissionsCheckingNo());
			newDetail.setCreator(commissionsCheckingOrder.getCreator());
			newDetail.setCreateTime(commissionsCheckingOrder.getCreateTime());
			newDetail.setSalesNo(null); //销售提成结算单不保存销售单号
			newDetailList.add(newDetail);
		}
		commissionsCheckingOrder.setOrderNum((short)(itemNo-1));
		
		int result = this.insertListCommissionsCheckingOrderDetail(newDetailList);
		result = this.insertCommissionsCheckingOrder(commissionsCheckingOrder);
		//更新提成分配状态为已生成结算单
		pd.put("orderNoIns", Tools.strSqlIn(checkingNoIns));
		pd.put("isChecking", "1");
		result = this.updateBatchOrderCommissionStatusByPrimaryKey(pd);
		if (result<=0) {
			throw new RuntimeException("提成结算单生成失败");
		}
		return result;
	}
	
	private CommissionsCheckingOrder fillDataForCommissionsCheckingOrder(PageData pd){
		Date nowDate = new Date();
		CommissionsCheckingOrder commissionsCheckingOrder = new CommissionsCheckingOrder();
		commissionsCheckingOrder.setOrderDate(nowDate);
		commissionsCheckingOrder.setComKey(pd.getString("comKey"));
		commissionsCheckingOrder.setIndustryId(pd.getString("industryId"));
		commissionsCheckingOrder.setPartnerKey(pd.getString("partnerKey"));
		commissionsCheckingOrder.setPartnerName(pd.getString("partnerName"));
		commissionsCheckingOrder.setPartnerShortname(pd.getString("partnerShortname"));
		commissionsCheckingOrder.setContactId(pd.getString("contactId"));
		commissionsCheckingOrder.setContactName(pd.getString("contactName"));
		commissionsCheckingOrder.setCaseDesc(pd.getString("caseDesc"));
		commissionsCheckingOrder.setOrderType(StringUtil.isEmpty(pd.getString("orderType"))==true?"1":pd.getString("orderType"));
		if ("2".equalsIgnoreCase(pd.getString("orderType"))) {
			commissionsCheckingOrder.setCommissionsCheckingNo(CodeBuilderUtil.getInstance().getOrderId("ST", 8));
			commissionsCheckingOrder.setTaskUserKey(pd.getString("taskUserKey"));
			commissionsCheckingOrder.setTaskEmployeeId(pd.getString("taskEmployeeId"));
			commissionsCheckingOrder.setTaskUserName(pd.getString("taskUserName"));
		}else{
			commissionsCheckingOrder.setCommissionsCheckingNo(CodeBuilderUtil.getInstance().getOrderId("XT", 8));
			commissionsCheckingOrder.setSalesId(pd.getString("salesId"));
			commissionsCheckingOrder.setSalesName(pd.getString("salesName"));
		}
		commissionsCheckingOrder.setIsValid("1");
		commissionsCheckingOrder.setIsDel("0");
		commissionsCheckingOrder.setOrderStatus(OrderEnum.STATUS_SETTLEMENT_NO.getCode()); //11未结算
		
		commissionsCheckingOrder.setCreator(pd.getString("userKey"));
		commissionsCheckingOrder.setCreateTime(nowDate);
		return commissionsCheckingOrder;
	}
	
	/**
	 * 
	 * @Title: savePaymentSettlement 
	 * @param comKey
	 * @param receiptPayment
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 结算付款
	 */
	public int savePaymentSettlement(String comKey,ReceiptPayment receiptPayment,String orderType) throws Exception{
		Date nowDate = new Date();
		if ("2".equals(orderType)) {
			receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_DESIGN_COMMISSION.getCode());//5设计提成结算单
			
		}else {
			receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_SALES_COMMISSION.getCode());//4销售提成结算单
		}
		receiptPayment.setComKey(comKey);
		receiptPayment.setIsValid("1");
		receiptPayment.setCreateTime(nowDate);
		int result = receiptPaymentMapper.insertSelective(receiptPayment);
		
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("commissionsCheckingNo", receiptPayment.getCheckingNo());
		CommissionsCheckingOrder checkingOrder = this.selectOneCommissionsCheckingOrder(pd);
		if(checkingOrder==null){
			throw new RuntimeException("提成结算单费用保存失败");
		}
		
		checkingOrder.setOrderStatus(OrderEnum.STATUS_SETTLEMENT_YES.getCode()); //12已结算
		checkingOrder.setSettlementMoney(receiptPayment.getRecpayMoney());
		checkingOrder.setBalanceMoney(checkingOrder.getSettlementMoney()
				.subtract(checkingOrder.getCommissionsMoney()).setScale(2, BigDecimal.ROUND_HALF_UP)); //差额=实际支付提成金额-合计提成金额
		result = this.updateCommissionsCheckingOrder(checkingOrder);
		if (result<=0) {
			throw new RuntimeException("付款结算失败");
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: updatePaymentSettlement 
	 * @param comKey
	 * @param receiptPayment
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 修改提成付款
	 */
	public int updatePaymentSettlement(String comKey,ReceiptPayment receiptPayment) throws Exception{
		receiptPayment.setComKey(comKey);
		int result = receiptPaymentMapper.updateByPrimaryKeySelective(receiptPayment);
		
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("commissionsCheckingNo", receiptPayment.getCheckingNo());
		CommissionsCheckingOrder checkingOrder = this.selectOneCommissionsCheckingOrder(pd);
		if(checkingOrder==null){
			throw new RuntimeException("提成结算单费用保存失败");
		}
		checkingOrder.setSettlementMoney(receiptPayment.getRecpayMoney());
		checkingOrder.setBalanceMoney(checkingOrder.getSettlementMoney()
				.subtract(checkingOrder.getCommissionsMoney()).setScale(2, BigDecimal.ROUND_HALF_UP)); //差额=实际支付提成金额-合计提成金额
		result = this.updateCommissionsCheckingOrder(checkingOrder);
		if (result<=0) {
			throw new RuntimeException("付款结算失败");
		}
		
		return result;
	}
	
	//=======设计提成
	public List<OrderCommissions> listPageAssignTasksForCommission(Page page){
		return orderCommissionsMapper.listPageAssignTasksForCommission(page);
	}
	
	/**
	 * 
	 * @Title: listAssignDesigners 
	 * @param taskNo
	 * @return
	 * @return List<AssignTaskDetail>
	 * @throws 
	 * @Description: 获取设计任务单的设计师
	 */
	public List<AssignTaskDetail> listAssignDesigners(String taskNo){
		return assignTaskService.listDoingTaskEmployees(taskNo);
	}
	
	/**
	 * @Title: insertNewAssignTaskCommissions 
	 * @param userVo
	 * @param orderCommissionsList
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 提成分配插入新记录
	 */
	public int insertNewAssignTaskCommissions(UserVo userVo,List<OrderCommissions> orderCommissionsList) throws Exception{
		Date nowDate = new Date();
		BigDecimal sumRate = BigDecimal.ZERO;
		BigDecimal sumCommissionMoney = BigDecimal.ZERO;
		for (OrderCommissions commission : orderCommissionsList) {
			commission.setComKey(userVo.getComKey());
			commission.setIndustryId(userVo.getDetailIndustryId());
			commission.setOrderType("2");
			commission.setIsChecking("0");
			commission.setIsValid("1");
			commission.setCreateTime(nowDate);
			commission.setCreator(userVo.getUserKey());
			commission.setCommissionsRate(commission.getCommissionsRate()==null?BigDecimal.ZERO:commission.getCommissionsRate());
			sumRate = commission.getCommissionsRate().add(sumRate).setScale(2, BigDecimal.ROUND_HALF_UP);
			sumCommissionMoney = commission.getCommissionsMoney().add(sumCommissionMoney).setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		
		int result = this.insertListOrderCommissions(orderCommissionsList);
		
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("taskNoIns", Tools.strSqlIn(orderCommissionsList.get(0).getOrderNo()));
		pd.put("isSettlement", "1");
		pd.put("commissionRate", sumRate);
		pd.put("commissionMoney", sumCommissionMoney);
		result = assignTaskService.updateBatchAssignTask(pd); //更新设计任务单的状态
		
		return result;
	}
	
	public List<OrderCommissions> listSettlementDesigners(Page page){
		return orderCommissionsMapper.listPageByPrimaryKey(page);
	}
	
	/**
	 * 
	 * @Title: listPageOrderCommissionByDesign 
	 * @param page
	 * @return
	 * @return List<OrderCommissions>
	 * @throws 
	 * @Description: 查询已分配提成未结算的设计派工
	 */
	public List<OrderCommissions> listPageOrderCommissionByDesign(Page page){
		return orderCommissionsMapper.listPageOrderCommissionByDesign(page);
	}
	
	/**
	 * 
	 * @Title: updateReAssignTaskCommissions 
	 * @param userVo
	 * @param orderCommissionsList
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 修改重新分配设计师提成
	 * 1.构造新的提成方案记录
	 * 2.删除原有的提成方案
	 * 3.保存新的提成方案
	 * 4.更新设计工单的金额及状态
	 */
	public int updateReAssignTaskCommissions(UserVo userVo,List<OrderCommissions> orderCommissionsList) throws Exception{
		Date nowDate = new Date();
		BigDecimal sumRate = BigDecimal.ZERO;
		BigDecimal sumCommissionMoney = BigDecimal.ZERO;
		for (OrderCommissions commission : orderCommissionsList) {
			commission.setComKey(userVo.getComKey());
			commission.setIndustryId(userVo.getDetailIndustryId());
			commission.setOrderType("2");
			commission.setIsChecking("0");
			commission.setIsValid("1");
			commission.setCreateTime(nowDate);
			commission.setCreator(userVo.getUserKey());
			commission.setCommissionsRate(commission.getCommissionsRate()==null?BigDecimal.ZERO:commission.getCommissionsRate());
			sumRate = commission.getCommissionsRate().add(sumRate).setScale(2, BigDecimal.ROUND_HALF_UP);
			sumCommissionMoney = commission.getCommissionsMoney().add(sumCommissionMoney).setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		
		PageData pd = new PageData();
		OrderCommissions commission = orderCommissionsList.get(0);
		pd.put("comKey", commission.getComKey());
		pd.put("orderNo", commission.getOrderNo());
		int result = this.deleteOrderCommissions(pd);
		result = this.insertListOrderCommissions(orderCommissionsList);
		
		pd.put("taskNoIns", Tools.strSqlIn(orderCommissionsList.get(0).getOrderNo()));
		pd.put("isSettlement", "1");
		pd.put("commissionRate", sumRate);
		pd.put("commissionMoney", sumCommissionMoney);
		result = assignTaskService.updateBatchAssignTask(pd); //更新设计任务单的状态
		
		return result;
		
	}
	
	public int saveNewDesignCommissionCheckingAndDetail(String taskNoIns,UserVo userVo) throws Exception{
		
		Page page = new Page();
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("uidIns", Tools.strSqlIn(taskNoIns));
		page.setShowCount(10000);
		page.setPd(pd);
		List<OrderCommissions> orderCommissionsList = this.listPageOrderCommissionByDesign(page);
		
		if (orderCommissionsList==null||orderCommissionsList.size()<=0) {
			return 0;
		}
		OrderCommissions orderCommission = orderCommissionsList.get(0);
		pd.put("userKey", userVo.getUserKey());
		pd.put("industryId", userVo.getDetailIndustryId());
		pd.put("partnerKey", orderCommission.getPartnerKey());
		pd.put("partnerName", orderCommission.getPartnerName());
		pd.put("partnerShortname", orderCommission.getPartnerShortname());
		pd.put("contactId", orderCommission.getContactId());
		pd.put("contactName", orderCommission.getContactName());
		pd.put("orderType", "2");
		pd.put("taskUserKey", orderCommission.getTaskUserKey());
		pd.put("taskEmployeeId", orderCommission.getTaskEmployeeId());
		pd.put("taskUserName", orderCommission.getTaskUserName());
		if (orderCommissionsList.size()>1) {
			pd.put("caseDesc", "多笔");
		}else{
			pd.put("caseDesc", orderCommissionsList.get(0).getCaseDesc());
		}
		CommissionsCheckingOrder commissionsCheckingOrder = this.fillDataForCommissionsCheckingOrder(pd);
		OrderTotalVO orderTotalVO = this.selectSumDesignerCommission(pd); //获取需要核算提成的金额统计
		commissionsCheckingOrder.setCommissionsMoney(orderTotalVO.getSumCommissionsMoney());
		
		//计算所有结算单对应的销售订单的订单周期
		List<String> salesNoIns = new ArrayList<>();
		for (OrderCommissions orderCommissions2 : orderCommissionsList) {
			salesNoIns.add(orderCommissions2.getSalesNo());
		}
		pd.clear();
		pd.put("comKey", userVo.getComKey());
		pd.put("salesNoList", salesNoIns);
		OrderTotalVO orderTotalVOforSales = salesOrderService.getSumTotalPriceOrder(pd);
		commissionsCheckingOrder.setTotalPrice(orderTotalVOforSales.getSumTotalPrice());
		String orderCycle = salesOrderService.getOrderCycle(Tools.strSqlIn(Tools.list2InString(salesNoIns)));
		commissionsCheckingOrder.setOrderCycle(orderCycle);
		
		List<CommissionsCheckingOrderDetail> newDetailList = new ArrayList<>();
		CommissionsCheckingOrderDetail newDetail = null;
		int itemNo = 1;
		for (OrderCommissions detail : orderCommissionsList) {
			newDetail = new CommissionsCheckingOrderDetail();
			BeanutilsCopy.apacheCopyProperties(newDetail, detail);
			newDetail.setUid(null);
			newDetail.setItemNo(itemNo++);
			newDetail.setTaskNo(detail.getOrderNo());
			newDetail.setCommissionsCheckingNo(commissionsCheckingOrder.getCommissionsCheckingNo());
			newDetail.setCreator(commissionsCheckingOrder.getCreator());
			newDetail.setCreateTime(commissionsCheckingOrder.getCreateTime());
			newDetail.setIndustryId(commissionsCheckingOrder.getIndustryId());
			newDetail.setIsDel("0");
			newDetail.setIsValid("1");
			newDetailList.add(newDetail);
		}
		commissionsCheckingOrder.setOrderNum((short)(itemNo-1));
		
		int result = this.insertListCommissionsCheckingOrderDetail(newDetailList);
		result = this.insertCommissionsCheckingOrder(commissionsCheckingOrder);
		//更新提成分配状态为已生成结算单
		pd.clear();
		pd.put("comKey", userVo.getComKey());
		pd.put("uidIns", Tools.strSqlIn(taskNoIns));
		pd.put("isChecking", "1");
		result = this.updateBatchOrderCommissionStatusByPrimaryKey(pd);
		if (result<=0) {
			throw new RuntimeException("提成结算单生成失败");
		}
		return result;
	}
	
	public OrderTotalVO selectSumDesignerCommission(PageData pd){
		return orderCommissionsMapper.selectSumDesignerCommission(pd);
	}

}
