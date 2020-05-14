package com.ydz.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.config.DZConfig;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.util.Const;
import com.ydz.util.EncryptUtils;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.SalesOrderVO;
import com.ydz.vo.SelectVo;
import com.ydz.vo.TotalSalesCheckingOrderDetailVO;

/**
 * 
* @ClassName: AppSalesOrderService 
* @Description: app的销售订单服务类
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2017年6月13日 下午5:35:22 
*
 */
@Service
public class AppSalesOrderService {
	
	@Resource SalesOrderService salesOrderService;
	@Resource OrderConfigService orderConfigService;
	@Resource CommonService commonService;
	@Resource DZConfig dzConfig;
	
//=====销售订单
	
	/**
	 * 
	 * @Title: getOneSalesOrderVO 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return HashMap<String,Object>
	 * @throws 
	 * @Description: 获取单个销售订单对象包括订单明细
	 */
	public HashMap<String, Object> getOneSalesOrderVO(PageData pd) throws Exception{
		ResultMap resultMap = null;
		SalesOrder order = salesOrderService.selectOneSalesOrder(pd);
		if(order!=null){
			resultMap = ResultUtil.getResultMap();
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			pd.clear();
			pd.put("salesNo", order.getSalesNo());
			page.setPd(pd);
			List<SalesOrderDetail> details = salesOrderService.listPageSalesOrderDetail(page);
			resultMap.put("saleOrder", order);
			resultMap.put("details", details);
			String shareUrl = dzConfig.webPath+"/ordershare/sales-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
					order.getIndustryId()+"-"+order.getSalesNo()+"-"+order.getComKey());
			resultMap.put("shareUrl",shareUrl);
		}
		return resultMap;
	}
	
	/**
	 * 
	* @Title: listPageSalesOrder 
	* @param page
	* @return
	* @throws Exception
	* @return List<SalesOrder>
	* @throws 
	* @Description: 获取分页的销售订单列表数据
	* 为app提供合并的订单明细业务内容合并
	 */
	public List<SalesOrder> listPageSalesOrder(Page page) throws Exception{
		List<SalesOrder> salesOrders = salesOrderService.listPageSalesOrder(page);
		for (SalesOrder salesOrder : salesOrders) {
			salesOrder.setCaseDesc(salesOrderService.getSalesOrderDetailGroupBusinessDesc(salesOrder.getSalesNo()));
		}
		return salesOrders;
	}
	
	/**
	 * 
	* @Title: listPageSalesOrderDetail 
	* @param page
	* @return
	* @throws Exception
	* @return List<SalesOrderDetail>
	* @throws 
	* @Description: 获取分页的销售订单明细数据
	 */
	public List<SalesOrderDetail> listPageSalesOrderDetail(Page page) throws Exception{
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		return salesOrderService.listPageSalesOrderDetail(page);
	}
	
	
	
//=====销售对账单	
	
	/**
	 * 
	* @Title: getOneSalesCheckingOrderVO 
	* @param pd
	* @return
	* @throws Exception
	* @return SalesCheckingOrderVO
	* @throws 
	* @Description: 获取单个销售对账单对象和对账单明细
	 */
	public HashMap<String,Object> getOneSalesCheckingOrderVO(PageData pd) throws Exception{
		ResultMap resultMap = null;
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if(checkingOrder!=null){
			resultMap = ResultUtil.getResultMap();
			List<TotalSalesCheckingOrderDetailVO> detailVOs = salesOrderService.getCheckingDetail(pd);
			resultMap.put("checkingOrder",checkingOrder);
			resultMap.put("details",detailVOs);
			List<BusinessTypeVO> businessTypes = orderConfigService.listBusinessTypeVO(checkingOrder.getIndustryId());
			List<SelectVo> svs = new ArrayList<SelectVo>();
			for (BusinessTypeVO typeVO : businessTypes) {
				SelectVo select = new SelectVo();
				select.setValue(typeVO.getBusinessType());
				select.setText(typeVO.getBusinessTypeDesc());
				svs.add(select);
			}
			resultMap.put("businessType",svs);
			String shareUrl = dzConfig.webPath+"/ordershare/saleschecking-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
					checkingOrder.getIndustryId()+"-"+checkingOrder.getSalescheckingNo()+"-"+checkingOrder.getComKey());
			resultMap.put("shareUrl",shareUrl);
		}
		return resultMap;
	}
	
	/**
	 * 
	* @Title: listPageCheckingOrder 
	* @param page
	* @return
	* @throws Exception
	* @return List<SalesCheckingOrder>
	* @throws 
	* @Description: 获取分页的销售对账单列表
	 */
	public List<SalesCheckingOrder> listPageCheckingOrder(Page page) throws Exception{
		List<SalesCheckingOrder> checkingOrders = salesOrderService.listPageSalesCheckingOrders(page);
		for (SalesCheckingOrder salesCheckingOrder : checkingOrders) {
			salesCheckingOrder.setCaseDesc(salesOrderService.getSalescheckingOrderDetailGroupBusinessDesc(salesCheckingOrder.getSalescheckingNo()));
		}
		return checkingOrders;
	}
	
	/**
	 * 
	* @Title: listPageCheckingOrderDetail 
	* @param page
	* @return
	* @throws Exception
	* @return List<SalesCheckingOrderDetail>
	* @throws 
	* @Description: 获取分页的销售对账单明细列表
	 */
	public List<SalesCheckingOrderDetail> listPageCheckingOrderDetail(Page page) throws Exception{
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		return salesOrderService.listPageSalesCheckingOrderDetail(page);
	}
	
}
