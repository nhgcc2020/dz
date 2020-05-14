package com.ydz.entity.assignment;

import java.io.Serializable;
import java.util.Date;

public class AssignTaskDetail implements Serializable{
    /** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 1L;

	private Long uid;
    
    private Integer itemNo;

    private String taskNo;

    private String taskUserKey;
    
    private String taskEmployeeId;

    private String taskUserName;

    private String status;

    private Date finishDate;

    private String remarks;
    
    private Date createTime;

    private String creator;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Integer getItemNo() {
		return itemNo;
	}

	public void setItemNo(Integer itemNo) {
		this.itemNo = itemNo;
	}

	public String getTaskNo() {
        return taskNo;
    }

    public void setTaskNo(String taskNo) {
        this.taskNo = taskNo == null ? null : taskNo.trim();
    }

    public String getTaskUserKey() {
        return taskUserKey;
    }

    public void setTaskUserKey(String taskUserKey) {
        this.taskUserKey = taskUserKey == null ? null : taskUserKey.trim();
    }

    public String getTaskEmployeeId() {
		return taskEmployeeId;
	}

	public void setTaskEmployeeId(String taskEmployeeId) {
		this.taskEmployeeId = taskEmployeeId;
	}

	public String getTaskUserName() {
        return taskUserName;
    }

    public void setTaskUserName(String taskUserName) {
        this.taskUserName = taskUserName == null ? null : taskUserName.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
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