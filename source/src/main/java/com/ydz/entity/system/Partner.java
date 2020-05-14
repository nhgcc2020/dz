
package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 合作伙伴(客户)信息
 */
public class Partner implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 590270617180369587L;

	private Long uid;

    private String partnerKey;
    
    private String partnerComKey;

    private String partnerName;

    private String partnerShortname;

    private String mnemonicCode;
    
    private String taxNo;

    private String partnerLevel;

    private String partnerAttr;

    private String partnerType;

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
    
    private String changer;
    
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date changeTime;

    private boolean sendMsg;

    public boolean isSendMsg() {
        return sendMsg;
    }

    public void setSendMsg(boolean sendMsg) {
        this.sendMsg = sendMsg;
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

    public String getPartnerQQ() {
        return partnerQQ;
    }

    public void setPartnerQQ(String partnerQQ) {
        this.partnerQQ = partnerQQ == null ? null : partnerQQ.trim();
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



	private String tel11;
    //联系人一备用手机
    private String tel112;
    private String contacterName11;

    private String tel12;
    private String contacterName12;

    public String getTel11() {
        return tel11;
    }

    public void setTel11(String tel11) {
        this.tel11 = tel11;
    }

    public String getContacterName11() {
        return contacterName11;
    }

    public void setContacterName11(String contacterName11) {
        this.contacterName11 = contacterName11;
    }

    public String getTel12() {
        return tel12;
    }

    public void setTel12(String tel12) {
        this.tel12 = tel12;
    }

    public String getContacterName12() {
        return contacterName12;
    }

    public void setContacterName12(String contacterName12) {
        this.contacterName12 = contacterName12;
    }

    public String getTel112() {
        return tel112;
    }

    public void setTel112(String tel112) {
        this.tel112 = tel112;
    }

	public String getChanger() {
		return changer;
	}

	public void setChanger(String changer) {
		this.changer = changer;
	}

	public Date getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
}