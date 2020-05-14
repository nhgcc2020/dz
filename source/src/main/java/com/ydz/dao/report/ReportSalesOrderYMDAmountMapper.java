package com.ydz.dao.report;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.report.ReportCompanyRecPayAmount;
import com.ydz.entity.report.ReportPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderPartnerAmount;
import com.ydz.entity.report.ReportSalesOrderYMDAmount;
import com.ydz.entity.report.ReportWorkbenchDaiduizhangAmount;
import com.ydz.entity.report.ReportWorkbenchDaishoukuanAmount;
import com.ydz.util.PageData;

public interface ReportSalesOrderYMDAmountMapper {
	
	List<ReportSalesOrderYMDAmount> getSalesOrderMonthsAmounts(PageData pd);
	
	List<ReportSalesOrderYMDAmount> getSalesOrderDaysAmounts(PageData pd);
	
	List<ReportPartnerAmount> listPageReportPartnerAmountFromSalesOrder(Page page);
	
	List<ReportPartnerAmount> listPagePartnerAmountFromSalesCheckingOrder(Page page);
	
	List<ReportSalesOrderPartnerAmount> listPageSalesOrderPartnerAmount(Page page);
	
	ReportSalesOrderPartnerAmount getSumSalesOrderPartner(PageData pd);
	
	List<ReportCompanyRecPayAmount> getCompanyRecPayAmounts(PageData pd);
	
	List<ReportCompanyRecPayAmount> getRangeCompanyRecPayAmounts(PageData pd);
	
//	ReportPartnerAmount getTotalReportPartnerAmountFromSalesOrder(Page page);
//	
//	ReportPartnerAmount listPagePartnerAmountFromSalesCheckingOrder(Page page);

}
