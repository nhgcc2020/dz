package com.ydz.entity.system;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public class Company implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2894605403414218405L;

	@JSONField(serialize = false)
	private Long uid;

    private String comKey;

    private String comId;

    private String withinComId;

    private String comName;

    private String comShortname;

    private String comType;

    private String comAttr;

    private String comProvince;

    private String comCity;

    private String comCountry;

    private String comAddress;

    private String areaCode;

    private String comTel;
    
    private String comQQ;

    private String comLogoPath;
    
    private String comBank;
    
    private String comAccount;

    private String industryId;
    
    private String industryValue;

    private String refereeName;

    private String isValid;

    private String inType;

    private String creator;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    //创建人姓名
    private String creatorName;
    //省
    private String province;
    //市
    private String city;
    //县
    private String country;
    //部门ID
    private String deptId;
    //该员工ID
    private String userKey;
    //助记码
    private String mnemonicCode;
    /**
     * 如果管理员和法人不同 需要存放 两个员工信息
     */
    private List<ComEmployee> employeeList;

    public List<ComEmployee> getEmployeeList() {
        return employeeList;
    }

    public void setEmployeeList(List<ComEmployee> employeeList) {
        this.employeeList = employeeList;
    }
    //
    private String adminName;
    //
    private String adminPhone;
    //
    private String bossName;
    //
    private String bossPhone;

    private String partnerStatus;

    private String empStatus;

    public String getEmpStatus() {
        return empStatus;
    }

    public void setEmpStatus(String empStatus) {
        this.empStatus = empStatus;
    }

    public String getPartnerStatus() {
        return partnerStatus;
    }

    public void setPartnerStatus(String partnerStatus) {
        this.partnerStatus = partnerStatus;
    }

    public String getBossName() {
        return bossName;
    }

    public void setBossName(String bossName) {
        this.bossName = bossName;
    }

    public String getBossPhone() {
        return bossPhone;
    }

    public void setBossPhone(String bossPhone) {
        this.bossPhone = bossPhone;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getComKey() {
        return comKey;
    }

    public Company setComKey(String comKey) {
        this.comKey = comKey;
        return null;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }
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

    public String getWithinComId() {
        return withinComId;
    }

    public void setWithinComId(String withinComId) {
        this.withinComId = withinComId == null ? null : withinComId.trim();
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName == null ? null : comName.trim();
    }

    public String getComShortname() {
        return comShortname;
    }

    public void setComShortname(String comShortname) {
        this.comShortname = comShortname == null ? null : comShortname.trim();
    }

    public String getComType() {
        return comType;
    }

    public void setComType(String comType) {
        this.comType = comType == null ? null : comType.trim();
    }

    public String getComAttr() {
        return comAttr;
    }

    public void setComAttr(String comAttr) {
        this.comAttr = comAttr == null ? null : comAttr.trim();
    }

    public String getComProvince() {
        return comProvince;
    }

    public void setComProvince(String comProvince) {
        this.comProvince = comProvince == null ? null : comProvince.trim();
    }

    public String getComCity() {
        return comCity;
    }

    public void setComCity(String comCity) {
        this.comCity = comCity == null ? null : comCity.trim();
    }

    public String getComCountry() {
        return comCountry;
    }

    public void setComCountry(String comCountry) {
        this.comCountry = comCountry == null ? null : comCountry.trim();
    }

    public String getComAddress() {
        return comAddress;
    }

    public void setComAddress(String comAddress) {
        this.comAddress = comAddress == null ? null : comAddress.trim();
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode == null ? null : areaCode.trim();
    }

    public String getComTel() {
        return comTel;
    }

    public void setComTel(String comTel) {
        this.comTel = comTel == null ? null : comTel.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getRefereeName() {
        return refereeName;
    }

    public void setRefereeName(String refereeName) {
        this.refereeName = refereeName == null ? null : refereeName.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getInType() {
        return inType;
    }

    public void setInType(String inType) {
        this.inType = inType == null ? null : inType.trim();
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

    public String getComLogoPath() {
        return comLogoPath;
    }

    public void setComLogoPath(String comLogoPath) {
        this.comLogoPath = comLogoPath == null ? null : comLogoPath.trim();
    }

	public String getComBank() {
		return comBank;
	}

	public void setComBank(String comBank) {
		this.comBank = comBank;
	}

	public String getComAccount() {
		return comAccount;
	}

	public void setComAccount(String comAccount) {
		this.comAccount = comAccount;
	}

	public String getMnemonicCode() {
		return mnemonicCode;
	}

	public void setMnemonicCode(String mnemonicCode) {
		this.mnemonicCode = mnemonicCode;
	}

	public String getComQQ() {
		return comQQ;
	}

	public void setComQQ(String comQQ) {
		this.comQQ = comQQ;
	}

	public String getIndustryValue() {
		return industryValue;
	}

	public void setIndustryValue(String industryValue) {
		this.industryValue = industryValue;
	}
	
}