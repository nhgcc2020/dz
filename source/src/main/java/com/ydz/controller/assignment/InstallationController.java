/**   
 * @Title: InstallationController.java 
 * @Package com.ydz.controller.assignment 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 上午11:36:30 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.assignment;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.assignment.InstallStandingBy;
import com.ydz.entity.assignment.InstallationOrder;
import com.ydz.entity.assignment.InstallationOrderAndDetailVO;
import com.ydz.entity.assignment.InstallationOrderDetail;
import com.ydz.entity.assignment.InstallationOrderVO;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.InstallationService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.TotalSalesOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: InstallationController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 上午11:36:30 
 * @Description: 安装业务控制器
 */
@Controller
@RequestMapping(value = "order/installation", produces = "plain/text; charset=UTF-8")
public class InstallationController extends BaseController{

	@Resource private SalesOrderService salesOrderService;
	@Resource private InstallationService installationService;
	
	@Resource private CompanyService companyService;
	@Resource private CommonService commonService;
	
//	查询销售订单用于选择进入待安装列表
	
	@RequestMapping("listSalesOrderAndDetail")
	@ResponseBody
	public String listSalesOrderAndDetail(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		if("ALL"
				.equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (StringUtil.isEmpty(pd.getString("isDel"))) {
			pd.put("isDel", "0");
		}
        page.setPd(pd);
        List<TotalSalesOrderDetailVO> totalVO = installationService.listPageSalesOrderAndDetails(page);
        ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setRows(totalVO);
        resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
//	插入待安装表
	@RequestMapping("insertInstallStandingBy")
	@ResponseBody
	public String insertInstallStandingBy() throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("detailUid"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "请选择需要的明细"));
		}
		//插入待安装列表
		int result = installationService.insertFromSalesOrderDetailToInstallStandingBy(userVo, pd);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	
//	查询待安装记录表
	@RequestMapping("listInstallStandingBy")
	@ResponseBody
	public String listInstallStandingBy(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		if("ALL"
				.equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
		page.setPd(pd);
		List<InstallStandingBy> installStandingBys = installationService.listPageInstallStandingBy(page);
		ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setRows(installStandingBys);
        resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping("forward-addInstallationOrder")
	public ModelAndView forwardAddInstallationOrder(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("detailUid"))) {
			return new ModelAndView("505");
		}
		ModelAndView forwardView = new ModelAndView();
		forwardView.setViewName("jsp/assignment/installation-add");
		forwardView.addObject("detailUid", Tools.strSqlIn(pd.getString("detailUid")));
		return forwardView;
	}
	
	/**
	 * 
	 * @Title: listInstallStandingByDetailForAdd 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 为新建安装工单获取勾选的记录集并返回
	 */
	@RequestMapping("listInstallStandingByDetailForAdd")
	@ResponseBody
	public String listInstallStandingByDetailForAdd()
			throws Exception{
		UserVo userVo = this.getSessionUservo();
		Page page = new Page();
		page.setShowCount(1000);
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("detailUid"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "请选择需要的明细"));
		}
		pd.put("comKey", userVo.getComKey());
		page.setPd(pd);
		List<InstallStandingBy> installStandingBys = installationService.listPageInstallStandingBy(page);
		for (InstallStandingBy installStandingBy : installStandingBys) {
			installStandingBy.setTotalPrice(BigDecimal.ZERO);
			installStandingBy.setUnitPrice(BigDecimal.ZERO);
		}
		return JsonUtil.toCompatibleJSONString(installStandingBys);
	}
	
