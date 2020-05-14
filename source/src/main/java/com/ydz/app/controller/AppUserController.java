/**   
 * @Title: UserController.java 
 * @Package com.ydz.app.controller 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:54:20 
 * @version  
 */
package com.ydz.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.User;
import com.ydz.enums.SystemEnum;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppUserController 
 * @Description: app用户控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:54:20 
 * 
 */
@RestController
@RequestMapping(value = "app/user", produces = "application/json;charset=UTF-8")
public class AppUserController extends BaseController{
	
	@Resource(name="userService")
	private UserService userService;
	
	/**
	 * 
	* @Title: getUserDetail 
	* @return
	* @return String
	* @throws 
	* @Description: 查看用户详情信息
	 */
    @RequestMapping(value = "detail",method = RequestMethod.GET)
    public String getUserDetail(HttpServletRequest request){
    	UserVo userVo = this.getAppCurrentUserVo();
        //根据userkey查询其所属的公司
        PageData pdPara = new PageData();
        pdPara.put("userKey", userVo.getUserKey());
        User userRes = null;
        try {
            userRes = userService.getUserById(pdPara);
            userVo.setNickName(userRes.getNickName());
            userVo.setNowProvince(userRes.getNowProvince());
            userVo.setNowCity(userRes.getNowCity());
            userVo.setNowCountry(userRes.getNowCountry());
            
            userVo.setLocalProvince(userRes.getLocalProvince());
            userVo.setLocalCity(userRes.getLocalCity());
            userVo.setLocalCountry(userRes.getLocalCountry());
            
            userVo.setQq(userRes.getQq());
            userVo.setTelBak(userRes.getTelBak());
            userVo.setEmail(userRes.getEmail());
            userVo.setAvatarPath(userRes.getAvatarPath());
            
            return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(userVo));
        } catch (Exception e) {
            e.printStackTrace();
            return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "查询失败"));
        }
    }
}
