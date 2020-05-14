package com.ydz.entity.commissions;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class CommissionsCheckingOrderDetail implements Serializable{

	private static final long serialVersionUID = -1348938280276760976L;

	@JSONField(serialize=false)
    private Long uid;

    private Integer itemNo;

    private String commissionsCheckingNo;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String salesId;

    private String salesName;

    private String contactId;

    private String contactName;
    
    private String taskUserKey;
    
    private String taskEmployeeId;
    
    private String taskUserName;

    private String checkingNo;
    
    private String salesNo;
    
    private String taskNo;
    
    private String taskDesc;

    private String caseDesc;

    @JSONField(format="yyyy-MM-dd")
    private Date orderDate;

    private String orderCycle;

    private BigDecimal totalPrice;

    private BigDecimal depositRequested;

    private BigDecimal paidUp;

    private BigDecimal commissionsMoney;

    private String orderStatus;

    private String orderType;

    private Short salesOrderNum;

    private Short detailNum;

    private String remarks;

    private String isValid;

    private String isDel;

    private String creator;
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    @JSONField(format="yyyy-MM-dd")
    private Date recpayDate;
    
    

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public String getCommissionsCheckingNo() {
        return commissionsCheckingNo;
    }

    public void setCommissionsCheckingNo(String commissionsCheckingNo) {
        this.commissionsCheckingNo = commissionsCheckingNo == null ? null : commissionsCheckingNo.trim();
    }

    public String getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(String salesNo) {
		this.salesNo = salesNo;
	}

	public String getTaskNo() {
		return taskNo;
	}

	public void setTaskNo(String taskNo) {
		this.taskNo = taskNo;
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

	public String getCheckingNo() {
        return checkingNo;
    }

    public void setCheckingNo(String checkingNo) {
        this.checkingNo = checkingNo == null ? null : checkingNo.trim();
    }

    public String getCaseDesc() {
        return caseDesc;
    }

    public void setCaseDesc(String caseDesc) {
        this.caseDesc = caseDesc == null ? null : caseDesc.trim();
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

    public Short getSalesOrderNum() {
        return salesOrderNum;
    }

    public void setSalesOrderNum(Short salesOrderNum) {
        this.salesOrderNum = salesOrderNum;
    }

    public Short getDetailNum() {
        return detailNum;
    }

    public void setDetailNum(Short detailNum) {
        this.detailNum = detailNum;
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

	public Date getRecpayDate() {
		return recpayDate;
	}

	public void setRecpayDate(Date recpayDate) {
		this.recpayDate = recpayDate;
	}

	public String getTaskDesc() {
		return taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}
}