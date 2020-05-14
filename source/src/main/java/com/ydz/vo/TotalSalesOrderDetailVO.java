/**
 * 
 */
package com.ydz.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.SalesOrderDetail;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/** 
 * @ClassName: TotalDetailVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月12日 下午4:48:40 
 * 
 */
public class TotalSalesOrderDetailVO extends SalesOrderDetail implements Serializable{

	private static final long serialVersionUID = 6516107771424426793L;
	
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
	
	private String industryId;
	
	private BigDecimal totalPriceOrder;
	
	private BigDecimal depositRequested;
	
	private String purchaseNo;
	
	private String salescheckingNo;
	
	private String caseDesc;
	
	private String taskStatus;
	
	private OrderTotalVO orderTotalVO;
	
	private int purchaseNoNum;

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
		this.partnerShortname = partnerShortname == null ? "" : partnerShortname.trim();
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

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
	}

	public BigDecimal getTotalPriceOrder() {
		return totalPriceOrder;
	}

	public void setTotalPriceOrder(BigDecimal totalPriceOrder) {
		this.totalPriceOrder = totalPriceOrder;
	}

	public BigDecimal getDepositRequested() {
		return depositRequested;
	}

	public void setDepositRequested(BigDecimal depositRequested) {
		this.depositRequested = depositRequested;
	}

	public String getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(String purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getSalescheckingNo() {
		return salescheckingNo;
	}

	public void setSalescheckingNo(String salescheckingNo) {
		this.salescheckingNo = salescheckingNo;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public OrderTotalVO getOrderTotalVO() {
		return orderTotalVO;
	}

	public void setOrderTotalVO(OrderTotalVO orderTotalVO) {
		this.orderTotalVO = orderTotalVO;
	}

	public int getPurchaseNoNum() {
		return purchaseNoNum;
	}

	public void setPurchaseNoNum(int purchaseNoNum) {
		this.purchaseNoNum = purchaseNoNum;
	}

}
