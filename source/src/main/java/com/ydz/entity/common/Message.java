package com.ydz.entity.common;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.Date;

public class Message implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 2323198285923827557L;

	private Long uid;

    private String msgId;

    private String msgTitle;

    private String comKey;

    private String msgContent;

    private String sendKey;

    private String sendName;

    @JSONField(format="yyyy-MM-dd")
    private Date sendTime;

    private String acceptUserKey;

    private String acceptComKey;

    private String status;

    private String type;
    
    private String msgAttr;

    private String isDel;

    private String creator;

    @JSONField(format="yyyy-MM-dd")
    private Date createTime;

    private String createTimeStr;

    private String friendStatus;

    private String reason;

    private String remarks;

    //手机号
    private String sendPhone;

    //
    private String adminName;
    //
    private String adminPhone;

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }

    public String getSendPhone() {
        return sendPhone;
    }

    public void setSendPhone(String sendPhone) {
        this.sendPhone = sendPhone;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getFriendStatus() {
        return friendStatus;
    }

    public void setFriendStatus(String friendStatus) {
        this.friendStatus = friendStatus;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId == null ? null : msgId.trim();
    }

    public String getMsgTitle() {
        return msgTitle;
    }

    public void setMsgTitle(String msgTitle) {
        this.msgTitle = msgTitle == null ? null : msgTitle.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getMsgContent() {
        return msgContent;
    }

    public void setMsgContent(String msgContent) {
        this.msgContent = msgContent == null ? null : msgContent.trim();
    }

    public String getSendKey() {
        return sendKey;
    }

    public void setSendKey(String sendKey) {
        this.sendKey = sendKey == null ? null : sendKey.trim();
    }

    public String getSendName() {
        return sendName;
    }

    public void setSendName(String sendName) {
        this.sendName = sendName == null ? null : sendName.trim();
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getAcceptUserKey() {
        return acceptUserKey;
    }

    public void setAcceptUserKey(String acceptUserKey) {
        this.acceptUserKey = acceptUserKey == null ? null : acceptUserKey.trim();
    }

    public String getAcceptComKey() {
        return acceptComKey;
    }

    public void setAcceptComKey(String acceptComKey) {
        this.acceptComKey = acceptComKey == null ? null : acceptComKey.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
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

	public String getMsgAttr() {
		return msgAttr;
	}

	public void setMsgAttr(String msgAttr) {
		this.msgAttr = msgAttr;
	}
}