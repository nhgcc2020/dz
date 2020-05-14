package com.ydz.controller.export;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.ComProPrice;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: ExcelAboutCompany 
 * @Description: 公司有关的业务信息导出Excel
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月21日 下午5:48:29 
 * 
 */
@Controller
@RequestMapping(value = "toExcel/company",produces = "plain/text; charset=UTF-8")
public class ExcelAboutCompanyController extends BaseController{
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@SuppressWarnings("deprecation")
	@RequestMapping("comProductPrice")
	public ModelAndView exportComProductPrice2Excel(HttpServletRequest request,HttpServletResponse response){
		UserVo userVo = this.getSessionUservo();
		PageData pdData = this.getPageData();
		if(StringUtil.isEmpty(pdData.getString("priceLevel"))){
			return null;
		}
		try {
			pdData.put("comKey",userVo.getComKey());
			pdData.put("tier", "3");
			pdData.put("pricingType", "1");
			List<ComProPrice> comProPrices = companyService.selectComProPricesToExcel(pdData); // 获得要导出的数据集
			
			// 创建excel工作簿
	        Workbook wb = new HSSFWorkbook();
	        // 创建第一个sheet（页），并命名
	        Sheet sheet = wb.createSheet("服务定价列表");
	        
	        // 手动设置列宽。第一个参数表示要为第几列设；，第二个参数表示列的宽度，n为列高的像素数。
	        sheet.setColumnWidth((short) 0, (short) (35.7 * 150));
	        sheet.setColumnWidth((short) 1, (short) (35.7 * 150));
	        sheet.setColumnWidth((short) 2, (short) (35.7 * 150));
	        sheet.setColumnWidth((short) 3, (short) (35.7 * 100));
	        
	        // 创建第一行
	        Row row = sheet.createRow((short) 0);
	        
	        // 创建两种单元格格式
	        CellStyle cs = wb.createCellStyle();
	        CellStyle cs2 = wb.createCellStyle();
	        
	        // 创建两种字体
	        Font f = wb.createFont();
	        Font f2 = wb.createFont();

	        // 创建第一种字体样式
	        f.setFontHeightInPoints((short) 12);
	        f.setColor(IndexedColors.BLACK.getIndex());
	        f.setBoldweight(Font.BOLDWEIGHT_BOLD);

	        // 创建第二种字体样式
	        f2.setFontHeightInPoints((short) 10);
	        f2.setColor(IndexedColors.BLACK.getIndex());
	        f2.setBoldweight(Font.BOLDWEIGHT_BOLD);

	        // 设置第一种单元格的样式
	        cs.setFont(f);
	        cs.setBorderLeft(CellStyle.BORDER_THIN);
	        cs.setBorderRight(CellStyle.BORDER_THIN);
	        cs.setBorderTop(CellStyle.BORDER_THIN);
	        cs.setBorderBottom(CellStyle.BORDER_THIN);
	        // cs.setDataFormat(df.getFormat("#,##0.0"));

	        // 设置第二种单元格的样式
	        cs2.setFont(f2);
	        cs2.setBorderLeft(CellStyle.BORDER_THIN);
	        cs2.setBorderRight(CellStyle.BORDER_THIN);
	        cs2.setBorderTop(CellStyle.BORDER_THIN);
	        cs2.setBorderBottom(CellStyle.BORDER_THIN);
	        // cs2.setDataFormat(df.getFormat("text"));
	        
	        // 创建列（每行里的单元格）
	        Cell cell = row.createCell(0);
	        cell.setCellValue("物料/制作/说明");
	        cell.setCellStyle(cs);

	        cell = row.createCell(1);
	        cell.setCellValue("计价方式");
	        cell.setCellStyle(cs);

	        cell = row.createCell(2);
	        cell.setCellValue("计价单位");
	        cell.setCellStyle(cs);

	        cell = row.createCell(3);
	        cell.setCellValue("单价");
	        cell.setCellStyle(cs);

	        int i = 0;
	        for (ComProPrice cpp : comProPrices) {
	        	// Row 行,Cell 方格 , Row 和 Cell 都是从0开始计数的
	            // 创建一行，在页sheet上
	            row = sheet.createRow((short) i + 1);
	            
	            // 在row行上创建一个方格
	            cell = row.createCell(0);
	            cell.setCellValue(cpp.getCategoryDesc());
//	            cell.setCellStyle(cs2);
	            
	            cell = row.createCell(1);
	            cell.setCellValue(cpp.getPriceWayDesc());
//	            cell.setCellStyle(cs2);
	            
	            cell = row.createCell(2);
	            cell.setCellValue(cpp.getPriceUnitDesc());
//	            cell.setCellStyle(cs2);
	            
	            cell = row.createCell(3);
	            cell.setCellValue(cpp.getUnitPrice().toString());
//	            cell.setCellStyle(cs2);
	            
	            i++;
			}
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        wb.write(os);
	        
	        byte[] content = os.toByteArray();
	        InputStream is = new ByteArrayInputStream(content);
	        
	        // 设置response参数，可以打开下载页面
	        response.reset();
	        response.setContentType("application/vnd.ms-excel;charset=utf-8");
	        String fileName = "产品服务价格";
	        if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(pdData.getString("priceLevel"))){
	        	fileName = "重点客户价格";
	        }else if(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(pdData.getString("priceLevel"))){
	        	fileName = "标准客户价格";
	        }else{
	        	fileName = "零散客户价格";
	        }
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
