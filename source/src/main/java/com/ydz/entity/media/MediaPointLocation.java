package com.ydz.entity.media;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class MediaPointLocation implements Serializable{
	
	private static final long serialVersionUID = -1775515180733667413L;

	@JSONField(serialize = false)
	private Long uid;
	
	private String comKey;
	
	private String industryId;

    private String mediaNo;

    private int itemNo;

    private String pointNo;

    private String pointName;
    
    private String pointCode;

    private String belongsType;

    private String pointProvince;

    private String pointCity;

    private String pointCountry;
    
    private String pointProvinceName;
    
    private String pointCityName;
    
    private String pointCountryName;

    private String pointLocation;

    private String place;

    private String specification;

    private BigDecimal unitPrice;

    private String priceWay;

    private String environment;

    private String priceScheme;

    private String status;
    
    private String statusDesc;

    private String isDel;

    private String remarks;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;

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
		this.comKey = comKey;
	}

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
	}

	public String getMediaNo() {
        return mediaNo;
    }

    public void setMediaNo(String mediaNo) {
        this.mediaNo = mediaNo == null ? null : mediaNo.trim();
    }

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public String getPointNo() {
        return pointNo;
    }

    public void setPointNo(String pointNo) {
        this.pointNo = pointNo == null ? null : pointNo.trim();
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName == null ? null : pointName.trim();
    }

    public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public String getBelongsType() {
        return belongsType;
    }

    public void setBelongsType(String belongsType) {
        this.belongsType = belongsType == null ? null : belongsType.trim();
    }

    public String getPointProvince() {
        return pointProvince;
    }

    public void setPointProvince(String pointProvince) {
        this.pointProvince = pointProvince == null ? null : pointProvince.trim();
    }

    public String getPointCity() {
        return pointCity;
    }

    public void setPointCity(String pointCity) {
        this.pointCity = pointCity == null ? null : pointCity.trim();
    }

    public String getPointCountry() {
        return pointCountry;
    }

    public void setPointCountry(String pointCountry) {
        this.pointCountry = pointCountry == null ? null : pointCountry.trim();
    }

    public String getPointProvinceName() {
		return pointProvinceName;
	}

	public void setPointProvinceName(String pointProvinceName) {
		this.pointProvinceName = pointProvinceName;
	}

	public String getPointCityName() {
		return pointCityName;
	}

	public void setPointCityName(String pointCityName) {
		this.pointCityName = pointCityName;
	}

	public String getPointCountryName() {
		return pointCountryName;
	}

	public void setPointCountryName(String pointCountryName) {
		this.pointCountryName = pointCountryName;
	}

	public String getPointLocation() {
        return pointLocation;
    }

    public void setPointLocation(String pointLocation) {
        this.pointLocation = pointLocation == null ? null : pointLocation.trim();
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place == null ? null : place.trim();
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification == null ? null : specification.trim();
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPriceWay() {
        return priceWay;
    }

    public void setPriceWay(String priceWay) {
        this.priceWay = priceWay == null ? null : priceWay.trim();
    }

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment == null ? null : environment.trim();
    }

    public String getPriceScheme() {
        return priceScheme;
    }

    public void setPriceScheme(String priceScheme) {
        this.priceScheme = priceScheme == null ? null : priceScheme.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getStatusDesc() {
		return statusDesc;
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
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

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }
}