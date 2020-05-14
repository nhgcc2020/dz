package com.ydz.test;

import com.alibaba.fastjson.JSONArray;
import com.ydz.entity.init.MenuInit;
import com.ydz.entity.system.ComProPriceVO;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.wechat.util.JsonUtil;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.List;
import java.util.Map;



@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/ApplicationContext.xml","classpath:spring/ApplicationContext-mvc.xml","classpath:redis/spring-redis.xml"})
public class TestRedis extends AbstractJUnit4SpringContextTests{


    @Resource(name = "orderConfigService")
    OrderConfigService orderConfigService;
    
    @Resource
	RedisUtil redisUtil;
    
    @Resource(name="companyService")
    CompanyService companyService;
    
    @Test
    public void testRedisObject(){
    	List<ComProPriceVO> cppvos = null;
    	try {
			PageData pd = new PageData();
			pd.put("industryId", "1A");
			pd.put("comKey", "d1e704269bd646e79a8186f07c26098f");
			pd.put("pricingType", "1");
			pd.put("pCode","0");
			pd.put("tier", "3");
			cppvos = null;
			System.out.println(JSONArray.toJSONString(cppvos));
			long start = System.currentTimeMillis();
			redisUtil.setIntervalSecond("mykey", cppvos,10);
			System.out.println(System.currentTimeMillis()-start);
			Thread.sleep(10000);
			Object object = redisUtil.get("mykey");
	        if(object!=null){
//	        	cppvos = (List<ComProPriceVO>) object;
	        	System.out.println(JSONArray.toJSONString((List<ComProPriceVO>) object));
	        }else{
	        	System.out.println("已过期");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    @Test
	public void testToken(){
		System.out.println(JsonUtil.toCompatibleJSONString((Map<String, Object>)redisUtil.get(Const.REDIS_GLOBALCONFIG_PRICEWAY+"1C")));
	}

	@Test
	public void test2(){
		String shareUrl = "https://test.yiduizhang.com/ordershare/saleschecking-order-detail-share.html?"
				+ "key1=52DEEDC304735ECD42115749251898B4CBD07E4C504696EEF752081FC632DFC59A24C1A368F019B1DF28268110E904ABC9DBF9459807DC33";
		String key = CodeBuilderUtil.getInstance().getVoucherCode(6);
		System.out.println(key);
        redisUtil.setIntervalDay(key, shareUrl, 1);
	}
}
