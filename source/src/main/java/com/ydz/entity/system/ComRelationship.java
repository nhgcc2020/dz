package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

public class ComRelationship implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6862922405939870506L;

	private Long uid;

    private String comId;

    private String relationComId;

    private String comAttr;

    private String isValid;

    private String creator;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId == null ? null : comId.trim();
    }

    public String getRelationComId() {
        return relationComId;
    }

    public void setRelationComId(String relationComId) {
        this.relationComId = relationComId == null ? null : relationComId.trim();
    }

    public String getComAttr() {
        return comAttr;
    }

    public void setComAttr(String comAttr) {
        this.comAttr = comAttr == null ? null : comAttr.trim();
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
}