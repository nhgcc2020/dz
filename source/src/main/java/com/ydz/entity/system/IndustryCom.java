package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

public class IndustryCom implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 7557021396102563587L;

	private Long uid;

    private String industryId;

    private String industryName;

    private String industryDesc;

    private String pIndustryId;

    private Integer sortItem;

    private String comId;

    private String comKey;

    private String isCheck;

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

    public String getIndustryName() {
        return industryName;
    }

    public void setIndustryName(String industryName) {
        this.industryName = industryName == null ? null : industryName.trim();
    }

    public String getIndustryDesc() {
        return industryDesc;
    }

    public void setIndustryDesc(String industryDesc) {
        this.industryDesc = industryDesc == null ? null : industryDesc.trim();
    }

    public String getpIndustryId() {
        return pIndustryId;
    }

    public void setpIndustryId(String pIndustryId) {
        this.pIndustryId = pIndustryId == null ? null : pIndustryId.trim();
    }

    public Integer getSortItem() {
        return sortItem;
    }

    public void setSortItem(Integer sortItem) {
        this.sortItem = sortItem;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId == null ? null : comId.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getIsCheck() {
        return isCheck;
    }

    public void setIsCheck(String isCheck) {
        this.isCheck = isCheck == null ? null : isCheck.trim();
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