/**   
 * @Title: ReportSalesOrderController.java 
 * @Package com.ydz.controller.report 
 * @Description: 销售订单类报表控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月8日 上午10:09:33 
 * @version  
 */
package com.ydz.controller.report;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.report.ReportCompanyRecPayAmount;
import com.ydz.entity.report.ReportPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderYMDAmount;
import com.ydz.enums.OrderEnum;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.report.ReportSalesOrderService;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: ReportSalesOrderController 
 * @Description: 销售订单类报表控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月8日 上午10:09:33 
 * 
 */
@Controller
@RequestMapping(value = "report/saleorder", produces = "plain/text; charset=UTF-8")
public class ReportSalesOrderController extends BaseController{
	
	@Resource private ReportSalesOrderService reportSalesOrderService;
	
	@Resource private SalesOrderService salesOrderService;
	
	@RequestMapping(value="salestrend")
	@ResponseBody
	public String getSalesTrend(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		ResultMap resultMap = ResultUtil.getResultMap();
		List<ReportSalesOrderYMDAmount> amounts = null;
		if (StringUtil.isEmpty(pd.getString("month"))) {
			amounts = reportSalesOrderService.getSalesOrderMonthsAmounts(userVo.getComKey(), pd.getString("year"));
		}else{
			amounts = reportSalesOrderService.getSalesOrderDaysAmounts(userVo.getComKey(), pd.getString("year"), pd.getString("month"));
		}
		resultMap.put("total", amounts.size());
		resultMap.setRows(amounts);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value="partnerAmount")
	@ResponseBody
	public String reportPartnerAmount() throws Exception{
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
		if (StringUtil.isEmpty(pd.getString("friend"))) {
			pd.put("friend", null);
			pd.put("friendnot", null);
		}else {
			if ("1".equalsIgnoreCase(pd.getString("friend"))) {
				pd.put("friend", "1");
				pd.put("friendnot", null);
			}else if ("0".equalsIgnoreCase(pd.getString("friend"))) {
				pd.put("friend", null);
				pd.put("friendnot", "1");
			}
		}
		if ("asc".equalsIgnoreCase(pd.getString("order"))) {
			pd.put("sortAsc", "1");
			pd.put("sortDesc", null);
		}else if ("desc".equalsIgnoreCase(pd.getString("order"))) {
			pd.put("sortAsc", null);
			pd.put("sortDesc", "1");
		}
		pd.put("group", "1");
		page.setPd(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		List<ReportPartnerAmount> partnerAmounts = reportSalesOrderService.reportPartnerAmount(page);
		resultMap.setRows(partnerAmounts);
		resultMap.setTotalCount(page.getTotalResult());

		//合计统计
		page.setShowCount(10000);
		pd.put("group", null);
		
		pd.put("orderStatus", OrderEnum.STATUS_DAIDUIZHANG.getCode());
		page.setPd(pd);
		List<ReportPartnerAmount> partnerAmountsTotal = reportSalesOrderService.reportPartnerAmount(page);
		BigDecimal totalPrice04 = partnerAmountsTotal.get(0).getTotalPrice04();
		totalPrice04 = totalPrice04==null?BigDecimal.ZERO:totalPrice04.setScale(2, BigDecimal.ROUND_HALF_UP);
		resultMap.put("totalPrice04", totalPrice04);
		
		pd.put("orderStatus", OrderEnum.STATUS_DAISHOUKUAN.getCode());
		page.setPd(pd);
		partnerAmountsTotal = reportSalesOrderService.reportPartnerAmount(page);
		BigDecimal totalPrice07 = partnerAmountsTotal.get(0).getTotalPrice07();
		totalPrice07 = totalPrice07==null?BigDecimal.ZERO:totalPrice07.setScale(2, BigDecimal.ROUND_HALF_UP);
		resultMap.put("totalPrice07", totalPrice07);
		resultMap.put("SumReceivablesMoney", totalPrice04.add(totalPrice07).setScale(2, BigDecimal.ROUND_HALF_UP));
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value="salesOrderPartnerAmount")
	@ResponseBody
	public String reportSalesOrderPartnerAmount() throws Exception{
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		
		String year = pd.getString("year");
		String month = pd.getString("month");
		if (StringUtil.isEmpty(year)) {
			year = Integer.toString(DateUtil.getYear(new Date()));
			pd.put("startDate",year+"-01-01");
			pd.put("endDate", year+"-12-31");
		}else {
			if (StringUtil.isEmpty(month)) {
				pd.put("startDate",year+"-01-01");
				pd.put("endDate", year+"-12-31");
			}else {
				int days = DateUtil.getDaysOfMonth(year+"-"+month+"-"+"01");
				pd.put("startDate",year+"-"+month+"-01");
				pd.put("endDate", year+"-"+month+"-"+Integer.toString(days));
			}
		}
		if("ALL"
				.equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
		if ("orderNum".equalsIgnoreCase(pd.getString("sort"))) {
			if ("asc".equalsIgnoreCase(pd.getString("order"))) {
				pd.put("orderNumSortAsc", "1");
			}else{
				pd.put("orderNumSortDesc", "1");
			}
		}else if ("sumTotalPrice".equalsIgnoreCase(pd.getString("sort"))) {
			if ("asc".equalsIgnoreCase(pd.getString("order"))) {
				pd.put("sumTotalPriceSortAsc", "1");
			}else{
				pd.put("sumTotalPriceSortDesc", "1");
			}
		}
		page.setPd(pd);
		List<ReportSalesOrderPartnerAmount> amounts = reportSalesOrderService.reportSalesOrderPartnerAmounts(page);
		ReportSalesOrderPartnerAmount sumTotalPrice = reportSalesOrderService.getSumSalesOrderPartner(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(amounts);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("sumTotalPriceAll", sumTotalPrice);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: reportCompayRecPayAmount 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 公司回款统计
	 */
	@RequestMapping(value="companyRecPayAmount")
	@ResponseBody
	public String reportCompayRecPayAmount() throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		
		return JsonUtil.toCompatibleJSONString(reportSalesOrderService.getCompanyRecPayAmounts(pd));
	}
	
	
}
