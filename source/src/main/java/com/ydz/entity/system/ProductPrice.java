package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ProductPrice implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -877527743395662323L;

	private Long uid;

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

    private String industryId;
    
    private String createType;
    
    private Byte tier;

    private String remarks;

    private Date createTime;
    
    private List<ProductPrice> productPrices;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
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
		return unitPrice!=null?unitPrice.setScale(2, BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
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
		this.industryId = industryId;
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

	public List<ProductPrice> getProductPrices() {
		return productPrices;
	}

	public void setProductPrices(List<ProductPrice> productPrices) {
		this.productPrices = productPrices;
	}

	public Byte getTier() {
		return tier;
	}

	public void setTier(Byte tier) {
		this.tier = tier;
	}

	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}
	
}