package com.ydz.vo;

import java.io.Serializable;
import java.util.Date;

import com.ydz.entity.assignment.AssignTask;

/** 
 * @ClassName: AssignTaskVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月21日 下午6:03:53 
 * 
 */
public class AssignTaskVO extends AssignTask implements Serializable{

	private static final long serialVersionUID = 1633586442248825467L;
	
	private String taskUserKey;

    private String taskUserName;

    private String statusDetail;

    private Date finishDateDetail;

    private String remarksDetail;

	public String getTaskUserKey() {
		return taskUserKey;
	}

	public void setTaskUserKey(String taskUserKey) {
		this.taskUserKey = taskUserKey;
	}

	public String getTaskUserName() {
		return taskUserName;
	}

	public void setTaskUserName(String taskUserName) {
		this.taskUserName = taskUserName;
	}

	public String getStatusDetail() {
		return statusDetail;
	}

	public void setStatusDetail(String statusDetail) {
		this.statusDetail = statusDetail;
	}

	public Date getFinishDateDetail() {
		return finishDateDetail;
	}

	public void setFinishDateDetail(Date finishDateDetail) {
		this.finishDateDetail = finishDateDetail;
	}

	public String getRemarksDetail() {
		return remarksDetail;
	}

	public void setRemarksDetail(String remarksDetail) {
		this.remarksDetail = remarksDetail;
	}
}
