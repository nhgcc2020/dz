package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class RentalPeriod implements Serializable{
	private static final long serialVersionUID = 4427542334652472702L;

	private Long uid;

    private String rentalKey;

    private String comKey;

    @JSONField(format="yyyy-MM-dd")
    private Date startDate;
    
    @JSONField(format="yyyy-MM-dd")
    private Date endDate;

    private Integer duration;

    private String status;
    
    private String statusValue;
    
    private String rentalVersion;

    private String remarks;

    private String creator;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String changer;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date changeTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getRentalKey() {
        return rentalKey;
    }

    public void setRentalKey(String rentalKey) {
        this.rentalKey = rentalKey == null ? null : rentalKey.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}

	public String getRentalVersion() {
		return rentalVersion;
	}

	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}

	public String getChanger() {
		return changer;
	}

	public void setChanger(String changer) {
		this.changer = changer;
	}

	public Date getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
    
}