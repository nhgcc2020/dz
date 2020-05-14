package com.ydz.test;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.collections4.MapUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.common.Dict;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.init.MenuInit;
import com.ydz.entity.pay.PaySettlement;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.entity.project.OpportunityQuotationDetail;
import com.ydz.entity.project.OpportunityQuotationParaVO;
import com.ydz.entity.system.ComEmployee;
import com.ydz.entity.system.ComProPrice;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.ProjectEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.exception.YdzBusinessException;
import com.ydz.exception.YdzSystemRuntimeException;
import com.ydz.service.advert.AssignTaskService;
import com.ydz.service.advert.MediaService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.UuidUtil;
import com.ydz.util.jwt.JWTUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.ComPartnerTotalPriceVO;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: TestTrade 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月18日 下午6:45:50 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 *  
 */
@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/ApplicationContext.xml","classpath:spring/ApplicationContext-mvc.xml","classpath:redis/spring-redis.xml"})
@Transactional
public class TestService extends AbstractJUnit4SpringContextTests{
	
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Resource
	private CompanyService companyService;
	@Resource
	private CommonService commonService;
	@Resource
	private MenuService menuService;
	@Resource
	private EmployeeService employeeService;
	@Resource
	private PartnerService partnerService;
	@Resource
	private AssignTaskService assignTaskService;
	@Autowired
	private MediaService mediaService;
	
	
	@Test
	public void listComPriceToExcel(){
		PageData pd = new PageData();
		pd.put("comKey", "480ad80b6dc6443386c7104469afa5de");
		pd.put("pricingType", "1");
		pd.put("tier", "3");
		pd.put("priceLevel", "1");
		List<ComProPrice> results = companyService.selectComProPricesToExcel(pd);
		System.out.println(JSONArray.toJSONString(results));
	}
	
	@Test
	public void testComProPrice() throws Exception{
		String comKey = "c1d10d7efdb94800969d009c3ea60efc";
		String industryId = "1C";
		String pricingType ="1";
		String pCode = "0";
		List<ComProPrice> comProPrices = companyService.listComProPrice(industryId, comKey, pricingType, pCode,null,null);
		System.out.println(JsonUtil.toCompatibleJSONString(comProPrices));
	}
	@Test
	public void testComProPrice3() throws Exception{
		String comKey = "c1d10d7efdb94800969d009c3ea60efc";
		String industryId = "1C";
		String pricingType ="1";
		String pCode = "1-0101";
		List<ComProPrice> comProPrices = companyService.listComProPriceAndPriceLevel(industryId, comKey, pricingType, pCode,null,null,null);
		System.out.println(JsonUtil.toCompatibleJSONString(comProPrices));
	}
	
	@Test
	public void testAssignTask() throws Exception{
//		taskUserKey,comKey,status,startDate,endDate,partnerKey
		String comKey = "427a98717a894f75a446ecefdbccdf44";
		String partnerKey = null;
		String status = "1";
		String startDate  ="2017-06-03";
		String endDate  ="2017-07-04";
		String taskUserKey = "85272a12e0c243a080a85d3022203c8b";
		Page page = new Page();
		page.setCurrentPage(0);
		page.setShowCount(100);
		PageData pd = new PageData();
		pd.put("taskUserKey", taskUserKey);
		pd.put("staff", null);
		pd.put("comKey", comKey);
		pd.put("status", status);
		pd.put("startDate", startDate);
		pd.put("endDate", endDate);
		pd.put("partnerKey", partnerKey);
		page.setPd(pd);
		
		System.out.println(JsonUtil.toCompatibleJSONString(assignTaskService.listPageAssignTasks(page)));
	}
	
	@Test
	public void testComSettingClass() throws Exception{
		List<ComSettingClass> classes = mediaService.listMediaSettingClasses("MEDIA_SHOW");
		System.out.println(classes);
	}
	
	
	public static void main(String[] args) {
		List<PurchaseOrderDetail> details = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			PurchaseOrderDetail detail = new PurchaseOrderDetail();
			details.add(detail);
		}
		System.out.println(JsonUtil.toCompatibleJSONString(details));
	}

}