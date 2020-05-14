/**   
 * @Title: ExcelSalesOrderController.java 
 * @Package com.ydz.controller.export 
 * @Description: 销售订单对账单的excel导出处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月8日 下午2:23:24 
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
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.data.redis.core.RedisAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.common.City;
import com.ydz.entity.common.Country;
import com.ydz.entity.common.Province;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.OrderEnum;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.TotalSalesCheckingOrderDetailVO;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: ExcelSalesOrderController 
 * @Description: 销售订单对账单的excel导出处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月8日 下午2:23:24 
 * 
 */
@Controller
@RequestMapping(value = "toExcel/order",produces = "plain/text; charset=UTF-8")
public class ExcelSalesOrderController extends BaseController{
	
	@Resource private SalesOrderService salesOrderService;
	@Resource private CommonService commonService;
//	@Resource private CompanyService companyService;
	@Resource private PartnerService partnerService;
	
	@Resource private RedisUtil redisUtil;
	
	@RequestMapping("salescheckingorder")
	public ModelAndView exportSalescheckingOrder2Excel(HttpServletRequest request,HttpServletResponse response){
		UserVo userVo = this.getSessionUservo();
		PageData pdData = this.getPageData();
		if(StringUtil.isEmpty(pdData.getString("salescheckingNo"))){
			return null;
		}
		try {
			pdData.put("comKey",userVo.getComKey());
			SalesCheckingOrder checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pdData); // 对账单
			String orderStatus = checkingOrder.getOrderStatus();  //待收款对账单最后显示应收总金额，已收款对账单最后显示实收总金额
			List<TotalSalesCheckingOrderDetailVO> detailVOs = salesOrderService.listSalesCheckingOrderDetail(pdData); //对账单明细
			
//			CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(),checkingOrder.getPartnerKey());
			pdData.put("partnerKey", checkingOrder.getPartnerKey());
			pdData.put("contacterId", checkingOrder.getContactId());
			PartnerVO partnerVO = partnerService.selectOnePartnerAndContacterByPartnerKey(pdData);
			
			// 创建excel工作簿
	        Workbook wb = new HSSFWorkbook();
	        // 创建第一个sheet（页），并命名
	        Sheet sheet = wb.createSheet("销售对账单");
	       
	        
	        String row1 = "企业名称,销售对账单号,客户名称,联系人,联系电话,项目名称,订单周期,客户地址";
	        String row2 = "合计,折扣,减免,税款,对账单金额,预收总金额";
	        String colsString = "下单日期,订单号,业务内容,物料制作说明,长(m),宽(m),数量,面积,单位,单价,行小计,经办人,签字";
	        
	        List<String> row1List = Tools.strArray2List(StringUtil.StrListByPattern(row1, ","));
	        for (int i = 0; i < row1List.size(); i++) {
	        	sheet.setColumnWidth((short) i, (short) (35.7 * 300));
			}
	        List<String> row2List = Tools.strArray2List(StringUtil.StrListByPattern(row2, ","));
	        for (int i = 0; i < row2List.size(); i++) {
	        	sheet.setColumnWidth((short) i, (short) (35.7 * 300));
			}
	        List<String> colsNameList = Tools.strArray2List(StringUtil.StrListByPattern(colsString, ","));
	        // 手动设置列宽。第一个参数表示要为第几列设；，第二个参数表示列的宽度，n为列高的像素数。
	        for (int i = 0; i < colsNameList.size(); i++) {
	        	sheet.setColumnWidth((short) i, (short) (35.7 * 150));
			}
	        
	        // 创建三种字体
	        
	        // 创建第一种字体样式列名
	        // 设置第一种单元格的样式 列名
	        Font f = wb.createFont();
	        f.setFontHeightInPoints((short) 12);
	        f.setColor(IndexedColors.BLACK.getIndex());
	        f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        f.setFontName("微软雅黑");
	        CellStyle cs = wb.createCellStyle();
	        cs.setFont(f);
	        cs.setBorderLeft(BorderStyle.THIN);
	        cs.setBorderRight(BorderStyle.THIN);
	        cs.setBorderTop(BorderStyle.THIN);
	        cs.setBorderBottom(BorderStyle.THIN);
	        
	        // 设置第二种单元格的样式 内容
	        Font f2 = wb.createFont();
	        // 创建第二种字体样式 内容
	        f2.setFontHeightInPoints((short) 12);
	        f2.setColor(IndexedColors.BLACK.getIndex());
	        f2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
	        f2.setFontName("微软雅黑");
	        CellStyle cs2 = wb.createCellStyle();
	        cs2.setFont(f2);
	        cs2.setBorderLeft(BorderStyle.THIN);
	        cs2.setBorderRight(BorderStyle.THIN);
	        cs2.setBorderTop(BorderStyle.THIN);
	        cs2.setBorderBottom(BorderStyle.THIN);
	        
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
	        
	      //========================= 销售对账单抬头
           
	        row = sheet.createRow((short) rowcount++);
        	cell = row.createCell(0);
	        cell.setCellValue(row1List.get(0));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
        	cell = row.createCell(0);
	        cell.setCellValue(userVo.getComName()); //企业名称
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(1));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(checkingOrder.getSalescheckingNo()); //销售对账单号
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(2));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(checkingOrder.getPartnerName()); //客户名称
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(3));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(checkingOrder.getContactName()); //联系人
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(4));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(partnerVO.getTel1()); //联系人电话
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(5));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(checkingOrder.getCaseDesc()); //项目名称
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(6));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(checkingOrder.getOrderCycle()); //订单周期
	        cell.setCellStyle(cs2);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(row1List.get(7));
	        cell.setCellStyle(cs);
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(0);
	        cell.setCellValue(this.getAddress(partnerVO)); //客户地址
	        cell.setCellStyle(cs2);
            
            row = sheet.createRow((short) rowcount++); //创建空行
	
            //=========================开始创建对账单明细数据
            
            row = sheet.createRow((short) rowcount++); // 创建列名行
	        // 创建列
	        for (int i = 0; i < colsNameList.size(); i++) {
	        	cell = row.createCell(i);
		        cell.setCellValue(colsNameList.get(i));
		        cell.setCellStyle(cs);
			}
	        
	        for (TotalSalesCheckingOrderDetailVO detailVO : detailVOs) {
	        	// Row 行,Cell 方格 , Row 和 Cell 都是从0开始计数的
	            // 创建一行，在页sheet上
	            row = sheet.createRow((short)rowcount++);
	            cell = row.createCell(0);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(DateUtil.DateToString(detailVO.getSalesOrderDate(), DateStyle.YYYY_MM_DD)); //订单下单日期
	            cell = row.createCell(1);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(detailVO.getSalesNo()); //订单号
	            cell = row.createCell(2);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(detailVO.getBusinessDesc()); //业务内容
	            cell = row.createCell(3);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(detailVO.getRequirements()); //物料制作说明
	            cell = row.createCell(4);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getLength().toString())); //长
	            cell = row.createCell(5);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getWidth().toString())); //宽
	            cell = row.createCell(6);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getQuantity().toString())); //数量
	            cell = row.createCell(7);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getTotalArea().toString())); //面积
	            cell = row.createCell(8);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(detailVO.getUnit()); //单位
	            cell = row.createCell(9);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getUnitPrice().toString())); //单价
	            cell = row.createCell(10);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(Double.parseDouble(detailVO.getTotalPrice().toString())); //行小计
	            cell = row.createCell(11);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(detailVO.getRemarks()); //经办人
	            cell = row.createCell(12);
	            cell.setCellStyle(cs2);
	            cell.setCellValue(""); //签字空格
			}
	        
	        row = sheet.createRow((short) rowcount++); //创建空行
	        
	        //=========================开始创建对账单底部数据
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(0));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue(Double.parseDouble(checkingOrder.getPrice().setScale(2,BigDecimal.ROUND_HALF_UP).toString())); //对账单合计金额
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(1));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue("- "+checkingOrder.getDiscount().toString()); //折扣
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(2));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue("- "+checkingOrder.getPreferential().toString()); //减免
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(3));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue(Double.parseDouble(checkingOrder.getTaxPrice().toString())); //税款
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(4));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue(Double.parseDouble(checkingOrder.getTotalPrice().toString())); //对账单金额
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++); //空行
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        cell.setCellValue(row2List.get(5));
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        cell.setCellValue("- "+checkingOrder.getDepositRequested().toString()); //预收总金额
	        cell.setCellStyle(cs3);
	        
	        row = sheet.createRow((short) rowcount++);
	        cell = row.createCell(8);
	        if (OrderEnum.STATUS_DAISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)) {
		        cell.setCellValue("应收总金额");
			}else if(OrderEnum.STATUS_YISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)){
				cell.setCellValue("实收总金额");
			}
	        cell.setCellStyle(cs);
	        cell = row.createCell(9);
	        if (OrderEnum.STATUS_DAISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)) {
            	cell.setCellValue(Double.parseDouble(checkingOrder.getReceivablesMoney().toString())); //应收总金额
			}else if(OrderEnum.STATUS_YISHOUKUAN.getCode().equalsIgnoreCase(orderStatus)){
				cell.setCellValue(Double.parseDouble(checkingOrder.getPaidUp().toString())); //实收总金额
			}
	        cell.setCellStyle(cs3);
            
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        wb.write(os);
	        
	        byte[] content = os.toByteArray();
	        InputStream is = new ByteArrayInputStream(content);
	        
	        // 设置response参数，可以打开下载页面
	        response.reset();
	        response.setContentType("application/vnd.ms-excel;charset=utf-8");
	        String fileName = checkingOrder.getPartnerShortname()+"的对账单"+"（"+checkingOrder.getOrderCycle()+"）";
	        
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
	
	private String getAddress(PartnerVO partnerVO){
		String cityId = partnerVO.getPartnerCity();
		String countryId = partnerVO.getPartnerCountry();
		
		String address = "";
        Object objCityId = redisUtil.get(Const.CITY_REDIS+cityId);
        Object objCountryId = redisUtil.get(Const.COUNTRY_REDIS+countryId);
        
        if (objCityId!=null) {
        	City city = (City)objCityId;
        	address += city.getCityName();
		}
        if (objCountryId!=null) {
			Country country = (Country)objCountryId;
			address += country.getCountryName();
		}
        address +=partnerVO.getPartnerAddress();
        return address;
	}

}
