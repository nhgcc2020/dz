/**
 * 
 */
package com.ydz.entity.advert;

import java.io.Serializable;

/** 
 * @ClassName: SalesMan 
 * @Description: 订单销售代表
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月18日 下午4:23:20 
 * 
 */
public class SalesMan implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8399140790626919203L;

	private String salesId;
	private String salesName;
	public String getSalesId() {
		return salesId;
	}
	public void setSalesId(String salesId) {
		this.salesId = salesId;
	}
	public String getSalesName() {
		return salesName;
	}
	public void setSalesName(String salesName) {
		this.salesName = salesName;
	}
	
	
}
