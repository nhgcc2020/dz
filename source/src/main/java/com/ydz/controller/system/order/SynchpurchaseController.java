package com.ydz.controller.system.order;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;
import com.ydz.enums.OrderEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.TotalPurchaseOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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
 * @classame SynchpurchaseController.java
 * @createTime 2016-08-23 下午7:29
 * @decription 类描述说明
 **/

@Controller
@RequestMapping(value = "ydz/synchpurchase", produces = "plain/text; charset=UTF-8")
public class SynchpurchaseController extends BaseController {

    @Resource(name="purchaseOrderService")
    PurchaseOrderService purchaseOrderService;
    
    @Resource(name="companyService")
    CompanyService companyService;
    
    /**
     * 跳转协同订单详情页面
     *
     * @return 详情页面
     */
    @RequestMapping(value = "detail")
    public ModelAndView salesOrderDetail(String salesNo) {

        return new ModelAndView("jsp/advert/synchpurchase-order-detail").addObject("salesNo", salesNo);
    }
    
    /**
     * 
    * @Title: salesOrderDetailData 
    * @param orderNo
    * @return
    * @return String
    * @throws 
    * @Description: 协同采购订单明细数据
     */
    @RequestMapping(value = "orderDetailData")
    @ResponseBody
    public String purchasecheckingOrderDetailData(String orderNo) {
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        pd.put("purchaseNo", orderNo);
        /*pd.put("comKey",userVo.getComKey());*/
        try {
            //协同采购订单
            PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pd);
            purchaseOrder.setComName(userVo.getComName());
            //协同采购订单明细
            List<PurchaseOrderDetail> orders = purchaseOrderService.selectListByPrimaryKey(pd);
            //协同采购订单详情底部数据
            CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),purchaseOrder.getPartnerKey());
            Map<String,Object> objectMap = new HashMap<>();
            purchaseOrder.setCreatorName("自动生成");
            objectMap.put("saleOrder",purchaseOrder);
            objectMap.put("orders",orders);
            objectMap.put("bottomComInfo", companyVO);
            return JsonUtil.toCompatibleJSONString(objectMap);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }


    @RequestMapping(value = "listPageSynch")
    @ResponseBody
    public String listPageSynch(HttpServletRequest request) throws Exception{
        UserVo userVo = getSessionUservo();
        Page page = this.getPageWithParameter();
        
        PageData pd = this.getPageData();
        
        if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(pd.getString("orderStatus"))
        		&&StringUtil.isNotEmpty(pd.getString("partnerKey"))
        		&&!"ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	page.setShowCount(10000);
        }
        pd.put("comKey",userVo.getComKey());
        pd.put("isSynchro", "1");
        
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
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        page.setPd(pd);

        List<PurchaseOrder> purchaseOrders = purchaseOrderService.listPagePurchaseOrderConcat(page);
        
        Map<String, Object> mapPage = new HashMap<>();
        mapPage.put("$entityCount", page.getTotalResult());
        mapPage.put("$data", purchaseOrders);
        
        return JsonUtil.toCompatibleJSONString(mapPage);
    }
    
    @RequestMapping(value = "listPageTotalSynch")
    @ResponseBody
    public String listPageTotalSynchro(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	Page page = getPageWithParameter();
    	
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
    	pd.put("isSynchro", "1");
    	
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
        if("ALL".equalsIgnoreCase(request.getParameter("partnerKey"))){
        	pd.put("partnerKey", null);
        }
    	
    	page.setPd(pd);
    	List<TotalPurchaseOrderDetailVO> detailVOs = purchaseOrderService.listPageTotalPurchaseDetail(page);
    	
    	Map<String, Object> mapPage = new HashMap<>();
        mapPage.put("$entityCount", page.getTotalResult());
        mapPage.put("$data", detailVOs);

        return JsonUtil.toCompatibleJSONString(mapPage);
    }

    @RequestMapping(value = "receivingOperation")
    @ResponseBody
    public String receivingOperation(@RequestBody String[] purchaseNo) throws Exception{
        UserVo userVo = getSessionUservo();
        Map<String,Object> map =null;
        for(int i = 0;i<purchaseNo.length;i++){
            map = purchaseOrderService.updateReceivingOperation(purchaseNo[i],userVo);
        }
        return JsonUtil.toCompatibleJSONString(map);
    }

}