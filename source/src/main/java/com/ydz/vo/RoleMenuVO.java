package com.ydz.vo;

import java.io.Serializable;
import java.util.List;

/** 
 * @ClassName: RoleMenuVO 
 * @Description: 提供给前端页面经过处理之后的菜单结构对象
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年12月13日 下午2:05:00 
 * 
 */
public class RoleMenuVO implements Serializable{

	private static final long serialVersionUID = -8617706092168625574L;
	
	private String menuId;
	private String menuName;
	private String menuIcon;
	private String menuUrl;
	private String menuClass;
	private String menuType;
	private String resourceId;
	private String resourceDesc;
	private Integer sortItem;
	private String closeable;
	private boolean isChecked;
	private String roleKey;
	
	private List<RoleMenuVO> roleMenuVOs;
	private List<RoleMenuVO> menus;
	
	private String permission;
	private List<PermissionVO> permissionVOs;
	
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
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
	public String getMenuType() {
		return menuType;
	}
	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}
	public String getResourceId() {
		return resourceId;
	}
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}
	public String getResourceDesc() {
		return resourceDesc;
	}
	public void setResourceDesc(String resourceDesc) {
		this.resourceDesc = resourceDesc;
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
		this.closeable = closeable;
	}
	public boolean getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}
	public List<RoleMenuVO> getRoleMenuVOs() {
		return roleMenuVOs;
	}
	public void setRoleMenuVOs(List<RoleMenuVO> roleMenuVOs) {
		this.roleMenuVOs = roleMenuVOs;
	}
	public List<RoleMenuVO> getMenus() {
		return menus;
	}
	public void setMenus(List<RoleMenuVO> menus) {
		this.menus = menus;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public List<PermissionVO> getPermissionVOs() {
		return permissionVOs;
	}
	public void setPermissionVOs(List<PermissionVO> permissionVOs) {
		this.permissionVOs = permissionVOs;
	}
	public String getRoleKey() {
		return roleKey;
	}
	public void setRoleKey(String roleKey) {
		this.roleKey = roleKey;
	}
}
