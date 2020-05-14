package com.ydz.controller.system.order;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.SalesOrderVO;
import com.ydz.vo.TaxPointVo;
import com.ydz.vo.TotalSalesOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/**
 * * ┏┓　　　┏┓
 * ┏┛┻━━━┛┻┓
 * ┃　　　　　　　┃
 * ┃　　　━　　　┃
 * ┃　┳┛　┗┳　┃
 * ┃　　　　　　　┃
 * ┃　　　┻　　　┃
 * ┃　　　　　　　┃
 * ┗━┓　　　┏━┛
 *    ┃　　　┃   神兽保佑
 *    ┃　　　┃   代码无BUG！
 *    ┃　　　┗━━━┓
 *    ┃　　　　　　　┣┓
 *    ┃　　　　　　　┏┛
 *    ┗┓┓┏━┳┓┏┛
 *    ┃┫┫　┃┫┫
 *    ┗┻┛　┗┻┛
 * Created by ydz on 2016/8/4.
 */
@Controller
@RequestMapping(value = "ydz/salesorder", produces = "plain/text; charset=UTF-8")
public class SalesOrderController extends BaseController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource
	private SalesOrderService salesOrderService;
	@Resource
	private PartnerService partnerService;
	@Resource
	private EmployeeService employeeService;
	@Resource
	private CompanyService companyService;
	@Resource
	private PurchaseOrderService purchaseOrderService;
	@Resource
	private CommonService commonService;

    /**
     * 查询合作伙伴(客户)
     *
     * @return
     */
    @RequestMapping(value = "partner")
    @ResponseBody
    public String findListPartnerVO(HttpServletRequest request, String orderStatus) {
        UserVo userVo = getSessionUservo();
        PageData pageData = this.getPageData();
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode()); //客户
        if(orderStatus != null && !"01".equals(orderStatus)){
//            pageData.put("notFriend","true");
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
     * 查询联系人
     *
     * @return
     */
//    @RequestMapping(value = "listContacter")
//    @ResponseBody
//    public String listPartnerContacter(String partnerKey) {
//        PageData pageData = new PageData();
//        //
//        pageData.put("partnerKey", partnerKey);
//        try {
//            List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pageData);
//            return JsonUtil.toCompatibleJSONString(partnerContacters);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "0";
//        }
//
//    }

    /**
     * 查询销售代表
     *
     * @return
     */
    @RequestMapping(value = "listSalesMan")
    @ResponseBody
    public String listSalesMan() throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pageData = new PageData();
        pageData.put("comKey", userVo.getComKey());
//        pageData.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
//        List<SalesMan> salesMens = employeeService.getList4order(pageData);
        List<Employee> employees = employeeService.getAllEmployeesForDropdown(pageData);
        return JsonUtil.toCompatibleJSONString(employees);
    }
    
    /**
     * 
     * @Title: getDefaultSaleMan 
     * @return
     * @return String
     * @throws 
     * @Description: 默认销售代表是公司的管理员
     */
    @RequestMapping(value = "getDefaultSalesMan")
    @ResponseBody
    public String getDefaultSaleMan(){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = new PageData();
    	pd.put("comKey", userVo.getComKey());
    	Employee employee = employeeService.getAdminEmployee(pd);
    	return JsonUtil.toCompatibleJSONString(employee);
    }


    /**
     * 新建订单
     *
     * @param items
     * @return
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public String saveOrders(@RequestBody SalesOrderVO items) throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("userKey", userVo.getUserKey());
        pd.put("industryId",userVo.getDetailIndustryId());
        Map<String,Object> resultMap = salesOrderService.saveOrderandOrderDetail(items, pd);;
        
        return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 现金订单。创建订单并收款
     * @param items
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "saveCash")
    @ResponseBody
    public String saveCash(@RequestBody SalesOrderVO items) throws Exception {
        UserVo userVo = getSessionUservo();
        if(items==null){
        	return "0";
        }
        Map<String,Object> resultMap = salesOrderService.saveCashOrder(items,userVo);;
        return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 保存订单草稿
     * @param items
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "saveDraft")
    @ResponseBody
    public String saveDraft(@RequestBody SalesOrderVO items) throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("userKey", userVo.getUserKey());
        pd.put("industryId",userVo.getDetailIndustryId());
        Map<String,Object> resultMap = salesOrderService.saveDraftOrder(items,pd);
        return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 
     * @Title: submitUpdateOrders 
     * @param items
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 提交为待对账订单
     * 1.订单修改后保存     04待对账——>04待对账
     * 2.草稿箱订单创建提交  01草稿箱——>04待对账
     */
    @RequestMapping(value = "submitUpdate")
    @ResponseBody
    public String submitUpdateOrders(@RequestBody SalesOrderVO items) throws Exception {
    	UserVo userVo = getSessionUservo();
    	Map<String,Object> resultMap = salesOrderService.updateOrderAndOrderDetail(items,userVo,OrderEnum.STATUS_DAIDUIZHANG.getCode());
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 修改订单(作为草稿箱状态)
     * 草稿箱中的订单继续保存到草稿箱
     *
     * @param items
     * @return
     */
    @RequestMapping(value = "updateAsDraft")
    @ResponseBody
    public String updateOrdersAsDraft(@RequestBody SalesOrderVO items) throws Exception {
        UserVo userVo = getSessionUservo();
        Map<String,Object> resultMap = salesOrderService.updateOrderAndOrderDetailAsDraft(items,userVo);
        return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 修改订单(作为现金订单)
     * 草稿箱中的订单直接提交为现金订单
     *
     * @param items
     * @return
     */
    @RequestMapping(value = "updateAsCash")
    @ResponseBody
    public String updateAsCash(@RequestBody SalesOrderVO items) throws Exception {
        UserVo userVo = getSessionUservo();
        Map<String,Object> resultMap = salesOrderService.updateOrderAndOrderDetailAsCash(items,userVo);
        return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 跳转销售订单详情页面
     *
     * @return
     */
    @RequestMapping(value = "salesOrderDetail")
    public ModelAndView forwardSalesOrderDetail(String salesNo) {
        return new ModelAndView("jsp/advert/sales-order-detail").addObject("salesNo", salesNo);
    }



    /**
     * 销售订单详情表单数据
     *
     * @param request
     * @param salesNo
     * @return
     */
    @RequestMapping(value = "salesOrderDetailData")
    @ResponseBody
    public String salesOrderDetailData(HttpServletRequest request, String salesNo) {
    	UserVo userVo = getSessionUservo();
       
        try {
        	PageData pageData = new PageData();
        	 pageData.put("salesNo", salesNo);
             pageData.put("comKey", userVo.getComKey());
        	 SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pageData); //查询单条销售订单记录
        	salesOrder.setComName(userVo.getComName());
            Page page = new Page();
            page.setShowCount(300);
            page.setCurrentPage(1);
            page.setPd(pageData);
            List<SalesOrderDetail> salesOrderDetails = salesOrderService.listPageSalesOrderDetail(page); //查询销售订单明细记录
            CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),salesOrder.getPartnerKey()); //详情页底部信息
            Map<String,Object> objectMap = new HashMap<>();
            objectMap.put("saleOrder",salesOrder);
            objectMap.put("orders",salesOrderDetails);
            objectMap.put("bottomComInfo", companyVO);
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
	 * @throws 
	 * @Description: 获取分享短地址连接
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("shareUrl")
	@ResponseBody
	public String getShareUrl(String orderNo){
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("salesNo", orderNo);
		SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
		if (salesOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此订单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/sales-order-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, salesOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}

    /**
     * 销售订单详情中 对应订单的数据
     *
     * @param salesNo
     * @return
     */
    @RequestMapping(value = "saleOrderOne")
    @ResponseBody
    public String saleOrderOne(String salesNo) {
        UserVo userVo = getSessionUservo();
        PageData pageData = new PageData();
        pageData.put("salesNo", salesNo);
        pageData.put("comKey", userVo.getComKey());
        try {
            SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pageData);
            return JsonUtil.toCompatibleJSONString(salesOrder);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * 带分页的销售订单查询
     *
     * @param request
     * @param
     * @param
     * @return
     */
    @RequestMapping(value = "listPageSalesOrder")
    @ResponseBody
    public String listPageSalesOrder(HttpServletRequest request) {
        UserVo userVo = getSessionUservo();
        Page page = this.getPageWithParameter();
        PageData pd = this.getPageData();
        
        if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(pd.getString("orderStatus"))
        		&&StringUtil.isNotEmpty(pd.getString("partnerKey"))
        		&&!"ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	page.setShowCount(10000);
        }

        pd.put("comKey", userVo.getComKey());
        
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (StringUtil.isEmpty(pd.getString("isDel"))) {
			pd.put("isDel", "0");
		}
        if (StringUtil.isEmpty(pd.getString("contacterId"))) {
			pd.put("contacterId", null);
		 }
        if (StringUtil.isEmpty(pd.getString("orderStatus"))) {
			pd.put("orderStatusNoCancel", "1");
		}
        page.setPd(pd);
        if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(pd.getString("orderStatus"))
         		&&StringUtil.isNotEmpty(pd.getString("partnerKey"))
         		&&!"ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
         	page.setShowCount(10000);
         }
        try {
            List<SalesOrder> salesOrders = salesOrderService.listPageSalesOrderConcat(page);
            ResultMap resultMap = ResultUtil.getResultMap();
            resultMap.setRows(salesOrders);
            resultMap.setTotalCount(page.getTotalResult());
            return JsonUtil.toCompatibleJSONString(resultMap);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    @RequestMapping(value = "listPageTotalDetailByOrder")
    @ResponseBody
    public String listPageTotalDetailByOrder(HttpServletRequest request) 
    		throws Exception {
    	 UserVo userVo = getSessionUservo();
         PageData pd = this.getPageData();
         pd.put("comKey", userVo.getComKey());
         
         pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
         pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
         if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
         	pd.put("partnerKey", null);
         }
         if (StringUtil.isEmpty(pd.getString("isDel"))) {
 			pd.put("isDel", "0");
 		}
        if (StringUtil.isEmpty(pd.getString("orderStatus"))) {
			pd.put("orderStatusNoCancel", "1");
		}
         Page page = getPageWithParameter();
         page.setPd(pd);
         if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(pd.getString("orderStatus"))
         		&&StringUtil.isNotEmpty(pd.getString("partnerKey"))
         		&&!"ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
         	page.setShowCount(10000);
         }
         if (StringUtil.isEmpty(pd.getString("contacterId"))) {
			pd.put("contacterId", null);
		 }
         List<TotalSalesOrderDetailVO> totalSalesOrderDetailVOs = salesOrderService.listPageTotalDetailByOrder(page);
         OrderTotalVO orderTotalVO = null;
         List<String> salesNoList = salesOrderService.getSalesOrderNos(pd);
         if (salesNoList!=null&&salesNoList.size()>0) {
        	 pd.put("salesNoList", salesNoList);
        	 orderTotalVO = salesOrderService.getSumTotalVO(pd, OrderEnum.TYPE_SALESORDER.getCode());
			
		}
         
         Map<String, Object> mapPage = ResultUtil.getResultMap();
         mapPage.put("total", page.getTotalResult());
         mapPage.put("rows", totalSalesOrderDetailVOs);
         mapPage.put("bottomInfo", orderTotalVO);
         if(totalSalesOrderDetailVOs==null){
             mapPage.put("rows",new String[0]);
         }
         return JsonUtil.toCompatibleJSONString(mapPage);
    }
    /**
     * 跳转修改页面
     *
     * @return
     */
    @RequestMapping(value = "updatePage")
    public ModelAndView toUpdatePage(String salesNo) {
    	UserVo userVo = getSessionUservo();
    	String industryId = userVo.getDetailIndustryId();
        if(salesNo == null 
        		|| industryId == null){
            return new ModelAndView("error");
        }
        String pathString = "jsp/advert/sales-order-update";
        
        return new ModelAndView(pathString).addObject("salesNo",salesNo);
    }

    /**
     * 修改页面的详情数据(订单信息和订单详情列表)
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "orderAndDetails")
    @ResponseBody
    public String orderAndDetails(String salesNo) throws Exception {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("industryId", userVo.getDetailIndustryId());
        pd.put("comKey", userVo.getComKey());
        pd.put("salesNo", salesNo);
        Map<String, Object> objectMap = salesOrderService.getOrderDatasForUpdateOrder(pd);

        return JsonUtil.toCompatibleJSONString(objectMap);
    }

    @RequestMapping(value = "toAdd")
    public ModelAndView toAddPage(HttpServletRequest request) {
        UserVo userVo = getSessionUservo();
        String industryId = userVo.getDetailIndustryId();
        if(industryId == null){
            return new ModelAndView("error");
        }
        ModelAndView modelAndView = new ModelAndView("/jsp/advert/sales-order-add");
        
        return modelAndView;
    }

    /**
     * 
     * @Title: generateBill 
     * @param taxPointVo
     * @param type
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 生成对账单
     * type == 1 时，表示生成对账单并收款操作
     */
    @RequestMapping(value = "generateBill")
    @ResponseBody
    public String generateBill(TaxPointVo taxPointVo,String type,String isSms) throws Exception {
        UserVo userVo = getSessionUservo();
        Map<String,Object> callBack = new HashMap<>();
        JSONArray jsonArray = JSON.parseArray(taxPointVo.getSalesNos());
        if(jsonArray == null){
            callBack.put("status","0");
            callBack.put("msg","请选择需要对账的订单");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
        Integer salesNum = jsonArray.size();

        if(salesNum > 0){
            //多笔订单
             callBack = salesOrderService.saveManyReconciliation(taxPointVo,userVo,jsonArray,type,isSms);
            return JsonUtil.toCompatibleJSONString(callBack);
        }else{
            callBack.put("status","0");
            callBack.put("msg","请选择需要对账的订单");
            return JsonUtil.toCompatibleJSONString(callBack);
        }
    }
    
    /**
     * 
     * @Title: deleteSalesOrder 
     * @param salesNo
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 删除销售订单和明细
     * 1. 只能删除草稿箱和待对账的订单
     * 2. 只能删除单向订单
     * 3. 删除之前需要判断订单状态是否变更
     * 4. 2017-07-06 10:57:01 修改业务，允许删除协同采购订单
     */
    @RequestMapping(value = "deleteSalesOrder")
    @ResponseBody
    public String deleteSalesOrder(String salesNo) throws Exception{
    	Map<String,Object> callBack = new HashMap<>();
    	if (StringUtil.isEmpty(salesNo)) {
    		callBack.put("status","0");
            callBack.put("msg","请选择需要删除的订单");
            return JsonUtil.toCompatibleJSONString(callBack);
		}
    	UserVo userVo = getSessionUservo();
    	String comKey = userVo.getComKey();
    	PageData pd = this.getPageData();
    	pd.put("comKey", comKey);
    	pd.put("salesNo", salesNo);
    	SalesOrder order = salesOrderService.selectOneSalesOrder(pd);
    	if(order == null){
    		callBack.put("status","0");
        	callBack.put("msg","订单不存在");
        	return JsonUtil.toCompatibleJSONString(callBack);
    	}
//    	if(StringUtil.isNotEmpty(order.getPurchaseNo())){
//    		callBack.put("status","0");
//    		callBack.put("msg","只能删除非协同销售订单");
//    		return JsonUtil.toCompatibleJSONString(callBack);
//    	}
    	String orderStatus = order.getOrderStatus();
    	if(!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIJIJIA.getCode())
    			&&!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
    		callBack.put("status","0");
    		callBack.put("msg","只能删除草稿箱或待对账的订单");
    		return JsonUtil.toCompatibleJSONString(callBack);
    	}
        int result = salesOrderService.deleteSalesOrderAndDetails(comKey, salesNo,order.getPurchaseNo());
        if (result>0) {
        	callBack.put("status","1");
        	callBack.put("msg","订单已删除");
		} else {
			callBack.put("status","0");
            callBack.put("msg","删除失败");
		}
        return JsonUtil.toCompatibleJSONString(callBack);
    }
    
    /**
     * 
     * @Title: cancelSalesOrder 
     * @param salesNo
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 作废销售订单
     * 销售只能针对“待对账订单”、“待提交订单“
     */
    @RequestMapping(value = "cancelSalesOrder")
    @ResponseBody
    public String cancelSalesOrder(String salesNo) throws Exception{
    	if (StringUtil.isEmpty(salesNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "请选择需要作废的销售单"));
		}
    	PageData pd = this.getPageData();
    	pd.put("salesNo", salesNo);
    	SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
    	if (salesOrder == null) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "无法作废订单"));
		}
    	String orderStatus = salesOrder.getOrderStatus();
    	if(!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIJIJIA.getCode())
    			&&!orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "只能作废草稿箱或待对账的订单"));
    	}
    	ResultMap resultMap = ResultUtil.getResultMap();
    	pd.put("changedTime", new Date());
    	pd.put("orderStatus", OrderEnum.STATUS_CANCEL.getCode());
    	if (StringUtil.isNotEmpty(salesOrder.getPurchaseNo())) {
    		pd.put("purchaseOrderNoIn", Tools.strArray2List(Tools.StrList(salesOrder.getPurchaseNo())));
		}
    	pd.put("salesOrderNoIn", Tools.strArray2List(Tools.StrList(salesNo)));
    	int result = salesOrderService.cancelSalesOrder(pd);
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
     * @Title: synchroSingleSalesOrder 
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 跳转至同步好友前单向销售订单
     */
    @RequestMapping(value = "forward-synchroSingleSalesOrder")
    public ModelAndView synchroSingleSalesOrder(){
    	return new ModelAndView("jsp/advert/synchro-sales-order");
    }
    
    
    /**
     * 
     * @Title: synchroSalesOrder 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 同步好友前的单向销售订单生成协同采购单
     */
    @RequestMapping(value = "synchroSingleSalesOrder")
    @ResponseBody
    public String synchroSingleSalesOrder(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	String salesNoIns = pd.getString("salesNos"); 
    	if (StringUtil.isEmpty(salesNoIns)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "请选择需要同步的销售订单"));
		}
    	
    	salesOrderService.insertBatchSynchroPurchaseOrderForSingleSalesOrder(salesNoIns);
    	
    	return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
    }
   
    @RequestMapping(value = "workingAssignTask")
    @ResponseBody
    public String workingAssignTask(@RequestBody List<SalesOrderDetail> items) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	if (!"1C".equalsIgnoreCase(userVo.getDetailIndustryId())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(0, "暂不支持制作派工业务"));
		}
    	if (items==null
    			||items.size()<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(0, "派工失败"));
		}
    	PageData pd = this.getPageData();
    	String salesNo = items.get(0).getSalesNo();
		pd.put("salesNo", salesNo);
		SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
    	salesOrderService.insertWorkingAssignTask(salesOrder, items);
    	
    	//如果有协同单则同步修改协同明细的加急
    	if (StringUtil.isNotEmpty(salesOrder.getPurchaseNo())) {
			pd.clear();
			pd.put("purchaseNo", salesOrder.getPurchaseNo());
			for (SalesOrderDetail salesOrderDetail : items) {
				pd.put("isUrgent", salesOrderDetail.getIsUrgent());
				pd.put("itemNo", salesOrderDetail.getItemNo());
				purchaseOrderService.updatePurchaseOrderDetailByMapPara(pd);
			}
		}
    	
    	return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("已完成派工"));
    }
    
    @RequestMapping(value = "toCreatePurchaseOrder")
    public ModelAndView toCreatePurchaseOrder(String salesNo){
    	String pathString = "jsp/advert/purchase-order-update";
        return new ModelAndView(pathString).addObject("salesNo",salesNo);
    }
    
    @RequestMapping(value = "forward-towithPurchaseOrderDetail")
    public ModelAndView towithPurchaseOrderDetail(String salesNo){
    	ModelAndView forwardView = new ModelAndView();
    	if (StringUtil.isEmpty(salesNo)) {
			return new ModelAndView("404");
		}
    	PageData pd = this.getPageData();
    	SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
    	BigDecimal totalPriceSales = salesOrder.getTotalPrice();
    	
    	pd.put("salesNo", null);
    	pd.put("fromSalesNo", salesNo);
    	String pathString = "jsp/advert/salesorder-with-purchaseorder-detail";
    	List<PurchaseOrder> purchaseOrders = purchaseOrderService.listPurchaseOrderBySalesNos(pd);
    	List<String> purchaseNoList = new ArrayList<>();
    	BigDecimal totalPricePurchase = BigDecimal.ZERO;
    	for (PurchaseOrder purchaseOrder : purchaseOrders) {
			purchaseNoList.add(purchaseOrder.getPurchaseNo());
			totalPricePurchase = totalPricePurchase.add(purchaseOrder.getTotalPrice());
		}
    	forwardView.setViewName(pathString);
    	forwardView.addObject("salesNo",salesNo);
    	forwardView.addObject("purchaseNo",Tools.list2InString(purchaseNoList));
    	forwardView.addObject("totalPriceSales",totalPriceSales);
    	forwardView.addObject("totalPricePurchase",totalPricePurchase);
    	forwardView.addObject("profitPrice",totalPriceSales.subtract(totalPricePurchase).setScale(2, BigDecimal.ROUND_HALF_UP));
    	return forwardView;
    }
    
    @RequestMapping(value = "validOrderCount")
    @ResponseBody
    public String validOrderCount() throws Exception{
    	PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
	    
        Map<String,Object> resultMap = null;
        if (RentalTradeEnum.PERIOD_TRIAL.getCode().equals(userVo.getPayStatus())) {
        	pd.put("comKey", userVo.getComKey());
        	resultMap = salesOrderService.validOrderCount(pd);
        	return JsonUtil.toCompatibleJSONString(resultMap);
        }else{
        	return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}
    }

}
