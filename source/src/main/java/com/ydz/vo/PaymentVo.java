package com.ydz.vo;

import java.io.Serializable;

/**
 * Created by pxy on 2016/6/5.
 */
public class PaymentVo implements Serializable{

    /**
	 * 
	 */
	private static final long serialVersionUID = 8530280316403907178L;

    private String duration;
    private String rentalVersion;
    private String rentalVersionValue; //版本号
    private String oldRentalVersion;
    private String voucherNo;
    private String rentalMoney;
    private String actualPayNum;
    private String rentalKey;
    private String tradeType;
    private String discount;
    //交易单号
    private String tradeKey;

    public String getTradeKey() {
        return tradeKey;
    }

    public void setTradeKey(String tradeKey) {
        this.tradeKey = tradeKey;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getRentalVersion() {
        return rentalVersion;
    }

    public void setRentalVersion(String rentalVersion) {
        this.rentalVersion = rentalVersion;
    }

    public String getRentalVersionValue() {
        return rentalVersionValue;
    }

    public void setRentalVersionValue(String rentalVersionValue) {
        this.rentalVersionValue = rentalVersionValue;
    }

    public String getVoucherNo() {
        return voucherNo;
    }

    public void setVoucherNo(String voucherNo) {
        this.voucherNo = voucherNo;
    }

    public String getRentalMoney() {
        return rentalMoney;
    }

    public void setRentalMoney(String rentalMoney) {
        this.rentalMoney = rentalMoney;
    }

    public String getActualPayNum() {
        return actualPayNum;
    }

    public void setActualPayNum(String actualPayNum) {
        this.actualPayNum = actualPayNum;
    }

    public String getRentalKey() {
        return rentalKey;
    }

    public void setRentalKey(String rentalKey) {
        this.rentalKey = rentalKey;
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

	public String getOldRentalVersion() {
		return oldRentalVersion;
	}

	public void setOldRentalVersion(String oldRentalVersion) {
		this.oldRentalVersion = oldRentalVersion;
	}
}
