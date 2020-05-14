/**
 * 
 */
package com.ydz.controller.base;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.exception.YdzBusinessException;
import com.ydz.exception.YdzSystemRuntimeException;


/** 
 * @ClassName: TestController 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月30日 下午5:50:34 
 * 
 */
@Controller
@RequestMapping(value = "test/exception",produces = "plain/text; charset=UTF-8")
public class TestExceptionController extends BaseController{
	
	/** 
     * jump into the login page 
     *  
     * @return 
     * @throws YdzBusinessException 
     * @throws 
     * @throws BusinessException 
     */  
    @RequestMapping(value = "/forward-error")  
    public ModelAndView loginPage() throws YdzBusinessException {  
        return null; 
    }  
  
    /** 
     * get the json object 
     *  
     * @return 
     * @throws Exception 
     */  
    @RequestMapping(value = "/josontest")  
    public @ResponseBody  
    Map<String, Object> getjson() throws Exception {  
        Map<String, Object> map = new HashMap<String, Object>();  
        try {  
            map.put("content", "123");  
            map.put("result", true);  
            map.put("account", 1);  
            throw new Exception();  
        } catch (Exception e) {  
            throw new YdzBusinessException("detail of ajax exception information");  
        }  
    }  
  
    
  
    /** 
     * logout operation 
     *  
     * @param request 
     * @param response 
     * @return 
     */  
    @RequestMapping(value = "/logout.html")  
    public ModelAndView logout(HttpServletRequest request,  
            HttpServletResponse response) {  
  
        /* 
         * HttpServletRequest.getSession(ture) equals to 
         * HttpServletRequest.getSession() means a new session created if no 
         * session exists request.getSession(false) means if session exists get 
         * the session,or value null 
         */  
        HttpSession session = request.getSession(false);  
  
        if (session != null) {  
            session.invalidate();  
        }  
  
        return new ModelAndView("redirect:/index.jsp");  
    }  
  
    /** 
     * check the Captcha code 
     *  
     * @param request 
     * @param command 
     * @return 
     */  
    protected Boolean validateCaptcha(HttpServletRequest request, Object command) {  
        return true;  
    }  

}
