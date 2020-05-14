/**   
 * @Title: ExcelReportController.java 
 * @Package com.ydz.controller.export 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 28, 2017 9:50:01 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.export;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.report.ReportSalesOrderPartnerAmount;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.report.ReportSalesOrderService;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: ExcelReportController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 28, 2017 9:50:01 AM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
@Controller
@RequestMapping(value = "toExcel/report",produces = "plain/text; charset=UTF-8")
public class ExcelReportController extends BaseController{
	
	@Resource private ReportSalesOrderService reportSalesOrderService;
	@Resource private SalesOrderService salesOrderService;
	
	@RequestMapping("salesOrderPartnerAmount")
	public ModelAndView exportSalesOrderPartnerAmount2Excel(HttpServletRequest request,HttpServletResponse response){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		Page page = new Page();
		pd.put("comKey", userVo.getComKey());
		try {
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
			page.setPd(pd);
			page.setShowCount(1000); //默认获取最大1000个客户的记录。
			List<ReportSalesOrderPartnerAmount> amounts = reportSalesOrderService.reportSalesOrderPartnerAmounts(page);
			
			ReportSalesOrderPartnerAmount sumTotalPrice = reportSalesOrderService.getSumSalesOrderPartner(pd);
			// 创建excel工作簿
	        Workbook wb = new HSSFWorkbook();
	        // 创建第一个sheet（页），并命名
	        Sheet sheet = wb.createSheet("客户销售报表");
	       
	        
	        String row1 = "下单客户数,订单笔数,订单金额";
	        
	        List<String> row1List = Tools.strArray2List(StringUtil.StrListByPattern(row1, ","));
	        for (int i = 0; i < row1List.size(); i++) {
	        	sheet.setColumnWidth((short) i, (short) (35.7 * 300));
			}
	        
	        // 创建三种字体
	        
	        // 创建第一种字体样式列名
	        // 设置第一种单元格的样式 列名
	        Font f = wb.createFont();
	        f.setFontHeightInPoints((short) 14);
	        f.setColor(IndexedColors.BLACK.getIndex());
	        f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        f.setFontName("微软雅黑");
	        CellStyle cs = wb.createCellStyle();
	        cs.setFont(f);
	        cs.setBorderLeft(BorderStyle.THIN);
	        cs.setBorderRight(BorderStyle.THIN);
	        cs.setBorderTop(BorderStyle.THIN);
	        cs.setBorderBottom(BorderStyle.THIN);
	        cs.setAlignment(HorizontalAlignment.CENTER);
	        cs.setVerticalAlignment(VerticalAlignment.CENTER);
	        
	        // 设置第二种单元格的样式 内容
	        Font f2 = wb.createFont();
	        // 创建第二种字体样式 内容
	        f2.setFontHeightInPoints((short) 12);
	        f2.setColor(IndexedColors.BLACK.getIndex());
	        f2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        f2.setFontName("微软雅黑");
	        CellStyle cs2 = wb.createCellStyle();
	        cs2.setFont(f2);
	        cs2.setBorderLeft(BorderStyle.THIN);
	        cs2.setBorderRight(BorderStyle.THIN);
	        cs2.setBorderTop(BorderStyle.THIN);
	        cs2.setBorderBottom(BorderStyle.THIN);
	        cs2.setBorderBottom(BorderStyle.THIN);
	        cs2.setAlignment(HorizontalAlignment.CENTER);
	        cs2.setVerticalAlignment(VerticalAlignment.CENTER);
	        
	        // 创建第三种字体样式 单据金额
	        Font f3 = wb.createFont();
	        f3.setFontHeightInPoints((short) 12);
	        f3.setColor(IndexedColors.BLACK.getIndex());
	        f3.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	        f3.setFontName("微软雅黑");
	        CellStyle cs3 = wb.createCellStyle();
	        cs3.setFont(f3);
	        cs3.setBorderLeft(BorderStyle.THIN);
	        cs3.setBorderRight(BorderStyle.THIN);
	        cs3.setBorderTop(BorderStyle.THIN);
	        cs3.setBorderBottom(BorderStyle.THIN);
	        cs3.setAlignment(HorizontalAlignment.RIGHT);

	        int rowcount = 0;
	        Row row = null;
	        Cell cell = null;
	        
	      //========================= 标题：
           
	        row = sheet.createRow((short) rowcount++);
	        row.setHeight((short)(35.7*20));
	        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));
	        cell = row.createCell(0);
	        String title = null;
	        title = userVo.getComShortname()+year;
	        if (StringUtil.isNotEmpty(pd.getString("month"))) {
				title = title+"-"+month;
			}else {
				title = title+"年";
			}
	        title+="客户销售报表";
	        cell.setCellValue(title);
	        cell.setCellStyle(cs);
            
            row = sheet.createRow((short) rowcount++); //创建空行
	
            //=========================开始创建对账单明细数据
            
            row = sheet.createRow((short) rowcount++); // 创建列名行
	        for (int i = 0; i < row1List.size(); i++) {
	        	cell = row.createCell(i);
		        cell.setCellValue(row1List.get(i));
		        cell.setCellStyle(cs2);
			}
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
            cell.setCellStyle(cs3);
            cell.setCellValue(page.getTotalResult()); //下单客户数
            
            cell = row.createCell(1);
            cell.setCellStyle(cs3);
            cell.setCellValue(sumTotalPrice.getOrderNum()); //订单笔数
            
            cell = row.createCell(2);
            cell.setCellStyle(cs3);
            cell.setCellValue(Double.parseDouble(sumTotalPrice.getSumTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString())); //订单金额
	        
            row = sheet.createRow((short) rowcount++); //创建空行
	        
	        for (ReportSalesOrderPartnerAmount amount : amounts) {
	        	row = sheet.createRow((short)rowcount++);
	            cell = row.createCell(0);
	            cell.setCellStyle(cs3);
	            cell.setCellValue(amount.getPartnerName()); //下单客户
	            cell = row.createCell(1);
	            cell.setCellStyle(cs3);
	            cell.setCellValue(amount.getOrderNum()); //订单笔数
	            cell = row.createCell(2);
	            cell.setCellStyle(cs3);
	            cell.setCellValue(Double.parseDouble(amount.getSumTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString())); //订单金额
			}
            
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        wb.write(os);
	        
	        byte[] content = os.toByteArray();
	        InputStream is = new ByteArrayInputStream(content);
	        
	        // 设置response参数，可以打开下载页面
	        response.reset();
	        response.setContentType("application/vnd.ms-excel;charset=utf-8");
	        String fileName = title;
	        
	        response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName + ".xls").getBytes(), "iso-8859-1"));

	        ServletOutputStream out = response.getOutputStream();

	        BufferedInputStream bis = null;
	        BufferedOutputStream bos = null;

	        try {

	            bis = new BufferedInputStream(is);
	            bos = new BufferedOutputStream(out);

	            byte[] buff = new byte[2048];
	            int bytesRead;

	            // Simple read/write loop.
	            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	                bos.write(buff, 0, bytesRead);
	            }
			
	        } catch (final IOException e) {
	        	e.printStackTrace();
	        } finally{
	        	if (bis != null)
	                bis.close();
	            if (bos != null)
	                bos.close();
	        }
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return null;
	}

}
