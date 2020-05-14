package com.ydz.entity.advert;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class PurchaseOrderDetail implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 756726469922663057L;

	@JSONField(serialize=false)
	private Long uid;

    private String purchaseNo;

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

    private String isUrgent;
    
    private String workingStatus;
    
    private String workingProcedure;

    private String isValid;

    private String isDel;

    private String creator;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private BigDecimal totalArea;
    
    private Date purchaseOrderDate;
    
    private String supplierKey;
    
    private String supplierName;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getPurchaseNo() {
        return purchaseNo;
    }

    public void setPurchaseNo(String purchaseNo) {
        this.purchaseNo = purchaseNo == null ? null : purchaseNo.trim();
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
        return length==null?new BigDecimal(0):length;
    }

    public void setLength(BigDecimal length) {
        this.length = length;
    }

    public BigDecimal getWidth() {
        return width==null?new BigDecimal(0):width;
    }

    public void setWidth(BigDecimal width) {
        this.width = width;
    }

    public BigDecimal getColorSize() {
        return colorSize==null?new BigDecimal(0):colorSize;
    }

    public void setColorSize(BigDecimal colorSize) {
        this.colorSize = colorSize;
    }

    public BigDecimal getPairsNum() {
    	return pairsNum==null?new BigDecimal(0):pairsNum;
    }

    public void setPairsNum(BigDecimal pairsNum) {
        this.pairsNum = pairsNum;
    }

    public BigDecimal getQuantity() {
        return quantity==null?new BigDecimal(0):quantity;
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

    public String getIsUrgent() {
        return isUrgent;
    }

    public void setIsUrgent(String isUrgent) {
        this.isUrgent = isUrgent == null ? null : isUrgent.trim();
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

	public BigDecimal getTotalArea() {
		if(totalArea ==null){
			totalArea = new BigDecimal(0).setScale(2);
    	}else{
    		totalArea = totalArea.setScale(2, BigDecimal.ROUND_HALF_UP);
    	}
		return totalArea;
	}

	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	public Date getPurchaseOrderDate() {
		return purchaseOrderDate;
	}

	public void setPurchaseOrderDate(Date purchaseOrderDate) {
		this.purchaseOrderDate = purchaseOrderDate;
	}

	public String getWorkingStatus() {
		return workingStatus;
	}

	public void setWorkingStatus(String workingStatus) {
		this.workingStatus = workingStatus == null?"":workingStatus.trim();
	}

	public String getWorkingProcedure() {
		return workingProcedure;
	}

	public void setWorkingProcedure(String workingProcedure) {
		this.workingProcedure = workingProcedure == null?"":workingProcedure.trim();
	}

	public String getSupplierKey() {
		return supplierKey;
	}

	public void setSupplierKey(String supplierKey) {
		this.supplierKey = supplierKey;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
}