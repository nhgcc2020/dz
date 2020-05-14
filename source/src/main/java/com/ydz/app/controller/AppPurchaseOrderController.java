package com.ydz.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.app.service.AppPurchaseOrderService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppPurchaseOrderController 
 * @Description: app的采购订单控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:51:05 
 * 
 */
@RestController
@RequestMapping(value = "app/purchase", produces = "application/json;charset=UTF-8")
public class AppPurchaseOrderController extends BaseController{
	
	@Resource
	private AppPurchaseOrderService appPurchaseOrderService;
	
	/**
	 * 
	* @Title: listPurchaseOrder 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 查询采购订单列表
	 */
	 @RequestMapping(value = "listPurchaseOrder", method = RequestMethod.POST)
	 public String listPurchaseOrder(HttpServletRequest request) throws Exception{
		 UserVo userVo = this.getAppCurrentUserVo();
		
		 Page page = this.getPageWithParameter();
	 	 PageData pd = this.getPageData();
	 	 pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
         pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
         if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
 				||StringUtil.isEmpty(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
         }
        
        String orderStatus = this.getPageData().getString("orderStatus");
        String orderStatusIn = StringUtil.isNotEmpty(orderStatus)?(orderStatus.length()==1?StringUtil.fillZero(orderStatus, 1):orderStatus):orderStatus;
        pd.put("orderStatusIN", Tools.strSqlIn(orderStatusIn));
        pd.put("comKey",userVo.getComKey());
        page.setPd(pd);
        ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setData(appPurchaseOrderService.listPagePurchaseOrder(page));
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.setPageCount(page.getTotalPage());
        return JsonUtil.toCompatibleJSONString(resultMap);
	 }
	 
	 /**
	  * 
	 * @Title: getPurchaseOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购订单明细
	  */
	 @RequestMapping(value = "purchaseOrderVo",method = RequestMethod.POST)
	 public String getPurchaseOrderVO(HttpServletRequest request) 
			 throws Exception{
	    return JsonUtil.toCompatibleJSONString(appPurchaseOrderService.getOnePurchaseOrderVO(this.getPageData()));
	 }
	 
	 /**
	  * 
	 * @Title: listPurchaseCheckingOrder 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购对账单列表
	  */
	 @RequestMapping(value = "listPurchaseCheckingOrder", method = RequestMethod.POST)
	 public String listPurchaseCheckingOrder(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getAppCurrentUserVo();
		
		Page page = this.getPageWithParameter();
	 	PageData pd = this.getPageData();
	 	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
				||StringUtil.isEmpty(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        
        String orderStatus = pd.getString("orderStatus");
        String orderStatusIn = StringUtil.isNotEmpty(orderStatus)?(orderStatus.length()==1?StringUtil.fillZero(orderStatus, 1):orderStatus):orderStatus;
        pd.put("orderStatusIN", Tools.strSqlIn(orderStatusIn));
        pd.put("comKey",userVo.getComKey());
        page.setPd(pd);
        
        ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setData(appPurchaseOrderService.listPagePurchaseCheckingOrder(page));
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.setPageCount(page.getTotalPage());
        return JsonUtil.toCompatibleJSONString(resultMap);
	 }
	 
	 /**
	  * 
	 * @Title: getPurchaseCheckingOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购对账单明细
	  */
	 @RequestMapping(value = "purchaseCheckingOrderVo", method = RequestMethod.POST)
	 public String getPurchaseCheckingOrderVO() 
			 throws Exception{
	    return JsonUtil.toCompatibleJSONString(appPurchaseOrderService.getOnePurchaseCheckingOrderVO(this.getPageData()));
	 }
	 
	 /**
	  * 
	  * @Title: delivery 
	  * @return
	  * @throws Exception
	  * @return String
	  * @throws 
	  * @Description: TODO(这里用一句话描述这个方法的作用)
	  */
	 @RequestMapping(value = "delivery", method = RequestMethod.POST)
	 public String delivery() throws Exception{
		 int result = appPurchaseOrderService.updateDelivery(this.getPageData());
		 if (result>0) {
			return JsonUtil.toJsonString(ResultUtil.successMsg("已收货"));
		}else{
			return JsonUtil.toJsonString(ResultUtil.error("收货失败"));
		}
	 }
	
}
