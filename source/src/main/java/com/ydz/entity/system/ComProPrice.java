package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ComProPrice implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3493303176064095484L;

	private Long uid;

    private String comKey;
    
    private String partnerKey;
    
    private String categoryId;

    private String categoryDesc;

    private String pCode;

    private Byte sortItem;

    private String priceWay;

    private String priceWayDesc;

    private String priceUnit;

    private String priceUnitDesc;

    private BigDecimal unitPrice;

    private String isValid;

    private String pricingType;
    
    private String isChecked;

    private String industryId;
    
    private String createType;
    
    private Byte tier;

    private String remarks;

    private Date createTime;
    
    private List<ComProPriceLevel> comProPriceLevels;
    
    private List<ComProPrice> comProPrices;
    
    private BigDecimal price1;
    
    private BigDecimal price2;
    
    private BigDecimal price3;
    
    private String maxCategoryId;

    private BigDecimal refUnitPrice;
    
    private String partnerLevel;
    
    private String workingProcedure;
    
    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId == null ? null : categoryId.trim();
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc == null ? null : categoryDesc.trim();
    }

    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode == null ? null : pCode.trim();
    }

    public Byte getSortItem() {
        return sortItem;
    }

    public void setSortItem(Byte sortItem) {
        this.sortItem = sortItem;
    }

    public String getPriceWay() {
        return priceWay;
    }

    public void setPriceWay(String priceWay) {
        this.priceWay = priceWay == null ? null : priceWay.trim();
    }

    public String getPriceWayDesc() {
        return priceWayDesc;
    }

    public void setPriceWayDesc(String priceWayDesc) {
        this.priceWayDesc = priceWayDesc == null ? null : priceWayDesc.trim();
    }

    public String getPriceUnit() {
        return priceUnit;
    }

    public void setPriceUnit(String priceUnit) {
        this.priceUnit = priceUnit == null ? null : priceUnit.trim();
    }

    public String getPriceUnitDesc() {
        return priceUnitDesc;
    }

    public void setPriceUnitDesc(String priceUnitDesc) {
        this.priceUnitDesc = priceUnitDesc == null ? null : priceUnitDesc.trim();
    }

    public BigDecimal getUnitPrice() {
		return unitPrice!=null?unitPrice.setScale(2,BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public BigDecimal getRefUnitPrice() {
		return refUnitPrice!=null?refUnitPrice.setScale(2,BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
	}

	public void setRefUnitPrice(BigDecimal refUnitPrice) {
		this.refUnitPrice = refUnitPrice;
	}

	public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getPricingType() {
        return pricingType;
    }

    public void setPricingType(String pricingType) {
        this.pricingType = pricingType == null ? null : pricingType.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public List<ComProPriceLevel> getComProPriceLevels() {
		return comProPriceLevels;
	}

	public void setComProPriceLevels(List<ComProPriceLevel> comProPriceLevels) {
		this.comProPriceLevels = comProPriceLevels;
	}

	public BigDecimal getPrice1() {
		return price1;
	}

	public void setPrice1(BigDecimal price1) {
		this.price1 = price1;
	}

	public BigDecimal getPrice2() {
		return price2;
	}

	public void setPrice2(BigDecimal price2) {
		this.price2 = price2;
	}

	public BigDecimal getPrice3() {
		return price3;
	}

	public void setPrice3(BigDecimal price3) {
		this.price3 = price3;
	}

	public Byte getTier() {
		return tier;
	}

	public void setTier(Byte tier) {
		this.tier = tier;
	}

	public String getPartnerKey() {
		return partnerKey;
	}

	public void setPartnerKey(String partnerKey) {
		this.partnerKey = partnerKey;
	}

	public String getPartnerLevel() {
		return partnerLevel;
	}

	public void setPartnerLevel(String partnerLevel) {
		this.partnerLevel = partnerLevel;
	}

	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}

	public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	public List<ComProPrice> getComProPrices() {
		return comProPrices;
	}

	public void setComProPrices(List<ComProPrice> comProPrices) {
		this.comProPrices = comProPrices;
	}

	public String getMaxCategoryId() {
		return maxCategoryId;
	}

	public void setMaxCategoryId(String maxCategoryId) {
		this.maxCategoryId = maxCategoryId;
	}

	public String getWorkingProcedure() {
		return workingProcedure;
	}

	public void setWorkingProcedure(String workingProcedure) {
		this.workingProcedure = workingProcedure;
	}
}