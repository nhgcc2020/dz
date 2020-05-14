package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;


public class BusiPriceCom implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -220414858247544069L;

	@JSONField(serialize = false)
	private Long uid;

    private String comKey;

    private String comId;

    private String businessCode;

    private String businessName;

    private String businessDesc;

    private String pBusinessCode;

    private BigDecimal businessPrice;

    private String businessUnit;

    private String isChecked;

    private String isValid;

    private String remarks;

    private Integer sortItem;

    private String funcType;

    private String industryId;
    
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
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

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId == null ? null : comId.trim();
    }

    public String getBusinessCode() {
        return businessCode;
    }

    public void setBusinessCode(String businessCode) {
        this.businessCode = businessCode == null ? null : businessCode.trim();
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName == null ? null : businessName.trim();
    }

    public String getBusinessDesc() {
        return businessDesc;
    }

    public void setBusinessDesc(String businessDesc) {
        this.businessDesc = businessDesc == null ? null : businessDesc.trim();
    }

    public String getpBusinessCode() {
        return pBusinessCode;
    }

    public void setpBusinessCode(String pBusinessCode) {
        this.pBusinessCode = pBusinessCode == null ? null : pBusinessCode.trim();
    }

    public BigDecimal getBusinessPrice() {
    	return businessPrice!=null?businessPrice.setScale(0):new BigDecimal(0);
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

    public String getIsChecked() {
        return isChecked;
    }

    public void setIsChecked(String isChecked) {
        this.isChecked = isChecked == null ? null : isChecked.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
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

    public String getFuncType() {
        return funcType;
    }

    public void setFuncType(String funcType) {
        this.funcType = funcType == null ? null : funcType.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	@Override
	public String toString() {
		return "BusiPriceCom [uid=" + uid + ", comKey=" + comKey + ", comId="
				+ comId + ", businessCode=" + businessCode + ", businessName="
				+ businessName + ", businessDesc=" + businessDesc
				+ ", pBusinessCode=" + pBusinessCode + ", businessPrice="
				+ businessPrice + ", businessUnit=" + businessUnit
				+ ", isChecked=" + isChecked + ", isValid=" + isValid
				+ ", remarks=" + remarks + ", sortItem=" + sortItem
				+ ", funcType=" + funcType + ", industryId=" + industryId
				+ ", createTime=" + createTime + "]";
	}
    
    
}