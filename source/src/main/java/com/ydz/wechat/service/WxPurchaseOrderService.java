package com.ydz.wechat.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.advert.SalesOrderDetailMapper;
import com.ydz.dao.advert.SalesOrderMapper;
import com.ydz.entity.Page;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.PurchaseCheckingOrderVO;
import com.ydz.vo.PurchaseOrderVO;
import com.ydz.vo.SelectVo;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.common.OperateLog;

/** 
 * @ClassName: WxPurchaseOrderService 
 * @Description: 微信采购订单Service
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月19日 下午5:29:37 
 * 
 */
@Service("wxPurchaseOrderService")
public class WxPurchaseOrderService {
	
	@Resource(name="purchaseOrderService")
	private PurchaseOrderService purchaseOrderService;
	
	@Resource(name="orderConfigService")
	private OrderConfigService orderConfigService;
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="salesOrderService")
	private SalesOrderService salesOrderService;
	
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
			List<BusinessTypeVO> businessTypes = orderConfigService.listBusinessTypeVO(order.getIndustryId());
			List<SelectVo> svs = new ArrayList<SelectVo>();
			for (BusinessTypeVO typeVO : businessTypes) {
				SelectVo select = new SelectVo();
				select.setValue(typeVO.getBusinessType());
				select.setText(typeVO.getBusinessTypeDesc());
				svs.add(select);
			}
			orderVO.setSelectVos(svs);
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
		return purchaseOrderService.listPagePurchaseOrder(page);
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
	* @Title: updateSynchroPurchaseTakeOver 
	* @param pd
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 协同采购订单收货
	* todo 判断是否已经被收货了
	 */
//	2017年03月16日17:30:35 取消确认收货
//	public int updateSynchroPurchaseTakeOver(PageData pd) throws Exception{
//		Integer result = 0;
//		//查询当前订单状态 如果不为待收货状态 则返回0
//		List<String> purchaseOrderNoIn = (List<String>) pd.get("purchaseOrderNoIn");
//		for(String no : purchaseOrderNoIn){
//			PageData pageData = new PageData();
//			pageData.put("purchaseNo",no);
//			PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pageData);
//			if(purchaseOrder.getOrderStatus()==null || !Const.ORDER_STATUS_03.equals(purchaseOrder.getOrderStatus())){
//				return 0;
//			}
//		}
//
//		this.updateBatchPurchaseOrder(pd);
//		this.updateBatchPurchaseOrderDetail(pd);
//		
//		salesOrderService.updateBatchBySalesNoIn(pd);
//		salesOrderService.updateBatchDetailBySalesNoIn(pd);
//		
////		commonService.insertOperateLog(this.getOperateLog(pd));
//		return result;
//	}
	
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
		return purchaseOrderService.listPagePurchaseCheckingOrder(page);
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
	* @Title: getSumTotalVO 
	* @param pd type: 01 协同订单 02 协同对账单 
	* 				  05 外协采购订单 06 外协采购对账单
	* @param type
	* @return
	* @throws Exception
	* @return OrderTotalVO
	* @throws 
	* @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	public OrderTotalVO getSumTotalVO(PageData pd,String type) throws Exception{
		return null;
//		return purchaseOrderService.getSumTotalVO(pd, type);
	}
	
	/**
	 * 
	 * @Title: updateDelivery 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 协同采购收货
	 */
	public int updateDelivery(PageData pd) throws Exception{
		return purchaseOrderService.updateDelivery(pd);
	}
	

}
