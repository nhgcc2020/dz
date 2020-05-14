package com.ydz.wechat.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.exception.WechatException;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.service.WxPurchaseOrderService;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WxPurchaseOrderController 
 * @Description: 微信采购单处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月20日 下午7:46:42 
 * 
 */
@Controller
@RequestMapping(value = "wx")
public class WxPurchaseOrderController extends BaseController{
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name="wxPurchaseOrderService")
	private WxPurchaseOrderService wxPurchaseOrderService;
	
	/**
	 * 
	* @Title: menuListPurchaseOrder 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 查询采购订单列表
	 */
	 @RequestMapping(value = "menu/listPurchaseOrder")
	 @ResponseBody
	 public String menuListPurchaseOrder(HttpServletRequest request) throws Exception{
		 	UserVo userVo = getWxCurrentUserVo();
	    	Page page = new Page();
	    	String pageSize = request.getParameter("pageSize");
	        String pageNo = request.getParameter("pageNo");
	        page.setShowCount(Integer.parseInt(pageSize));
	        page.setCurrentPage(Integer.parseInt(pageNo));
	        PageData pd = new PageData();
	        
	        String orderStatus = request.getParameter("orderStatus");
	        String orderStatusIn = StringUtil.isNotEmpty(orderStatus)?(orderStatus.length()==1?StringUtil.fillZero(orderStatus, 1):orderStatus):orderStatus;
	        pd.put("orderStatusIN", Tools.strSqlIn(orderStatusIn));
	        pd.put("comKey",userVo.getComKey());
//	        pd.put("isSynchro", request.getParameter("isSynchro"));
	        page.setPd(pd);
	        HashMap<String,Object> jsonMap = new HashMap<String, Object>();
	        jsonMap.put("orders", wxPurchaseOrderService.listPagePurchaseOrder(page));
	        jsonMap.put("pageCount", page.getTotalResult());
	        return JsonUtil.toCompatibleJSONString(jsonMap);
	 }
	 
	 /**
	  * 
	 * @Title: menuPurchaseOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购订单明细
	  */
	 @RequestMapping(value = "menu/purchaseOrderVo")
	 @ResponseBody
	 public String menuPurchaseOrderVO(HttpServletRequest request) throws Exception{
	        PageData pd = new PageData();
	        pd.put("purchaseNo", request.getParameter("purchaseNo"));
	        return JsonUtil.toCompatibleJSONString(wxPurchaseOrderService.getOnePurchaseOrderVO(pd));
	 }
	 
	 /**
	  * 
	 * @Title: notifyPurchaseOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询微信消息采购订单详情
	  */
	 @RequestMapping(value = "notify/purchaseOrderVo")
	 @ResponseBody
	 public String notifyPurchaseOrderVO(HttpServletRequest request) throws Exception{
	        PageData pd = new PageData();
	        pd.put("purchaseNo", request.getParameter("purchaseNo"));
	        return JsonUtil.toCompatibleJSONString(wxPurchaseOrderService.getOnePurchaseOrderVO(pd));
	 }
	 
	 /**
	  * 
	 * @Title: menuListPurchaseCheckingOrder 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购对账单列表
	  */
	 @RequestMapping(value = "menu/listPurchaseCheckingOrder")
	 @ResponseBody
	 public String menuListPurchaseCheckingOrder(HttpServletRequest request) throws Exception{
		 	UserVo userVo = getWxCurrentUserVo();
		 	Page page = new Page();
	    	String pageSize = request.getParameter("pageSize");
	        String pageNo = request.getParameter("pageNo");
	        page.setShowCount(Integer.parseInt(pageSize));
	        page.setCurrentPage(Integer.parseInt(pageNo));
	        PageData pd = new PageData();
	        pd.put("purchasecheckingNo", request.getParameter("purchasecheckingNo"));
	        
	        String orderStatus = request.getParameter("orderStatus");
	        String orderStatusIn = StringUtil.isNotEmpty(orderStatus)?(orderStatus.length()==1?StringUtil.fillZero(orderStatus, 1):orderStatus):orderStatus;
	        pd.put("orderStatusIN", Tools.strSqlIn(orderStatusIn));
	        pd.put("comKey",userVo.getComKey());
//	        pd.put("isSynchro", request.getParameter("isSynchro"));
	        page.setPd(pd);
	        HashMap<String,Object> jsonMap = new HashMap<String, Object>();
	        jsonMap.put("orders", wxPurchaseOrderService.listPagePurchaseCheckingOrder(page));
	        jsonMap.put("pageCount", page.getTotalResult());
	        return JsonUtil.toCompatibleJSONString(jsonMap);
	 }
	 
	 /**
	  * 
	 * @Title: menuPurchaseCheckingOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 查询采购对账单明细
	  */
	 @RequestMapping(value = "menu/purchaseCheckingOrderVo")
	 @ResponseBody
	 public String menuPurchaseCheckingOrderVO(HttpServletRequest request) throws Exception{
		 	PageData pd = this.getPageData();
		 	pd.put("purchasecheckingNo", request.getParameter("purchasecheckingNo"));
		 	return JsonUtil.toCompatibleJSONString(wxPurchaseOrderService.getOnePurchaseCheckingOrderVO(pd));
	 }
	 
	 /**
	  * 
	 * @Title: notifyPurchaseCheckingOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 微信消息查询采购对账单详情
	  */
	 @RequestMapping(value = "notify/purchaseCheckingOrderVo")
	 @ResponseBody
	 public String notifyPurchaseCheckingOrderVO(HttpServletRequest request) throws Exception{
		 	PageData pd = new PageData();
		 	pd.put("purchasecheckingNo", request.getParameter("purchasecheckingNo"));
		 	return JsonUtil.toCompatibleJSONString(wxPurchaseOrderService.getOnePurchaseCheckingOrderVO(pd));
	 }
	 
	 
	 /**
	  * 
	 * @Title: updatePurchaseOrder 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 协同采购订单收货
	  */
	 @RequestMapping(value = "purchase/delivery")
	 @ResponseBody
	 public String delivery(HttpServletRequest request){
		 int result = 0;
	        try {
				PageData pd = this.getPageData();
				if (StringUtil.isEmpty(pd.getString("purchaseNo"))) {
					return JsonUtil.toCompatibleJSONString(ResultUtil.error("微信收货失败"));
				}
				result = wxPurchaseOrderService.updateDelivery(pd);
			} catch (Exception e) {
				logger.error(e.getMessage());
				throw new WechatException("微信收货失败");
			}
	        if (result<=0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("微信收货失败"));
			}else {
				return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("微信收货成功"));
			}
	 }
}
