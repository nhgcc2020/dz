package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Date;

public class DepartmentInit implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 8568276796063579053L;

	private Long uid;

    private String deptId;

    private String deptName;

    private String pDeptId;

    private Integer sortItem;

    private String isValid;

    private String industryId;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId == null ? null : deptId.trim();
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

    public String getpDeptId() {
        return pDeptId;
    }

    public void setpDeptId(String pDeptId) {
        this.pDeptId = pDeptId == null ? null : pDeptId.trim();
    }

    public Integer getSortItem() {
        return sortItem;
    }

    public void setSortItem(Integer sortItem) {
        this.sortItem = sortItem;
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}