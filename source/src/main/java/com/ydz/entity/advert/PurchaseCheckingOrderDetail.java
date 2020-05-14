package com.ydz.entity.advert;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class PurchaseCheckingOrderDetail implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6752210676575109895L;

	@JSONField(serialize=false)
	private Long uid;

    private String purchasecheckingNo;

    private Integer itemNo;

    private String businessType;

    private String businessDesc;

    private String requirements;

    private String specification;

    private String priceWay;
    
    private String priceWayDesc;

    private BigDecimal length;

    private BigDecimal width;

    private BigDecimal colorSize;

    private BigDecimal pairsNum;

    private BigDecimal quantity;

    private String unit;

    private BigDecimal unitPrice;

    private String additionalService;

    private BigDecimal additionalPrice;

    private BigDecimal preferential;

    private BigDecimal totalPrice;

    private String remarks;

    private String orderStatus;
    
    private String orderStatusDesc;

    private String invoiceStatus;
    
    private String invoiceStatusDesc;

    private String isValid;

    private String isDel;
    
    private String purchaseNo;
    
    private Integer purchaseOrderItem;
    
    @JSONField(format="yyyy-MM-dd")
    private Date purchaseOrderDate;

    private String creator;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getPurchasecheckingNo() {
        return purchasecheckingNo;
    }

    public void setPurchasecheckingNo(String purchasecheckingNo) {
        this.purchasecheckingNo = purchasecheckingNo == null ? null : purchasecheckingNo.trim();
    }

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public String getBusinessType() {
        return businessType;
    }

    public void setBusinessType(String businessType) {
        this.businessType = businessType == null ? null : businessType.trim();
    }

    public String getBusinessDesc() {
        return businessDesc;
    }

    public void setBusinessDesc(String businessDesc) {
        this.businessDesc = businessDesc == null ? "" : businessDesc.trim();
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements == null ? "" : requirements.trim();
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification == null ? "" : specification.trim();
    }

    public String getPriceWay() {
        return priceWay;
    }

    public void setPriceWay(String priceWay) {
        this.priceWay = priceWay == null ? null : priceWay.trim();
    }

    public BigDecimal getLength() {
        return length;
    }

    public void setLength(BigDecimal length) {
        this.length = length;
    }

    public BigDecimal getWidth() {
        return width;
    }

    public void setWidth(BigDecimal width) {
        this.width = width;
    }

    public BigDecimal getColorSize() {
        return colorSize;
    }

    public void setColorSize(BigDecimal colorSize) {
        this.colorSize = colorSize;
    }

    public BigDecimal getPairsNum() {
        return pairsNum;
    }

    public void setPairsNum(BigDecimal pairsNum) {
        this.pairsNum = pairsNum;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public BigDecimal getUnitPrice() {
    	if(unitPrice ==null){
    		unitPrice = new BigDecimal(0).setScale(2);
    	}else{
    		unitPrice = unitPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getAdditionalService() {
        return additionalService;
    }

    public void setAdditionalService(String additionalService) {
        this.additionalService = additionalService == null ? "" : additionalService.trim();
    }

    public BigDecimal getAdditionalPrice() {
    	if(additionalPrice ==null){
    		additionalPrice = new BigDecimal(0).setScale(2);
    	}else{
    		additionalPrice = additionalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return additionalPrice;
    }

    public void setAdditionalPrice(BigDecimal additionalPrice) {
        this.additionalPrice = additionalPrice;
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

    public BigDecimal getTotalPrice() {
    	if(totalPrice ==null){
    		totalPrice = new BigDecimal(0).setScale(2);
    	}else{
    		totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
    	this.totalPrice = totalPrice;
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

	public String getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(String purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getPriceWayDesc() {
		return priceWayDesc;
	}

	public void setPriceWayDesc(String priceWayDesc) {
		this.priceWayDesc = priceWayDesc;
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

	public Date getPurchaseOrderDate() {
		return purchaseOrderDate;
	}

	public void setPurchaseOrderDate(Date purchaseOrderDate) {
		this.purchaseOrderDate = purchaseOrderDate;
	}

	public Integer getPurchaseOrderItem() {
		return purchaseOrderItem;
	}

	public void setPurchaseOrderItem(Integer purchaseOrderItem) {
		this.purchaseOrderItem = purchaseOrderItem;
	}
}