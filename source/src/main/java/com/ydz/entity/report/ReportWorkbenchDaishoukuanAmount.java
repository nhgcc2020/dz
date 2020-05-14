package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: ReportWorkbenchDaishoukuanAmount 
 * @Description: 工作台销售待收款对账单
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月11日 下午1:43:56 
 * 
 */
public class ReportWorkbenchDaishoukuanAmount implements Serializable{

	private static final long serialVersionUID = 3715205645813181932L;
	
	private String totalPrice;
	private String receivablesMoney;
	private Integer monthOrderDate;
	
	
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getReceivablesMoney() {
		return receivablesMoney;
	}
	public void setReceivablesMoney(String receivablesMoney) {
		this.receivablesMoney = receivablesMoney;
	}
	public Integer getMonthOrderDate() {
		return monthOrderDate;
	}
	public void setMonthOrderDate(Integer monthOrderDate) {
		this.monthOrderDate = monthOrderDate;
	}

}
