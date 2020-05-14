package com.ydz.vo;

import java.io.Serializable;
import java.util.List;

import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;

/** 
 * @ClassName: PurchaseCheckingOrderVO 
 * @Description: 附带采购对账单明细
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月19日 下午5:42:21 
 * 
 */
public class PurchaseCheckingOrderVO extends PurchaseCheckingOrder implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7451741874747386975L;
	
	private List<PurchaseCheckingOrderDetail> details;
	
	private List<SelectVo> selectVos;
	
	private String shareUrl;

	public List<PurchaseCheckingOrderDetail> getDetails() {
		return details;
	}

	public void setDetails(List<PurchaseCheckingOrderDetail> details) {
		this.details = details;
	}

	public List<SelectVo> getSelectVos() {
		return selectVos;
	}

	public void setSelectVos(List<SelectVo> selectVos) {
		this.selectVos = selectVos;
	}

	public String getShareUrl() {
		return shareUrl;
	}

	public void setShareUrl(String shareUrl) {
		this.shareUrl = shareUrl;
	}
	
}
