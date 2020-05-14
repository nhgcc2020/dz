package com.ydz.entity.pay;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class PaySettlement implements Serializable{
	
	private static final long serialVersionUID = 3740890496057540551L;

	@JSONField(serialize=false)
    private Long uid;

    private String tradeNo;

    private String checkingNo;

    private String comKey;

    private String partnerKey;

    private String industryId;

    private String orderDesc;

    private BigDecimal payMoney;

    private String clientIp;

    private String isPayed;

    private String remarks;

    private String creator;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo == null ? null : tradeNo.trim();
    }

    public String getCheckingNo() {
        return checkingNo;
    }

    public void setCheckingNo(String checkingNo) {
        this.checkingNo = checkingNo == null ? null : checkingNo.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getPartnerKey() {
        return partnerKey;
    }

    public void setPartnerKey(String partnerKey) {
        this.partnerKey = partnerKey == null ? null : partnerKey.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getOrderDesc() {
        return orderDesc;
    }

    public void setOrderDesc(String orderDesc) {
        this.orderDesc = orderDesc == null ? null : orderDesc.trim();
    }

    public BigDecimal getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(BigDecimal payMoney) {
        this.payMoney = payMoney;
    }

    public String getClientIp() {
        return clientIp;
    }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp == null ? null : clientIp.trim();
    }

    public String getIsPayed() {
        return isPayed;
    }

    public void setIsPayed(String isPayed) {
        this.isPayed = isPayed == null ? null : isPayed.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
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

	@Override
	public String toString() {
		return "PaySettlement [uid=" + uid + ", tradeNo=" + tradeNo
				+ ", checkingNo=" + checkingNo + ", comKey=" + comKey
				+ ", partnerKey=" + partnerKey + ", industryId=" + industryId
				+ ", orderDesc=" + orderDesc + ", payMoney=" + payMoney
				+ ", clientIp=" + clientIp + ", isPayed=" + isPayed
				+ ", remarks=" + remarks + ", creator=" + creator
				+ ", createTime=" + createTime + "]";
	}
}