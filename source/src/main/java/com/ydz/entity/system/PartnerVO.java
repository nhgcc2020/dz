
package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class PartnerVO implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2215270001576057328L;

	@JSONField(serialize = false)
	private Long uid;

    private String partnerKey;
    
    private String partnerComKey;

    private String partnerName;

    private String partnerShortname;

    private String mnemonicCode;
    
    private String taxNo;
    
    private BigDecimal balanceMoney;

    private String partnerLevel;
    
    private String partnerLevelValue;

    private String partnerAttr;
    
    private String partnerAttrValue;

    private String partnerType;
    
    private String partnerTypeValue;
    
    private String partnerQQ;

	private String partnerTel;
    
    private String partnerProvince;

    private String partnerCity;

    private String partnerCountry;

    private String partnerAddress;

    private String isValid;

    private String remarks;

    private String creator;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    private String contacterId;
    
    private String contacterName;
    
    private String tel1;
    
    private String tel2;
    
    private String comKey;
    
    private String comId;
    
    private String areaCode;
    
    private String comTel;
    
    private String partnerStatus;
    
    private String statusValue;

    private String myComName;

    private String myComShortname;
    //YDZ_COM_PARTNER 的Uid
    private Long cUid;
    //YDZ_PARTNER_CONTACTER 的Uid
    private Long pcUid;
    
    private String comLogoPath;

    private Integer gt6OrderNum; //超过6个月待对账订单数
    
    private String gt6TotalPrice; //超过6个月待对账订单金额
    
    private Integer gt3OrderNum; //超过3个月待对账订单数
    
    private String gt3TotalPrice; //超过3个月待对账订单金额
    
    private Integer allOrderNum04; //全部待对账的订单数
    
    private String allTotalPrice; //全部待对账合计订单金额
    
    private Integer allOrderNum07; //全部待收款的订单数
    
    private String allReceivablesMoney; //全部待收款合计应收金额
    
    
    public String getComLogoPath() {
        return comLogoPath;
    }

    public Long getPcUid() {
        return pcUid;
    }

    public void setPcUid(Long pcUid) {
        this.pcUid = pcUid;
    }

    public void setComLogoPath(String comLogoPath) {
        this.comLogoPath = comLogoPath;
    }

    public Long getcUid() {
        return cUid;
    }

    public void setcUid(Long cUid) {
        this.cUid = cUid;
    }

    public String getMyComName() {
        return myComName;
    }

    public void setMyComName(String myComName) {
        this.myComName = myComName;
    }

    public String getMyComShortname() {
        return myComShortname;
    }

    public void setMyComShortname(String myComShortname) {
        this.myComShortname = myComShortname;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getPartnerKey() {
        return partnerKey;
    }

    public void setPartnerKey(String partnerKey) {
        this.partnerKey = partnerKey == null ? null : partnerKey.trim();
    }
    
    public String getPartnerComKey() {
		return partnerComKey;
	}

	public void setPartnerComKey(String partnerComKey) {
		this.partnerComKey = partnerComKey == null ? null : partnerComKey.trim();
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

    public String getMnemonicCode() {
        return mnemonicCode;
    }

    public void setMnemonicCode(String mnemonicCode) {
        this.mnemonicCode = mnemonicCode == null ? null : mnemonicCode.trim();
    }

    public String getTaxNo() {
		return taxNo;
	}

	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}

	public BigDecimal getBalanceMoney() {
		return balanceMoney;
	}

	public void setBalanceMoney(BigDecimal balanceMoney) {
		this.balanceMoney = balanceMoney;
	}

	public String getPartnerLevel() {
        return partnerLevel;
    }

    public void setPartnerLevel(String partnerLevel) {
        this.partnerLevel = partnerLevel == null ? null : partnerLevel.trim();
    }

    public String getPartnerAttr() {
        return partnerAttr;
    }

    public void setPartnerAttr(String partnerAttr) {
        this.partnerAttr = partnerAttr == null ? null : partnerAttr.trim();
    }

    public String getPartnerType() {
        return partnerType;
    }

    public void setPartnerType(String partnerType) {
        this.partnerType = partnerType == null ? null : partnerType.trim();
    }

    public String getPartnerTel() {
        return partnerTel;
    }

    public void setPartnerTel(String partnerTel) {
        this.partnerTel = partnerTel == null ? null : partnerTel.trim();
    }

    public String getPartnerAddress() {
        return partnerAddress;
    }

    public void setPartnerAddress(String partnerAddress) {
        this.partnerAddress = partnerAddress == null ? null : partnerAddress.trim();
    }

    public String getIsValid() {
        return isValid;
    }

    public void setIsValid(String isValid) {
        this.isValid = isValid == null ? null : isValid.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
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

	public String getContacterId() {
		return contacterId;
	}

	public void setContacterId(String contacterId) {
		this.contacterId = contacterId;
	}

	public String getContacterName() {
		return contacterName;
	}

	public void setContacterName(String contacterName) {
		this.contacterName = contacterName;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey;
	}

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}

	public String getPartnerLevelValue() {
		return partnerLevelValue;
	}

	public void setPartnerLevelValue(String partnerLevelValue) {
		this.partnerLevelValue = partnerLevelValue;
	}

	public String getPartnerAttrValue() {
		return partnerAttrValue;
	}

	public void setPartnerAttrValue(String partnerAttrValue) {
		this.partnerAttrValue = partnerAttrValue;
	}

	public String getPartnerTypeValue() {
		return partnerTypeValue;
	}

	public void setPartnerTypeValue(String partnerTypeValue) {
		this.partnerTypeValue = partnerTypeValue;
	}
	
	public String getComId() {
		return comId;
	}

	public void setComId(String comId) {
		this.comId = comId;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getComTel() {
		return comTel;
	}

	public void setComTel(String comTel) {
		this.comTel = comTel;
	}

	public String getPartnerStatus() {
		return partnerStatus;
	}

	public void setPartnerStatus(String partnerStatus) {
		this.partnerStatus = partnerStatus;
	}
    public String getPartnerQQ() {
		return partnerQQ;
	}

	public void setPartnerQQ(String partnerQQ) {
		this.partnerQQ = partnerQQ;
	}

	public String getPartnerProvince() {
		return partnerProvince;
	}

	public void setPartnerProvince(String partnerProvince) {
		this.partnerProvince = partnerProvince;
	}

	public String getPartnerCity() {
		return partnerCity;
	}

	public void setPartnerCity(String partnerCity) {
		this.partnerCity = partnerCity;
	}

	public String getPartnerCountry() {
		return partnerCountry;
	}

	public void setPartnerCountry(String partnerCountry) {
		this.partnerCountry = partnerCountry;
	}

	public Integer getGt6OrderNum() {
		return gt6OrderNum;
	}

	public void setGt6OrderNum(Integer gt6OrderNum) {
		this.gt6OrderNum = gt6OrderNum;
	}

	public String getGt6TotalPrice() {
		return gt6TotalPrice;
	}

	public void setGt6TotalPrice(String gt6TotalPrice) {
		this.gt6TotalPrice = gt6TotalPrice;
	}

	public Integer getGt3OrderNum() {
		return gt3OrderNum;
	}

	public void setGt3OrderNum(Integer gt3OrderNum) {
		this.gt3OrderNum = gt3OrderNum;
	}

	public String getGt3TotalPrice() {
		return gt3TotalPrice;
	}

	public void setGt3TotalPrice(String gt3TotalPrice) {
		this.gt3TotalPrice = gt3TotalPrice;
	}

	public Integer getAllOrderNum04() {
		return allOrderNum04;
	}

	public void setAllOrderNum04(Integer allOrderNum04) {
		this.allOrderNum04 = allOrderNum04;
	}

	public String getAllTotalPrice() {
		return allTotalPrice;
	}

	public void setAllTotalPrice(String allTotalPrice) {
		this.allTotalPrice = allTotalPrice;
	}

	public Integer getAllOrderNum07() {
		return allOrderNum07;
	}

	public void setAllOrderNum07(Integer allOrderNum07) {
		this.allOrderNum07 = allOrderNum07;
	}

	public String getAllReceivablesMoney() {
		return allReceivablesMoney;
	}

	public void setAllReceivablesMoney(String allReceivablesMoney) {
		this.allReceivablesMoney = allReceivablesMoney;
	}
}