package com.ydz.entity.init;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/** 
* @ClassName: MenuInit 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月5日 下午2:46:28 
* @Description: TODO(这里用一句话描述这个类的作用) 
*  
*/
public class MenuInit implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6764633331514221275L;

	private Long uid;
	
	private String rentalVersion;

	private String industryId;

	private String menuId;

    private String label;

    private String pMenuId;

    private String menuDesc;

    private String icon;

    private String path;

    private Integer sortItem;

    private Boolean closeable;
    
    private String isValid;
    
    private Byte tier;

    private Date createTime;
    
    private List<MenuInit> menus;

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getpMenuId() {
		return pMenuId;
	}

	public void setpMenuId(String pMenuId) {
		this.pMenuId = pMenuId;
	}

	public String getMenuDesc() {
		return menuDesc;
	}

	public void setMenuDesc(String menuDesc) {
		this.menuDesc = menuDesc;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getSortItem() {
		return sortItem;
	}

	public void setSortItem(Integer sortItem) {
		this.sortItem = sortItem;
	}

	public String getIndustryId() {
		
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
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
	
	public Boolean getCloseable() {
		return closeable;
	}

	public void setCloseable(Boolean closeable) {
		this.closeable = closeable;
	}

	public List<MenuInit> getMenus() {
		return menus;
	}

	public void setMenus(List<MenuInit> menus) {
		this.menus = menus;
	}

	public String getRentalVersion() {
		return rentalVersion;
	}

	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}

	public Byte getTier() {
		return tier;
	}

	public void setTier(Byte tier) {
		this.tier = tier;
	}
	
}