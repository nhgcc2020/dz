package com.ydz.entity.common;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class ComSettingClass  implements Serializable{
   
	private static final long serialVersionUID = 3303143038430563583L;

	@JSONField(serialize=false)
	private Long uid;

    private String comKey;

    private String industryId;

    private String settingClass;

    private String typeCode;

    private String typeDesc;

    private String remarks;
    
    private String isDel;

    @JSONField(serialize=false)
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

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getSettingClass() {
        return settingClass;
    }

    public void setSettingClass(String settingClass) {
        this.settingClass = settingClass == null ? null : settingClass.trim();
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode == null ? null : typeCode.trim();
    }

    public String getTypeDesc() {
        return typeDesc;
    }

    public void setTypeDesc(String typeDesc) {
        this.typeDesc = typeDesc == null ? null : typeDesc.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}

	public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	@Override
	public String toString() {
		return "ComSettingClass [uid=" + uid + ", comKey=" + comKey
				+ ", industryId=" + industryId + ", settingClass="
				+ settingClass + ", typeCode=" + typeCode + ", typeDesc="
				+ typeDesc + ", remarks=" + remarks + ", isDel=" + isDel
				+ ", createTime=" + createTime + "]";
	}
}