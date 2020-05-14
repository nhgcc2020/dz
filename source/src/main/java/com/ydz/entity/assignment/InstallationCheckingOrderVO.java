/**   
 * @Title: InstallationCheckingOrderVO.java 
 * @Package com.ydz.entity.assignment 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 19, 2017 4:26:13 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.assignment;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: InstallationCheckingOrderVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 19, 2017 4:26:13 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class InstallationCheckingOrderVO extends InstallationCheckingOrder implements Serializable {
	
	private static final long serialVersionUID = -5422009479488224429L;

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
