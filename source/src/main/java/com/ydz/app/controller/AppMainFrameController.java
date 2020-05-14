package com.ydz.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.ResultMap;
import com.ydz.service.common.CommonService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: AppMainFrameController 
 * @Description: app工作台
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午6:16:24 
 * 
 */
@RestController
@RequestMapping(value = "app/mainframe", produces = "application/json;charset=UTF-8")
public class AppMainFrameController extends BaseController{
	
	@Resource
	private CommonService commonService;

	@RequestMapping(value = "/workbench",method = RequestMethod.GET)
	public String workbenchInfo(HttpServletRequest request){
		UserVo userVo = this.getAppCurrentUserVo();
		
		PageData pd = this.getPageData();
		pd.put("comKey",userVo.getComKey());
				
		ResultMap resultMap = new ResultMap();	
		resultMap.put("comKey", userVo.getComKey());
		resultMap.put("comName", userVo.getComName());
		resultMap.put("comShortname", userVo.getComShortname());
		resultMap.put("industryId", userVo.getDetailIndustryId());
		resultMap.put("todo", commonService.getTodoList(pd));
		
		return JSONArray.toJSONString(resultMap);
	}
	
}
