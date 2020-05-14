/**   
 * @Title: PaySettlementService.java 
 * @Package com.ydz.service.system 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 8, 2017 4:17:50 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.system;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.pay.PayMerchantIdMapper;
import com.ydz.dao.pay.PaySettlementMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.pay.PayMerchantId;
import com.ydz.entity.pay.PaySettlement;
import com.ydz.enums.OrderEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;

/** 
 * @ClassName: PaySettlementService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 8, 2017 4:17:50 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
@Service
public class PaySettlementService {
	
	@Autowired private PaySettlementMapper paySettlementMapper;
	@Autowired private PayMerchantIdMapper payMerchantIdMapper;
	
	@Resource private SalesOrderService salesOrderService;
	@Resource private PurchaseOrderService purchaseOrderService;
	
	@Resource private CommonService commonService;
	
	public PayMerchantId selectOneMerchantId(PageData pd){
		return payMerchantIdMapper.selectByPrimaryKey(pd);
	}
	public int insertOneMerchantId(PayMerchantId payMerchantId) throws Exception{
		return payMerchantIdMapper.insertSelective(payMerchantId);
	}
	public int updatePayMerchantId(PayMerchantId payMerchantId) throws Exception{
		return payMerchantIdMapper.updateByPrimaryKeySelective(payMerchantId);
	}
	
	public PaySettlement selectOnePaySettlement(PageData pd){
		return paySettlementMapper.selectByPrimaryKey(pd);
	}
	public int insertOnePaySettlement(PaySettlement paySettlement) throws Exception{
		return paySettlementMapper.insertSelective(paySettlement);
	}
	public int updatePaySettlement(PaySettlement paySettlement) throws Exception{
		return paySettlementMapper.updateByPrimaryKeySelective(paySettlement);
	}
	public int updatePaySettlementByPageData(PageData pd) throws Exception{
		return paySettlementMapper.updatePaySettlementByPageData(pd);
	}
	
	/**
	 * 
	 * @Title: SavePaySalesCheckingOrder 
	 * @param pd
	 * @return
	 * @return int
	 * @throws Exception 
	 * @throws 
	 * @Description: 用于支付成功后回调
	 * 1.单向销售单的，只有收款
	 * 2.协同单的，付款方记录付款，收款方记录收款。并且协同结算单也一并处理
	 * 3.更新销售对账单的收款金额及状态，协同采购对账单的，更新采购对账单的付款及状态
	 * 4.更新支付记录状态为已支付
	 * 
	 */
	public int SavePaySalesCheckingOrder(String back_tradeNo,String accountType) throws Exception{
		PageData pd = new PageData();
		pd.put("tradeNo", back_tradeNo);
		PaySettlement paySettlement = this.selectOnePaySettlement(pd);
		if (paySettlement==null) {
			return 0;
		}
		//更新支付状态已支付成功
		pd.put("isPayed", "1");
		int result = this.updatePaySettlementByPageData(pd);
		if (result<=0) {
			return 0;
		}
		pd.put("comKey", paySettlement.getComKey());
		pd.put("checkingNo", paySettlement.getCheckingNo());
		ReceiptPayment receiptPaymentQuery = salesOrderService.getReceiptPaymentInfo(pd);
		if (receiptPaymentQuery!=null) {
			return 0;  //已付款回调成功，直接返回
		}
		//查询销售结算单
		pd.put("salescheckingNo",paySettlement.getCheckingNo());
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return 0;
		}
		Date nowDate = new Date();
		
		//记录收款信息
		ReceiptPayment receiptPayment = new ReceiptPayment();
		receiptPayment.setComKey(paySettlement.getComKey());
		receiptPayment.setCheckingNo(paySettlement.getCheckingNo());
		receiptPayment.setTradeNo(pd.getString("tradeNo"));
		receiptPayment.setRecpayType("1"); //收款
		receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_SALES.getCode());
		receiptPayment.setRecpayDate(nowDate);
		receiptPayment.setRecpayMoney(paySettlement.getPayMoney().divide(BigDecimal.valueOf(100)).setScale(2, BigDecimal.ROUND_HALF_UP));
		receiptPayment.setAccountPayee(commonService.formatAccountPayee(accountType));
		receiptPayment.setAccountType(accountType);
		int resultSales = salesOrderService.insertReceiptPayment(receiptPayment);
		if (resultSales > 0) {
			//更新销售对账单状态及金额
			pd.put("orderStatus", OrderEnum.STATUS_YISHOUKUAN.getCode());
			pd.put("paidUp", paySettlement.getPayMoney().divide(BigDecimal.valueOf(100)).setScale(2, BigDecimal.ROUND_HALF_UP));
			pd.put("balanceMoney", BigDecimal.ZERO);
			pd.put("changedTime", nowDate);
			pd.put("salescheckingNoIn", Tools.str2StrArray(paySettlement.getCheckingNo()));
			resultSales = salesOrderService.updateBatchBySalesCheckingNoIn(pd);
		}
		int resultPurchase = 0;
		//协同单记录付款
		if(StringUtil.isNotEmpty(checkingOrder.getPurchasecheckingNo())){ 
			pd.clear();
			pd.put("purchasecheckingNo", checkingOrder.getPurchasecheckingNo());
			PurchaseCheckingOrder purchaseCheckingOrder = purchaseOrderService.selectOnePurchaseCheckingOrder(pd);
			if (purchaseCheckingOrder!=null) {
				ReceiptPayment receiptPayment2 = new ReceiptPayment();
				receiptPayment2.setComKey(purchaseCheckingOrder.getComKey());
				receiptPayment2.setCheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
				receiptPayment2.setTradeNo(pd.getString("tradeNo"));
				receiptPayment2.setRecpayType("2"); //付款
				receiptPayment2.setCheckingType(OrderEnum.CHECKING_TYPE_PURCHASE.getCode());
				receiptPayment2.setRecpayDate(nowDate);
				receiptPayment2.setRecpayMoney(paySettlement.getPayMoney().divide(BigDecimal.valueOf(100)).setScale(2, BigDecimal.ROUND_HALF_UP));
				receiptPayment2.setAccountPayee(commonService.formatAccountPayee(accountType));
				receiptPayment2.setAccountType(accountType);
				resultPurchase = salesOrderService.insertReceiptPayment(receiptPayment2); //协同采购单插入付款记录
				if (resultPurchase > 0) {
					//更新采购对账单付款
					pd.put("orderStatus", OrderEnum.STATUS_YIFUKUAN.getCode());
					pd.put("paidUp", paySettlement.getPayMoney().divide(BigDecimal.valueOf(100)).setScale(2, BigDecimal.ROUND_HALF_UP));
					pd.put("changedTime", nowDate);
					pd.put("purchasecheckingNoIn", Tools.str2StrArray(purchaseCheckingOrder.getPurchasecheckingNo()));
					resultPurchase = purchaseOrderService.updateBatchByPurchaseCheckingNoIn(pd);
				}
			}
		}
		
		return result+resultSales+resultPurchase;
	}
	

}
