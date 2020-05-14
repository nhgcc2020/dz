/**   
 * @Title: ReportSalesOrderService.java 
 * @Package com.ydz.service.report 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月6日 下午10:53:26 
 * @version  
 */
package com.ydz.service.report;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


//import com.bstek.ureport.exception.ReportPagingException;
//import com.bstek.ureport.model.Report;
import com.ydz.dao.report.ReportSalesOrderYMDAmountMapper;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.report.ReportCompanyRecPayAmount;
import com.ydz.entity.report.ReportPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderYMDAmount;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.OrderEnum;
import com.ydz.service.system.PartnerService;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: ReportSalesOrderService 
 * @Description: 销售订单类报表服务类
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月6日 下午10:53:26 
 * 
 */
@Service
public class ReportSalesOrderService {
	
	@Autowired private ReportSalesOrderYMDAmountMapper reportSalesOrderYMDAmountMapper;
	
	@Resource private PartnerService partnerService;
	
	/**
	 * 
	 * @Title: getSalesOrderMonthsAmounts 
	 * @param comKey
	 * @param year
	 * @return
	 * @return List<ReportSalesOrderYMDAmount>
	 * @throws 
	 * @Description: 公司的销售订单根据年份按月进行统计，并计算对比上月的升降趋势
	 */
	public List<ReportSalesOrderYMDAmount> getSalesOrderMonthsAmounts(String comKey,String year){
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("year", year);
		List<ReportSalesOrderYMDAmount> amounts = reportSalesOrderYMDAmountMapper.getSalesOrderMonthsAmounts(pd);
		Map<String, ReportSalesOrderYMDAmount> tempMap = new HashMap<String, ReportSalesOrderYMDAmount>();
		for (ReportSalesOrderYMDAmount ymd : amounts) {
			tempMap.put(ymd.getMonths(), ymd);
		}
		LinkedList<ReportSalesOrderYMDAmount> linkedAmounts = new LinkedList<ReportSalesOrderYMDAmount>();
		String month = null;
		BigDecimal nowTotalPrice = null;
		BigDecimal preTotalPrice = null;
		for (int i = 1; i <= 12; i++) {
			ReportSalesOrderYMDAmount ymd_ = new ReportSalesOrderYMDAmount();
			ymd_.setYears(year);
			month = i<10?"0"+Integer.toString(i):Integer.toString(i);
			ymd_.setMonths(month);
			ymd_.setOrderNum(tempMap.get(month)==null?"0":tempMap.get(month).getOrderNum());
			
			nowTotalPrice = tempMap.get(month)==null?BigDecimal.ZERO:new BigDecimal(tempMap.get(month).getTotalPrice());
			ymd_.setTotalPrice(nowTotalPrice.toString());
			
			if(i == 1){
				preTotalPrice = nowTotalPrice;
				ymd_.setTrend("1");
			}
			if(i>1){
				if (nowTotalPrice.compareTo(preTotalPrice)>=0) {
					ymd_.setTrend("1");
				}else{
					ymd_.setTrend("0");
				}
				preTotalPrice = nowTotalPrice;
			}
			linkedAmounts.add(ymd_);
		}
		tempMap.clear();
		return linkedAmounts;
	}
	
	/**
	 * 
	 * @Title: getSalesOrderDaysAmounts 
	 * @param comKey
	 * @param year
	 * @param month
	 * @return
	 * @return List<ReportSalesOrderYMDAmount>
	 * @throws 
	 * @Description: 公司的销售订单根据年月按天数进行统计，并计算对比前一天的升降趋势
	 */
	public List<ReportSalesOrderYMDAmount> getSalesOrderDaysAmounts(String comKey,String year,String month){
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("yearMonth", year+"-"+month);
		List<ReportSalesOrderYMDAmount> amounts = reportSalesOrderYMDAmountMapper.getSalesOrderDaysAmounts(pd);
		Map<String, ReportSalesOrderYMDAmount> tempMap = new HashMap<String, ReportSalesOrderYMDAmount>();
		for (ReportSalesOrderYMDAmount ymd : amounts) {
			tempMap.put(ymd.getDays(), ymd);
		}
		LinkedList<ReportSalesOrderYMDAmount> linkedAmounts = new LinkedList<ReportSalesOrderYMDAmount>();
		String days = null;
		BigDecimal nowTotalPrice = null;
		BigDecimal preTotalPrice = null;
		int dayNum = DateUtil.getDaysOfMonth(year+"-"+month);
		for (int i = 1; i <= dayNum; i++) {
			ReportSalesOrderYMDAmount ymd_ = new ReportSalesOrderYMDAmount();
			ymd_.setYears(year);
			ymd_.setMonths(month);
			days = i<10?"0"+Integer.toString(i):Integer.toString(i);
			ymd_.setDays(days);
			ymd_.setOrderNum(tempMap.get(days)==null?"0":tempMap.get(days).getOrderNum());
			
			nowTotalPrice = tempMap.get(days)==null?BigDecimal.ZERO:new BigDecimal(tempMap.get(days).getTotalPrice());
			ymd_.setTotalPrice(nowTotalPrice.toString());
			
			if(i == 1){
				preTotalPrice = nowTotalPrice;
				ymd_.setTrend("1");
			}
			if(i>1){
				if (nowTotalPrice.compareTo(preTotalPrice)>=0) {
					ymd_.setTrend("1");
				}else{
					ymd_.setTrend("0");
				}
				preTotalPrice = nowTotalPrice;
			}
			linkedAmounts.add(ymd_);
		}
		tempMap.clear();
		
		return linkedAmounts;
	}
	
