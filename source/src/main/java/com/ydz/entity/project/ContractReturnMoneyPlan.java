package com.ydz.entity.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class ContractReturnMoneyPlan implements Serializable{
    /** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = -6154198279756190697L;

	@JSONField(serialize = false)
	private Long uid;

    private String contractNo;

    private String comKey;

    private Byte stage;

    @JSONField(format="yyyy-MM-dd")
    private Date planReturnDate;
    
    private BigDecimal planReturnRate;

    private BigDecimal planReturnMoney;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date planRemindTime;
    
    private String planRemindTimeValue;

    private String planRemindContactId;
    
    private String planRemindContactName;

    private String remarks;

    private String isDel;

    @JSONField(serialize = false)
    private Date createTime;
    @JSONField(serialize = false)
    private String creator;

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

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public Byte getStage() {
        return stage;
    }

    public void setStage(Byte stage) {
        this.stage = stage;
    }

    public Date getPlanReturnDate() {
        return planReturnDate;
    }

    public void setPlanReturnDate(Date planReturnDate) {
        this.planReturnDate = planReturnDate;
    }

    public BigDecimal getPlanReturnRate() {
		return planReturnRate;
	}

	public void setPlanReturnRate(BigDecimal planReturnRate) {
		this.planReturnRate = planReturnRate;
	}

	public BigDecimal getPlanReturnMoney() {
        return planReturnMoney;
    }

    public void setPlanReturnMoney(BigDecimal planReturnMoney) {
        this.planReturnMoney = planReturnMoney;
    }

    public Date getPlanRemindTime() {
        return planRemindTime;
    }

    public void setPlanRemindTime(Date planRemindTime) {
        this.planRemindTime = planRemindTime;
    }

    public String getPlanRemindTimeValue() {
		return planRemindTimeValue;
	}

	public void setPlanRemindTimeValue(String planRemindTimeValue) {
		this.planRemindTimeValue = planRemindTimeValue;
	}

	public String getPlanRemindContactId() {
        return planRemindContactId;
    }

    public void setPlanRemindContactId(String planRemindContactId) {
        this.planRemindContactId = planRemindContactId == null ? null : planRemindContactId.trim();
    }

    public String getPlanRemindContactName() {
		return planRemindContactName;
	}

	public void setPlanRemindContactName(String planRemindContactName) {
		this.planRemindContactName = planRemindContactName;
	}

	public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
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
}