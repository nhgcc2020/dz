package com.ydz.entity.init;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class IndustryInit implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1424886977708156374L;

	private Long uid;

    private String industryId;

    private String industryName;

    private String industryDesc;

    private String pIndustryId;

    private Integer sortItem;

    private String isValid;

    private Date createTime;

    private List<IndustryInit> indus;


	public IndustryInit() {
		// TODO Auto-generated constructor stub
	}
    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getIndustryName() {
        return industryName;
    }

    public void setIndustryName(String industryName) {
        this.industryName = industryName == null ? null : industryName.trim();
    }

    public String getIndustryDesc() {
        return industryDesc;
    }

    public void setIndustryDesc(String industryDesc) {
        this.industryDesc = industryDesc == null ? null : industryDesc.trim();
    }

    public String getpIndustryId() {
        return pIndustryId;
    }

    public void setpIndustryId(String pIndustryId) {
        this.pIndustryId = pIndustryId == null ? null : pIndustryId.trim();
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<IndustryInit> getIndus() {
        return indus;
    }

    public void setIndus(List<IndustryInit> indus) {
        this.indus = indus;
    }

    @Override
	//todo indus集合没加
    public String toString() {
		return "IndustryInit [uid=" + uid + ", industryId=" + industryId
				+ ", industryName=" + industryName + ", industryDesc="
				+ industryDesc + ", pIndustryId=" + pIndustryId + ", sortItem="
				+ sortItem + ", isValid=" + isValid + ", createTime="
				+ createTime + "]";
	}
    
}