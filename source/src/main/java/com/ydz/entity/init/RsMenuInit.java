package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class RsMenuInit implements Serializable{
	
	private static final long serialVersionUID = -360775984457179818L;

	@JSONField(serialize = false)
	private Long uid;

    private String industryId;

    private String menuId;

    private String pMenuId;

    private String menuType;

    private Integer sortItem;

    private String closeable;

    private String isValid;
    
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String menuName;
    
    private String menuIcon;
    
    private String menuUrl;
    
    private String menuClass;
    
    List<RsMenuInit> rsMenuInits;
    

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId == null ? null : menuId.trim();
    }

    public String getpMenuId() {
        return pMenuId;
    }

    public void setpMenuId(String pMenuId) {
        this.pMenuId = pMenuId == null ? null : pMenuId.trim();
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType == null ? null : menuType.trim();
    }

    public Integer getSortItem() {
        return sortItem;
    }

    public void setSortItem(Integer sortItem) {
        this.sortItem = sortItem;
    }

    public String getCloseable() {
        return closeable;
    }

    public void setCloseable(String closeable) {
        this.closeable = closeable == null ? null : closeable.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getMenuClass() {
		return menuClass;
	}

	public void setMenuClass(String menuClass) {
		this.menuClass = menuClass;
	}

	public List<RsMenuInit> getRsMenuInits() {
		return rsMenuInits;
	}

	public void setRsMenuInits(List<RsMenuInit> rsMenuInits) {
		this.rsMenuInits = rsMenuInits;
	}
}