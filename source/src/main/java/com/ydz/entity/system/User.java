package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable{
	private static final long serialVersionUID = -2428247496913171131L;

	private Long uid;

    private String userKey;
    //手机号用于登录
    private String userId;
    //备用手机号
    private String telBak;
    //昵称
    private String nickName;

    private String realName;

    private String email;

    private String password;

    private String salt;

    private String qq;

    private Date birthday;

    private String nowProvince;

    private String nowCity;

    private String nowCountry;

    private String localProvince;

    private String localCity;

    private String localCountry;

    private String avatarPath;

    private String bindWechat;
    
    private String loginWechat;

    private String bindQq;

    private String bindAlipay;

    private Date lastUpdateTime;

    private String registerIp;

    private String registerCity;
    
    private String regType;

    private String isValid;

    private Date createTime;

    //
    private String comId;

    private String defaultCom;

    //邀请人的userKey
    private String refereeName;
    
    private String promoterKey;

    public String getRefereeName() {
        return refereeName;
    }

    public void setRefereeName(String refereeName) {
        this.refereeName = refereeName;
    }

    public String getDefaultCom() {
        return defaultCom;
    }

    public void setDefaultCom(String defaultCom) {
        this.defaultCom = defaultCom;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey == null ? null : userKey.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getTelBak() {
        return telBak;
    }

    public void setTelBak(String telBak) {
        this.telBak = telBak == null ? null : telBak.trim();
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNowProvince() {
        return nowProvince;
    }

    public void setNowProvince(String nowProvince) {
        this.nowProvince = nowProvince == null ? null : nowProvince.trim();
    }

    public String getNowCity() {
        return nowCity;
    }

    public void setNowCity(String nowCity) {
        this.nowCity = nowCity == null ? null : nowCity.trim();
    }

    public String getNowCountry() {
        return nowCountry;
    }

    public void setNowCountry(String nowCountry) {
        this.nowCountry = nowCountry == null ? null : nowCountry.trim();
    }

    public String getLocalProvince() {
        return localProvince;
    }

    public void setLocalProvince(String localProvince) {
        this.localProvince = localProvince == null ? null : localProvince.trim();
    }

    public String getLocalCity() {
        return localCity;
    }

    public void setLocalCity(String localCity) {
        this.localCity = localCity == null ? null : localCity.trim();
    }

    public String getLocalCountry() {
        return localCountry;
    }

    public void setLocalCountry(String localCountry) {
        this.localCountry = localCountry == null ? null : localCountry.trim();
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath == null ? null : avatarPath.trim();
    }

    public String getBindWechat() {
        return bindWechat;
    }

    public void setBindWechat(String bindWechat) {
        this.bindWechat = bindWechat == null ? null : bindWechat.trim();
    }
    
    public String getLoginWechat() {
        return loginWechat;
    }

    public void setLoginWechat(String loginWechat) {
        this.loginWechat = loginWechat == null ? null : loginWechat.trim();
    }

    public String getBindQq() {
        return bindQq;
    }

    public void setBindQq(String bindQq) {
        this.bindQq = bindQq == null ? null : bindQq.trim();
    }

    public String getBindAlipay() {
        return bindAlipay;
    }

    public void setBindAlipay(String bindAlipay) {
        this.bindAlipay = bindAlipay == null ? null : bindAlipay.trim();
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp == null ? null : registerIp.trim();
    }

    public String getRegisterCity() {
        return registerCity;
    }

    public void setRegisterCity(String registerCity) {
        this.registerCity = registerCity == null ? null : registerCity.trim();
    }

    public String getRegType() {
		return regType;
	}

	public void setRegType(String regType) {
		this.regType = regType;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getPromoterKey() {
		return promoterKey;
	}

	public void setPromoterKey(String promoterKey) {
		this.promoterKey = promoterKey;
	}
}