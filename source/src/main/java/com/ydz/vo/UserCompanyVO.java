package com.ydz.vo;

import com.ydz.entity.system.User;

import java.io.Serializable;

/**
 * Created by pengxuyang on 16/11/11.
 */
public class UserCompanyVO extends User implements Serializable {

    private static final long serialVersionUID = 3344116765409785622L;

    private String comId;

    private String withinComId;

    private String comName;

    private String comShortname;

    private String isBoss;

    private String isAdmin;

    private String industryId;

    private String comLogoPath;

    private String comIsvalid;

    private String comType;

    private String comKey;
    
    private String comAttr;

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey;
    }

    public String getComType() {
        return comType;
    }

    public void setComType(String comType) {
        this.comType = comType;
    }

    public String getComIsvalid() {
        return comIsvalid;
    }

    public void setComIsvalid(String comIsvalid) {
        this.comIsvalid = comIsvalid;
    }

    public String getComLogoPath() {
        return comLogoPath;
    }

    public void setComLogoPath(String comLogoPath) {
        this.comLogoPath = comLogoPath;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId;
    }

    public String getIsBoss() {
        return isBoss;
    }

    public void setIsBoss(String isBoss) {
        this.isBoss = isBoss;
    }

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }

    @Override
    public String getComId() {
        return comId;
    }

    @Override
    public void setComId(String comId) {
        this.comId = comId;
    }

    public String getWithinComId() {
        return withinComId;
    }

    public void setWithinComId(String withinComId) {
        this.withinComId = withinComId;
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

	public String getComAttr() {
		return comAttr;
	}

	public void setComAttr(String comAttr) {
		this.comAttr = comAttr;
	}
}
