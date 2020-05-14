package com.ydz.app.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.AppSalesOrderService;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.SalesOrderVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppSalesOrderController 
 * @Description: app的销售订单控制器，包括销售对账单的处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:49:44 
 * 
 */
@RestController
@RequestMapping(value = "app/sales", produces = "application/json;charset=UTF-8")
public class AppSalesOrderController extends BaseController{
	@Autowired
	private AppSalesOrderService appSalesOrderService;
	@Autowired
	private SalesOrderService salesOrderService;
	
//=====销售订单
	
	/**
	 * 
	* @Title: listSalesOrder 
	* @param request
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 销售订单列表查询
	 */
	@RequestMapping(value = "listSalesOrder", method = RequestMethod.POST)
	public String listSalesOrder(HttpServletRequest request) throws Exception{
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
        resultMap.setData(appSalesOrderService.listPageSalesOrder(page));
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.setPageCount(page.getTotalPage());
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: getSalesOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 销售订单查看明细
	 */
	@RequestMapping(value = "salesOrderVo", method = RequestMethod.POST)
	public String getSalesOrderVO(HttpServletRequest request) throws Exception{
        return JsonUtil.toCompatibleJSONString(appSalesOrderService.getOneSalesOrderVO(this.getPageData()));
	}
	
	
//=====销售对账单
	
	/**
	 * 
	 * @Title: listSalesCheckingOrder 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 销售对账单列表查询
	 */
	@RequestMapping(value = "listSalesCheckingOrder", method = RequestMethod.POST)
	public String listSalesCheckingOrder(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getAppCurrentUserVo();
		
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
	 	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))
				||StringUtil.isEmpty(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
		String orderStatus = request.getParameter("orderStatus");
		String orderStatusIn = StringUtil.isNotEmpty(orderStatus)?(orderStatus.length()==1?StringUtil.fillZero(orderStatus, 1):orderStatus):orderStatus;
		pd.put("orderStatusIN", Tools.strSqlIn(orderStatusIn));
		pd.put("comKey",userVo.getComKey());
		page.setPd(pd);
		
		ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setData(appSalesOrderService.listPageCheckingOrder(page));
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.setPageCount(page.getTotalPage());
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: getSalesCheckingOrderVO 
	 * @param request
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 销售对账单明细查看
	 */
	@RequestMapping(value = "salesCheckingOrderVo", method = RequestMethod.POST)
	public String getSalesCheckingOrderVO() throws Exception{
		return JsonUtil.toCompatibleJSONString(appSalesOrderService.getOneSalesCheckingOrderVO(this.getPageData()));
	}
	
	//新建销售订单 草稿箱
	@RequestMapping(value = "newSalesOrderVO", method = RequestMethod.POST)
	public String newSalesOrderVO(@RequestBody SalesOrderVO  salesOrderVO) throws Exception{
		if (salesOrderVO == null || salesOrderVO.getSalesOrder() == null
				|| salesOrderVO.getDetails() == null
				|| salesOrderVO.getDetails().size() <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建销售单失败"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd  = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("industryId", userVo.getDetailIndustryId());
		pd.put("userKey", userVo.getUserKey());
		Map resultMap = salesOrderService.saveDraftOrder(salesOrderVO, pd);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
		
	}
	//修改销售订单
	@RequestMapping(value = "updateSalesOrderVO", method = RequestMethod.POST)
	public String updateSalesOrderVO(@RequestBody SalesOrderVO salesOrderVO) throws Exception{
		if (salesOrderVO == null || salesOrderVO.getSalesOrder() == null
				|| salesOrderVO.getDetails() == null
				|| salesOrderVO.getDetails().size() <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改销售单失败"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		Map<String,Object> resultMap = salesOrderService.updateOrderAndOrderDetailAsDraft(salesOrderVO,userVo);
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	
}
