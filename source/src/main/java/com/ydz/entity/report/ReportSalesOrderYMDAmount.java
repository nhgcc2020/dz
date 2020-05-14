package com.ydz.entity.report;

import java.io.Serializable;

import com.ydz.util.StringUtil;


/** 
 * @ClassName: ReportSalesOrderYMDAmount 
 * @Description: 销售订单年月日的订单金额统计
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月6日 下午10:30:22 
 * 
 */
public class ReportSalesOrderYMDAmount implements Serializable{
	
	private static final long serialVersionUID = -588529874572568075L;
	
	private String years;
	private String months;
	private String days;
	private String totalPrice;
	private String orderNum;
	private String trend;
	
	
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getTotalPrice() {
		if(StringUtil.isEmpty(totalPrice)){
			totalPrice = "0.00";
		}
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getTrend() {
		return trend;
	}
	public void setTrend(String trend) {
		this.trend = trend;
	}
}
