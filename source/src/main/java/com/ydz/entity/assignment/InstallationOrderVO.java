package com.ydz.entity.assignment;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class InstallationOrderVO extends InstallationOrderDetail implements Serializable{
    
	private static final long serialVersionUID = -3101134019784131585L;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String contactId;

    private String contactName;
    
    @JSONField(format = "yyyy-MM-dd")
    private Date orderDate;

    private String caseDesc;
    
    private BigDecimal discountRate;

    private BigDecimal discount;

    private BigDecimal preferential;
    
    private BigDecimal prepayPrice;
    
    private BigDecimal payablePrice;

    private BigDecimal totalPriceOrder;

    private BigDecimal installationPrice;

    private String status;
    
    private String statusDesc;

    private String orderRemarks;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date orderCreateTime;
    
    private BigDecimal sumDiscount;
    
    private BigDecimal sumPreferential;
    
    private BigDecimal sumPrepayPrice;
    
    private BigDecimal sumPayablePrice;
    
    private BigDecimal sumTotalPrice;

    private BigDecimal sumInstallationPrice;
    
    private String orderCycle;
    
	public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey;
	}

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
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

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public BigDecimal getTotalPriceOrder() {
		return totalPriceOrder;
	}

	public void setTotalPriceOrder(BigDecimal totalPriceOrder) {
		this.totalPriceOrder = totalPriceOrder;
	}

	public BigDecimal getPayablePrice() {
		return payablePrice;
	}

	public void setPayablePrice(BigDecimal payablePrice) {
		this.payablePrice = payablePrice;
	}

	public BigDecimal getSumPayablePrice() {
		return sumPayablePrice;
	}

	public void setSumPayablePrice(BigDecimal sumPayablePrice) {
		this.sumPayablePrice = sumPayablePrice;
	}

	public BigDecimal getInstallationPrice() {
		return installationPrice;
	}

	public void setInstallationPrice(BigDecimal installationPrice) {
		this.installationPrice = installationPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusDesc() {
		return statusDesc;
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	public String getOrderRemarks() {
		return orderRemarks;
	}

	public void setOrderRemarks(String orderRemarks) {
		this.orderRemarks = orderRemarks;
	}

	public Date getOrderCreateTime() {
		return orderCreateTime;
	}

	public void setOrderCreateTime(Date orderCreateTime) {
		this.orderCreateTime = orderCreateTime;
	}

	public BigDecimal getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(BigDecimal discountRate) {
		this.discountRate = discountRate;
	}

	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public BigDecimal getPreferential() {
		return preferential;
	}

	public void setPreferential(BigDecimal preferential) {
		this.preferential = preferential;
	}

	public BigDecimal getPrepayPrice() {
		return prepayPrice;
	}

	public void setPrepayPrice(BigDecimal prepayPrice) {
		this.prepayPrice = prepayPrice;
	}

	public BigDecimal getSumDiscount() {
		return sumDiscount;
	}

	public void setSumDiscount(BigDecimal sumDiscount) {
		this.sumDiscount = sumDiscount;
	}

	public BigDecimal getSumPreferential() {
		return sumPreferential;
	}

	public void setSumPreferential(BigDecimal sumPreferential) {
		this.sumPreferential = sumPreferential;
	}

	public BigDecimal getSumPrepayPrice() {
		return sumPrepayPrice;
	}

	public void setSumPrepayPrice(BigDecimal sumPrepayPrice) {
		this.sumPrepayPrice = sumPrepayPrice;
	}

	public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle;
	}

	public BigDecimal getSumTotalPrice() {
		return sumTotalPrice;
	}

	public void setSumTotalPrice(BigDecimal sumTotalPrice) {
		this.sumTotalPrice = sumTotalPrice;
	}

	public BigDecimal getSumInstallationPrice() {
		return sumInstallationPrice;
	}

	public void setSumInstallationPrice(BigDecimal sumInstallationPrice) {
		this.sumInstallationPrice = sumInstallationPrice;
	}
}