/**
 * 
 */
package com.ydz.vo;

import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;



public class AllSalesCheckingOrderVO extends SalesCheckingOrder implements Serializable {

	private static final long serialVersionUID = 136814320159675098L;

	private String recpayName; //收款人

	private String recpayDate; //收款日期
	
	private String accountPayee; //收付款账户
	
	private String balanceRemarks; //差额说明

	private String invoiceDate; //发票日期

	private String ciComName; // 开票公司

	private BigDecimal invoiceAmount;

	public BigDecimal getInvoiceAmount() {
		if(invoiceAmount==null){
			invoiceAmount = new BigDecimal(0);
		}else{
			invoiceAmount = invoiceAmount.setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		return invoiceAmount;
	}

	public void setInvoiceAmount(BigDecimal invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	public String getRecpayName() {
		return recpayName;
	}

	public void setRecpayName(String recpayName) {
		this.recpayName = recpayName;
	}

	public String getRecpayDate() {
		return recpayDate;
	}

	public void setRecpayDate(String recpayDate) {
		this.recpayDate = recpayDate;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getCiComName() {
		return ciComName;
	}

	public void setCiComName(String ciComName) {
		this.ciComName = ciComName;
	}

	public String getAccountPayee() {
		return accountPayee;
	}

	public void setAccountPayee(String accountPayee) {
		this.accountPayee = accountPayee;
	}

	public String getBalanceRemarks() {
		return balanceRemarks;
	}

	public void setBalanceRemarks(String balanceRemarks) {
		this.balanceRemarks = balanceRemarks;
	}
}
