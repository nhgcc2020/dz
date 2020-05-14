package com.ydz.entity.advert;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class ReceiptPayment implements Serializable{
	private static final long serialVersionUID = -652646084406185278L;
	
	@JSONField(serialize=false)
	private Long uid;

    private String checkingNo;
    
    private String tradeNo;

    private String checkingType;

    private String recpayType;

    private String comKey;

    private BigDecimal recpayMoney;

    private Date recpayDate;

    private String recpayName;
    
    private String accountPayee;
    
    private String accountType;

    private String remarks;

    private String isValid;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
    
    private String isSms;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getCheckingNo() {
        return checkingNo;
    }

    public void setCheckingNo(String checkingNo) {
        this.checkingNo = checkingNo == null ? null : checkingNo.trim();
    }

    public String getTradeNo() {
		return tradeNo;
	}

	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}

	public String getCheckingType() {
        return checkingType;
    }

    public void setCheckingType(String checkingType) {
        this.checkingType = checkingType == null ? null : checkingType.trim();
    }

    public String getRecpayType() {
        return recpayType;
    }

    public void setRecpayType(String recpayType) {
        this.recpayType = recpayType == null ? null : recpayType.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public BigDecimal getRecpayMoney() {
        return recpayMoney;
    }

    public void setRecpayMoney(BigDecimal recpayMoney) {
        this.recpayMoney = recpayMoney;
    }

    public Date getRecpayDate() {
        return recpayDate;
    }

    public void setRecpayDate(Date recpayDate) {
        this.recpayDate = recpayDate;
    }

    public String getRecpayName() {
        return recpayName;
    }

    public void setRecpayName(String recpayName) {
        this.recpayName = recpayName == null ? null : recpayName.trim();
    }

    public String getAccountPayee() {
		return accountPayee;
	}

	public void setAccountPayee(String accountPayee) {
		this.accountPayee = accountPayee == null ? null : accountPayee.trim();
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getIsSms() {
		return isSms;
	}

	public void setIsSms(String isSms) {
		this.isSms = isSms;
	}
}