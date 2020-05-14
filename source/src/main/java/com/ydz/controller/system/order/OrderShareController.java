package com.ydz.controller.system.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import sun.tools.tree.ThisExpression;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.entity.assignment.InstallationCheckingOrder;
import com.ydz.entity.assignment.InstallationCheckingOrderDetail;
import com.ydz.entity.assignment.InstallationOrder;
import com.ydz.entity.assignment.InstallationOrderDetail;
import com.ydz.entity.commissions.CommissionsCheckingOrder;
import com.ydz.entity.commissions.CommissionsCheckingOrderDetail;
import com.ydz.entity.project.ContractProject;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.CommissionsService;
import com.ydz.service.advert.ContractService;
import com.ydz.service.advert.InstallationService;
import com.ydz.service.advert.OpportunityService;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.EncryptUtils;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.TotalPurchaseCheckingOrderDetailVO;
import com.ydz.vo.TotalSalesCheckingOrderDetailVO;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: OrderShareController 
 * @Description: 订单分享控制器，用于处理订单分享访问
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年1月17日 上午11:22:39 
 * 
 */
@RestController
@RequestMapping(value = "ordershare", produces = "application/json; charset=UTF-8")
public class OrderShareController extends BaseController{
	
	@Resource
	private OrderConfigService orderConfigService;

	@Resource
	private CompanyService companyService;

	@Resource
	private SalesOrderService salesOrderService;
	@Resource
	private PurchaseOrderService purchaseOrderService;
	@Resource
	private CommissionsService commissionsService;

	@Resource
	private InstallationService installationService;

	@Resource
	private OpportunityService opportunityService;
	@Resource
	private ContractService contractService;
	@Resource
	private PartnerService partnerService;
	
	private String getOrderNo(String keyno){
		return StringUtil.StrListByPattern(EncryptUtils.getInstance().decryptDESByKey(keyno), "-")[1];
	}
	private String getComKey(String keyno){
		return StringUtil.StrListByPattern(EncryptUtils.getInstance().decryptDESByKey(keyno), "-")[2];
	}

    /**
     *据行业获取订单明细业务类型及对应的订单明细格式列
     * @return
     * @throws Exception 
     */
	@RequestMapping("listBusinessTypeVO")
    @ResponseBody
    public String listBusinessTypeVO(HttpServletRequest request) throws Exception{
        String industryId = null;
        String way = this.getPageData().getString("way");
        if(StringUtil.isNotEmpty(way)&&way.equals("detail")){
        	String key1 = this.getPageData().getString("key1");
        	if(StringUtil.isNotEmpty(key1)){
        		key1 = EncryptUtils.getInstance().decryptDESByKey(key1); //解密字符串
        		industryId = StringUtil.StrListByPattern(key1, "-")[0];
        	}
        }
        List<BusinessTypeVO> businessTypeVOs = orderConfigService.listBusinessTypeVO(industryId);
        for(BusinessTypeVO businessTypeVO : businessTypeVOs){
            List<String> list = new ArrayList<>(businessTypeVO.getBusinessTypeColsList());
            for(int i = 0; i<list.size(); i++){
                if("itemNo".equals(list.get(i))) { //去掉itemNo
                    list.remove(i);
                    i--;
                }
            }
            businessTypeVO.setBusinessTypeColsList(list);
            businessTypeVO.setType(businessTypeVO.getBusinessType());
            businessTypeVO.setBusinessType("model"+businessTypeVO.getBusinessType());

        }
        return JSON.toJSONString(businessTypeVOs);
    }
	
