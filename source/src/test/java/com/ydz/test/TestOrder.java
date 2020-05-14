package com.ydz.test;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.PageData;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.AllPurchaseCheckingOrderVO;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/ApplicationContext.xml","classpath:spring/ApplicationContext-mvc.xml","classpath:redis/spring-redis.xml"})
public class TestOrder extends AbstractJUnit4SpringContextTests{

	@Resource(name="partnerService")
	private PartnerService partnerService;

	@Resource(name="salesOrderService")
	SalesOrderService salesOrderService;

	@Resource(name="purchaseOrderService")
	PurchaseOrderService purchaseOrderService;

	@Resource(name="orderConfigService")
	OrderConfigService orderConfigService;
	
	@Resource(name = "commonService")
	CommonService commonService;


	@Test
	public void getListSalesOrderDetail() throws Exception{
		Page page = new Page();
		page.setShowCount(100);
		PageData pd = new PageData();
		pd.put("salesNo", "X160927315116626");
		page.setPd(pd);
		List<SalesOrderDetail> salesOrderDetails = salesOrderService.listPageSalesOrderDetail(page);
		
		System.out.println(JSONArray.toJSONString(salesOrderDetails));
	}
	@Test
	public void getTotalDetail() throws Exception{
		PageData pd= new PageData();
		pd.put("salescheckingNo", "D170329442364430");
		System.out.println(JSONArray.toJSONString(salesOrderService.getCheckingDetail(pd)));
	}
	
	@Test
	public void listPageTotalPurchaseCheckingOrder()throws Exception{
		Page page = new Page();
		page.setShowCount(30);
		page.setCurrentPage(1);
		
		PageData pd = new PageData();
		pd.put("comKey", "cc89a37b4bbe4fa7859217e4ce7e3e06");
		pd.put("isSynchro", "1");
		pd.put("searchKey", "763");
		page.setPd(pd);
		
		List<AllPurchaseCheckingOrderVO> allvos = purchaseOrderService.listPageTotalPurchaseCheckingOrder(page);
		System.out.println(JSONArray.toJSONString(allvos));
		
	}
	
	@Test
	public void testOrderCycle(){
	}
	
	public static void main(String[] args) {
//		for (int i = 0; i < 502; i++) {
//			System.out.println(UuidUtil.get32UUID());
//		}
		
		for (int i = 0; i < 502; i++) {
			System.out.println(CodeBuilderUtil.getInstance().getAnyId(10));
		}
	}
}
