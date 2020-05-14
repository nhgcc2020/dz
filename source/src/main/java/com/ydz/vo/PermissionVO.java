/**
 * 
 */
package com.ydz.vo;

import java.io.Serializable;

/** 
 * @ClassName: PermissionVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月7日 下午5:36:36 
 * 
 */
public class PermissionVO implements Serializable{

	private static final long serialVersionUID = 1556830866702496056L;
	
	private String roleKey;
	private String resourceId;
	private String permissionCode;
	private String permissionValue;
	public String getRoleKey() {
		return roleKey;
	}
	public void setRoleKey(String roleKey) {
		this.roleKey = roleKey;
	}
	public String getResourceId() {
		return resourceId;
	}
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}
	public String getPermissionCode() {
		return permissionCode;
	}
	public void setPermissionCode(String permissionCode) {
		this.permissionCode = permissionCode;
	}
	public String getPermissionValue() {
		return permissionValue;
	}
	public void setPermissionValue(String permissionValue) {
		this.permissionValue = permissionValue;
	}
}
