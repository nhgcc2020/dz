package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: OrderTotalVO 
 * @Description: 订单统计用值对象
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月13日 下午11:44:56 
 * 
 */
public class OrderTotalVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6503161004749360959L;
	
	private int orderCount; //订单数量
	private int orderDetailCount; //订单明细数量
	
	private BigDecimal sumTotalPrice; //订单/对账单总金额
	private BigDecimal sumReceivablesMoney; //应收总金额
	private BigDecimal sumDepositRequested; //预收总金额
	private BigDecimal sumDetailTotalPrice; //订单明细总金额
	private BigDecimal sumPaidUp; //合计实收总金额
	
	private BigDecimal sumCommissionsMoney; //合计提成金额
	private BigDecimal sumSettlementMoney; //合计提成结算金额
	
	private BigDecimal sumRechargeMoney; //充值总金额
	private BigDecimal sumPresentMoney;  //赠送总金额
	private BigDecimal sumConsumeMoney;  //消费总金额
	private BigDecimal sumBalanceMoney;  //总余额
	
	private BigDecimal sumContractMoney; //合同签约金额
    private BigDecimal sumActualContractMoney; //合同实际金额=计划回款的总金额
    private BigDecimal sumInvoiceContractMoney; //已开票金额
    private BigDecimal sumReturnedContractMoney; //已回款金额
    private BigDecimal sumWaitforContractMoney; //待回款金额
    private BigDecimal sumBaddebtMoney; //坏账
	
	
	//应付总金额
	//实付总金额
	
	public BigDecimal getSumTotalPrice() {
		return sumTotalPrice;
	}
	public void setSumTotalPrice(BigDecimal sumTotalPrice) {
		this.sumTotalPrice = sumTotalPrice==null?BigDecimal.ZERO:sumTotalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public int getOrderDetailCount() {
		return orderDetailCount;
	}
	public void setOrderDetailCount(int orderDetailCount) {
		this.orderDetailCount = orderDetailCount;
	}
	public BigDecimal getSumDetailTotalPrice() {
		return sumDetailTotalPrice;
	}
	public void setSumDetailTotalPrice(BigDecimal sumDetailTotalPrice) {
		this.sumDetailTotalPrice = sumDetailTotalPrice==null?BigDecimal.ZERO:sumDetailTotalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumReceivablesMoney() {
		return sumReceivablesMoney;
	}
	public void setSumReceivablesMoney(BigDecimal sumReceivablesMoney) {
		this.sumReceivablesMoney = sumReceivablesMoney==null?BigDecimal.ZERO:sumReceivablesMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumDepositRequested() {
		return sumDepositRequested;
	}
	public void setSumDepositRequested(BigDecimal sumDepositRequested) {
		this.sumDepositRequested = sumDepositRequested==null?BigDecimal.ZERO:sumDepositRequested.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumPaidUp() {
		return sumPaidUp;
	}
	public void setSumPaidUp(BigDecimal sumPaidUp) {
		this.sumPaidUp = sumPaidUp==null?BigDecimal.ZERO:sumPaidUp.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumCommissionsMoney() {
		return sumCommissionsMoney;
	}
	public void setSumCommissionsMoney(BigDecimal sumCommissionsMoney) {
		this.sumCommissionsMoney = sumCommissionsMoney==null?BigDecimal.ZERO:sumCommissionsMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumSettlementMoney() {
		return sumSettlementMoney;
	}
	public void setSumSettlementMoney(BigDecimal sumSettlementMoney) {
		this.sumSettlementMoney = sumSettlementMoney==null?BigDecimal.ZERO:sumSettlementMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumRechargeMoney() {
		return sumRechargeMoney;
	}
	public void setSumRechargeMoney(BigDecimal sumRechargeMoney) {
		this.sumRechargeMoney = sumRechargeMoney==null?BigDecimal.ZERO:sumRechargeMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumPresentMoney() {
		return sumPresentMoney;
	}
	public void setSumPresentMoney(BigDecimal sumPresentMoney) {
		this.sumPresentMoney = sumPresentMoney==null?BigDecimal.ZERO:sumPresentMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumConsumeMoney() {
		return sumConsumeMoney;
	}
	public void setSumConsumeMoney(BigDecimal sumConsumeMoney) {
		this.sumConsumeMoney = sumConsumeMoney==null?BigDecimal.ZERO:sumConsumeMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumBalanceMoney() {
		return sumBalanceMoney;
	}
	public void setSumBalanceMoney(BigDecimal sumBalanceMoney) {
		this.sumBalanceMoney = sumBalanceMoney==null?BigDecimal.ZERO:sumBalanceMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getSumContractMoney() {
		return sumContractMoney;
	}
	public void setSumContractMoney(BigDecimal sumContractMoney) {
		this.sumContractMoney = sumContractMoney;
	}
	public BigDecimal getSumActualContractMoney() {
		return sumActualContractMoney;
	}
	public void setSumActualContractMoney(BigDecimal sumActualContractMoney) {
		this.sumActualContractMoney = sumActualContractMoney;
	}
	public BigDecimal getSumInvoiceContractMoney() {
		return sumInvoiceContractMoney;
	}
	public void setSumInvoiceContractMoney(BigDecimal sumInvoiceContractMoney) {
		this.sumInvoiceContractMoney = sumInvoiceContractMoney;
	}
	public BigDecimal getSumReturnedContractMoney() {
		return sumReturnedContractMoney;
	}
	public void setSumReturnedContractMoney(BigDecimal sumReturnedContractMoney) {
		this.sumReturnedContractMoney = sumReturnedContractMoney;
	}
	public BigDecimal getSumWaitforContractMoney() {
		return sumWaitforContractMoney;
	}
	public void setSumWaitforContractMoney(BigDecimal sumWaitforContractMoney) {
		this.sumWaitforContractMoney = sumWaitforContractMoney;
	}
	public BigDecimal getSumBaddebtMoney() {
		return sumBaddebtMoney;
	}
	public void setSumBaddebtMoney(BigDecimal sumBaddebtMoney) {
		this.sumBaddebtMoney = sumBaddebtMoney;
	}
}