	/**
	 * 
	 * @Title: getSalesOrderDetail 
	 * @param keyno
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看销售订单明细分享页面
	 */
	@RequestMapping(value = "salesorderdetail/{keyno}")
	@ResponseBody
	public String getSalesOrderDetail(@PathVariable String keyno){
       try {
        	PageData pageData = new PageData();
        	pageData.put("salesNo", this.getOrderNo(keyno));
        	SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pageData); //查询单条销售订单记录
        	
            Page page = new Page();
            page.setShowCount(300);
            page.setCurrentPage(1);
            page.setPd(pageData);
            List<SalesOrderDetail> salesOrderDetails = salesOrderService.listPageSalesOrderDetail(page); //查询销售订单明细记录
            CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno),salesOrder.getPartnerKey()); //详情页底部信息
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
	 * @Title: getSalescheckingOrder 
	 * @param checkingNo
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看销售对账单明细分享页面
	 */
	@RequestMapping(value = "salescheckingorderdetail/{keyno}")
	@ResponseBody
	public String getSalescheckingOrder(@PathVariable String keyno){
		try{
			PageData pd = new PageData();
			pd.put("salescheckingNo", this.getOrderNo(keyno));
			//销售对账单
			SalesCheckingOrder salesCheckingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
			//销售对账单明细
			List<TotalSalesCheckingOrderDetailVO> salesCheckingOrderDetails = salesOrderService.listSalesCheckingOrderDetail(pd);
			//详情页底部信息
			CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno),salesCheckingOrder.getPartnerKey()); //详情页底部信息
			Map<String,Object> objectMap = new HashMap<>();
			objectMap.put("salesCheckingOrder",salesCheckingOrder);
			objectMap.put("salesCheckingOrderDetails",salesCheckingOrderDetails);
			objectMap.put("bottomComInfo", companyVO);
			return JsonUtil.toCompatibleJSONString(objectMap);
		}catch(Exception ex){
			ex.printStackTrace();
			return "0";
		}
	}
	
