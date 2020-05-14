/**   
 * @Title: AppAnonymousAccess.java 
 * @Package com.ydz.app.controller 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 8, 2018 1:38:38 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.app.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.service.common.CommonService;
import com.ydz.util.Logger;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppAnonymousAccess 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 8, 2018 1:38:38 PM 
 * @Description: 处理无需登录App即可访问的匿名请求
 */
@RestController
@RequestMapping(value="app/anonymous", produces = "application/json;charset=UTF-8")
public class AppAnonymousAccess extends BaseController{
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value="getValidRegisterDate", method = RequestMethod.GET)
	public String getValidRegisterDate(){
		return JsonUtil.toJsonString(commonService.getDictValue("IOS_VALID_REGISTER_DATE")); //获取在dict表中预配置的ios-app登录页判断是否打开注册入口的日期
	}
}
