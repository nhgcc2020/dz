/**   
 * @Title: ReportSalesOrderPartnerAmount.java 
 * @Package com.ydz.entity.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 27, 2017 3:56:13 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: ReportSalesOrderPartnerAmount 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 27, 2017 3:56:13 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class ReportSalesOrderPartnerAmount implements Serializable{

	private static final long serialVersionUID = -2223177324346068878L;
	
	private int partnerNum;
	private String partnerKey;
	private String partnerName;
	private int orderNum;
	private BigDecimal sumTotalPrice;
	public int getPartnerNum() {
		return partnerNum;
	}
	public void setPartnerNum(int partnerNum) {
		this.partnerNum = partnerNum;
	}
	public String getPartnerKey() {
		return partnerKey;
	}
	public void setPartnerKey(String partnerKey) {
		this.partnerKey = partnerKey;
	}
	public String getPartnerName() {
		return partnerName;
	}
	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public BigDecimal getSumTotalPrice() {
		return sumTotalPrice;
	}
	public void setSumTotalPrice(BigDecimal sumTotalPrice) {
		this.sumTotalPrice = sumTotalPrice;
	}
}
