/**   
 * @Title: ReportCompanySheet.java 
 * @Package com.ydz.entity.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:48:18 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: ReportCompanySheet 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:48:18 PM 
 * @Description: 公司营收利润成本等统计表
 */
public class ReportCompanySheet implements Serializable{
	
	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = -4218406434222372530L;
	
	private BigDecimal salesTotalPrice;
	private BigDecimal purchaseTotalPrice;
	private BigDecimal expenseDailyTotalPrice;
	private BigDecimal expenseSalaryTotalPrice;
	
	public BigDecimal getSalesTotalPrice() {
		return salesTotalPrice;
	}
	public void setSalesTotalPrice(BigDecimal salesTotalPrice) {
		this.salesTotalPrice = salesTotalPrice;
	}
	public BigDecimal getPurchaseTotalPrice() {
		return purchaseTotalPrice;
	}
	public void setPurchaseTotalPrice(BigDecimal purchaseTotalPrice) {
		this.purchaseTotalPrice = purchaseTotalPrice;
	}
	public BigDecimal getExpenseDailyTotalPrice() {
		return expenseDailyTotalPrice;
	}
	public void setExpenseDailyTotalPrice(BigDecimal expenseDailyTotalPrice) {
		this.expenseDailyTotalPrice = expenseDailyTotalPrice;
	}
	public BigDecimal getExpenseSalaryTotalPrice() {
		return expenseSalaryTotalPrice;
	}
	public void setExpenseSalaryTotalPrice(BigDecimal expenseSalaryTotalPrice) {
		this.expenseSalaryTotalPrice = expenseSalaryTotalPrice;
	}
	
	

}
