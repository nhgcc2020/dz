package com.ydz.vo;

import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;

import java.io.Serializable;
import java.util.List;

/**
 * 新建订单时前台传入控制器时  springmvc 用来接收的对象
 * 包括一条订单信息 和多条订单详情
 * Created by pxy on 16/8/18.
 */
public class SalesOrderVO implements Serializable{

	private static final long serialVersionUID = -1950749616779138343L;

	//销售订单信息
    SalesOrder salesOrder;

    //销售订单详情列表
    List<SalesOrderDetail> details;
    
    List<SelectVo> selectVos;

    public SalesOrder getSalesOrder() {
        return salesOrder;
    }

    public void setSalesOrder(SalesOrder salesOrder) {
        this.salesOrder = salesOrder;
    }

	public List<SalesOrderDetail> getDetails() {
		return details;
	}

	public void setDetails(List<SalesOrderDetail> details) {
		this.details = details;
	}

	public List<SelectVo> getSelectVos() {
		return selectVos;
	}

	public void setSelectVos(List<SelectVo> selectVos) {
		this.selectVos = selectVos;
	}
}
