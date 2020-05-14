package com.ydz.entity.commissions;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class OrderCommissions implements Serializable {
	private static final long serialVersionUID = -7535788581408321768L;
	private Long uid;

    private String orderNo;
    
    private String salesNo;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;
    
    private String contactId;

    private String contactName;

    private String salesId;

    private String salesName;
    
    private String taskUserKey;
    
    private String taskEmployeeId;
    
    private String taskUserName;
    
    private String taskUser;

    private String allocationType;

    private BigDecimal commissionsRate;

    private BigDecimal commissionsMoney;

    private String orderType;

    private String isChecking;

    private String remarks;

    private String isValid;

    private String creator;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String taskDesc;
    
    private Date orderDate;
    
    private String businessDesc;
    
    private String caseDesc;
    
    private BigDecimal totalPrice;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo == null ? null : orderNo.trim();
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

	public String getTaskUser() {
		return taskUser;
	}

	public void setTaskUser(String taskUser) {
		this.taskUser = taskUser;
	}

	public String getAllocationType() {
        return allocationType;
    }

    public void setAllocationType(String allocationType) {
        this.allocationType = allocationType == null ? null : allocationType.trim();
    }

    public BigDecimal getCommissionsRate() {
        return commissionsRate;
    }

    public void setCommissionsRate(BigDecimal commissionsRate) {
        this.commissionsRate = commissionsRate;
    }

    public BigDecimal getCommissionsMoney() {
        return commissionsMoney;
    }

    public void setCommissionsMoney(BigDecimal commissionsMoney) {
        this.commissionsMoney = commissionsMoney;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType == null ? null : orderType.trim();
    }

    public String getIsChecking() {
		return isChecking;
	}

	public void setIsChecking(String isChecking) {
		this.isChecking = isChecking;
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

	public String getTaskDesc() {
		return taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getPartnerShortname() {
		return partnerShortname;
	}

	public void setPartnerShortname(String partnerShortname) {
		this.partnerShortname = partnerShortname;
	}

	public String getContactId() {
		return contactId;
	}

	public void setContactId(String contactId) {
		this.contactId = contactId;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getBusinessDesc() {
		return businessDesc;
	}

	public void setBusinessDesc(String businessDesc) {
		this.businessDesc = businessDesc;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}
}