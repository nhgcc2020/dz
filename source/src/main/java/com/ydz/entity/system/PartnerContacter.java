package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

/**
 * 合作伙伴联系人
 */
public class PartnerContacter implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -1363465510761098430L;

	private Long uid;

    private String partnerKey;

    private String contacterId;

    private String contacterName;

    private String tel1;

    private String tel2;

    private String isValid;

    private String creator;

    private Date createTime;

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

    public String getContacterId() {
        return contacterId;
    }

    public void setContacterId(String contacterId) {
        this.contacterId = contacterId == null ? null : contacterId.trim();
    }

    public String getContacterName() {
        return contacterName;
    }

    public void setContacterName(String contacterName) {
        this.contacterName = contacterName == null ? null : contacterName.trim();
    }

    public String getTel1() {
        return tel1;
    }

    public void setTel1(String tel1) {
        this.tel1 = tel1 == null ? null : tel1.trim();
    }

    public String getTel2() {
        return tel2;
    }

    public void setTel2(String tel2) {
        this.tel2 = tel2 == null ? null : tel2.trim();
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