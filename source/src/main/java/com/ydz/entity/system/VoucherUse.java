package com.ydz.entity.system;

import java.io.Serializable;
import java.util.Date;

public class VoucherUse implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -3907017293866553415L;

	private Long uid;

    private String voucherCode;

    private String rentalKey;

    private String comKey;

    private Date useDate;

    private String creator;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode == null ? null : voucherCode.trim();
    }

    public String getRentalKey() {
        return rentalKey;
    }

    public void setRentalKey(String rentalKey) {
        this.rentalKey = rentalKey == null ? null : rentalKey.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public Date getUseDate() {
        return useDate;
    }

    public void setUseDate(Date useDate) {
        this.useDate = useDate;
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