//	新建安装工单及明细
	@RequestMapping("insert")
	@ResponseBody
	public String insertInstallationOrder(@RequestBody InstallationOrderAndDetailVO orderVo)
			throws Exception{
		if (orderVo==null||orderVo.getOrder()==null||orderVo.getDetails()==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，请重试"));
		}
		if (StringUtil.isEmpty(orderVo.getOrder().getPartnerKey())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "必须选择供应商"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = installationService.insertNewInstallationOrder(orderVo, userVo);
		if (result>0) {
			//todo
			//安装工单新建完成后，发送短信给安装工
			return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，可能是金额计算错误，请重试"));
		}
	}
	@RequestMapping(value = "forward-updatePage")
    public ModelAndView forwardUpdatePage(String installationNo) {
    	UserVo userVo = getSessionUservo();
    	String industryId = userVo.getDetailIndustryId();
        if(installationNo == null 
        		|| industryId == null){
            return new ModelAndView("error");
        }
        String pathString = "jsp/assignment/installation-update";
        
        return new ModelAndView(pathString).addObject("installationNo",installationNo);
    }
	
	@RequestMapping("orderAndDetailSimple")
	@ResponseBody
	public String orderAndDetailSimple(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		InstallationOrderAndDetailVO orderDetailVOs = installationService.getOrderAndDetailSimple(pd);
		
		return JsonUtil.toCompatibleJSONString(orderDetailVOs);
	}
	
//	修改安装工单及明细
	@RequestMapping("update")
	@ResponseBody
	public String updateInstallationOrder(@RequestBody InstallationOrderAndDetailVO orderVo )
			throws Exception{
		if (orderVo==null||orderVo.getOrder()==null||orderVo.getDetails()==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，请重试"));
		}
		if (StringUtil.isEmpty(orderVo.getOrder().getPartnerKey())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "必须选择供应商"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = installationService.updateInstallationOrderAndDetail(orderVo, userVo);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，请重试"));
		}
	}
	
	//修改安装工单时需要打开待安装列表进行选择
	
//	查看安装工单列表
	@RequestMapping("listInstallationOrder")
	@ResponseBody
	public String listInstallationOrder()
			throws Exception{
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
		if ("ALL".equalsIgnoreCase(pd.getString("orderStatus"))) {
			pd.put("status", null);
			pd.put("statusIns", "('04','05')");
		}
		
		page.setPd(pd);
		List<InstallationOrderVO> installationOrderVOs = installationService.listPageInstallationOrderVOs(page);
		ResultMap resultMap = ResultUtil.getResultMap();
        resultMap.setRows(installationOrderVOs);
        resultMap.setTotalCount(page.getTotalResult());
        resultMap.put("orderTotalVO", installationService.getOrderTotalVO(page));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "forward-installation-list-detail")
    public ModelAndView forwardInstallationOrderDetail(String installationNo) {
        return new ModelAndView("jsp/assignment/installation-list-detail").addObject("installationNo", installationNo);
    }
	
//	查看安装工单详情
	@SuppressWarnings("unchecked")
	@RequestMapping("orderAndDetails")
	@ResponseBody
	public String orderAndDetails()
			throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		InstallationOrder order = installationService.selectOneInstallationOrder(pd);
		if (order==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		Page page = new Page();
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		pd.put("isntallationNo", order.getInstallationNo());
		page.setPd(pd);
		List<InstallationOrderDetail> details = installationService.listPageInstallationOrderDetails(page);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(), order.getPartnerKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("order",order);
		resultMap.put("details",details);
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
		pd.put("installationNo", orderNo);
		InstallationOrder installationOrder = installationService.selectOneInstallationOrder(pd);
		if (installationOrder==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此订单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/installation-list-detail-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, installationOrder.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
//	作废安装工单
	@RequestMapping("cancel")
	@ResponseBody
	public String cancelOrder()	throws Exception{
		PageData pd = this.getPageData();
		if(StringUtil.isEmpty(pd.getString("installationNo"))){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "作废失败，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("status", OrderEnum.STATUS_CANCEL.getCode());
		int result = installationService.cancelInstallationOrder(pd);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "作废失败，请重试"));
		}
	}
	
	@RequestMapping("create-installationchecking")
	@ResponseBody
	public String createInstallationChecking()	throws Exception{
		PageData pd = this.getPageData();
		if(StringUtil.isEmpty(pd.getString("installationNoIns"))){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "没有工单需要生成对账单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		String installationNoIns = Tools.strSqlIn(pd.getString("installationNoIns"));
		pd.put("comKey", userVo.getComKey());
		pd.put("installationNoIns", installationNoIns);
		pd.put("userKey", userVo.getUserKey());
		int result = installationService.createInstallationChecking(pd);
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "生成安装对账单失败，请重试"));
		}
	}
	
	
}
