/**
 * 
 */
package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.advert.PurchaseCheckingOrder;

/** 
 * @ClassName: AllPurchaseCheckingOrderVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年10月12日 下午2:09:53 
 * 
 */
public class AllPurchaseCheckingOrderVO extends PurchaseCheckingOrder implements Serializable {

	private static final long serialVersionUID = -2138175896732372674L;
	
	private String recpayName; //收款人

	@JSONField(format="yyyy-MM-dd")
	private Date recpayDate; //收款日期

	@JSONField(format="yyyy-MM-dd")
	private Date invoiceDate; //发票日期

	private String ciComName; // 开票公司

	private BigDecimal invoiceAmount;

	public String getRecpayName() {
		return recpayName;
	}

	public void setRecpayName(String recpayName) {
		this.recpayName = recpayName;
	}

	public Date getRecpayDate() {
		return recpayDate;
	}

	public void setRecpayDate(Date recpayDate) {
		this.recpayDate = recpayDate;
	}

	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getCiComName() {
		return ciComName;
	}

	public void setCiComName(String ciComName) {
		this.ciComName = ciComName;
	}

	public BigDecimal getInvoiceAmount() {
		if (invoiceAmount==null) {
			invoiceAmount = new BigDecimal(0);
		} else {
			invoiceAmount = invoiceAmount.setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		return invoiceAmount;
	}

	public void setInvoiceAmount(BigDecimal invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}
}
