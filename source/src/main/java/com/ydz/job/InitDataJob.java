
package com.ydz.job;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ydz.service.common.InitializedDataToRedisService;
import com.ydz.util.Logger;

@Service("initDataJob")
public class InitDataJob{
	Logger logger = Logger.getLogger(InitDataJob.class);
	
		 
	@Resource(name="initializedDataToRedisService")
	InitializedDataToRedisService initializedDataToRedisService;
	public void work() throws Exception {
		logger.info("=======系统启动成功=======");
		
//		initializedDataToRedisService.clearAllComProductPrice();
//		initializedDataToRedisService.insertGlobalConfigToRedis();
//		initializedDataToRedisService.insertProvinceCityCountryToRedis();
		logger.info("=======数据初始化成功=======");
		
	}
}
