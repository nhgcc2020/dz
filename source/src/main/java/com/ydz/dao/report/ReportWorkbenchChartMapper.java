package com.ydz.dao.report;

import java.util.List;

import com.ydz.entity.report.ReportWorkbenchDaiduizhangAmount;
import com.ydz.entity.report.ReportWorkbenchDaishoukuanAmount;
import com.ydz.util.PageData;

public interface ReportWorkbenchChartMapper {
	
	ReportWorkbenchDaiduizhangAmount getDaiduizhangAmount(PageData pd);
	
	List<ReportWorkbenchDaishoukuanAmount> getDaishoukuanAmount(PageData pd);

}
