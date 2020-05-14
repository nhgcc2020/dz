package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

/** 
 * @ClassName: ReportPartnerAmount 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 10, 2017 2:17:38 PM 
 * @Description: 客户应收汇总报表
 */
public class ReportPartnerAmount implements Serializable{

	private static final long serialVersionUID = -580910535082927510L;
	
	private String comKey;
	private String partnerKey;
	private String partnerName;
	private String partnerShortname;
	
	private BigDecimal totalPrice04;
	private BigDecimal totalPrice07;
	
	private int orderCount;
	
	public String getComKey() {
		return comKey;
	}
	public void setComKey(String comKey) {
		this.comKey = comKey;
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
	public String getPartnerShortname() {
		return partnerShortname;
	}
	public void setPartnerShortname(String partnerShortname) {
		this.partnerShortname = partnerShortname;
	}
	public BigDecimal getTotalPrice04() {
		return totalPrice04;
	}
	public void setTotalPrice04(BigDecimal totalPrice04) {
		this.totalPrice04 = totalPrice04==null?BigDecimal.ZERO:totalPrice04.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public BigDecimal getTotalPrice07() {
		return totalPrice07;
	}
	public void setTotalPrice07(BigDecimal totalPrice07) {
		this.totalPrice07 = totalPrice07==null?BigDecimal.ZERO:totalPrice07.setScale(2, BigDecimal.ROUND_HALF_UP);
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
}
