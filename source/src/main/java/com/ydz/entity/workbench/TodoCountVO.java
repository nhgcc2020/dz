package com.ydz.entity.workbench;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 4stones@yiduizhang.com 赵石磊
 * @classame TodoCountVO.java
 * @createTime 2016-08-20 16:53
 * @decription 工作台待办任务数量统计
 **/

public class TodoCountVO implements Serializable {


    private static final long serialVersionUID = 3648021755627437982L;

    private String orderStatus;
    private Integer orderCount;
    private String orderType;
    private String comKey;

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

	public String getComKey() {
		return comKey;
	}

	public void setComKey(String comKey) {
		this.comKey = comKey;
	}
    
}
