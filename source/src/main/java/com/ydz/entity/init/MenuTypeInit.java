package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class MenuTypeInit implements Serializable{
	private static final long serialVersionUID = -4766913272540467779L;

	@JSONField(serialize = false)
	private Long uid;

    private String rentalVersion;

    private String industryId;

    private String menuId;

    private String pMenuId;

    private Integer sortItem;

    private String closeable;

    private String isValid;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String menuName;
    
    private String menuIcon;
    
    private String menuUrl;
    
    private String menuClass;
    
    private List<MenuTypeInit> menuTypeInits;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getRentalVersion() {
        return rentalVersion;
    }

    public void setRentalVersion(String rentalVersion) {
        this.rentalVersion = rentalVersion == null ? null : rentalVersion.trim();
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

	public List<MenuTypeInit> getMenuTypeInits() {
		return menuTypeInits;
	}

	public void setMenuTypeInits(List<MenuTypeInit> menuTypeInits) {
		this.menuTypeInits = menuTypeInits;
	}
}