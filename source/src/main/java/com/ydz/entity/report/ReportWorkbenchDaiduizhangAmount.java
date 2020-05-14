/**   
 * @Title: ReportWorkbenchDaiduizhangAmount.java 
 * @Package com.ydz.entity.report 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月10日 下午6:30:39 
 * @version  
 */
package com.ydz.entity.report;

import java.io.Serializable;
import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;
import com.ydz.util.StringUtil;

/** 
 * @ClassName: ReportWorkbenchDaiduizhangAmount 
 * @Description: 工作台销售待对账订单报表统计
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月10日 下午6:30:39 
 * 
 */
public class ReportWorkbenchDaiduizhangAmount implements Serializable{

	private static final long serialVersionUID = 1876050448043843777L;
	
	private String price1;
	private String price2;
	private String price3;
	private String price4;
	private String price5;
	
	public String getPrice1() {
		if(StringUtil.isEmpty(price1)){
			price1 = "0.00";
		}
		return price1;
	}
	public void setPrice1(String price1) {
		this.price1 = price1;
	}
	public String getPrice2() {
		if(StringUtil.isEmpty(price2)){
			price2 = "0.00";
		}
		return price2;
	}
	public void setPrice2(String price2) {
		this.price2 = price2;
	}
	public String getPrice3() {
		if(StringUtil.isEmpty(price3)){
			price3 = "0.00";
		}
		return price3;
	}
	public void setPrice3(String price3) {
		this.price3 = price3;
	}
	public String getPrice4() {
		if(StringUtil.isEmpty(price4)){
			price4 = "0.00";
		}
		return price4;
	}
	public void setPrice4(String price4) {
		this.price4 = price4;
	}
	public String getPrice5() {
		if(StringUtil.isEmpty(price5)){
			price5 = "0.00";
		}
		return price5;
	}
	public void setPrice5(String price5) {
		this.price5 = price5;
	}
}
