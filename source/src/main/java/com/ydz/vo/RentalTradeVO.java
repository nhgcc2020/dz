package com.ydz.vo;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.entity.system.RentalTrade;

/** 
 * @ClassName: RentalTradeVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年10月15日 下午8:52:49 
 * 
 */
public class RentalTradeVO extends RentalTrade implements Serializable {

	
	private static final long serialVersionUID = -6491611522666510712L;
	
	@JSONField(format="yyyy-MM-dd")
	private Date startDate;
	
	@JSONField(format="yyyy-MM-dd")
	private Date endDate;
	
	private int duration;
	
	private String statusPeriod;
	
	private String statusPeriodValue;

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

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getStatusPeriod() {
		return statusPeriod;
	}

	public void setStatusPeriod(String statusPeriod) {
		this.statusPeriod = statusPeriod;
	}

	public String getStatusPeriodValue() {
		return statusPeriodValue;
	}

	public void setStatusPeriodValue(String statusPeriodValue) {
		this.statusPeriodValue = statusPeriodValue;
	}

}
