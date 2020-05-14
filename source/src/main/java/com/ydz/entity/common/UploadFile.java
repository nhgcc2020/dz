/**   
 * @Title: UploadFile.java 
 * @Package com.ydz.entity.common 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 28, 2017 1:33:18 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.common;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: UploadFile 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 28, 2017 1:33:18 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class UploadFile implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@JSONField(serialize = false)
	private Long uid;
	private String fileId;
	private String orderNo;
	private String comKey;
	private String fileName;
	private String filePath;
	private String showPath;
	private String fileType;
	private String remarks;
	private String isDel;
	 @JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Date createTime;
	private String creator;
	public Long getUid() {
		return uid;
	}
	public void setUid(Long uid) {
		this.uid = uid;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getComKey() {
		return comKey;
	}
	public void setComKey(String comKey) {
		this.comKey = comKey;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getShowPath() {
		return showPath;
	}
	public void setShowPath(String showPath) {
		this.showPath = showPath;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
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
		this.creator = creator;
	}

}
