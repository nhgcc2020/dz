package com.ydz.entity.init;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class BusinessPriceInit implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -428949572599535610L;

	private Long uid;

    private String rentalVersion;

    private BigDecimal businessPrice;

    private String businessUnit;

    private String remarks;

    private Integer sortItem;

    private String cityLevel;

    private String industryId;

    private String isValid;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getRentalVersion() {
        return rentalVersion;
    }

    public void setRentalVersion(String rentalVersion) {
        this.rentalVersion = rentalVersion == null ? null : rentalVersion.trim();
    }

    public BigDecimal getBusinessPrice() {
        return businessPrice;
    }

    public void setBusinessPrice(BigDecimal businessPrice) {
        this.businessPrice = businessPrice;
    }

    public String getBusinessUnit() {
        return businessUnit;
    }

    public void setBusinessUnit(String businessUnit) {
        this.businessUnit = businessUnit == null ? null : businessUnit.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Integer getSortItem() {
        return sortItem;
    }

    public void setSortItem(Integer sortItem) {
        this.sortItem = sortItem;
    }

    public String getCityLevel() {
        return cityLevel;
    }

    public void setCityLevel(String cityLevel) {
        this.cityLevel = cityLevel == null ? null : cityLevel.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}