/**   
 * @Title: SalesOrderJob.java 
 * @Package com.ydz.job 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 5:38:44 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.job;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ydz.util.Logger;

/** 
 * @ClassName: SalesOrderJob 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 5:38:44 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
@Service
@EnableScheduling
public class OrderJob {
	
	public Logger logger = Logger.getLogger(this.getClass());
	
//	@Scheduled(cron="0/5 * *  * * ? ")
	public void execute() {
		logger.info("测试定时任务=======");
	}

}
