package com.ydz.entity.assignment;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class InstallationCheckingOrderDetail implements Serializable{
	
	private static final long serialVersionUID = 976177264016967241L;

	@JSONField(serialize = false)
    private Long uid;

    private String installationcheckingNo;

    private Integer itemNo;

    private String businessDesc;

    private String requirements;

    private String specification;

    private String priceWay;

    private BigDecimal length;

    private BigDecimal width;

    private BigDecimal quantity;
    
    private BigDecimal totalArea;

    private String unit;

    private BigDecimal unitPrice;

    private BigDecimal totalPrice;

    private String remarks;

    private String installationNo;

    private Integer installationOrderItem;
    
    @JSONField(format = "yyyy-MM-dd")
    private Date installationOrderDate;

    private String isValid;

    private String isDel;

    private String creator;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getInstallationcheckingNo() {
        return installationcheckingNo;
    }

    public void setInstallationcheckingNo(String installationcheckingNo) {
        this.installationcheckingNo = installationcheckingNo == null ? null : installationcheckingNo.trim();
    }

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public String getBusinessDesc() {
        return businessDesc;
    }

    public void setBusinessDesc(String businessDesc) {
        this.businessDesc = businessDesc == null ? null : businessDesc.trim();
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements == null ? null : requirements.trim();
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification == null ? null : specification.trim();
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

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalArea() {
		return totalArea;
	}

	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalPrice() {
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

    public String getInstallationNo() {
        return installationNo;
    }

    public void setInstallationNo(String installationNo) {
        this.installationNo = installationNo == null ? null : installationNo.trim();
    }

    public Integer getInstallationOrderItem() {
        return installationOrderItem;
    }

    public void setInstallationOrderItem(Integer installationOrderItem) {
        this.installationOrderItem = installationOrderItem;
    }

    public Date getInstallationOrderDate() {
		return installationOrderDate;
	}

	public void setInstallationOrderDate(Date installationOrderDate) {
		this.installationOrderDate = installationOrderDate;
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
}