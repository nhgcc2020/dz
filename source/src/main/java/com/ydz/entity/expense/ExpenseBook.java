package com.ydz.entity.expense;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class ExpenseBook implements Serializable{
	private static final long serialVersionUID = 1L;

	@JSONField(serialize = false)
	private Long uid;

    private String expenseNo;

    private String comKey;

    private String industryId;

    private String spenderKey;

    private String spenderName;

    private String payType;
    @JSONField(format="yyyy-MM-dd")
    private Date payDate;
    @JSONField(format="yyyy-MM-dd")
    private Date chargeDate;

    private String expenseExplain;
    
    private String expenseType;

    private String isDel;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;
    
    private BigDecimal totalMoney;
    
    private int detailNum;
    
    private List<ExpenseBookDetail> details;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getExpenseNo() {
        return expenseNo;
    }

    public void setExpenseNo(String expenseNo) {
        this.expenseNo = expenseNo == null ? null : expenseNo.trim();
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

    public String getSpenderKey() {
        return spenderKey;
    }

    public void setSpenderKey(String spenderKey) {
        this.spenderKey = spenderKey == null ? null : spenderKey.trim();
    }

    public String getSpenderName() {
        return spenderName;
    }

    public void setSpenderName(String spenderName) {
        this.spenderName = spenderName == null ? null : spenderName.trim();
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType == null ? null : payType.trim();
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Date getChargeDate() {
        return chargeDate;
    }

    public void setChargeDate(Date chargeDate) {
        this.chargeDate = chargeDate;
    }

    public String getExpenseExplain() {
        return expenseExplain;
    }

    public void setExpenseExplain(String expenseExplain) {
        this.expenseExplain = expenseExplain == null ? null : expenseExplain.trim();
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
    }

    public String getExpenseType() {
		return expenseType;
	}

	public void setExpenseType(String expenseType) {
		this.expenseType = expenseType == null ? null : expenseType.trim();
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

	public BigDecimal getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(BigDecimal totalMoney) {
		this.totalMoney = totalMoney;
	}

	public List<ExpenseBookDetail> getDetails() {
		return details;
	}

	public void setDetails(List<ExpenseBookDetail> details) {
		this.details = details;
	}

	public int getDetailNum() {
		return detailNum;
	}

	public void setDetailNum(int detailNum) {
		this.detailNum = detailNum;
	}
}