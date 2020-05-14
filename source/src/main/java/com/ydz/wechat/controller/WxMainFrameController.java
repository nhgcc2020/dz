package com.ydz.wechat.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ydz.controller.base.BaseController;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WxMainFrameController 
 * @Description: 微信主框架控制器，用于微信系统级控制，包括权限判断等
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年1月10日 下午6:17:43 
 * 
 */
@Controller
@RequestMapping(value = "wx/mainframe")
public class WxMainFrameController extends BaseController{
	
	@RequestMapping(value="userRoleInfo")
	@ResponseBody
	public String getUserRoleInfo(){
		UserVo userVo = this.getWxCurrentUserVo();
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("roleKey", userVo.getRoleKeys());
		jsonMap.put("industryId", userVo.getDetailIndustryId());
		
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}

}
