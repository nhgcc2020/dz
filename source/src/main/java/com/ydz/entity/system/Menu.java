package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class Menu implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 5004932959575554688L;

	@JSONField(serialize = false)
	private Long uid;
	
    private String comKey;

    private String industryId;

    private String rentalVersion;
    
    private String isValid;
    
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date changedTime;

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
		this.comKey = comKey;
	}

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
	}

	public String getRentalVersion() {
		return rentalVersion;
	}

	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public Date getChangedTime() {
		return changedTime;
	}

	public void setChangedTime(Date changedTime) {
		this.changedTime = changedTime;
	}
}