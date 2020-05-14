package com.ydz.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.entity.security.TokenInfo;
import com.ydz.enums.SystemEnum;
import com.ydz.util.Const;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.jwt.JWTUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.UserVo;

public class AppLoginHandlerInterceptor extends HandlerInterceptorAdapter{
	
	private RedisUtil redisUtil;
	

	public RedisUtil getRedisUtil() {
		return redisUtil;
	}

	public void setRedisUtil(RedisUtil redisUtil) {
		this.redisUtil = redisUtil;
	}


	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
			 /*
			 * 如果请求地址用包含app/anonymous，表示该请求是匿名访问无需登录验证。
			 */
			if (request.getRequestURI().indexOf("app/anonymous")>0) { 
				return true;
			}
			String token = request.getParameter("token");
			if(StringUtil.isEmpty(token)){
				response.setHeader("Content-type", "text/html;charset=UTF-8"); 
				response.getWriter().write(JSONArray.toJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR_VERIFY.getCode(), "验证失败")));
				return false;
			}
			TokenInfo tokenInfo = JWTUtil.unsign(token, TokenInfo.class);
			if (tokenInfo==null) {
				response.setHeader("Content-type", "text/html;charset=UTF-8"); 
				response.getWriter().write(JSONArray.toJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR_VERIFY.getCode(), "验证失败")));
				return false;
			}
			UserVo userVo = (UserVo)redisUtil.get(Const.REDIS_APPTOKEN+tokenInfo.getIndustryId()+tokenInfo.getComKey()+tokenInfo.getUserKey());
			if(userVo==null){
				response.setHeader("Content-type", "text/html;charset=UTF-8"); 
				response.getWriter().write(JSONArray.toJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR_VERIFY.getCode(), "验证失败")));
				return false;
			}else{
				request.setAttribute(Const.SESSION_APP_USER, userVo);
				return true;
			}
	}
}
