package com.ydz.entity.assignment;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.system.ComProPrice;

public class AssignWorkshopServicePrice implements Serializable{
	private static final long serialVersionUID = 1L;

	@JSONField(serialize = false)
	private Long uid;

    private String comKey;

    private String industryId;

    private String categoryId;

    private String workshop;

    private String workingProcedure;
    
    private String isChecked;
    
    //=======

    private String categoryDesc;

    private String pCode;
    
    private Byte tier;

    private Byte sortItem;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
//    private List<AssignWorkshopServicePrice> items;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
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

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId == null ? null : categoryId.trim();
    }

    public String getWorkshop() {
        return workshop;
    }

    public void setWorkshop(String workshop) {
        this.workshop = workshop == null ? null : workshop.trim();
    }

    public String getWorkingProcedure() {
        return workingProcedure;
    }

    public void setWorkingProcedure(String workingProcedure) {
        this.workingProcedure = workingProcedure == null ? null : workingProcedure.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	public String getCategoryDesc() {
		return categoryDesc;
	}

	public void setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public Byte getTier() {
		return tier;
	}

	public void setTier(Byte tier) {
		this.tier = tier;
	}

	public Byte getSortItem() {
		return sortItem;
	}

	public void setSortItem(Byte sortItem) {
		this.sortItem = sortItem;
	}

//	public List<AssignWorkshopServicePrice> getItems() {
//		return items;
//	}
//
//	public void setItems(List<AssignWorkshopServicePrice> items) {
//		this.items = items;
//	}
}