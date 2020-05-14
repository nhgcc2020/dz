package com.ydz.entity.common;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class OperateLog implements Serializable{
	private static final long serialVersionUID = -5848163945153127392L;

	@JSONField(serialize = false)
	private Long uid;
	
	private String comKey;
	
	private String comShortname;

    private String userKey;

    private String userName;
    
    private String operPlace;

    private String operAction;

    private String operContent;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
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

	public String getComShortname() {
		return comShortname;
	}

	public void setComShortname(String comShortname) {
		this.comShortname = comShortname;
	}

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOperPlace() {
		return operPlace;
	}

	public void setOperPlace(String operPlace) {
		this.operPlace = operPlace;
	}

	public String getOperAction() {
		return operAction;
	}

	public void setOperAction(String operAction) {
		this.operAction = operAction;
	}

	public String getOperContent() {
		return operContent;
	}

	public void setOperContent(String operContent) {
		this.operContent = operContent;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}