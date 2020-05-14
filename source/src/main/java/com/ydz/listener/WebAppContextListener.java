package com.ydz.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ydz.util.Const;

/** 
* @ClassName: WebAppContextListener 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月4日 下午3:34:06 
* @Description: TODO(这里用一句话描述这个类的作用) 
*  
*/
public class WebAppContextListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
	}

	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		Const.WEB_APP_CONTEXT = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
		//System.out.println("========获取Spring WebApplicationContext");
	}

}
