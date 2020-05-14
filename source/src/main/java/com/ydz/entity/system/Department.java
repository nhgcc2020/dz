package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

public class Department implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1505695573088468597L;

	private Long uid;

    private String deptId;

    private String deptName;

    private String pDeptId;

    private Integer sortItem;

    private String comKey;

    private String isValid;

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

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}