/**
 * 
 */
package com.ydz.vo;

import java.io.Serializable;
import java.util.List;

import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;

/** 
 * @ClassName: SalesCheckingOrderVO 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月29日 下午8:20:57 
 * 
 */
public class SalesCheckingOrderVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 710743194159391733L;
	private SalesCheckingOrder order;
	private List<SalesCheckingOrderDetail> details;
	private List<SelectVo> selectVos;
	
	public SalesCheckingOrder getOrder() {
		return order;
	}
	public void setOrder(SalesCheckingOrder order) {
		this.order = order;
	}
	public List<SalesCheckingOrderDetail> getDetails() {
		return details;
	}
	public void setDetails(List<SalesCheckingOrderDetail> details) {
		this.details = details;
	}
	public List<SelectVo> getSelectVos() {
		return selectVos;
	}
	public void setSelectVos(List<SelectVo> selectVos) {
		this.selectVos = selectVos;
	}
}
