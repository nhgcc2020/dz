/**
 * 
 */
package com.ydz.wechat.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.service.WxSalesOrderService;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WxSalesOrderController 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月24日 下午3:48:43 
 * 
 */
@Controller
@RequestMapping(value = "wx")
public class WxSalesOrderController extends BaseController{
	
	@Resource(name="wxSalesOrderService")
	private WxSalesOrderService wxSalesOrderService;
	
//=====销售订单
	
	/**
	 * 
	* @Title: menuListSalesOrder 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 销售订单列表查询
	 */
	@RequestMapping(value = "menu/listSalesOrder")
	@ResponseBody
	public String menuListSalesOrder(HttpServletRequest request) throws Exception{
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
        page.setPd(pd);
        HashMap<String,Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("orders", wxSalesOrderService.listPageSalesOrder(page));
        jsonMap.put("pageCount", page.getTotalResult());
        return JsonUtil.toCompatibleJSONString(jsonMap);
	}
	
	/**
	 * 
	* @Title: menuSalesOrderVO 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 销售订单查看明细
	 */
	@RequestMapping(value = "menu/SalesOrderVO")
	@ResponseBody
	public String menuSalesOrderVO(HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
        pd.put("salesNo", request.getParameter("salesNo"));
        return JsonUtil.toCompatibleJSONString(wxSalesOrderService.getOneSalesOrderVO(pd));
	}
	
	/**
	 * 
	* @Title: notifySalesOrderVO 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 微信消息订单查看详情
	 */
	@RequestMapping(value = "notify/SalesOrderVO")
	@ResponseBody
	public String notifySalesOrderVO(HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		pd.put("salesNo", request.getParameter("salesNo"));
		return JsonUtil.toCompatibleJSONString(wxSalesOrderService.getOneSalesOrderVO(pd));
	}
	
//=====销售对账单
	
	/**
	 * 
	* @Title: menuListSalesCheckingOrder 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 销售对账单列表查询
	 */
	@RequestMapping(value = "menu/listSalesCheckingOrder")
	@ResponseBody
	public String menuListSalesCheckingOrder(HttpServletRequest request) throws Exception{
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
		page.setPd(pd);
		HashMap<String,Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("orders", wxSalesOrderService.listPageCheckingOrder(page));
		jsonMap.put("pageCount", page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}
	
	/**
	 * 
	* @Title: menuSalesCheckingOrderVO 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 销售对账单明细查看
	 */
	@RequestMapping(value = "menu/SalesCheckingOrderVO")
	@ResponseBody
	public String menuSalesCheckingOrderVO(HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		pd.put("salescheckingNo", request.getParameter("salescheckingNo"));
		return JsonUtil.toCompatibleJSONString(wxSalesOrderService.getOneSalesCheckingOrderVO(pd));
	}
	
	/**
	 * 
	* @Title: notifySalesCheckingOrderVO 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 微信消息查看销售对账单详情
	 */
	@RequestMapping(value = "notify/SalesCheckingOrderVO")
	@ResponseBody
	public String notifySalesCheckingOrderVO(HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		pd.put("salesNo", request.getParameter("salesNo"));
		return JsonUtil.toCompatibleJSONString(wxSalesOrderService.getOneSalesCheckingOrderVO(pd));
	}
}
