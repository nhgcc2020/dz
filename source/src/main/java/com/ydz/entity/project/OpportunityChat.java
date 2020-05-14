package com.ydz.entity.project;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class OpportunityChat implements Serializable{
    /** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 2194579844061324938L;
	
	@JSONField(serialize=false)
	private Long uid;

    private String oppoNo;
    
    private String comKey;

    private String chatEmployeeId;

    private String chatEmployeeName;
    
    private String chatType;

    private String chatContent;

    private String isValid;

    private String isDel;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getOppoNo() {
        return oppoNo;
    }

    public void setOppoNo(String oppoNo) {
        this.oppoNo = oppoNo == null ? null : oppoNo.trim();
    }

    public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey == null ? null : comKey.trim();
	}

	public String getChatEmployeeId() {
        return chatEmployeeId;
    }

    public void setChatEmployeeId(String chatEmployeeId) {
        this.chatEmployeeId = chatEmployeeId == null ? null : chatEmployeeId.trim();
    }

    public String getChatEmployeeName() {
        return chatEmployeeName;
    }

    public void setChatEmployeeName(String chatEmployeeName) {
        this.chatEmployeeName = chatEmployeeName == null ? null : chatEmployeeName.trim();
    }

    public String getChatType() {
		return chatType;
	}

	public void setChatType(String chatType) {
		this.chatType = chatType;
	}

	public String getChatContent() {
        return chatContent;
    }

    public void setChatContent(String chatContent) {
        this.chatContent = chatContent == null ? null : chatContent.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
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