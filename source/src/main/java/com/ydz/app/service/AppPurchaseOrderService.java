package com.ydz.app.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.config.DZConfig;
import com.ydz.entity.Page;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.EncryptUtils;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.PurchaseCheckingOrderVO;
import com.ydz.vo.PurchaseOrderVO;
import com.ydz.vo.SelectVo;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.exception.AppException;

/**
 * 
* @ClassName: AppPurchaseOrderService 
* @Description: app的采购业务服务类
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2017年6月13日 下午5:33:04 
*
 */
@Service
public class AppPurchaseOrderService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name="purchaseOrderService")
	private PurchaseOrderService purchaseOrderService;
	
	@Resource(name="orderConfigService")
	private OrderConfigService orderConfigService;
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="salesOrderService")
	private SalesOrderService salesOrderService;
	
	@Resource
	private DZConfig dzConfig;
	
	/**
	 * 
	* @Title: getOnePurchaseOrderVO 
	* @param pd comKey，purchaseNo
	* @return
	* @throws Exception
	* @return PurchaseOrderVO
	* @throws 
	* @Description: 根据参数获取单条订单对象，含订单明细
	 */
	public PurchaseOrderVO getOnePurchaseOrderVO(PageData pd)  throws Exception{
		PurchaseOrderVO orderVO = null;
		PurchaseOrder order = purchaseOrderService.selectOnePurchaseOrder(pd);
		if(order!=null){
			orderVO = new PurchaseOrderVO();
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			page.setPd(pd);
			List<PurchaseOrderDetail> details = purchaseOrderService.listPagePurchaseOrderDetail(page);
			BeanutilsCopy.apacheCopyProperties(orderVO, order);
			orderVO.setDetails(details);
			
			String shareUrl = dzConfig.webPath+"/ordershare/purchase-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
					order.getIndustryId()+"-"+order.getPurchaseNo()+"-"+order.getComKey());
			orderVO.setShareUrl(shareUrl);
		}
		return orderVO;
	}
	
	/**
	 * 
	* @Title: listPagePurchaseOrder 
	* @param page
	* @return
	* @throws Exception
	* @return List<PurchaseOrder>
	* @throws 
	* @Description: 获取分页采购订单数据
	 */
	public List<PurchaseOrder> listPagePurchaseOrder(Page page)  throws Exception{
		List<PurchaseOrder> purchaseOrders = purchaseOrderService.listPagePurchaseOrder(page);
		for (PurchaseOrder purchaseOrder : purchaseOrders) {
			purchaseOrder.setCaseDesc(purchaseOrderService.getPurchaseOrderDetailGroupBusinessDesc(purchaseOrder.getPurchaseNo()));
		}
		return purchaseOrders;
	}
	
	public List<PurchaseOrderDetail> listPagePurchaseOrderDetail(Page page) throws Exception{
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		return purchaseOrderService.listPagePurchaseOrderDetail(page);
	}
	
	/** 批量更新采购订单 **/
	public int updateBatchPurchaseOrder(PageData pd) throws Exception{
		return purchaseOrderService.updateBatchByPurchaseNoIn(pd);
	}
	/** 批量更新采购订单明细 **/
	public int updateBatchPurchaseOrderDetail(PageData pd) throws Exception{
		return purchaseOrderService.updateBatchDetailByPurchaseNoIn(pd);
	}
	
	
	/**
	 * 
	* @Title: getPurchaseCheckingOrderVO 
	* @param pd
	* @return
	* @throws Exception
	* @return PurchaseCheckingOrderVO
	* @throws 
	* @Description: 获取单个采购对账单及明细记录
	 */
	public PurchaseCheckingOrderVO getOnePurchaseCheckingOrderVO(PageData pd) throws Exception{
		PurchaseCheckingOrderVO checkingOrderVO = null;
		PurchaseCheckingOrder order = purchaseOrderService.selectOnePurchaseCheckingOrder(pd);
		if(order!=null){
			checkingOrderVO = new PurchaseCheckingOrderVO();
			BeanutilsCopy.apacheCopyProperties(checkingOrderVO, order);
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			page.setPd(pd);
			List<PurchaseCheckingOrderDetail> checkingDetail = purchaseOrderService.listPagePurchaseCheckingOrderDetail(page);
			checkingOrderVO.setDetails(checkingDetail);
			List<BusinessTypeVO> businessTypes = orderConfigService.listBusinessTypeVO(order.getIndustryId());
			List<SelectVo> svs = new ArrayList<SelectVo>();
			for (BusinessTypeVO typeVO : businessTypes) {
				SelectVo select = new SelectVo();
				select.setValue(typeVO.getBusinessType());
				select.setText(typeVO.getBusinessTypeDesc());
				svs.add(select);
			}
			checkingOrderVO.setSelectVos(svs);
			String shareUrl = dzConfig.webPath+"/ordershare/purchasechecking-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
					order.getIndustryId()+"-"+order.getPurchasecheckingNo()+"-"+order.getComKey());
			checkingOrderVO.setShareUrl(shareUrl);
		}
		
		return checkingOrderVO;
	}
	
	
	/**
	 * 
	* @Title: listPagePurchaseCheckingOrder 
	* @param page
	* @return
	* @throws Exception
	* @return List<PurchaseCheckingOrder>
	* @throws 
	* @Description: 分页查询采购对账单
	 */
	public List<PurchaseCheckingOrder> listPagePurchaseCheckingOrder(Page page) throws Exception{
		List<PurchaseCheckingOrder> checkingOrders = purchaseOrderService.listPagePurchaseCheckingOrder(page);
		for (PurchaseCheckingOrder purchaseCheckingOrder : checkingOrders) {
			purchaseCheckingOrder.setCaseDesc(purchaseOrderService.getPurchasecheckingOrderDetailGroupBusinessDesc(purchaseCheckingOrder.getPurchasecheckingNo()));
		}
		return checkingOrders;
	}
	
	/**
	 * 
	* @Title: listPagePurchaseCheckingOrderDetail 
	* @param page
	* @return
	* @throws Exception
	* @return List<PurchaseCheckingOrderDetail>
	* @throws 
	* @Description: 分页查询采购对账单明细
	 */
	public List<PurchaseCheckingOrderDetail> listPagePurchaseCheckingOrderDetail(Page page) throws Exception{
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		return purchaseOrderService.listPagePurchaseCheckingOrderDetail(page);
	}
	
	/**
	 * 
	 * @Title: updateDelivery 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 协同采购单收货
	 */
	public int updateDelivery(PageData pd) throws Exception{
		int result = 0;
		try {
			result = purchaseOrderService.updateDelivery(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new AppException("协同采购收货失败");
		}
		return result;
	}

}
