package com.ydz.entity.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class ContractProject implements Serializable{
	
	private static final long serialVersionUID = -9127445675063755398L;

	@JSONField(serialize = false)
	private Long uid;

    private String contractNo;

    private String contractDesc;

    private String comKey;

    private String industryId;

    private String partnerKey;

    private String partnerName;

    private String partnerShortname;

    private String contactId;

    private String contactName;
    
    private String contactTel;
    
    private String projectType;
    
    private String projectTypeDesc;
    
    private String salesId;
    
    private String salesName;
    
    @JSONField(format="yyyy-MM-dd")
    private Date startDate;
    @JSONField(format="yyyy-MM-dd")
    private Date endDate;
    @JSONField(format="yyyy-MM-dd")
    private Date signDate;
    
    private BigDecimal contractMoney;

    private String partnerSignerId;

    private String partnerSignerName;

    private String ourSignerId;

    private String ourSignerName;

    private String status;

    private String oppoNo;
    
    private String participantEmployeeId;
    
    private String participantEmployeeName;

    private String remarks;

    private String isValid;

    private String isDel;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;
    
    private String latestChat;
    
    //合同实际金额=计划回款的总金额
    private BigDecimal actualContractMoney;
    //已开票金额
    private BigDecimal invoiceContractMoney;
    //已回款金额
    private BigDecimal returnedContractMoney;
    //待回款金额=合同总金额-已回款金额
    private BigDecimal waitforContractMoney;
    //坏账=回款记录中回款类型为坏账的金额统计
    private BigDecimal baddebtMoney;
    
    private BigDecimal waitforInvoiceContractMoney;
    
    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getContractNo() {
        return contractNo;
    }

    public void setContractNo(String contractNo) {
        this.contractNo = contractNo == null ? null : contractNo.trim();
    }

    public String getContractDesc() {
        return contractDesc;
    }

    public void setContractDesc(String contractDesc) {
        this.contractDesc = contractDesc == null ? null : contractDesc.trim();
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

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}

	public String getProjectTypeDesc() {
		return projectTypeDesc;
	}

	public void setProjectTypeDesc(String projectTypeDesc) {
		this.projectTypeDesc = projectTypeDesc;
	}

	public String getSalesId() {
		return salesId;
	}

	public void setSalesId(String salesId) {
		this.salesId = salesId;
	}

	public String getSalesName() {
		return salesName;
	}

	public void setSalesName(String salesName) {
		this.salesName = salesName;
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

    public Date getSignDate() {
        return signDate;
    }

    public void setSignDate(Date signDate) {
        this.signDate = signDate;
    }

    public BigDecimal getContractMoney() {
		return contractMoney;
	}

	public void setContractMoney(BigDecimal contractMoney) {
		this.contractMoney = contractMoney;
	}

	public String getPartnerSignerId() {
        return partnerSignerId;
    }

    public void setPartnerSignerId(String partnerSignerId) {
        this.partnerSignerId = partnerSignerId == null ? null : partnerSignerId.trim();
    }

    public String getPartnerSignerName() {
        return partnerSignerName;
    }

    public void setPartnerSignerName(String partnerSignerName) {
        this.partnerSignerName = partnerSignerName == null ? null : partnerSignerName.trim();
    }

    public String getOurSignerId() {
        return ourSignerId;
    }

    public void setOurSignerId(String ourSignerId) {
        this.ourSignerId = ourSignerId == null ? null : ourSignerId.trim();
    }

    public String getOurSignerName() {
        return ourSignerName;
    }

    public void setOurSignerName(String ourSignerName) {
        this.ourSignerName = ourSignerName == null ? null : ourSignerName.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getOppoNo() {
        return oppoNo;
    }

    public void setOppoNo(String oppoNo) {
        this.oppoNo = oppoNo == null ? null : oppoNo.trim();
    }

    public String getParticipantEmployeeId() {
		return participantEmployeeId;
	}

	public void setParticipantEmployeeId(String participantEmployeeId) {
		this.participantEmployeeId = participantEmployeeId;
	}

	public String getParticipantEmployeeName() {
		return participantEmployeeName;
	}

	public void setParticipantEmployeeName(String participantEmployeeName) {
		this.participantEmployeeName = participantEmployeeName;
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

	public String getLatestChat() {
		return latestChat;
	}

	public void setLatestChat(String latestChat) {
		this.latestChat = latestChat;
	}

	public BigDecimal getActualContractMoney() {
		return actualContractMoney;
	}

	public void setActualContractMoney(BigDecimal actualContractMoney) {
		this.actualContractMoney = actualContractMoney;
	}

	public BigDecimal getInvoiceContractMoney() {
		return invoiceContractMoney;
	}

	public void setInvoiceContractMoney(BigDecimal invoiceContractMoney) {
		this.invoiceContractMoney = invoiceContractMoney;
	}

	public BigDecimal getReturnedContractMoney() {
		return returnedContractMoney;
	}

	public void setReturnedContractMoney(BigDecimal returnedContractMoney) {
		this.returnedContractMoney = returnedContractMoney;
	}

	public BigDecimal getWaitforContractMoney() {
		return waitforContractMoney;
	}

	public void setWaitforContractMoney(BigDecimal waitforContractMoney) {
		this.waitforContractMoney = waitforContractMoney;
	}

	public BigDecimal getBaddebtMoney() {
		return baddebtMoney;
	}

	public void setBaddebtMoney(BigDecimal baddebtMoney) {
		this.baddebtMoney = baddebtMoney;
	}

	public BigDecimal getWaitforInvoiceContractMoney() {
		return waitforInvoiceContractMoney;
	}

	public void setWaitforInvoiceContractMoney(
			BigDecimal waitforInvoiceContractMoney) {
		this.waitforInvoiceContractMoney = waitforInvoiceContractMoney;
	}
}