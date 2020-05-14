/**   
 * @Title: UserPromoterVO.java 
 * @Package com.ydz.vo 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月7日 下午2:30:03 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.vo;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: UserPromoterVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月7日 下午2:30:03 
 * @Description: 对账推广大使
 */
public class UserPromoterVO implements Serializable{

	private static final long serialVersionUID = -2788303320380517795L;
	
	private String realName;
	private String userId;
	private String comKey;
	private String comName;
	private String promoterKey;
	private String rentalVersion;
	private String status;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getComKey() {
		return comKey;
	}
	public void setComKey(String comKey) {
		this.comKey = comKey;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
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
	public String getRentalVersion() {
		return rentalVersion;
	}
	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
