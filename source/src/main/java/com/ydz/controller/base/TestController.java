/**
 * 
 */
package com.ydz.controller.base;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.entity.Page;
import com.ydz.entity.common.OperateLog;
import com.ydz.service.common.LoggerService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.wechat.util.JsonUtil;


/** 
 * @ClassName: TestController 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月30日 下午5:50:34 
 * 
 */
@RestController
@RequestMapping(value = "test/common", produces = "application/json;charset=UTF-8")
public class TestController extends BaseController{
	
	@Autowired private LoggerService loggerService;
	
	 @RequestMapping(value = "testCookie")
	 public String testCookie(HttpServletResponse response){
		 String tmpString = "3453453445-34543543543";
		 Cookie cookie = new Cookie("openId", tmpString);
		 cookie.setDomain("localhost");
		 cookie.setPath("/");
		 response.addCookie(cookie);
		 return "jsp/company/employee";
	 }
	 
	 @RequestMapping(value = "getOperatorLog")
	 public String getOperatorLog(){
		 Page page = this.getPage();
		 page.setShowCount(100);
		 PageData pd = this.getPageData();
		 page.setPd(pd);
		 return JsonUtil.toCompatibleJSONString(loggerService.listOperateLog(page));
		 
	 }
	 @RequestMapping(value = "insertOperator")
	 public String insertOperator(@RequestBody OperateLog operateLog){
		 int result = loggerService.insertOperatorLog(operateLog);
		 if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("日志插入失败"));
		}else {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("日志插入成功"));
		}
	 }

}
