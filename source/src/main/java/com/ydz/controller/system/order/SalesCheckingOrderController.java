package com.ydz.controller.system.order;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.CheckingInvoice;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.system.ComPartner;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.EncryptUtils;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.*;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classname SalesCheckingOrderController.java
 * @createTime 2016-08-23 下午4:26
 * @decription 销售对象单Controller
 **/
@Controller
@RequestMapping(value = "ydz/salescheck")
public class SalesCheckingOrderController extends BaseController {
	private Logger logger = Logger.getLogger(this.getClass());
	

    @Resource private SalesOrderService salesOrderService;

    @Resource private CompanyService companyService;
    @Resource private PartnerService partnerService;
    
    @Resource private CommonService commonService;
    @Resource private DZConfig dzConfig;
    

    /**
     * 带分页的销售
     * @return 销售对账单JSON数据
     */
    @RequestMapping(value = "listPageSalesCheckingOrder")
    @ResponseBody
    public String listPageSalesOrder(HttpServletRequest request) {
        UserVo userVo = getSessionUservo();
        Page page = getPageWithParameter();
        PageData pd = this.getPageData();
        
        pd.put("comKey", userVo.getComKey());
        String orderStatus = request.getParameter("parameter");
        // 07未收款 08已收款
        pd.put("orderStatus", orderStatus);
        
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))
        		||"".equals(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (OrderEnum.STATUS_YISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)) {
			pd.put("recPayDateSort", "1"); //08已收款之后按照收款日期倒序
		}else if(StringUtil.isEmpty(orderStatus)
				||OrderEnum.STATUS_DAISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)){
			pd.put("uidSort", "1"); //07未收款按照创建顺序倒序
		}
        if (StringUtil.isEmpty(pd.getString("contacterId"))) {
			pd.put("contacterId", null);
		 }
        page.setPd(pd);
        try {
        	List<AllSalesCheckingOrderVO> orderVOs = salesOrderService.listPageAllSalesCheckingOrderConCat(page);
        	OrderTotalVO orderTotalVO = null;
        	List<String> salescheckingOrderNoList = salesOrderService.getSalescheckingOrderNos(pd);
        	if (salescheckingOrderNoList!=null&&salescheckingOrderNoList.size()>0) {
				pd.put("salescheckingOrderNoList", salescheckingOrderNoList);
				orderTotalVO = salesOrderService.getSumTotalVO(pd, OrderEnum.TYPE_SALESCHECKINGORDER.getCode());
			}
            ResultMap resultMap = ResultUtil.getResultMap();
            resultMap.setTotalCount(page.getTotalResult());
            resultMap.setRows(orderVOs);
            resultMap.put("bottomInfo", orderTotalVO);
            return JsonUtil.toCompatibleJSONString(resultMap);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     *  全部对账单
     * @return
     */
    @RequestMapping(value = "listPageTotalDetail")
    @ResponseBody
    public String listPageTotalDetail(HttpServletRequest request){
        UserVo userVo = this.getSessionUservo();
       Page page = this.getPageWithParameter();
       PageData pd = this.getPageData();
       pd.put("comKey",userVo.getComKey());
       
       String startDate = pd.getString("startTime");
       String endDate = pd.getString("endTime");
       
       if(StringUtil.isNotEmpty(startDate)){
       	if(startDate.length()>=10){
       		startDate = startDate.substring(0, 10)+" 00:00:00";
       	}
       }else{
       	startDate = null;
       }
       if(StringUtil.isNotEmpty(endDate)){
       	if(endDate.length()>=10){
       		endDate = endDate.substring(0, 10)+" 23:59:59";
       	}
       }else{
       	endDate = null;
       }
       pd.put("startDate", startDate);
       pd.put("endDate", endDate);
       
       if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))
       		||"".equals(request.getParameter("partnerKey"))){
       		pd.put("partnerKey", null);
       }
       if (StringUtil.isEmpty(pd.getString("contacterId"))) {
			pd.put("contacterId", null);
	   }
       pd.put("uidSort", "1");
       page.setPd(pd);
       List<AllSalesCheckingOrderVO> orderVOs = salesOrderService.listPageAllSalesCheckingOrderConCat(page);
       ResultMap resultMap = ResultUtil.getResultMap();
       resultMap.setTotalCount(page.getTotalResult());
       resultMap.setRows(orderVOs);
       return JsonUtil.toCompatibleJSONString(resultMap);
    }

    /**
     * 跳转销售对账单详情页面
     *
     * @return 详情页面
     */
    @RequestMapping(value = "salesCheckDetail")
    public ModelAndView forwardSalesOrderDetail(String orderNo) {
        UserVo userVo = getSessionUservo();
        String industryId = userVo.getDetailIndustryId();
        if(orderNo == null 
        		|| industryId == null){
            return new ModelAndView("error");
        }
        String pathString = "jsp/advert/saleschecking-order-detail";
        return new ModelAndView(pathString).addObject("orderNo", orderNo);
    }

   /**
    *
   * @Title: salesOrderDetailData
   * @param orderNo
   * @return
   * @return String
   * @throws
   * @Description: 销售对账单详情页数据，（按销售订单分隔查看）1C专用
    */
    @RequestMapping(value = "salesOrderDetailData")
    @ResponseBody
    public String salesOrderDetailData() {
        UserVo userVo = getSessionUservo();
        PageData pd = this.getPageData();
        pd.put("comKey",userVo.getComKey());
        if (StringUtil.isNotEmpty(pd.getString("orderNo"))) {
        	pd.put("salescheckingNo", pd.getString("orderNo"));
		}
        Page page = null;
       
        List<TotalSalesCheckingOrderDetailVO> salesCheckingOrderDetails = null;
        ResultMap resultMap = ResultUtil.getResultMap();
        try {
             //销售对账单
             SalesCheckingOrder salesCheckingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
             if ("detail".equalsIgnoreCase(pd.getString("type"))) {
            	 page = this.getPageWithParameter();
            	 page.setPd(pd);
            	 //销售对账单明细
            	 salesCheckingOrderDetails = salesOrderService.listPageSalesCheckingOrderDetailVO(page);
            	 resultMap.setTotalCount(page.getTotalResult());
			}else{
				salesCheckingOrderDetails = salesOrderService.listSalesCheckingOrderDetail(pd);
			}
             //详情页底部信息
             CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),salesCheckingOrder.getPartnerKey());

             resultMap.put("salesCheckingOrder",salesCheckingOrder);
             resultMap.put("salesCheckingOrderDetails", salesCheckingOrderDetails);
             resultMap.put("bottomComInfo", companyVO);
             
             return JsonUtil.toCompatibleJSONString(resultMap);
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
		pd.put("salescheckingNo", orderNo);
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此对账单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/saleschecking-order-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, checkingOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: getPayUrltoShare 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 获取对账单分享地址，用于支付
	 */
	@RequestMapping("payUrltoShare")
	@ResponseBody
	public String getPayUrltoShare() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("checkingNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("salescheckingNo", pd.getString("checkingNo"));
		SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此对账单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/saleschecking-order-detail-share.html";
        String payUrltoShare = dzConfig.webPath+orderUrl+"?key1="+EncryptUtils.getInstance().encryptDESByKey
        		(checkingOrder.getIndustryId()+"-"+pd.getString("checkingNo")+"-"+checkingOrder.getComKey())+"&transmit="+pd.getString("transmit");
        resultMap.put("payUrltoShare",payUrltoShare);
        return JsonUtil.toCompatibleJSONString(resultMap);
	}

    /**
     * 开票操作
     * @param checkingInvoice
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "drawBill")
    @ResponseBody
    public String saveBill(CheckingInvoice checkingInvoice) throws Exception {
        UserVo userVo = getSessionUservo();

        Integer result = salesOrderService.saveBill(userVo,checkingInvoice);
        return Integer.toString(result);
    }

    /**
     * 
     * @Title: getComPartnerBalanceMoney 
     * @return
     * @return String
     * @throws 
     * @Description: 收款选择预存款账户时，获取客户的预存款余额，预备进行扣减
     */
    @RequestMapping(value = "getComPartnerBalanceMoney")
    @ResponseBody
    public String getComPartnerBalanceMoney(){
    	PageData pd = this.getPageData();
    	ResultMap resultMap = ResultUtil.getResultMap();
    	if (StringUtil.isEmpty(pd.getString("partnerKey"))) {
    		resultMap.put("balanceMoney", BigDecimal.ZERO);
			return JsonUtil.toCompatibleJSONString(resultMap);
		}
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
        ComPartner comPartner = partnerService.findComPartner(pd);
        if (comPartner!=null) {
        	resultMap.put("balanceMoney", comPartner.getBalanceMoney());
		}else{
			resultMap.put("balanceMoney", BigDecimal.ZERO);
		}
        PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
        resultMap.put("contacter", contacter);
		return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    /**
     * 收款操作
     * @param receiptPayment
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "receivables")
    @ResponseBody
    public String receivables(ReceiptPayment receiptPayment) throws Exception{
        UserVo userVo = getSessionUservo();
        Integer result = salesOrderService.saveReceivables(userVo,receiptPayment);
        return JsonUtil.toCompatibleJSONString(result);
    }
    
    @RequestMapping(value = "cancelreceivable")
    @ResponseBody
    public String cancelRecevables() throws Exception{
    	UserVo userVo = getSessionUservo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	pd.put("salescheckingNo", pd.getString("checkingNo"));
    	SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
    	if (AssignEnum.COMMISSION_SETTLEMENT_YES.getCode()
        		.equalsIgnoreCase(checkingOrder.getIsSettlement())) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error("已分配销售绩效，不能撤销收款"));
		}
    	int result = salesOrderService.deleteReceivables(pd);
    	if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("已撤销收款"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("撤销收款失败"));
		}
    }
    

    /**
     * 
     * @Title: cancelDelCheckingOrder 
     * @param checkingNo
     * @return
     * @return String
     * @throws Exception 
     * @throws 
     * @Description: 撤销删除对账单
     * 1.单向记账订单，撤销后，相关订单需被撤回至“待对账”
     * 2.协同记账订单，撤销后，【协同方】对应对账单也要被撤销，【销售方/协同方】相关订单需被撤回至待对账
     */
    @RequestMapping(value = "cancelDelSalescheckingOrder")
    @ResponseBody
    public String cancelDelCheckingOrder(String checkingNo) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	Map<String, String> result = new HashMap<String, String>();
    	if(StringUtil.isEmpty(checkingNo)){
    		result.put("status", "0");
    		result.put("msg", "请先选中需要删除的对账单");
    	}
    	PageData pd = new PageData();
        pd.put("salescheckingNo", checkingNo);
        pd.put("comKey",userVo.getComKey());
        SalesCheckingOrder salesCheckingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
        String orderStatus = salesCheckingOrder.getOrderStatus();
        if(!OrderEnum.STATUS_DAISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)){
        	result.put("status", "0");
    		result.put("msg", "只能删除待收款对账单");
        }
        result = salesOrderService.cancelDelSalescheckingOrder(salesCheckingOrder, result);
    	result.put("status", "1");
    	result.put("msg", "接口调用成功");
    	return JsonUtil.toCompatibleJSONString(result);
    }
    
    @RequestMapping(value = "getReceivableInfo")
    @ResponseBody
    public String getReceivableInfo(){
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("checkingNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法查询到收款信息"));
		}
    	pd.put("comKey", this.getSessionUservo().getComKey());
    	ReceiptPayment receiptPayment = salesOrderService.getReceiptPaymentInfo(pd);
    	return JsonUtil.toCompatibleJSONString(receiptPayment);
    }
    
    

}