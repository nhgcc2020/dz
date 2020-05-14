/**   
 * @Title: MediaRunPlanDetailPointLocationVO.java 
 * @Package com.ydz.entity.media 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 18, 2018 4:25:29 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.media;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: MediaRunPlanDetailPointLocationVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 18, 2018 4:25:29 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class MediaRunPlanDetailPointLocationVO extends MediaPointLocation{

	private String planNo;

    private String pointNo;

    private String pointName;

    private String pointCode;

    @JSONField(format="yyyy-MM-dd")
    private Date startDate;

    @JSONField(format="yyyy-MM-dd")
    private Date endDate;

    private int days;
    
    private String planStatus;

	public String getPlanNo() {
		return planNo;
	}

	public void setPlanNo(String planNo) {
		this.planNo = planNo;
	}

	public String getPointNo() {
		return pointNo;
	}

	public void setPointNo(String pointNo) {
		this.pointNo = pointNo;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public String getPlanStatus() {
		return planStatus;
	}

	public void setPlanStatus(String planStatus) {
		this.planStatus = planStatus;
	}
	
	
}
