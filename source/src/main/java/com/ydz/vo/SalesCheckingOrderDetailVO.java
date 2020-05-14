/**
/**
 *
 */
package com.ydz.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;

import javax.xml.crypto.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/** 
 * @ClassName: SalesCheckingOrderVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月29日 下午8:20:57 
 * 
 */
public class SalesCheckingOrderDetailVO implements Serializable{
	
	private static final long serialVersionUID = 710743194159391733L;

	private String salesNo;
	
	private String salescheckingNo;

	private String caseDesc;

	@JSONField(format="yyyy-MM-dd")
	private Date orderDate;

	private BigDecimal price;

	private List<SalesCheckingOrderDetail> details;
	
	private Integer salesOrderItem;

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public String getSalescheckingNo() {
		return salescheckingNo;
	}

	public void setSalescheckingNo(String salescheckingNo) {
		this.salescheckingNo = salescheckingNo;
	}

	public List<SalesCheckingOrderDetail> getDetails() {
		return details;
	}

	public void setDetails(List<SalesCheckingOrderDetail> details) {
		this.details = details;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public BigDecimal getPrice() {
		if(price ==null){
			price = new BigDecimal(0).setScale(2);
		}else{
			price = price.setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getSalesOrderItem() {
		return salesOrderItem;
	}

	public void setSalesOrderItem(Integer salesOrderItem) {
		this.salesOrderItem = salesOrderItem;
	}
}
