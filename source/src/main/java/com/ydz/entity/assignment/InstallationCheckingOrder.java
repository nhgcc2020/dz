package com.ydz.entity.assignment;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class InstallationCheckingOrder implements Serializable{
    
	private static final long serialVersionUID = 228849377213659034L;

	@JSONField(serialize = false)
	private Long uid;

    private String installationcheckingNo;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String contactId;

    private String contactName;
    
    private String contactTel;
    
    @JSONField(format = "yyyy-MM-dd")
    private Date orderDate;

    private String caseDesc;

    private BigDecimal totalPrice;

    private BigDecimal installationPrice;

    private BigDecimal prepayPrice;

    private BigDecimal payablePrice;
    
    private BigDecimal discount;
    
    private BigDecimal preferential;
    
    private BigDecimal paidUp;
    
    private BigDecimal balanceMoney;
    
    private String balanceRemarks;
    
    private String status;
    
    private String orderCycle;

    private String remarks;

    private String installationNo;

    private Integer installationOrderNum;

    private Integer detailNum;
    
    private String orderCountValue;
    
    private String isValid;

    private String isDel;

    private String creator;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
  //制单人名称
    private String creatorName;
    
    

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getInstallationcheckingNo() {
        return installationcheckingNo;
    }

    public void setInstallationcheckingNo(String installationcheckingNo) {
        this.installationcheckingNo = installationcheckingNo == null ? null : installationcheckingNo.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getPartnerKey() {
        return partnerKey;
    }

    public void setPartnerKey(String partnerKey) {
        this.partnerKey = partnerKey == null ? null : partnerKey.trim();
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName == null ? null : partnerName.trim();
    }

    public String getPartnerShortname() {
        return partnerShortname;
    }

    public void setPartnerShortname(String partnerShortname) {
        this.partnerShortname = partnerShortname == null ? null : partnerShortname.trim();
    }

    public String getContactId() {
        return contactId;
    }

    public void setContactId(String contactId) {
        this.contactId = contactId == null ? null : contactId.trim();
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName == null ? null : contactName.trim();
    }

    public String getContactTel() {
		return contactTel;
	}

	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

	public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getCaseDesc() {
        return caseDesc;
    }

    public void setCaseDesc(String caseDesc) {
        this.caseDesc = caseDesc == null ? null : caseDesc.trim();
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getInstallationPrice() {
        return installationPrice;
    }

    public void setInstallationPrice(BigDecimal installationPrice) {
        this.installationPrice = installationPrice;
    }

    public BigDecimal getPrepayPrice() {
        return prepayPrice;
    }

    public void setPrepayPrice(BigDecimal prepayPrice) {
        this.prepayPrice = prepayPrice;
    }

    public BigDecimal getPayablePrice() {
        return payablePrice;
    }

    public void setPayablePrice(BigDecimal payablePrice) {
        this.payablePrice = payablePrice;
    }

    public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public BigDecimal getPreferential() {
		return preferential;
	}

	public void setPreferential(BigDecimal preferential) {
		this.preferential = preferential;
	}

	public BigDecimal getPaidUp() {
		return paidUp;
	}

	public void setPaidUp(BigDecimal paidUp) {
		this.paidUp = paidUp;
	}

	public BigDecimal getBalanceMoney() {
		return balanceMoney;
	}

	public void setBalanceMoney(BigDecimal balanceMoney) {
		this.balanceMoney = balanceMoney;
	}

	public String getBalanceRemarks() {
		return balanceRemarks;
	}

	public void setBalanceRemarks(String balanceRemarks) {
		this.balanceRemarks = balanceRemarks;
	}

	public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle == null ? null : orderCycle.trim();
	}

	public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getInstallationNo() {
        return installationNo;
    }

    public void setInstallationNo(String installationNo) {
        this.installationNo = installationNo == null ? null : installationNo.trim();
    }

    public Integer getInstallationOrderNum() {
        return installationOrderNum;
    }

    public void setInstallationOrderNum(Integer installationOrderNum) {
        this.installationOrderNum = installationOrderNum;
    }

    public Integer getDetailNum() {
        return detailNum;
    }

    public void setDetailNum(Integer detailNum) {
        this.detailNum = detailNum;
    }

	public String getOrderCountValue() {
		return orderCountValue;
	}

	public void setOrderCountValue(String orderCountValue) {
		this.orderCountValue = orderCountValue;
	}

	public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
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

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
}