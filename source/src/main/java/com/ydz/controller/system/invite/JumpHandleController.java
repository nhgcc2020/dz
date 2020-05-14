package com.ydz.controller.system.invite;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.User;
import com.ydz.service.system.UserService;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.redis.RedisUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by pengxuyang on 16/10/17.
 */
@Controller
public class JumpHandleController extends BaseController {

    
	@Resource private RedisUtil redisUtil;
    @Resource private DZConfig dzConfig;
    
    @Resource private UserService userService;

    @RequestMapping(value = "jh/{key}")
    public @ResponseBody ModelAndView JumpHandle(@PathVariable(value = "key") String key, HttpServletRequest request){
        String value = null;
        if(null != redisUtil.get("j_"+key)){
            value = (String) redisUtil.get("j_"+key);
        }
        if(value == null){
            return new ModelAndView("/jsp/invite/invalid");
        }else{
            return new ModelAndView("forward:"+value);
        }
    }
    
    @RequestMapping(value = "st/{key}")
	public ModelAndView dispatchShortUrl(@PathVariable(value = "key") String key, HttpServletRequest request){
		String dispatch = null;
		ModelAndView dispatchView = new ModelAndView();
		if (StringUtil.isEmpty(key)) {
			dispatchView.setViewName("404"); 
			return dispatchView;
		}
		
		if(null != redisUtil.get(key)){
			dispatch = (String) redisUtil.get(key);
        }
		if (StringUtil.isEmpty(dispatch)) {
			dispatchView.setViewName("404");
			return dispatchView;
		}
		dispatchView.setView(new RedirectView(dispatch));
		return dispatchView;
		
	}
    
    @RequestMapping(value = "promoter/{key}")
    public ModelAndView promoter(@PathVariable(value = "key") String key, HttpServletRequest request) throws UnsupportedEncodingException{
    	ModelAndView dispatchView = new ModelAndView();
    	if (StringUtil.isEmpty(key)) {
    		dispatchView.setView(new RedirectView(dzConfig.webPath));
    		return dispatchView;
    	}
    	PageData pdPara = new PageData();
    	pdPara.put("userKey", key);
    	User user = userService.getUserById(pdPara);
    	if (user==null) {
    		dispatchView.setView(new RedirectView(dzConfig.webPath));
    		return dispatchView;
		}
    	
    	dispatchView.setView(new RedirectView(dzConfig.webPath+"/mobile/app-promoter.jsp"));
//    	dispatchView.setView(new RedirectView("http://localhost:8080/mobile/app-promoter.jsp"));
    	dispatchView.addObject("name", user.getRealName());
    	dispatchView.addObject("key", user.getUserKey());
    	return dispatchView;
    	
    }
}
