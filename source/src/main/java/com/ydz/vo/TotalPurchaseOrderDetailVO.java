/**
 * 
 */
package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.PurchaseOrderDetail;

/** 
 * @ClassName: TotalPurchaseOrderDetailVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月28日 下午7:16:48 
 * 
 */
public class TotalPurchaseOrderDetailVO extends PurchaseOrderDetail implements Serializable{

	private static final long serialVersionUID = -4263120917056645214L;
	
	private String comKey;

    private String partnerKey;

    private String partnerName;
    
    private String partnerShortname;
    
    private String orderStatusMain;
    
    private String orderStatusDesc;

	@JSONField(format="yyyy-MM-dd")
	private Date orderDate;

	private String contactId;

	private String contactName;
	
	private String caseDesc;
	
	private String industryId;
	
	private BigDecimal totalPriceOrder;

	public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey;
	}

	public String getPartnerKey() {
		return partnerKey;
	}

	public void setPartnerKey(String partnerKey) {
		this.partnerKey = partnerKey;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getPartnerShortname() {
		return partnerShortname;
	}

	public void setPartnerShortname(String partnerShortname) {
		this.partnerShortname = partnerShortname;
	}

	public String getOrderStatusMain() {
		return orderStatusMain;
	}

	public void setOrderStatusMain(String orderStatusMain) {
		this.orderStatusMain = orderStatusMain;
	}

	public String getOrderStatusDesc() {
		return orderStatusDesc;
	}

	public void setOrderStatusDesc(String orderStatusDesc) {
		this.orderStatusDesc = orderStatusDesc;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getContactId() {
		return contactId;
	}

	public void setContactId(String contactId) {
		this.contactId = contactId;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public String getIndustryId() {
		return industryId;
	}

	public void setIndustryId(String industryId) {
		this.industryId = industryId;
	}

	public BigDecimal getTotalPriceOrder() {
		return totalPriceOrder;
	}

	public void setTotalPriceOrder(BigDecimal totalPriceOrder) {
		this.totalPriceOrder = totalPriceOrder;
	}
}
