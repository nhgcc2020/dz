/**   
 * @Title: ReportWorkBenchService.java 
 * @Package com.ydz.service.report 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月11日 上午10:44:23 
 * @version  
 */
package com.ydz.service.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.report.ReportWorkbenchChartMapper;
import com.ydz.entity.report.ReportWorkbenchDaiduizhangAmount;
import com.ydz.entity.report.ReportWorkbenchDaishoukuanAmount;
import com.ydz.util.PageData;

/** 
 * @ClassName: ReportWorkBenchService 
 * @Description: 工作台报表
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月11日 上午10:44:23 
 * 
 */
@Service
public class ReportWorkBenchService {
	
	@Autowired private ReportWorkbenchChartMapper reportWBchartMapper;
	
	/**
	 * 
	 * @Title: getDaiduizhangAmount 
	 * @param comKey
	 * @return
	 * @return ReportWorkbenchDaiduizhangAmount
	 * @throws 
	 * @Description: 工作台销售待对账订单统计
	 */
	public ReportWorkbenchDaiduizhangAmount getDaiduizhangAmount(String comKey){
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		return reportWBchartMapper.getDaiduizhangAmount(pd);
	}
	
	/**
	 * 
	 * @Title: getDaishoukuanAmount 
	 * @param year
	 * @param comKey
	 * @return
	 * @return List<ReportWorkbenchDaishoukuanAmount>
	 * @throws 
	 * @Description: 工作台销售对账单待收款订单统计
	 */
	public List<ReportWorkbenchDaishoukuanAmount> getDaishoukuanAmount(String year,String comKey){
		PageData pd = new PageData();
		pd.put("year",year);
		pd.put("comKey", comKey);
		return reportWBchartMapper.getDaishoukuanAmount(pd);
	}

}
