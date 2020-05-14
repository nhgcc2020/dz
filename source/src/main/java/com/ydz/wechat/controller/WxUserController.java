package com.ydz.wechat.controller;


import javax.annotation.Resource;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.User;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by pengxuyang on 16/11/4.
 * 微信用户控制器
 */
@Controller
@RequestMapping(value = "wx/user",produces = "plain/text; charset=UTF-8")
public class WxUserController extends BaseController {
	
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
    @RequestMapping(value = "detail")
    @ResponseBody
    public String getUserDetail(){
        UserVo userVo = getWxCurrentUserVo();
        //根据userkey查询其所属的公司
        if(userVo == null){
            return "0";
        }
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
            
            return JsonUtil.toCompatibleJSONString(userVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    /**
     * 
    * @Title: removeBind 
    * @return
    * @return String
    * @throws 
    * @Description: 解除微信绑定
     */
    @RequestMapping(value = "deleteBind")
    @ResponseBody
    public String removeBind(){
    	UserVo userVo = this.getWxCurrentUserVo();
    	try {
			userService.deleteBind(userVo.getUserKey(),Const.BIND_WECHAT);
			this.getCurrentSession().removeAttribute(Const.SESSION_WECHAT);
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
    }
}
