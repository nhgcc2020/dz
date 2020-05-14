package com.ydz.controller.assignment;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.assignment.InstallationCheckingOrder;
import com.ydz.entity.assignment.InstallationCheckingOrderDetail;
import com.ydz.entity.assignment.InstallationCheckingOrderVO;
import com.ydz.entity.assignment.InstallationOrder;
import com.ydz.entity.assignment.InstallationOrderDetail;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.InstallationService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Const;
import com.ydz.util.EncryptUtils;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.PaymentVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: InstallationCheckingController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月27日 下午3:06:52 
 * @Description: 安装结算单控制器  
 */
@Controller
@RequestMapping(value = "order/installationchecking", produces = "plain/text; charset=UTF-8")
public class InstallationCheckingController extends BaseController{
	
	@Resource private InstallationService installationService;
	
	@Resource private CompanyService companyService;
	@Resource private CommonService commonService;
	
	//查看安装对账单
	@RequestMapping("listCheckingOrder")
	@ResponseBody
	public String listCheckingOrder(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
		page.setPd(pd);
		List<InstallationCheckingOrderVO> checkingOrders = installationService.listPageCheckingOrders(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(checkingOrders);
		resultMap.setTotalCount(page.getShowCount());
		return JsonUtil.toCompatibleJSONString(checkingOrders);
	}
	
	//跳转安装对账单详情
	@RequestMapping("forward-installation-checking-list-detail")
	public ModelAndView forwarInstallationcheckingDetail(String installationcheckingNo) {
        return new ModelAndView("jsp/assignment/installation-checking-list-detail").addObject("installationcheckingNo", installationcheckingNo);
    }
	//查看安装对账单详情
	@SuppressWarnings("unchecked")
	@RequestMapping("checkingOrderAndDetails")
	@ResponseBody
	public String checkingOrderAndDetails()	throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		InstallationCheckingOrder checkingOrder = installationService.selectOneCheckingOrder(pd);
		if (checkingOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		Page page = new Page();
		page.setCurrentPage(1);
		page.setShowCount(1000);
		pd.put("isntallationcheckingNo", checkingOrder.getInstallationcheckingNo());
		page.setPd(pd);
		List<InstallationCheckingOrderDetail> checkingOrderDetails = installationService.listPageCheckingOrderDetails(page);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(), checkingOrder.getPartnerKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("order",checkingOrder);
		resultMap.put("details",checkingOrderDetails);
		resultMap.put("bottomComInfo", companyVO);
        
		return JsonUtil.toCompatibleJSONString(resultMap);
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
		pd.put("installationcheckingNo", orderNo);
		InstallationCheckingOrder checkingOrder = installationService.selectOneCheckingOrder(pd);
		if (checkingOrder==null) {
			JsonUtil.toCompatibleJSONString(ResultUtil.error("无此结算单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/installation-checking-list-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, checkingOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: addPayment 
	 * @param receiptPayment
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 添加安装对账单的结算付款费用
	 */
	@RequestMapping("addPayment")
	@ResponseBody
	public String addPayment(ReceiptPayment receiptPayment) throws Exception{
		if (receiptPayment==null||StringUtil.isEmpty(receiptPayment.getCheckingNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		 UserVo userVo = getSessionUservo();
        int result = installationService.saveReceivables(userVo.getComKey(),receiptPayment);
        if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	/**
	 * 
	 * @Title: getPaymentInfo 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 获取对账单付款信息
	 */
	@RequestMapping("getPaymentInfo")
	@ResponseBody
	public String getPaymentInfo() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("checkingNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有该对账单信息"));
		}
		 UserVo userVo = getSessionUservo();
		 pd.put("comKey", userVo.getComKey());
        ReceiptPayment receiptPayment = installationService.selectOneReceiptPayment(pd);
        return JsonUtil.toCompatibleJSONString(receiptPayment);
	}
	
	
	/**
	 * 
	 * @Title: updatePayment 
	 * @param receiptPayment
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改安装对账单的结算付款费用
	 */
	@RequestMapping("udpatePayment")
	@ResponseBody
	public String updatePayment(ReceiptPayment receiptPayment) throws Exception{
		UserVo userVo = getSessionUservo();
		int result = installationService.updateReceivables(userVo.getComKey(), receiptPayment);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
	
	

}
