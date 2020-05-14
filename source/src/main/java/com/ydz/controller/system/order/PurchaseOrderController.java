package com.ydz.controller.system.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.mysql.fabric.xmlrpc.base.Array;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.advert.SalesMan;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.EncryptUtils;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.PurchaseOrderVO;
import com.ydz.vo.TaxPointVo;
import com.ydz.vo.TotalPurchaseOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: PurchaseOrderController 
 * @Description: 采购订单控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月15日 下午5:45:12 
 * 
 */
@Controller
@RequestMapping(value = "ydz/purchaseorder", produces = "plain/text; charset=UTF-8")
public class PurchaseOrderController  extends BaseController{
	
	@Resource private CommonService commonService;
	@Resource private PurchaseOrderService purchaseOrderService;
	@Resource private CompanyService companyService;
	
	@Resource private PartnerService partnerService;
	
	@Resource private EmployeeService employeeService;
	
	
	/**
	 * 
	 * @Title: findListPartnerVO 
	 * @param request
	 * @param orderStatus
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 下拉框获取供应商列表
	 */
    @RequestMapping(value = "supplier")
    @ResponseBody
    public String findListPartnerVO(HttpServletRequest request, String orderStatus) {
        UserVo userVo = getSessionUservo();
        PageData pageData = this.getPageData();
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode()); //供应商
        if(orderStatus != null && !"01".equals(orderStatus)){
            pageData.put("notFriend",null);
        }
        try {
            List<PartnerVO> partnerVOs = partnerService.partnerVOList(pageData);
            return JSONArray.toJSONString(partnerVOs);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    /**
     * 
     * @Title: listPartnerContacter 
     * @param partnerKey
     * @return
     * @return String
     * @throws 
     * @Description: 查询供应商的联系人
     */
//    @RequestMapping(value = "listContacter")
//    @ResponseBody
//    public String listPartnerContacter(String partnerKey) {
//        PageData pageData = new PageData();
//        pageData.put("partnerKey", partnerKey);
//        try {
//            List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pageData);
//            return JsonUtil.toCompatibleJSONString(partnerContacters);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "0";
//        }
//    }
    
    /**
     * 
     * @Title: listPurchaseMen 
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 查询采购商的员工列表作为操作人
     */
    @RequestMapping(value = "listPurchaseMen")
    @ResponseBody
    public String listPurchaseMen() throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pageData = new PageData();
        pageData.put("comKey", userVo.getComKey());
//        pageData.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
//        List<SalesMan> salesMens = employeeService.getList4order(pageData);
        List<Employee> employees = employeeService.getAllEmployeesForDropdown(pageData);
        return JsonUtil.toCompatibleJSONString(employees);
    }
	
	@RequestMapping(value = "toAdd")
    public ModelAndView toAddPage(HttpServletRequest request) {
        UserVo userVo = getSessionUservo();
        String industryId = userVo.getDetailIndustryId();
        if(industryId == null){
            return new ModelAndView("error");
        }
        ModelAndView modelAndView = new ModelAndView("/jsp/advert/purchase-order-add");
        
        
        return modelAndView;
    }
	