	public List<ReportPartnerAmount> reportPartnerAmount(Page page){
		String orderStatus = page.getPd().getString("orderStatus");
		List<ReportPartnerAmount> reportPartnerAmounts = null;
		if (OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(orderStatus)) {
			reportPartnerAmounts = reportSalesOrderYMDAmountMapper.listPageReportPartnerAmountFromSalesOrder(page);
		}else if(OrderEnum.STATUS_DAISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)){
			reportPartnerAmounts = reportSalesOrderYMDAmountMapper.listPagePartnerAmountFromSalesCheckingOrder(page);
		}
		return reportPartnerAmounts;
	}
	
	public List<ReportSalesOrderPartnerAmount> reportSalesOrderPartnerAmounts(Page page){
		return reportSalesOrderYMDAmountMapper.listPageSalesOrderPartnerAmount(page);
	}
	
	public ReportSalesOrderPartnerAmount getSumSalesOrderPartner(PageData pd){
		return reportSalesOrderYMDAmountMapper.getSumSalesOrderPartner(pd);
	}
	
	/**
	 * 
	 * @Title: getCompanyRecPayAmounts 
	 * @param pd
	 * @return
	 * @return List<ReportCompanyRecPayAmount>
	 * @throws 
	 * @Description: 公司回款统计
	 */
	public ResultMap getCompanyRecPayAmounts(PageData pd){
		ResultMap resultMap = ResultUtil.getResultMap();
		ReportCompanyRecPayAmount rangeRecPayAmount = new ReportCompanyRecPayAmount();
		
		List<ReportCompanyRecPayAmount> allAmounts = reportSalesOrderYMDAmountMapper.getCompanyRecPayAmounts(pd);
		
		if (allAmounts==null||allAmounts.size()==0) {
			resultMap.setRows("");
			resultMap.put("rangeAmount", rangeRecPayAmount);
			return resultMap;
		}
		List<ReportCompanyRecPayAmount> amounts = reportSalesOrderYMDAmountMapper.getRangeCompanyRecPayAmounts(pd);
		
		if (amounts==null||amounts.size()==0) {
			resultMap.setRows("");
			resultMap.put("rangeAmount", rangeRecPayAmount);
			return resultMap;
		}
		Map<String,ReportCompanyRecPayAmount> mapAmount = new HashMap<>();
		for (ReportCompanyRecPayAmount amount : amounts) {
			mapAmount.put(amount.getAccountType(), amount);
		}
		ReportCompanyRecPayAmount amount = null;
		for (ReportCompanyRecPayAmount allAmount : allAmounts) {
			amount = mapAmount.get(allAmount.getAccountType());
			if (amount!=null) {
				allAmount.setSumRecpayMoney(amount.getSumRecpayMoney());
				allAmount.setSumTotalPrice(amount.getSumTotalPrice());
			}
		}
		
		
		resultMap.setRows(amounts);
		if (amounts==null) {
			resultMap.setRows("");
			resultMap.put("rangeAmount", rangeRecPayAmount);
			return resultMap;
		}
		rangeRecPayAmount.setSumRangeRecpayMoney(BigDecimal.ZERO);
		rangeRecPayAmount.setSumRangeTotalPrice(BigDecimal.ZERO);
		for (ReportCompanyRecPayAmount amount1 : allAmounts) {
			rangeRecPayAmount.setSumRangeRecpayMoney(amount1.getSumRecpayMoney().add(rangeRecPayAmount.getSumRangeRecpayMoney()).setScale(2, BigDecimal.ROUND_HALF_UP));
			rangeRecPayAmount.setSumRangeTotalPrice(amount1.getSumTotalPrice().add(rangeRecPayAmount.getSumRangeTotalPrice()).setScale(2, BigDecimal.ROUND_HALF_UP));
		}
		resultMap.put("rangeAmount", rangeRecPayAmount);
		
		return resultMap;
		
	}
	
}
