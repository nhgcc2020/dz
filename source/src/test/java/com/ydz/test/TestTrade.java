package com.ydz.test;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONArray;
import com.ydz.dao.advert.PurchaseCheckingOrderMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseCheckingOrder;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.ydz.entity.system.CityLevel;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Menu;
import com.ydz.entity.system.RentalPeriod;
import com.ydz.entity.system.Voucher;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.MenuService;
import com.ydz.util.Const;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: TestTrade 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月18日 下午6:45:50 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 *  
 */
@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/ApplicationContext.xml",
		"classpath:spring/ApplicationContext-mvc.xml",
		"classpath:redis/spring-redis.xml" })
@Transactional
public class TestTrade extends AbstractJUnit4SpringContextTests{
	
	@Resource(name="tradeService")
	private TradeService tradeService;
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@Autowired
	private PurchaseCheckingOrderMapper purchaseCheckingOrderMapper;


	@Test
	public void test1(){
		Page page = new Page();
		page.setCurrentPage(1);
		page.setShowCount(300);
		PageData pageData = new PageData();
		pageData.put("purchasecheckingNo","D160913697571423");
		page.setPd(pageData);
		List<PurchaseCheckingOrder> purchaseCheckingOrder = purchaseCheckingOrderMapper.listPagePurchaseCheckingOrder(page);
		System.out.println(purchaseCheckingOrder);

	}

	@Test
	public void test2(){

		PageData pageData = new PageData();
		pageData.put("purchasecheckingNo","D160913697571423");
		PurchaseCheckingOrder purchaseCheckingOrder = purchaseCheckingOrderMapper.selectByPrimaryKey(pageData);
		System.out.println(purchaseCheckingOrder);

	}


	@Test
	public void findRentalPeriod(){
		try {
			PageData pd = new PageData();
			pd.put("comKey", "d1e704269bd646e79a8186f07c26098f");
			pd.put("endDate", DateUtil.getDate(new Date()));
			RentalPeriod rp = tradeService.getParseRentalPeriod(pd);
//			System.out.println(JSON.toJSONString(rp, mapping));
			System.out.println(JsonUtil.toCompatibleJSONString(rp));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	@Test
	public void trailBusinessPriceInit() throws Exception{
		PageData pd = new PageData();
		pd.put("rentalVersion", "03");
		pd.put("industryId", "1A");
		pd.put("cityLevel", "03");
		pd.put("comKey", "3bd1d1b8f43d42bbb86f938e57e8b699");
		pd.put("comId", "UR8TPW");
		pd.put("userKey", "6aa60e1156174a4ab2d844ad25b3c157");
		
		try {
			//tradeService.insertTrialBusiPriceCom(pd);
			Menu menu = new Menu();
			menu.setComKey(pd.getString("comKey"));
			menu.setIndustryId(pd.getString("industryId"));
			menu.setRentalVersion(pd.getString("rentalVersion"));
			Date nowDate = new Date();
			menu.setChangedTime(nowDate);
			menu.setCreateTime(nowDate);
			menuService.insertComMenu(menu);
			System.out.println("1");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("0");
		}
	}
	
	@Test
	public void getCreateVoucher() throws Exception{
		Date nowDate = new Date();
		Voucher voucher = new Voucher();
		voucher.setComKey("7870fadedb954628b98bb73668fec99c");
		voucher.setVoucherNo(CodeBuilderUtil.getInstance().getVoucherCode(10));
		voucher.setStartDate(nowDate);
//		String periodDay = commonService.getDictValue("VOUCHER_PERIOD_DAY");
		String periodDay = "5";
		voucher.setEndDate(DateUtil.addDay(nowDate, StringUtil.isNotEmpty(periodDay)==true?Integer.parseInt(periodDay):10)); //代金券有效期默认10天
		voucher.setPeriodDay(StringUtil.isNotEmpty(periodDay)==true?Integer.parseInt(periodDay):10);
		voucher.setStatus(RentalTradeEnum.VOUCHER_STATUS_UNUSED.getCode());
//		//根据不同的城市级别生成代金券金额
//		Company company = companyService.getCompanyByUserKey(pd.getString("comKey"));
//		PageData pdPara = new PageData();
//		
//        pdPara.put("cityId", company.getComCity());
//        CityLevel cityLevel = this.getCityLevel(pdPara);
//        String cityLevelString = cityLevel==null?"01":cityLevel.getCityLevel();
        
		voucher.setVoucherMoney(new BigDecimal(200));
		voucher.setVoucherName("注册赠送");
		voucher.setCreator("system");
		voucher.setCreateTime(nowDate);
		System.out.println(JsonUtil.toCompatibleJSONString(voucher));
		tradeService.insertVoucher(voucher);
		
		
	}
	
	public static void main(String[] args) {
		System.out.println(CodeBuilderUtil.getInstance().getAnyId(14));
		System.out.println(CodeBuilderUtil.getInstance().getPaySerial());
//		System.out.println(DateUtil.getIntervalDays("", "2023-11-20"));
		
//		SELECT com_key,com_name  FROM	ydz_company WHERE com_type = '1' and CREATOR in (SELECT user_key FROM ydz_user WHERE user_id = '13868888344') 
//		select * from ydz_rental_trade where com_key = 'fc5d6ed7e2b94da8a87f225652bf390a'
//		select * from ydz_rental_period where com_key = 'fc5d6ed7e2b94da8a87f225652bf390a'
	}

}