	/**
	 * 
	 * @Title: addPurchaseOrder 
	 * @param items
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 新建采购订单
	 */
	@RequestMapping(value = "addOrder")
	@ResponseBody
	public String addOrder(@RequestBody PurchaseOrderVO items) throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = new PageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("userKey", userVo.getUserKey());
        pd.put("industryId",userVo.getDetailIndustryId());
        pd.put("userName", userVo.getRealName());
        Map<String,Object> resultMap = purchaseOrderService.saveOrderAndOrderDetail(items, pd);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	/**
	 * 
	 * @Title: addAndPaymentPurchaseOrder 
	 * @param items
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 创建采购订单并付款
	 */
	@RequestMapping(value = "addAndPayment")
	@ResponseBody
	public String addAndPaymentPurchaseOrder(@RequestBody PurchaseOrderVO items) throws Exception{
		UserVo userVo = getSessionUservo();
        if(items==null){
        	return "0";
        }
        Map<String,Object> resultMap = purchaseOrderService.savePaymentOrder(items, userVo);
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: modifyOrder 
	 * @param items
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 修改采购订单
	 */
	@RequestMapping(value = "modifyOrder")
	@ResponseBody
	public String modifyOrder(@RequestBody PurchaseOrderVO items){
		return null;
	}
	
	/**
	 * 
	 * @Title: generateBill 
	 * @param taxPointVo
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 生成采购对账单
	 */
	@RequestMapping(value = "generateBill")
    @ResponseBody
    public String generateBill(TaxPointVo taxPointVo) throws Exception {
		UserVo userVo = this.getSessionUservo();
        Map<String,Object> resultmMap = new HashMap<>();
        JSONArray jsonArray = JSON.parseArray(taxPointVo.getPurchaseNos());
        if(jsonArray == null){
        	resultmMap.put("status","0");
        	resultmMap.put("msg","请选择需要对账的订单");
            return JsonUtil.toCompatibleJSONString(resultmMap);
        }
        int purchaseNum = jsonArray.size();

        if(purchaseNum > 0){
            //多笔采购订单生成一笔对账单
        	resultmMap = purchaseOrderService.saveManyCheckingOrder(taxPointVo,userVo,jsonArray);
            return JsonUtil.toCompatibleJSONString(resultmMap);
        }else{
        	resultmMap.put("status","0");
        	resultmMap.put("msg","请选择需要对账的订单");
            return JsonUtil.toCompatibleJSONString(resultmMap);
        }
	}
	
	/**
	 * 
	 * @Title: salesOrderDetail 
	 * @param salesNo
	 * @return
	 * @return ModelAndView
	 * @throws 
	 * @Description: 跳转协同采购订单详情页面
	 */
    @RequestMapping(value = "detail")
    public ModelAndView purchaseOrderDetail(String purchaseNo) {
        return new ModelAndView("jsp/advert/purchase-order-detail").addObject("purchaseNo", purchaseNo);
    }
    
    /**
     * 
    * @Title: salesOrderDetailData 
    * @param orderNo
    * @return
    * @return String
    * @throws 
    * @Description: 采购订单明细数据
     */
    @RequestMapping(value = "orderDetailData")
    @ResponseBody
    public String purchaseOrderDetailData(String orderNo) {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("purchaseNo", orderNo);
        try {
            //协同采购订单
            PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pd);
            purchaseOrder.setComName(userVo.getComName());
            //协同采购订单明细
            List<PurchaseOrderDetail> orders = purchaseOrderService.selectListByPrimaryKey(pd);
            //协同采购订单详情底部数据
            CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),purchaseOrder.getPartnerKey());
            Map<String,Object> objectMap = new HashMap<>();
            objectMap.put("purchaseOrder",purchaseOrder);
            objectMap.put("orders",orders);
            objectMap.put("bottomComInfo", companyVO);
            String orderUrl = "/ordershare/purchase-order-detail-share.html";
            objectMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, userVo.getDetailIndustryId(), orderNo, userVo.getComKey()));
            return JsonUtil.toCompatibleJSONString(objectMap);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    /**
	 * 
	 * @Title: getShareUrl 
	 * @param orderNo
	 * @return
	 * @return String
     * @throws Exception 
	 * @throws 
	 * @Description: 获取分享短地址连接
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("shareUrl")
	@ResponseBody
	public String getShareUrl(String orderNo) throws Exception{
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("purchaseNo", orderNo);
		PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pd);
		if (purchaseOrder==null) {
			JsonUtil.toCompatibleJSONString(ResultUtil.error("无此订单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/purchase-order-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, userVo.getDetailIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}

    /**
     * 
     * @Title: listPagePurchaseOrder 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 采购订单分页查询
     */
    @RequestMapping(value = "listPagePurchaseOrder")
    @ResponseBody
    public String listPagePurchaseOrder(HttpServletRequest request) throws Exception{
        UserVo userVo = getSessionUservo();
        Page page = this.getPageWithParameter();
        ResultMap resultMap = ResultUtil.getResultMap();
        PageData pd = this.getPageData();
        
        if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(pd.getString("orderStatus"))
        		&&StringUtil.isNotEmpty(pd.getString("partnerKey"))
        		&&!"ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	page.setShowCount(10000);
        }
        pd.put("comKey",userVo.getComKey());
        
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (StringUtil.isEmpty(pd.getString("orderStatus"))) {
			pd.put("orderStatusNoCancel", "1");
		}
        page.setPd(pd);
        
        List<PurchaseOrder> purchaseOrderList = purchaseOrderService.getPurchaseOrderNoList(page);
        if (purchaseOrderList==null||purchaseOrderList.size()==0) {
        	resultMap.setRows("");
            resultMap.setTotalCount(0);
            return JsonUtil.toCompatibleJSONString(resultMap);
		}
		List<String> purchaseNoIns = new ArrayList<>();
		for (PurchaseOrder purchaseOrder : purchaseOrderList) {
			purchaseNoIns.add(purchaseOrder.getPurchaseNo());
		}
		pd.put("purchaseNoIns", Tools.strSqlIn(Tools.list2InString(purchaseNoIns)));
		page.setPd(pd);
        List<PurchaseOrder> purchaseOrders = purchaseOrderService.listPagePurchaseOrderConcat(page);
        
        OrderTotalVO orderTotalVO = null;
        if (purchaseNoIns!=null&&purchaseNoIns.size()>0) {
        	pd.put("purchaseNoList", purchaseNoIns);
            orderTotalVO = purchaseOrderService.getSumTotalVO(pd, OrderEnum.TYPE_PURCHASEORDER.getCode());
		}
        resultMap.setRows(purchaseOrders);
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.put("bottomInfo", orderTotalVO);
        
        return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 
     * @Title: listPageTotalPurchaseOrderDetails 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 采购订单分页总查询
     */
    @RequestMapping(value = "listPageTotalPurchaseOrderDetails")
    @ResponseBody
    public String listPageTotalPurchaseOrderDetails(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	Page page = getPageWithParameter();
    	
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
    	
    	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
    	
    	page.setPd(pd);
    	List<TotalPurchaseOrderDetailVO> detailVOs = purchaseOrderService.listPageTotalPurchaseDetail(page);
    	
    	Map<String, Object> mapPage = new HashMap<>();
        mapPage.put("total", page.getTotalResult());
        mapPage.put("rows", detailVOs);

        return JsonUtil.toCompatibleJSONString(mapPage);
    }

   
    
    /**
     * 
     * @Title: toUpdatePage 
     * @param purchaseNo
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 修改采购订单跳转
     */
    @RequestMapping(value = "updatePage")
    public ModelAndView toUpdatePage(String purchaseNo) {
    	UserVo userVo = getSessionUservo();
    	String industryId = userVo.getDetailIndustryId();
        if(purchaseNo == null 
        		|| industryId == null){
            return new ModelAndView("error");
        }
        String pathString = "jsp/advert/purchase-order-update";
        return new ModelAndView(pathString).addObject("purchaseNo",purchaseNo);
    }
    
    /**
     * 修改页面的详情数据(订单信息和订单详情列表)
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "orderAndDetails")
    @ResponseBody
    public String orderAndDetailsForUpdate() throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pd = this.getPageData();
        Map<String, Object> returnMap = null;
        pd.put("industryId", userVo.getDetailIndustryId());
        pd.put("comKey", userVo.getComKey());
        String salesNo = pd.getString("salesNo");
        String purchaseNo = pd.getString("purchaseNo");
        if (StringUtil.isEmpty(salesNo)) {
        	if (StringUtil.isEmpty(purchaseNo)) {
        		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()), "销售单不存在，无法生成采购单"));
			}else{
				returnMap = purchaseOrderService.getOrderDatasForUpdateOrder(pd);
			}
		}else{
			returnMap = new HashMap<>();
	    	PurchaseOrderVO orderVO = purchaseOrderService.createPurchaseOrderFromSalesOrder(salesNo);
	    	returnMap.put("purchaseOrder",orderVO.getPurchaseOrder());
			returnMap.put("purchaseOrderDetail",orderVO.getDetails());
		}
        return JsonUtil.toCompatibleJSONString(returnMap);
    }
    
    /**
     * 
     * @Title: submitUpdateOrders 
     * @param items
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 修改采购订单后提交保存
     */
    @RequestMapping(value = "submitUpdate")
    @ResponseBody
    public String submitUpdateOrders(@RequestBody PurchaseOrderVO orderVO) throws Exception {
    	UserVo userVo = getSessionUservo();
    	Map<String,Object> resultMap = purchaseOrderService.updateOrderAndOrderDetail(orderVO, userVo, OrderEnum.STATUS_DAIDUIZHANG.getCode());
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 
     * @Title: deletePurchaseOrder 
     * @param purchaseNo
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 删除采购订单和明细
     * 1. 只能删除待对账的订单
     * 2. 只能删除单向订单
     * 3. 删除之前需要判断订单状态是否变更
     */
    @RequestMapping(value = "deletePurchaseOrder")
    @ResponseBody
    public String deletePurchaseOrder(String purchaseNo) throws Exception{
    	Map<String,Object> callBack = new HashMap<>();
    	if (StringUtil.isEmpty(purchaseNo)) {
    		callBack.put("status","0");
            callBack.put("msg","请选择需要删除的订单");
            return JsonUtil.toCompatibleJSONString(callBack);
		}
    	UserVo userVo = getSessionUservo();
    	String comKey = userVo.getComKey();
    	PageData pd = this.getPageData();
    	pd.put("comKey", comKey);
    	pd.put("purchaseNo", purchaseNo);
    	PurchaseOrder order = purchaseOrderService.selectOnePurchaseOrder(pd);
    	if(order == null){
    		callBack.put("status","0");
        	callBack.put("msg","订单不存在");
        	return JsonUtil.toCompatibleJSONString(callBack);
    	}
    	if(StringUtil.isNotEmpty(order.getSalesNo())){
    		callBack.put("status","0");
    		callBack.put("msg","只能删除非协同采购订单");
    		return JsonUtil.toCompatibleJSONString(callBack);
    	}
    	String orderStatus = order.getOrderStatus();
    	if(!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
    		callBack.put("status","0");
    		callBack.put("msg","只能删除待对账的订单");
    		return JsonUtil.toCompatibleJSONString(callBack);
    	}
        int result = purchaseOrderService.deletePurchaseOrderAndDetails(comKey, purchaseNo);
        if (result>0) {
        	callBack.put("status","1");
        	callBack.put("msg","订单已删除");
		} else {
			callBack.put("status","0");
            callBack.put("msg","删除失败");
		}
        return JsonUtil.toCompatibleJSONString(callBack);
    }
    
    @RequestMapping(value = "cancelPurchaseOrder")
    @ResponseBody
    public String cancelPurchaseOrder(String purchaseNo) throws Exception{
    	if (StringUtil.isEmpty(purchaseNo)) {
            return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "请选择需要作废的采购单"));
		}
    	PageData pd = this.getPageData();
    	pd.put("purchaseNo", purchaseNo);
    	PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pd);
    	if (purchaseOrder == null) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "无法作废订单"));
		}
    	if (StringUtil.isNotEmpty(purchaseOrder.getSalesNo())) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "只能作废非协同的采购订单"));
    	}
    	String orderStatus = purchaseOrder.getOrderStatus();
    	if(!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIJIJIA.getCode())
    			&&!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "只能作废待对账的采购订单"));
    	}
    	ResultMap resultMap = ResultUtil.getResultMap();
    	pd.put("changedTime", new Date());
    	pd.put("orderStatus", OrderEnum.STATUS_CANCEL.getCode());
    	pd.put("purchaseOrderNoIn", Tools.strArray2List(Tools.StrList(purchaseOrder.getPurchaseNo())));
    	int result = purchaseOrderService.cancelPurchaseOrder(pd);
    	if (result>0) {
        	resultMap.setCode(new Integer(SystemEnum.RETURN_INFO_SUCCESS_DELETE.getCode()));
        	resultMap.setMsg("订单已作废");
		} else {
			resultMap.setCode(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()));
        	resultMap.setMsg("订单作废失败");
		}
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 
     * @Title: delivery 
     * @return
     * @return String
     * @throws Exception 
     * @throws 
     * @Description: 协同采购单收货
     */
    @RequestMapping(value = "delivery")
    @ResponseBody
    public String delivery() throws Exception{
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("purchaseNo"))) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error("收货失败"));
		}
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
    	int result = purchaseOrderService.updateDelivery(pd);
    	if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("收货失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("收货完成"));
		}
    }
    
    @RequestMapping(value = "forward-addOrderBySupplier")
	public ModelAndView forwardAddOrderBySupplier() throws Exception {
    	return new ModelAndView("jsp/advert/purchase-order-batch-add").addObject("salesNo", this.getPageData().getString("salesNo"));
	}
    
    /**
     * 
     * @Title: addOrderBySupplier 
     * @param details
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 根据不同供应商批量创建采购单
     */
    @RequestMapping(value = "addOrderBySupplier", method = RequestMethod.POST)
    @ResponseBody
	public String addOrderBySupplier(
			@RequestBody List<PurchaseOrderDetail> details) throws Exception {
    	if (details==null||details.size()<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("创建采购单失败"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("industryId", userVo.getDetailIndustryId());
		pd.put("userKey", userVo.getUserKey());
		int result = purchaseOrderService.insertBatchPurchaseOrderBySuppliers(details, pd);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("创建采购单成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("创建采购单失败"));
		}
    }
}
