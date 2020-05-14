/**   
 * @Title: WorkingTaskLabelVO.java 
 * @Package com.ydz.entity.assignment 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年8月15日 下午6:00:50 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.assignment;

import java.io.Serializable;

/** 
 * @ClassName: WorkingTaskLabelVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年8月15日 下午6:00:50 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class WorkingTaskLabelVO implements Serializable{

	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 8949880293444853648L;
	
	private String partnerShortname;
	private String contacterName;
	private String mobile;
	private String tel;
	private String businessDesc;
	private String requirement;
	private String specification;
	private int quantity;
	private String address;
	private String comShortname;
	private String comTel;
	private String taskurl;
	public String getPartnerShortname() {
		return partnerShortname;
	}
	public void setPartnerShortname(String partnerShortname) {
		this.partnerShortname = partnerShortname;
	}
	public String getContacterName() {
		return contacterName;
	}
	public void setContacterName(String contacterName) {
		this.contacterName = contacterName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBusinessDesc() {
		return businessDesc;
	}
	public void setBusinessDesc(String businessDesc) {
		this.businessDesc = businessDesc;
	}
	public String getRequirement() {
		return requirement;
	}
	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getComShortname() {
		return comShortname;
	}
	public void setComShortname(String comShortname) {
		this.comShortname = comShortname;
	}
	public String getComTel() {
		return comTel;
	}
	public void setComTel(String comTel) {
		this.comTel = comTel;
	}
	public String getTaskurl() {
		return taskurl;
	}
	public void setTaskurl(String taskurl) {
		this.taskurl = taskurl;
	}

}
