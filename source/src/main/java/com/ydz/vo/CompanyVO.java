package com.ydz.vo;

import java.io.Serializable;

import com.ydz.entity.system.Company;

/** 
 * @ClassName: CompanyVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年10月26日 上午11:16:06 
 * 
 */
public class CompanyVO extends Company implements Serializable{
	
	private static final long serialVersionUID = -1887528717303964211L;
	
	private String realName;
	
	private String userId;
	
	private String isAdmin;
	
	private String partnerProvince;
	
	private String partnerCity;
	
	private String partnerCountry;
	
	private String partnerAddress;

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

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getPartnerProvince() {
		return partnerProvince;
	}

	public void setPartnerProvince(String partnerProvince) {
		this.partnerProvince = partnerProvince;
	}

	public String getPartnerCity() {
		return partnerCity;
	}

	public void setPartnerCity(String partnerCity) {
		this.partnerCity = partnerCity;
	}

	public String getPartnerCountry() {
		return partnerCountry;
	}

	public void setPartnerCountry(String partnerCountry) {
		this.partnerCountry = partnerCountry;
	}

	public String getPartnerAddress() {
		return partnerAddress;
	}

	public void setPartnerAddress(String partnerAddress) {
		this.partnerAddress = partnerAddress;
	}

}
