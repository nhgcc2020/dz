package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;

/** 
 * @ClassName: TotalPurchaseCheckingOrderDetailVO 
 * @Description: 采购对账单明细合并相关字段
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月28日 下午7:18:16 
 * 
 */
public class TotalPurchaseCheckingOrderDetailVO extends PurchaseCheckingOrderDetail implements Serializable{

	private static final long serialVersionUID = -2804149552098470171L;
	
	private String comKey;

    private String partnerKey;

    private String partnerName;
    
    private String partnerShortname;
    
    private String orderStatusMain;
    
    private String orderStatusDesc;

	@JSONField(format="yyyy-MM-dd")
	private Date orderDate;

	private String contactId;

	private String contactName;
	
	private String orderCycle;
	
	private String caseDesc;
	
	private BigDecimal totalOrderPrice;
	
	private BigDecimal purchaseOrderPrice;
	
	private BigDecimal totalArea;
	
	private String isReceived;

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

	public String getOrderStatusMain() {
		return orderStatusMain;
	}

	public void setOrderStatusMain(String orderStatusMain) {
		this.orderStatusMain = orderStatusMain;
	}

	public String getOrderStatusDesc() {
		return orderStatusDesc;
	}

	public void setOrderStatusDesc(String orderStatusDesc) {
		this.orderStatusDesc = orderStatusDesc;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getContactId() {
		return contactId;
	}

	public void setContactId(String contactId) {
		this.contactId = contactId;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public BigDecimal getTotalOrderPrice() {
		return totalOrderPrice;
	}

	public void setTotalOrderPrice(BigDecimal totalOrderPrice) {
		this.totalOrderPrice = totalOrderPrice;
	}

	public BigDecimal getTotalArea() {
		return totalArea;
	}

	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	public BigDecimal getPurchaseOrderPrice() {
		return purchaseOrderPrice;
	}

	public void setPurchaseOrderPrice(BigDecimal purchaseOrderPrice) {
		this.purchaseOrderPrice = purchaseOrderPrice;
	}

	public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle == null ? null : orderCycle.trim();
	}

	public String getIsReceived() {
		return isReceived;
	}

	public void setIsReceived(String isReceived) {
		this.isReceived = isReceived;
	}
}
