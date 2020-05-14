package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class RoleMenuInit implements Serializable{
	
	private static final long serialVersionUID = -3248542859732071333L;

	@JSONField(serialize = false)
    private Long uid;

    private String roleKey;

    private String menuId;

    private String industryId;

    private String rentalVersion;

    @JSONField(serialize = false)
    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getRoleKey() {
        return roleKey;
    }

    public void setRoleKey(String roleKey) {
        this.roleKey = roleKey == null ? null : roleKey.trim();
    }

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId == null ? null : menuId.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getRentalVersion() {
        return rentalVersion;
    }

    public void setRentalVersion(String rentalVersion) {
        this.rentalVersion = rentalVersion == null ? null : rentalVersion.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}