//	================== 采购
	
	/**
	 * 
	 * @Title: getPurchaseOrderDetail 
	 * @param keyno
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看采购订单分享页面
	 */
	@RequestMapping(value = "purchaseorderdetail/{keyno}")
	@ResponseBody
	public String getPurchaseOrderDetail(@PathVariable String keyno){
	       
        try {
        	PageData pageData = new PageData();
        	pageData.put("purchaseNo", this.getOrderNo(keyno));
        	PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pageData); //查询单条采购订单记录
        	
            Page page = new Page();
            page.setShowCount(300);
            page.setCurrentPage(1);
            page.setPd(pageData);
            List<PurchaseOrderDetail> details = purchaseOrderService.listPagePurchaseOrderDetail(page);
            CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno),purchaseOrder.getPartnerKey()); //详情页底部信息
            Map<String,Object> objectMap = new HashMap<>();
            objectMap.put("purchaseOrder",purchaseOrder);
            objectMap.put("orders",details);
            objectMap.put("bottomComInfo", companyVO);
            return JsonUtil.toCompatibleJSONString(objectMap);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
	}
	
	/**
	 * 
	 * @Title: getPurchasecheckingOrder 
	 * @param checkingNo
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看采购对账单分享页面
	 */
	@RequestMapping(value = "purchasecheckingorderdetail/{keyno}")
	@ResponseBody
	public String getPurchasecheckingOrder(@PathVariable String keyno){
		try{
			PageData pageData = new PageData();
			pageData.put("purchasecheckingNo", this.getOrderNo(keyno));
			//采购对账单
			PurchaseCheckingOrder purchasecheckingOrder = purchaseOrderService.selectOnePurchaseCheckingOrder(pageData);
			//采购对账单明细
			List<TotalPurchaseCheckingOrderDetailVO> purchaseCheckingOrderDetails = purchaseOrderService.listPurchaseCheckingOrderDetailByPrimaryKeyPCO(pageData);
			//详情页底部信息
			CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno),purchasecheckingOrder.getPartnerKey()); //详情页底部信息
			Map<String,Object> objectMap = new HashMap<>();
			objectMap.put("purchaseCheckingOrder",purchasecheckingOrder);
			objectMap.put("purchaseCheckingOrderDetails",purchaseCheckingOrderDetails);
			objectMap.put("bottomComInfo", companyVO);
			return JsonUtil.toCompatibleJSONString(objectMap);
		}catch(Exception ex){
			ex.printStackTrace();
			return "0";
		}
	}
	
	//============================= 安装工单
	
	/**
	 * 
	 * @Title: getInstallationOrder 
	 * @param keyno
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看安装单明细分享页面
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "installationorderdetail/{keyno}")
	@ResponseBody
	public String getInstallationOrder(@PathVariable String keyno){
		try{
			PageData pd = new PageData();
			pd.put("installationNo", this.getOrderNo(keyno));
			pd.put("comKey", this.getComKey(keyno));
			InstallationOrder order = installationService.selectOneInstallationOrder(pd);
			if (order==null) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
			}
			Page page = new Page();
			page.setShowCount(Const.PAGE_SIZE_DETAIL);
			pd.put("isntallationNo", order.getInstallationNo());
			page.setPd(pd);
			List<InstallationOrderDetail> details = installationService.listPageInstallationOrderDetails(page);
			CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno), order.getPartnerKey());
			ResultMap resultMap = ResultUtil.getResultMap();
			resultMap.put("order",order);
			resultMap.put("details",details);
			resultMap.put("bottomComInfo", companyVO);
			return JsonUtil.toCompatibleJSONString(resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			return "0";
		}
	}
	
	/**
	 * 
	 * @Title: getInstallationCheckingOrder 
	 * @param checkingNo
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 查看安装对账单分享页面
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "installationcheckingorderdetail/{keyno}")
	@ResponseBody
	public String getInstallationCheckingOrder(@PathVariable String keyno){
		try{
			PageData pd = new PageData();
			pd.put("installationcheckingNo",this.getOrderNo(keyno));
			pd.put("comKey", this.getComKey(keyno));
			InstallationCheckingOrder checkingOrder = installationService.selectOneCheckingOrder(pd);
			if (checkingOrder==null) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
			}
			Page page = new Page();
			page.setShowCount(1000);
			page.setPd(pd);
			List<InstallationCheckingOrderDetail> checkingOrderDetails = installationService.listPageCheckingOrderDetails(page);
			CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno), checkingOrder.getPartnerKey());
			ResultMap resultMap = ResultUtil.getResultMap();
			resultMap.put("order",checkingOrder);
			resultMap.put("details",checkingOrderDetails);
			resultMap.put("bottomComInfo", companyVO);
			return JsonUtil.toCompatibleJSONString(resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			return "0";
		}
	}
	
	@RequestMapping(value = "commissioncheckingorderdetail/{keyno}")
	@ResponseBody
	public String getCommissionCheckingOrder(@PathVariable String keyno){
		try{
			PageData pd = new PageData();
			pd.put("commissionsCheckingNo", this.getOrderNo(keyno));
			pd.put("comKey", this.getComKey(keyno));
			CommissionsCheckingOrder checkingOrder = commissionsService.selectOneCommissionsCheckingOrder(pd);
			if (checkingOrder==null) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
			}
			Page page = new Page();
			page.setShowCount(1000);
			page.setPd(pd);
			List<CommissionsCheckingOrderDetail> checkingOrderDetails = commissionsService.listPageCommissionsCheckingOrderDetails(page);
			CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno), checkingOrder.getPartnerKey());
			ResultMap resultMap = ResultUtil.getResultMap();
			resultMap.put("order",checkingOrder);
			resultMap.put("details",checkingOrderDetails);
			resultMap.put("bottomComInfo", companyVO);
			return JsonUtil.toCompatibleJSONString(resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			return "0";
		}
	}
	
	@RequestMapping(value = "opportunityquotationOrderAndDetail/{keyno}")
	@ResponseBody
	public String getOpportunityQuotationOrder(@PathVariable String keyno)
			throws Exception {
		PageData pd = new PageData();
		pd.put("oppoNo", this.getOrderNo(keyno));
		pd.put("comKey", this.getComKey(keyno));
		OpportunityOrder opportunityOrder = opportunityService.selectOneOpportunityOrder(pd);
		
		pd.put("partnerKey", opportunityOrder.getPartnerKey());
		pd.put("contacterId", opportunityOrder.getContactId());
		PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
		if (contacter!=null) {
			opportunityOrder.setContactTel(contacter.getTel1());
		}
		pd.put("isDefault", "1");
		OpportunityQuotation quotation = opportunityService.getOneOpportunityQuotation(pd);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno), opportunityOrder.getPartnerKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("opportunity",opportunityOrder);
		resultMap.put("quotation",quotation);
		resultMap.put("bottomComInfo", companyVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "contractOrderAndDetail/{keyno}")
	@ResponseBody
	public String getContractOrderAndDetail(@PathVariable String keyno)
			throws Exception {
		PageData pd = new PageData();
		pd.put("contractNo", this.getOrderNo(keyno));
		pd.put("comKey", this.getComKey(keyno));
		ContractProject contract = contractService.selectContractProject(pd);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(this.getComKey(keyno), contract.getPartnerKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("contract", contract);
		resultMap.put("plans", contractService.listPlans(pd));
		resultMap.put("invioces", contractService.listInvoices(pd));
		resultMap.put("returnMoneys", contractService.listReturnRecord(pd));
		resultMap.put("bottomComInfo", companyVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}

}
