package com.ydz.vo;

import java.io.Serializable;
import java.util.List;

import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;

/** 
 * @ClassName: PurchaseOrderVO 
 * @Description: 附带采购订单明细记录
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月19日 下午5:40:21 
 * 
 */
public class PurchaseOrderVO extends PurchaseOrder implements Serializable{

	private static final long serialVersionUID = 5763095043123735761L;
	
	private PurchaseOrder purchaseOrder;
	
	private List<PurchaseOrderDetail> details;
	
	private List<SelectVo> selectVos;
	
	private String shareUrl;

	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}

	public List<PurchaseOrderDetail> getDetails() {
		return details;
	}

	public void setDetails(List<PurchaseOrderDetail> details) {
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
