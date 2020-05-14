package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.SalesCheckingOrderDetail;

/** 
 * @ClassName: TotalSalesCheckingOrderDetailVO 
 * @Description: 混合了销售对账单和对账单明细的全部字段
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年3月29日 下午5:08:15 
 * 
 */
public class TotalSalesCheckingOrderDetailVO extends SalesCheckingOrderDetail implements Serializable{

	private static final long serialVersionUID = 69178723715079243L;
	
	private String orderCycle;
	
	private String caseDesc;

	@JSONField(format="yyyy-MM-dd")
	private Date orderDate;

	private BigDecimal totalOrderPrice;
	
	private BigDecimal salesOrderPrice;
	
	private String isReceived;

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

	public BigDecimal getTotalOrderPrice() {
		return totalOrderPrice;
	}

	public void setTotalOrderPrice(BigDecimal totalOrderPrice) {
		this.totalOrderPrice = totalOrderPrice;
	}

	public BigDecimal getSalesOrderPrice() {
		return salesOrderPrice;
	}

	public void setSalesOrderPrice(BigDecimal salesOrderPrice) {
		this.salesOrderPrice = salesOrderPrice;
	}

	public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle == null ? null : orderCycle.trim();
	}

	public String getIsReceived() {
		return isReceived;
	}

	public void setIsReceived(String isReceived) {
		this.isReceived = isReceived;
	}
	
}
