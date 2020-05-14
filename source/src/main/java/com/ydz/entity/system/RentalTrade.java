package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/** 
* @ClassName: RentalTrade 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年8月3日 下午9:28:15 
* @Description: TODO(这里用一句话描述这个类的作用) 
*  
*/
public class RentalTrade implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -509835631887592519L;

	private Long uid;

    private String tradeKey;

    private String rentalKey;

    private String comKey;

    private String tradeType;

    private BigDecimal rentalMoney;
    
    private BigDecimal discount;

    private BigDecimal payedMoney;
    
    private String voucherNo;

    private BigDecimal deductionMoney;

    private String paymentType;

    private String paymentNum;

    private String isInvoice;
    
    private String status;
    
    private String rentalVersion;

    private String beforeChange;

    private String afterChange;
    
    private String buyBusinessCode;

    private String creator;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getTradeKey() {
        return tradeKey;
    }

    public void setTradeKey(String tradeKey) {
        this.tradeKey = tradeKey == null ? null : tradeKey.trim();
    }

    public String getRentalKey() {
        return rentalKey;
    }

    public void setRentalKey(String rentalKey) {
        this.rentalKey = rentalKey == null ? null : rentalKey.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType == null ? null : tradeType.trim();
    }

    public BigDecimal getRentalMoney() {
        return rentalMoney!=null?rentalMoney.setScale(2, BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
    }

    public void setRentalMoney(BigDecimal rentalMoney) {
        this.rentalMoney = rentalMoney;
    }

    public BigDecimal getPayedMoney() {
        return payedMoney!=null?payedMoney.setScale(2, BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
    }

    public void setPayedMoney(BigDecimal payedMoney) {
        this.payedMoney = payedMoney;
    }

    public BigDecimal getDeductionMoney() {
        return deductionMoney!=null?deductionMoney.setScale(2, BigDecimal.ROUND_HALF_UP):new BigDecimal(0);
    }

    public void setDeductionMoney(BigDecimal deductionMoney) {
        this.deductionMoney = deductionMoney;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType == null ? null : paymentType.trim();
    }

    public String getPaymentNum() {
        return paymentNum;
    }

    public void setPaymentNum(String paymentNum) {
        this.paymentNum = paymentNum == null ? null : paymentNum.trim();
    }

    public String getIsInvoice() {
        return isInvoice;
    }

    public void setIsInvoice(String isInvoice) {
        this.isInvoice = isInvoice == null ? null : isInvoice.trim();
    }

    public String getBeforeChange() {
        return beforeChange;
    }

    public void setBeforeChange(String beforeChange) {
        this.beforeChange = beforeChange == null ? null : beforeChange.trim();
    }

    public String getAfterChange() {
        return afterChange;
    }

    public void setAfterChange(String afterChange) {
        this.afterChange = afterChange == null ? null : afterChange.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getBuyBusinessCode() {
		return buyBusinessCode;
	}

	public void setBuyBusinessCode(String buyBusinessCode) {
		this.buyBusinessCode = buyBusinessCode;
	}

	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRentalVersion() {
		return rentalVersion;
	}

	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}

	public String getVoucherNo() {
		return voucherNo;
	}

	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}
	
}