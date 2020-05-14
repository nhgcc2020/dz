package com.ydz.controller.system.order;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.AllPurchaseCheckingOrderVO;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.TotalPurchaseCheckingOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame SynchpurchaseCheckController.java
 * @createTime 2016-09-24 下午15:11
 * @decription 采购对账单控制器
 **/

@Controller
@RequestMapping(value = "ydz/purchasechecking", produces = "plain/text; charset=UTF-8")
public class PurchaseCheckingOrderController extends BaseController {

    //采购业务层
    @Resource private PurchaseOrderService purchaseOrderService;
    @Resource private CompanyService companyService;
    @Resource private CommonService commonService;
    
    /**
     * 
     * @Title: listPagePurchaseCheckingOrder 
     * @param request
     * @return
     * @return String
     * @throws 
     * @Description: 分页查询采购对账单
     */
    @RequestMapping(value = "listPagePurchaseCheckingOrder")
    @ResponseBody
    public String listPagePurchaseCheckingOrder(HttpServletRequest request) {
        UserVo userVo = getSessionUservo();
        Page page = getPageWithParameter();
        PageData pd = this.getPageData();
        pd.put("comKey", userVo.getComKey());
        String parameter = request.getParameter("parameter");
        // 09未付款 10已付款
        pd.put("orderStatus", parameter);
//        pd.put("isSynchro","1");
        
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
         page.setPd(pd);
        try {
            List<AllPurchaseCheckingOrderVO> purchaseCheckingOrder = purchaseOrderService.listPageTotalPurchaseCheckingOrder(page);
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("total", page.getTotalResult());
            mapPage.put("rows", purchaseCheckingOrder);
            return JsonUtil.toCompatibleJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }


    /**
     * 
     * @Title: purchasecheckingOrderDetail 
     * @param salesNo
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 跳转查看采购对账单详情
     */
    @RequestMapping(value = "detail")
    public ModelAndView purchasecheckingOrderDetail(String purchasecheckingNo) {
        return new ModelAndView("jsp/advert/purchasechecking-order-detail").addObject("orderNo", purchasecheckingNo);
    }

    /**
     * 
     * @Title: purchasecheckingOrderDetailData 
     * @param orderNo
     * @return
     * @return String
     * @throws 
     * @Description: 采购对账单详情查看
     */
    @RequestMapping(value = "orderDetailData")
    @ResponseBody
    public String purchasecheckingOrderDetailData(String orderNo) {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("purchasecheckingNo", orderNo);
        try {
            //协同采购对账单
            PurchaseCheckingOrder purchaseCheckingOrder = purchaseOrderService.selectOnePurchaseCheckingOrder(pd);
            purchaseCheckingOrder.setComName(userVo.getComName());
            //协同采购对账单明细
            List<TotalPurchaseCheckingOrderDetailVO> purchaseCheckingOrderDetails = purchaseOrderService.listPurchaseCheckingOrderDetailByPrimaryKeyPCO(pd);
            //协同采购对账单详情底部数据
            CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),purchaseCheckingOrder.getPartnerKey());
            Map<String,Object> objectMap = new HashMap<>();
            objectMap.put("purchasecheckingOrder",purchaseCheckingOrder);
            objectMap.put("orders",purchaseCheckingOrderDetails);
            objectMap.put("bottomComInfo", companyVO);
            String orderUrl = "/ordershare/purchasechecking-order-detail-share.html";
            objectMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, purchaseCheckingOrder.getIndustryId(), orderNo, userVo.getComKey()));
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
		pd.put("purchasecheckingNo", orderNo);
		PurchaseCheckingOrder purchaseCheckingOrder = purchaseOrderService.selectOnePurchaseCheckingOrder(pd);
		if (purchaseCheckingOrder==null) {
			JsonUtil.toCompatibleJSONString(ResultUtil.error("无此对账单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/purchasechecking-order-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, purchaseCheckingOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}

    @RequestMapping(value = "listPageTotalPurchaseCheckingOrder")
    @ResponseBody
    public String listPageTotalPurchaseCheckingOrder(HttpServletRequest request) throws Exception{
    	 UserVo userVo = getSessionUservo();
         Page page = getPageWithParameter();
         PageData pd = this.getPageData();
         pd.put("comKey", userVo.getComKey());
         
         pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
         pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
         if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
         	pd.put("partnerKey", null);
         }
          page.setPd(pd);
         try {
             List<AllPurchaseCheckingOrderVO> purchaseCheckingOrder = purchaseOrderService.listPageTotalPurchaseCheckingOrder(page);
             OrderTotalVO orderTotalVO = purchaseOrderService.getSumTotalVO(pd, OrderEnum.TYPE_PURCHASECHECKINGORDER.getCode());
             Map<String, Object> mapPage = new HashMap<>();
             mapPage.put("total", page.getTotalResult());
             mapPage.put("rows", purchaseCheckingOrder);
             mapPage.put("bottomInfo", orderTotalVO);
             return JsonUtil.toCompatibleJSONString(mapPage);
         } catch (Exception e) {
             e.printStackTrace();
             return "0";
         }
    }
    
    /**
     * 
     * @Title: paymentMoney 
     * @param receiptPayment
     * @return
     * @return String
     * @throws 
     * @Description: 采购单付款操作
     */
	@RequestMapping(value = "payPurchaseOrder")
    @ResponseBody
	public String paymentMoney(ReceiptPayment receiptPayment){
		UserVo userVo = getSessionUservo();
	    Integer result = 0;
		try {
			result = purchaseOrderService.savePayments(userVo,receiptPayment);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return JsonUtil.toCompatibleJSONString(result);
	}

}