package com.ydz.entity.common;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class LoginLog implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2765908481864312789L;

	@JSONField(serialize=false)
	private Long uid;

    private String userKey;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date loginTime;

    private String loginIp;

    private String loginCity;
    
    /** 
	 * @Title: LoginLog
	 * @Description: 构造方法 
	 */
	public LoginLog() {
		// TODO Auto-generated constructor stub
	}

    /** 
	 * @Title: LoginLog
	 * @Description: 构造方法
	 * @param userKey
	 * @param loginTime
	 * @param loginIp
	 * @param loginCity 
	 */
	public LoginLog(String userKey, Date loginTime, String loginIp,
			String loginCity) {
		super();
		this.userKey = userKey;
		this.loginTime = loginTime;
		this.loginIp = loginIp;
		this.loginCity = loginCity;
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

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp == null ? null : loginIp.trim();
    }

    public String getLoginCity() {
        return loginCity;
    }

    public void setLoginCity(String loginCity) {
        this.loginCity = loginCity == null ? null : loginCity.trim();
    }
}