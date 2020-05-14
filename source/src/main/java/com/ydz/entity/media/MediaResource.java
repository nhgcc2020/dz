package com.ydz.entity.media;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class MediaResource implements Serializable{
    /** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = -5672092623905719833L;

	@JSONField(serialize = false)
	private Long uid;

    private String mediaNo;

    private String comKey;

    private String industryId;

    private String mediaDesc;

    private String mediaType;

    private String mediaTypeDesc;

    private String showType;

    private String showTypeDesc;

    private int pointNum;

    @JSONField(serialize = false)
    private String isDel;

    private String remarks;

    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String creator;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getMediaNo() {
        return mediaNo;
    }

    public void setMediaNo(String mediaNo) {
        this.mediaNo = mediaNo == null ? null : mediaNo.trim();
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey == null ? null : comKey.trim();
    }

    public String getIndustryId() {
        return industryId;
    }

    public void setIndustryId(String industryId) {
        this.industryId = industryId == null ? null : industryId.trim();
    }

    public String getMediaDesc() {
        return mediaDesc;
    }

    public void setMediaDesc(String mediaDesc) {
        this.mediaDesc = mediaDesc == null ? null : mediaDesc.trim();
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType == null ? null : mediaType.trim();
    }

    public String getMediaTypeDesc() {
        return mediaTypeDesc;
    }

    public void setMediaTypeDesc(String mediaTypeDesc) {
        this.mediaTypeDesc = mediaTypeDesc == null ? null : mediaTypeDesc.trim();
    }

    public String getShowType() {
        return showType;
    }

    public void setShowType(String showType) {
        this.showType = showType == null ? null : showType.trim();
    }

    public String getShowTypeDesc() {
        return showTypeDesc;
    }

    public void setShowTypeDesc(String showTypeDesc) {
        this.showTypeDesc = showTypeDesc == null ? null : showTypeDesc.trim();
    }

    public int getPointNum() {
        return pointNum;
    }

    public void setPointNum(int pointNum) {
        this.pointNum = pointNum;
    }

    public String getIsDel() {
        return isDel;
    }

    public void setIsDel(String isDel) {
        this.isDel = isDel == null ? null : isDel.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }
}