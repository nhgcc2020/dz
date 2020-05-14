package com.ydz.entity.commissions;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class CommissionsCheckingOrder implements Serializable{
	
	private static final long serialVersionUID = 1949905874523420511L;

	@JSONField(serialize=false)
    private Long uid;

    private String commissionsCheckingNo;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String contactId;
    
    private String contactName;
    
    private String salesId;

    private String salesName;
    
    private String salesTel;
    
    private String taskUserKey;
    
    private String taskEmployeeId;
    
    private String taskUserName;
    
    private String taskUserTel;
    
    @JSONField(format="yyyy-MM-dd")
    private Date orderDate;

    private String orderCycle;

    private String caseDesc;

    private BigDecimal totalPrice;

    private BigDecimal depositRequested;

    private BigDecimal paidUp;

    private BigDecimal commissionsMoney;
    
    private BigDecimal settlementMoney;
    
    private BigDecimal balanceMoney;

    private String remarks;

    private String orderStatus;

    private String orderType;

    private Short orderNum;

    private String isValid;

    private String isDel;

    private String ordersNo;

    private String creator;
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String creatorName;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getCommissionsCheckingNo() {
        return commissionsCheckingNo;
    }

    public void setCommissionsCheckingNo(String commissionsCheckingNo) {
        this.commissionsCheckingNo = commissionsCheckingNo == null ? null : commissionsCheckingNo.trim();
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

    public String getSalesId() {
        return salesId;
    }

    public void setSalesId(String salesId) {
        this.salesId = salesId == null ? null : salesId.trim();
    }

    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName == null ? null : salesName.trim();
    }

    public String getSalesTel() {
		return salesTel;
	}

	public void setSalesTel(String salesTel) {
		this.salesTel = salesTel;
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

    public String getTaskUserKey() {
		return taskUserKey;
	}

	public void setTaskUserKey(String taskUserKey) {
		this.taskUserKey = taskUserKey;
	}

	public String getTaskEmployeeId() {
		return taskEmployeeId;
	}

	public void setTaskEmployeeId(String taskEmployeeId) {
		this.taskEmployeeId = taskEmployeeId;
	}

	public String getTaskUserName() {
		return taskUserName;
	}

	public void setTaskUserName(String taskUserName) {
		this.taskUserName = taskUserName;
	}

	public String getTaskUserTel() {
		return taskUserTel;
	}

	public void setTaskUserTel(String taskUserTel) {
		this.taskUserTel = taskUserTel;
	}

	public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderCycle() {
        return orderCycle;
    }

    public void setOrderCycle(String orderCycle) {
        this.orderCycle = orderCycle == null ? null : orderCycle.trim();
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

    public BigDecimal getDepositRequested() {
        return depositRequested;
    }

    public void setDepositRequested(BigDecimal depositRequested) {
        this.depositRequested = depositRequested;
    }

    public BigDecimal getPaidUp() {
        return paidUp;
    }

    public void setPaidUp(BigDecimal paidUp) {
        this.paidUp = paidUp;
    }

    public BigDecimal getCommissionsMoney() {
        return commissionsMoney;
    }

    public void setCommissionsMoney(BigDecimal commissionsMoney) {
        this.commissionsMoney = commissionsMoney;
    }

    public BigDecimal getSettlementMoney() {
		return settlementMoney;
	}

	public void setSettlementMoney(BigDecimal settlementMoney) {
		this.settlementMoney = settlementMoney;
	}

	public BigDecimal getBalanceMoney() {
		return balanceMoney;
	}

	public void setBalanceMoney(BigDecimal balanceMoney) {
		this.balanceMoney = balanceMoney;
	}

	public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus == null ? null : orderStatus.trim();
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType == null ? null : orderType.trim();
    }

    public Short getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Short orderNum) {
        this.orderNum = orderNum;
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

    public String getOrdersNo() {
        return ordersNo;
    }

    public void setOrdersNo(String ordersNo) {
        this.ordersNo = ordersNo == null ? null : ordersNo.trim();
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