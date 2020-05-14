package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class RentalInvoice implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8414094601316244748L;

	private Long uid;

    private String invoiceKey;

    private String rentalKey;

    private String comKey;

    private String invoiceTitle;

    private String invoiceContent;

    private BigDecimal taxRate;

    private String invoiceType;

    private Date invoiceDate;

    private String recipients;

    private String receivedProvince;

    private String receivedCity;

    private String receivedCountry;

    private String receivedAddress;

    private String remarks;

    private String creator;

    private Date createTime;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getInvoiceKey() {
        return invoiceKey;
    }

    public void setInvoiceKey(String invoiceKey) {
        this.invoiceKey = invoiceKey == null ? null : invoiceKey.trim();
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

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public void setInvoiceTitle(String invoiceTitle) {
        this.invoiceTitle = invoiceTitle == null ? null : invoiceTitle.trim();
    }

    public String getInvoiceContent() {
        return invoiceContent;
    }

    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent == null ? null : invoiceContent.trim();
    }

    public BigDecimal getTaxRate() {
        return taxRate;
    }

    public void setTaxRate(BigDecimal taxRate) {
        this.taxRate = taxRate;
    }

    public String getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(String invoiceType) {
        this.invoiceType = invoiceType == null ? null : invoiceType.trim();
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public String getRecipients() {
        return recipients;
    }

    public void setRecipients(String recipients) {
        this.recipients = recipients == null ? null : recipients.trim();
    }

    public String getReceivedProvince() {
        return receivedProvince;
    }

    public void setReceivedProvince(String receivedProvince) {
        this.receivedProvince = receivedProvince == null ? null : receivedProvince.trim();
    }

    public String getReceivedCity() {
        return receivedCity;
    }

    public void setReceivedCity(String receivedCity) {
        this.receivedCity = receivedCity == null ? null : receivedCity.trim();
    }

    public String getReceivedCountry() {
        return receivedCountry;
    }

    public void setReceivedCountry(String receivedCountry) {
        this.receivedCountry = receivedCountry == null ? null : receivedCountry.trim();
    }

    public String getReceivedAddress() {
        return receivedAddress;
    }

    public void setReceivedAddress(String receivedAddress) {
        this.receivedAddress = receivedAddress == null ? null : receivedAddress.trim();
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
}