package com.ydz.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame TaxPointVo.java
 * @createTime 2016-09-06 下午1:42
 * @decription 税点VO处理
 **/

public class TaxPointVo implements Serializable {

    private static final long serialVersionUID = 2256684135269083334L;
    //销售订单号
    private String salesNos;
    //采购订单号
    private String purchaseNos;
    //合计金额(不含税 如:200)
    private BigDecimal totalPrice;
    //税点（百分比的整数部分。如：10%  则为10）
    private BigDecimal taxRateView;
    //税点（小数，如：10%  则为0.1）
    private BigDecimal taxRate;
    //税额(200 * 0.1 = 20)
    private BigDecimal taxPrice;
    //合计金额（含税 :220）
    private BigDecimal totalPriceWithTax;


    public String getSalesNos() {
        return salesNos;
    }

    public void setSalesNos(String salesNos) {
        this.salesNos = salesNos;
    }

    public String getPurchaseNos() {
		return purchaseNos;
	}

	public void setPurchaseNos(String purchaseNos) {
		this.purchaseNos = purchaseNos;
	}

	public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getTaxRateView() {
        return taxRateView;
    }

    public void setTaxRateView(BigDecimal taxRateView) {
        this.taxRateView = taxRateView;
    }

    public BigDecimal getTaxRate() {
        return taxRate;
    }

    public void setTaxRate(BigDecimal taxRate) {
        this.taxRate = taxRate;
    }

    public BigDecimal getTaxPrice() {
        return taxPrice;
    }

    public void setTaxPrice(BigDecimal taxPrice) {
        this.taxPrice = taxPrice;
    }

    public BigDecimal getTotalPriceWithTax() {
        return totalPriceWithTax;
    }

    public void setTotalPriceWithTax(BigDecimal totalPriceWithTax) {
        this.totalPriceWithTax = totalPriceWithTax;
    }
}