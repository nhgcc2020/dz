/**   
 * @Title: ReportCompanyRecPayAmount.java 
 * @Package com.ydz.entity.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 15, 2017 4:39:13 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: ReportCompanyRecPayAmount 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 15, 2017 4:39:13 PM 
 * @Description: 公司回款统计
 */
public class ReportCompanyRecPayAmount implements Serializable{

	private static final long serialVersionUID = -5019193408130836922L;
	
	private String accountType;
	private String accountPayee;
	private BigDecimal sumRecpayMoney;
	private BigDecimal sumTotalPrice;
	private BigDecimal sumAllRecpayMoney;
	private BigDecimal sumRangeRecpayMoney;
	private BigDecimal sumRangeTotalPrice;
	public String getAccountType() {
		return accountType;
	}
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	public String getAccountPayee() {
		return accountPayee;
	}
	public void setAccountPayee(String accountPayee) {
		this.accountPayee = accountPayee;
	}
	public BigDecimal getSumRecpayMoney() {
		this.sumRecpayMoney = sumRecpayMoney==null?BigDecimal.ZERO:sumRecpayMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
		return sumRecpayMoney;
	}
	public void setSumRecpayMoney(BigDecimal sumRecpayMoney) {
		this.sumRecpayMoney = sumRecpayMoney;
	}
	public BigDecimal getSumTotalPrice() {
		this.sumTotalPrice = sumTotalPrice==null?BigDecimal.ZERO:sumTotalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
		return sumTotalPrice;
	}
	public void setSumTotalPrice(BigDecimal sumTotalPrice) {
		this.sumTotalPrice = sumTotalPrice;
	}
	public BigDecimal getSumAllRecpayMoney() {
		this.sumAllRecpayMoney = sumAllRecpayMoney==null?BigDecimal.ZERO:sumAllRecpayMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
		return sumAllRecpayMoney;
	}
	public void setSumAllRecpayMoney(BigDecimal sumAllRecpayMoney) {
		this.sumAllRecpayMoney = sumAllRecpayMoney;
	}
	public BigDecimal getSumRangeRecpayMoney() {
		this.sumRangeRecpayMoney = sumRangeRecpayMoney==null?BigDecimal.ZERO:sumRangeRecpayMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
		return sumRangeRecpayMoney;
	}
	public void setSumRangeRecpayMoney(BigDecimal sumRangeRecpayMoney) {
		this.sumRangeRecpayMoney = sumRangeRecpayMoney;
	}
	public BigDecimal getSumRangeTotalPrice() {
		this.sumRangeTotalPrice = sumRangeTotalPrice==null?BigDecimal.ZERO:sumRangeTotalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
		return sumRangeTotalPrice;
	}
	public void setSumRangeTotalPrice(BigDecimal sumRangeTotalPrice) {
		this.sumRangeTotalPrice = sumRangeTotalPrice;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
