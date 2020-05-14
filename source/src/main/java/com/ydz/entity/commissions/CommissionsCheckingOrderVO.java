/**   
 * @Title: CommissionsCheckingOrderVO.java 
 * @Package com.ydz.entity.commissions 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 26, 2017 6:05:41 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.commissions;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: CommissionsCheckingOrderVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 26, 2017 6:05:41 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class CommissionsCheckingOrderVO extends CommissionsCheckingOrder implements Serializable{
	
	private static final long serialVersionUID = 8056869035688612953L;

	private String recpayName; //收款人

	@JSONField(format = "yyyy-MM-dd")
	private String recpayDate; //收款日期
	
	private String accountPayee; //收付款账户
	
	private String balanceRemarks; //差额说明

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
