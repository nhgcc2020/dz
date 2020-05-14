/**   
 * @Title: ReportCompanySheetMapper.java 
 * @Package com.ydz.dao.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:47:17 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.dao.report;

import com.ydz.entity.report.ReportCompanySheet;
import com.ydz.util.PageData;

/** 
 * @ClassName: ReportCompanySheetMapper 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:47:17 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public interface ReportCompanySheetMapper {
	
	ReportCompanySheet getCompanyGrossProfit(PageData pd);

}
