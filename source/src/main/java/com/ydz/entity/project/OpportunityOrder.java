package com.ydz.entity.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class OpportunityOrder implements Serializable{
	
	private static final long serialVersionUID = -311346685955958856L;

	@JSONField(serialize=false)
	private Long uid;

    private String oppoNo;
    
    private String oppoDesc;
    
    private String oppoType;
    
    private String oppoTypeDesc;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String contactId;

    private String contactName;
    
    private String contactTel;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date startDate;
    
    private String startDateValue;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date endDate;
    
    private String endDateValue;
    
    private int upToNow;

    private String address;
    
    private Date orderDate;
    
    private String orderSection;

    private String orderStatus;

    private String salesId;

    private String salesName;

    private String participantEmployeeId;

    private String isValid;

    private String isDel;

    private String remarks;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;
    
    private int quotCount;
    
    private BigDecimal totalPrice;
    
    private String participantEmployeeName;
    
    private String latestChat;

	public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getOppoNo() {
        return oppoNo;
    }

    public void setOppoNo(String oppoNo) {
        this.oppoNo = oppoNo == null ? null : oppoNo.trim();
    }

    public String getOppoType() {
		return oppoType;
	}

	public void setOppoType(String oppoType) {
		this.oppoType = oppoType;
	}

	public String getOppoTypeDesc() {
		return oppoTypeDesc;
	}

	public void setOppoTypeDesc(String oppoTypeDesc) {
		this.oppoTypeDesc = oppoTypeDesc;
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

	public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }


    public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderSection() {
		return orderSection;
	}

	public void setOrderSection(String orderSection) {
		this.orderSection = orderSection == null ? null : orderSection.trim();
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus == null ? null : orderStatus.trim();
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

    public String getParticipantEmployeeId() {
        return participantEmployeeId;
    }

    public void setParticipantEmployeeId(String participantEmployeeId) {
        this.participantEmployeeId = participantEmployeeId == null ? null : participantEmployeeId.trim();
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

	public String getOppoDesc() {
		return oppoDesc;
	}

	public void setOppoDesc(String oppoDesc) {
		this.oppoDesc = oppoDesc;
	}

	public String getStartDateValue() {
		return startDateValue;
	}

	public void setStartDateValue(String startDateValue) {
		this.startDateValue = startDateValue;
	}

	public String getEndDateValue() {
		return endDateValue;
	}

	public void setEndDateValue(String endDateValue) {
		this.endDateValue = endDateValue;
	}

	public int getUpToNow() {
		return upToNow;
	}

	public void setUpToNow(int upToNow) {
		this.upToNow = upToNow;
	}

	public int getQuotCount() {
		return quotCount;
	}

	public void setQuotCount(int quotCount) {
		this.quotCount = quotCount;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getParticipantEmployeeName() {
		return participantEmployeeName;
	}

	public void setParticipantEmployeeName(String participantEmployeeName) {
		this.participantEmployeeName = participantEmployeeName;
	}

	public String getLatestChat() {
		return latestChat;
	}

	public void setLatestChat(String latestChat) {
		this.latestChat = latestChat;
	}
}