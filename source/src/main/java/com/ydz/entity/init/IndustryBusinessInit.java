package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Date;

public class IndustryBusinessInit implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1901206034046039492L;

	private Long uid;

    private String industryId;

    private String pIndustryId;

    private String businessCode;

    private String pBusinessCode;

    private Integer sortItem;

    private String funcType;

    private String isValid;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getpIndustryId() {
        return pIndustryId;
    }

    public void setpIndustryId(String pIndustryId) {
        this.pIndustryId = pIndustryId == null ? null : pIndustryId.trim();
    }

    public String getBusinessCode() {
        return businessCode;
    }

    public void setBusinessCode(String businessCode) {
        this.businessCode = businessCode == null ? null : businessCode.trim();
    }

    public String getpBusinessCode() {
        return pBusinessCode;
    }

    public void setpBusinessCode(String pBusinessCode) {
        this.pBusinessCode = pBusinessCode == null ? null : pBusinessCode.trim();
    }

    public Integer getSortItem() {
        return sortItem;
    }

    public void setSortItem(Integer sortItem) {
        this.sortItem = sortItem;
    }

    public String getFuncType() {
        return funcType;
    }

    public void setFuncType(String funcType) {
        this.funcType = funcType == null ? null : funcType.trim();
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