package com.ydz.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.system.Company;

import java.io.Serializable;
import java.util.Date;

/** 
 * @ClassName: MessageCompanyVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月30日 下午3:27:55 
 * 
 */
public class MessageCompanyVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8697867375070230359L;


	private String comKey;
	private String comId;
	private String comName;
	private String comShortname;
	private String comLogoPath;
	private String userKey;
	private String userType;
	private String realName;
	private String userId;
	private String adminName;
	private String adminPhone;
	private String bossName;
	private String bossPhone;
	
	//消息
	private long uid;
	private String msgId;
	private String status;
	
	@JSONField(format = "yyyy/MM/dd")
	private Date sendTime;

	public long getUid() {
		return uid;
	}

	public void setUid(long uid) {
		this.uid = uid;
	}

	public String getMsgId() {
		return msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey;
	}

	public String getComId() {
		return comId;
	}

	public void setComId(String comId) {
		this.comId = comId;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getComShortname() {
		return comShortname;
	}

	public void setComShortname(String comShortname) {
		this.comShortname = comShortname;
	}

	public String getComLogoPath() {
		return comLogoPath;
	}

	public void setComLogoPath(String comLogoPath) {
		this.comLogoPath = comLogoPath;
	}

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

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

	public String getBossName() {
		return bossName;
	}

	public void setBossName(String bossName) {
		this.bossName = bossName;
	}

	public String getBossPhone() {
		return bossPhone;
	}

	public void setBossPhone(String bossPhone) {
		this.bossPhone = bossPhone;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
}
