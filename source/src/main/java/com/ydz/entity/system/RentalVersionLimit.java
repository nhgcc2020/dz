package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class RentalVersionLimit implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 5608998548466149185L;

	@JSONField(serialize = false)
	private Long uid;

    private String rentalVersion;

    private String industryId;

    private Integer userCount;

    private Integer customerCount;

    private String remakrs;

    private Date changeTime;

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

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public Integer getUserCount() {
        return userCount;
    }

    public void setUserCount(Integer userCount) {
        this.userCount = userCount;
    }

    public Integer getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(Integer customerCount) {
        this.customerCount = customerCount;
    }

    public String getRemakrs() {
        return remakrs;
    }

    public void setRemakrs(String remakrs) {
        this.remakrs = remakrs == null ? null : remakrs.trim();
    }

    public Date getChangeTime() {
        return changeTime;
    }

    public void setChangeTime(Date changeTime) {
        this.changeTime = changeTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}