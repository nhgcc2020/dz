/**   
 * @Title: TestReport.java 
 * @Package com.ydz.test 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月11日 上午10:49:53 
 * @version  
 */
package com.ydz.test;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSONArray;
import com.ydz.entity.report.ReportSalesOrderYMDAmount;
import com.ydz.service.report.ReportSalesOrderService;
import com.ydz.service.report.ReportWorkBenchService;
import com.ydz.util.PageData;
import com.ydz.wechat.util.JsonUtil;

@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/ApplicationContext.xml","classpath:spring/ApplicationContext-mvc.xml","classpath:redis/spring-redis.xml"})
public class TestReport extends AbstractJUnit4SpringContextTests{
	
	@Resource
	private ReportWorkBenchService benchService;
	
	@Resource
	private ReportSalesOrderService reportSalesOrderService; 
	
//	@Test
//	public void getDaiduizhangReport(){
//		String comKey = "06539e13ed6f4c1b941f5a459c69fb3a";
//		System.out.println(JsonUtil.toCompatibleJSONString(benchService.getDaiduizhangAmount(comKey)));
//	}
//	
//	@Test
//	public void getDaishoukuanReport(){
//		String year = "2017";
//		String comKey = "06539e13ed6f4c1b941f5a459c69fb3a";
//		System.out.println(JsonUtil.toCompatibleJSONString(benchService.getDaishoukuanAmount(year, comKey)));
//	}
	
	@Test
	public void getCompanyRecPayAmountReport(){
		PageData pd = new PageData();
		pd.put("comKey", "8894e8fe2bcc44a5a600d2848ba04f23");
		pd.put("startDate", "2017-11-01");
		pd.put("endDate", "2017-11-31");
		System.out.println(JsonUtil.toCompatibleJSONString(reportSalesOrderService.getCompanyRecPayAmounts(pd)));
	}

}
