package com.ydz.entity.advert;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class SalesCheckingOrder implements Serializable{

	private static final long serialVersionUID = 5113845947079106764L;

	@JSONField(serialize=false)
	private Long uid;

    private String salescheckingNo;

    private String comKey;
    
    private String comName;

    private String partnerKey;

    private String partnerName;
    
    private String partnerShortname;
    
    private String partnerAddress;
    
    private String taxNo;

    private String salesId;

    private String salesName;

    private String contactId;

    private String contactName;
    
    private String contactTel;

    private String orderSelfNo;
    
    private String orderCycle;

    private String caseDesc;

    @JSONField(format="yyyy-MM-dd")
    private Date orderDate;

    private BigDecimal price;

    private BigDecimal discountRate;

    private BigDecimal discount;

    private BigDecimal taxRate;

    private BigDecimal taxPrice;

    private BigDecimal preferential;

    private BigDecimal totalPrice;

    private BigDecimal depositRequested;

    private BigDecimal receivablesMoney;

    private BigDecimal invoiceMoney;

    private BigDecimal paidUp;
    
    private BigDecimal balanceMoney;

    private String remarks;

    private String orderStatus;
    
    private String orderStatusDesc;

    private String invoiceStatus;
    
    private String invoiceStatusDesc;
    
    private String isSettlement;

    private String orderType;

    private Short salesOrderNum;

    private Short detailNum;
    
    private String orderCountValue;

    private String isValid;

    private String isDel;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date changedTime;

    private String businessType;

    private String industryId;

    private String salesNo;
    
    private String purchasecheckingNo;

    private String creator;
    
    private String creatorName;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;


    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getSalescheckingNo() {
        return salescheckingNo;
    }

    public void setSalescheckingNo(String salescheckingNo) {
        this.salescheckingNo = salescheckingNo == null ? null : salescheckingNo.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getPartnerKey() {
        return partnerKey;
    }

    public void setPartnerKey(String partnerKey) {
        this.partnerKey = partnerKey == null ? null : partnerKey.trim();
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName == null ? null : partnerName.trim();
    }

    public String getSalesId() {
        return salesId;
    }

    public void setSalesId(String salesId) {
        this.salesId = salesId == null ? null : salesId.trim();
    }

    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName == null ? null : salesName.trim();
    }

    public String getContactId() {
        return contactId;
    }

    public void setContactId(String contactId) {
        this.contactId = contactId == null ? null : contactId.trim();
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName == null ? null : contactName.trim();
    }

    public String getContactTel() {
		return contactTel;
	}

	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

	public String getOrderSelfNo() {
        return orderSelfNo;
    }

    public void setOrderSelfNo(String orderSelfNo) {
        this.orderSelfNo = orderSelfNo == null ? null : orderSelfNo.trim();
    }

    public String getCaseDesc() {
        return caseDesc;
    }

    public void setCaseDesc(String caseDesc) {
        this.caseDesc = caseDesc == null ? "" : caseDesc.trim();
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getPrice() {
    	if(price ==null){
    		price = new BigDecimal(0).setScale(2);
    	}else{
    		price = price.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getDiscountRate() {
    	if(discountRate ==null){
    		discountRate = new BigDecimal(0).setScale(2);
    	}else{
    		discountRate = discountRate.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return discountRate;
    }

    public void setDiscountRate(BigDecimal discountRate) {
        this.discountRate = discountRate;
    }

    public BigDecimal getDiscount() {
    	if(discount ==null){
    		discount = new BigDecimal(0).setScale(2);
    	}else{
    		discount = discount.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return discount;
    }

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public BigDecimal getPreferential() {
    	if(preferential ==null){
    		preferential = new BigDecimal(0).setScale(2);
    	}else{
    		preferential = preferential.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return preferential;
    }

    public void setPreferential(BigDecimal preferential) {
        this.preferential = preferential;
    }

    public BigDecimal getTaxRate() {
    	if(taxRate ==null){
    		taxRate = new BigDecimal(0).setScale(2);
    	}else{
    		taxRate = taxRate.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return taxRate;
    }

    public void setTaxRate(BigDecimal taxRate) {
        this.taxRate = taxRate;
    }

    public BigDecimal getTaxPrice() {
    	if(taxPrice == null){
    		taxPrice = new BigDecimal(0).setScale(2);
    	}else{
    		taxPrice = taxPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return taxPrice;
    }

    public void setTaxPrice(BigDecimal taxPrice) {
        this.taxPrice = taxPrice;
    }

    public BigDecimal getTotalPrice() {
    	if(totalPrice == null){
    		totalPrice = new BigDecimal(0).setScale(2);
    	}else{
    		totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getDepositRequested() {
    	if(depositRequested ==null){
    		depositRequested = new BigDecimal(0).setScale(2);
    	}else{
    		depositRequested = depositRequested.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return depositRequested;
    }

    public void setDepositRequested(BigDecimal depositRequested) {
        this.depositRequested = depositRequested;
    }

    public BigDecimal getReceivablesMoney() {
    	if(receivablesMoney ==null){
    		receivablesMoney = new BigDecimal(0).setScale(2);
    	}else{
    		receivablesMoney = receivablesMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return receivablesMoney;
    }

    public void setReceivablesMoney(BigDecimal receivablesMoney) {
        this.receivablesMoney = receivablesMoney;
    }

    public BigDecimal getInvoiceMoney() {
    	if(invoiceMoney ==null){
    		invoiceMoney = new BigDecimal(0).setScale(2);
    	}else{
    		invoiceMoney = invoiceMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return invoiceMoney;
    }

    public void setInvoiceMoney(BigDecimal invoiceMoney) {
        this.invoiceMoney = invoiceMoney;
    }

    public BigDecimal getPaidUp() {
    	if(paidUp ==null){
    		paidUp = new BigDecimal(0).setScale(2);
    	}else{
    		paidUp = paidUp.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return paidUp;
    }

    public void setPaidUp(BigDecimal paidUp) {
        this.paidUp = paidUp;
    }

    public BigDecimal getBalanceMoney() {
    	if(balanceMoney ==null){
    		balanceMoney = new BigDecimal(0).setScale(2);
    	}else{
    		balanceMoney = balanceMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return balanceMoney;
	}

	public void setBalanceMoney(BigDecimal balanceMoney) {
		this.balanceMoney = balanceMoney;
	}

	public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus == null ? null : orderStatus.trim();
    }

    public String getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceStatus(String invoiceStatus) {
        this.invoiceStatus = invoiceStatus == null ? null : invoiceStatus.trim();
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType == null ? null : orderType.trim();
    }

    public Short getSalesOrderNum() {
        return salesOrderNum;
    }

    public void setSalesOrderNum(Short salesOrderNum) {
        this.salesOrderNum = salesOrderNum;
    }

    public Short getDetailNum() {
        return detailNum;
    }

    public void setDetailNum(Short detailNum) {
        this.detailNum = detailNum;
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
    }

    public Date getChangedTime() {
        return changedTime;
    }

    public void setChangedTime(Date changedTime) {
        this.changedTime = changedTime;
    }

    public String getBusinessType() {
        return businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType == null ? null : businessType.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getSalesNo() {
        return salesNo;
    }

    public void setSalesNo(String salesNo) {
        this.salesNo = salesNo == null ? null : salesNo.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getPartnerShortname() {
        return partnerShortname;
    }

    public void setPartnerShortname(String partnerShortname) {
        this.partnerShortname = partnerShortname;
    }

	public String getPartnerAddress() {
		return partnerAddress;
	}

	public void setPartnerAddress(String partnerAddress) {
		this.partnerAddress = partnerAddress;
	}

	public String getTaxNo() {
		return taxNo;
	}

	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}

	public String getPurchasecheckingNo() {
		return purchasecheckingNo;
	}

	public void setPurchasecheckingNo(String purchasecheckingNo) {
		this.purchasecheckingNo = purchasecheckingNo;
	}

	public String getOrderStatusDesc() {
		return orderStatusDesc;
	}

	public void setOrderStatusDesc(String orderStatusDesc) {
		this.orderStatusDesc = orderStatusDesc;
	}

	public String getInvoiceStatusDesc() {
		return invoiceStatusDesc;
	}

	public void setInvoiceStatusDesc(String invoiceStatusDesc) {
		this.invoiceStatusDesc = invoiceStatusDesc;
	}

	public String getIsSettlement() {
		return isSettlement;
	}

	public void setIsSettlement(String isSettlement) {
		this.isSettlement = isSettlement;
	}

	public String getOrderCountValue() {
		return orderCountValue;
	}

	public void setOrderCountValue(String orderCountValue) {
		this.orderCountValue = orderCountValue;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle == null ? null : orderCycle.trim();
	}
	
}