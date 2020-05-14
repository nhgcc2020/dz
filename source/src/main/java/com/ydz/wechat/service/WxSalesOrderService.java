package com.ydz.wechat.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.entity.Page;

import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: WxSalesOrderService 
 * @Description: 微信销售订单Service
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月19日 下午5:12:59 
 * 
 */
@Service("wxSalesOrderService")
public class WxSalesOrderService {
	
	@Resource(name="salesOrderService")
	SalesOrderService salesOrderService;
	
	@Resource(name="orderConfigService")
	OrderConfigService orderConfigService;
	
	@Resource(name="commonService")
	CommonService commonService;
	
//=====销售订单
	
	/**
	 * 
	* @Title: getOneSalesOrderVO 
	* @param pd
	* @return
	* @throws Exception
	* @return SalesOrderVO
	* @throws 
	* @Description: 获取单个销售订单对象包括订单明细
	 */
	public HashMap<String, Object> getOneSalesOrderVO(PageData pd) throws Exception{
		HashMap<String, Object> mapResult = null;
		SalesOrder order = salesOrderService.selectOneSalesOrder(pd);
		if(order!=null){
			mapResult = new HashMap<String, Object>();
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			page.setPd(pd);
			List<SalesOrderDetail> details = salesOrderService.listPageSalesOrderDetail(page);
			mapResult.put("wxSalesOrder", order);
			mapResult.put("details", details);
			List<BusinessTypeVO> businessTypes = orderConfigService.listBusinessTypeVO(order.getIndustryId());
			List<SelectVo> svs = new ArrayList<SelectVo>();
			for (BusinessTypeVO typeVO : businessTypes) {
				SelectVo select = new SelectVo();
				select.setValue(typeVO.getBusinessType());
				select.setText(typeVO.getBusinessTypeDesc());
				svs.add(select);
			}
			mapResult.put("businessType", svs);
		}
		return mapResult;
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
	 */
	public List<SalesOrder> listPageSalesOrder(Page page) throws Exception{
		return salesOrderService.listPageSalesOrder(page);
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
		HashMap<String, Object> mapResult = null;
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if(checkingOrder!=null){
			mapResult = new HashMap<String,Object>();
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			page.setPd(pd);
			List<SalesCheckingOrderDetail> details = salesOrderService.listPageSalesCheckingOrderDetail(page);
			mapResult.put("checkingOrder",checkingOrder);
			mapResult.put("details",details);
			List<BusinessTypeVO> businessTypes = orderConfigService.listBusinessTypeVO(checkingOrder.getIndustryId());
			List<SelectVo> svs = new ArrayList<SelectVo>();
			for (BusinessTypeVO typeVO : businessTypes) {
				SelectVo select = new SelectVo();
				select.setValue(typeVO.getBusinessType());
				select.setText(typeVO.getBusinessTypeDesc());
				svs.add(select);
			}
			mapResult.put("businessType",svs);
		}
		return mapResult;
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
		return salesOrderService.listPageSalesCheckingOrders(page);
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
