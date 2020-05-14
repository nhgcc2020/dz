package com.ydz.vo;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class BusinessTypeVO implements Serializable{
	
	private static final long serialVersionUID = -5265163764555879576L;
	
	@JSONField(name="modelName")
	private String businessType;
	
	@JSONField(name="label")
	private String businessTypeDesc;
	
	@JSONField(serialize=false)
	private String businessTypeCols;
	
	@JSONField(name="columns")
	private List<String> businessTypeColsList;

	private String type;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public String getBusinessTypeDesc() {
		return businessTypeDesc;
	}
	public void setBusinessTypeDesc(String businessTypeDesc) {
		this.businessTypeDesc = businessTypeDesc;
	}
	public String getBusinessTypeCols() {
		return businessTypeCols;
	}
	public void setBusinessTypeCols(String businessTypeCols) {
		this.businessTypeCols = businessTypeCols;
	}
	public List<String> getBusinessTypeColsList() {
		return businessTypeColsList;
	}
	public void setBusinessTypeColsList(List<String> businessTypeColsList) {
		this.businessTypeColsList = businessTypeColsList;
	}
}
