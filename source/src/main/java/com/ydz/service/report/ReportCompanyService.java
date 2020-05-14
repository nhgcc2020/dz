/**   
 * @Title: ReportCompanyService.java 
 * @Package com.ydz.service.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:54:23 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.report.ReportCompanySheetMapper;
import com.ydz.entity.report.ReportCompanySheet;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;

/** 
 * @ClassName: ReportCompanyService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:54:23 PM 
 * @Description: 公司级报表Service
 *
 */
@Service
public class ReportCompanyService {
	
	@Autowired private ReportCompanySheetMapper reportCompanySheetMapper;
	
	public ReportCompanySheet getCompanyGrossProfit(PageData pd){
		String orderDateString = pd.getString("orderDate");
		pd.put("startDate", orderDateString+"-01");
		pd.put("endDate", orderDateString+"-"+DateUtil.getDaysOfMonth(orderDateString+"-01"));
		return reportCompanySheetMapper.getCompanyGrossProfit(pd);
	}

}
