/**   
 * @Title: TokenInfo.java 
 * @Package com.ydz.entity.app 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月13日 上午10:05:57 
 * @version  
 */
package com.ydz.entity.security;

import java.io.Serializable;

/** 
 * @ClassName: TokenInfo 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月13日 上午10:05:57 
 * 
 */
public class TokenInfo implements Serializable{

	private static final long serialVersionUID = -1566983579215513424L;
	
	private String userKey;
	private String comKey;
	private String industryId;
	private String remarks;
	public String getUserKey() {
		return userKey;
	}
	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
	public String getComKey() {
		return comKey;
	}
	public void setComKey(String comKey) {
		this.comKey = comKey;
	}
	public String getIndustryId() {
		return industryId;
	}
	public void setIndustryId(String industryId) {
		this.industryId = industryId;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
