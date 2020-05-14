package com.ydz.entity.assignment;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class AssignWorkingProcedure implements Serializable{
	private static final long serialVersionUID = 1L;

	private Long uid;

    private String comKey;

    private String industryId;

    private String workshop;

    private String workingProcedure;
    
    private String workingProcedureDesc;

    private String remarks;

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
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getWorkshop() {
        return workshop;
    }

    public void setWorkshop(String workshop) {
        this.workshop = workshop == null ? null : workshop.trim();
    }

    public String getWorkingProcedure() {
        return workingProcedure;
    }

    public void setWorkingProcedure(String workingProcedure) {
        this.workingProcedure = workingProcedure == null ? null : workingProcedure.trim();
    }

    public String getWorkingProcedureDesc() {
		return workingProcedureDesc;
	}

	public void setWorkingProcedureDesc(String workingProcedureDesc) {
		this.workingProcedureDesc = workingProcedureDesc;
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