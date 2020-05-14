package com.ydz.wechat.vo;

import java.io.Serializable;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame PurchaseMsgVO.java
 * @createTime 2016-09-21 下午4:41
 * @decription 类描述说明
 **/

public class PurchaseMsgVO implements Serializable {
    private static final long serialVersionUID = -5761620064533554849L;

    //模板号
    private String templateId;
    //头部信息
    private String first;
    //项目名称
    private String projectName;
    //订单来源
    private String orderSource;
    //订单编号
    private String orderNo;
    //订单金额
    private String orderMoney;
    //订单日期
    private String orderDate;
    //订单周期
    private String orderCycle;
    //备注信息
    private String remark;
    //跳转链接
    private String callBackurl;
    //openId
    private String openId;



    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getOrderSource() {
        return orderSource;
    }

    public void setOrderSource(String orderSource) {
        this.orderSource = orderSource;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderMoney() {
        return orderMoney;
    }

    public void setOrderMoney(String orderMoney) {
        this.orderMoney = orderMoney;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getCallBackurl() {
        return callBackurl;
    }

    public void setCallBackurl(String callBackurl) {
        this.callBackurl = callBackurl;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

	public String getOrderCycle() {
		return orderCycle;
	}

	public void setOrderCycle(String orderCycle) {
		this.orderCycle = orderCycle;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getFirst() {
		return first;
	}

	public void setFirst(String first) {
		this.first = first;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}