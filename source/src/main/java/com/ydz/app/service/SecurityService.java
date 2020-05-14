/**   
 * @Title: SecurityService.java 
 * @Package com.ydz.app.service 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月13日 上午11:25:11 
 * @version  
 */
package com.ydz.app.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.entity.security.TokenInfo;
import com.ydz.util.Const;
import com.ydz.util.StringUtil;
import com.ydz.util.jwt.JWTUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: SecurityService 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月13日 上午11:25:11 
 * 
 */
@Service
public class SecurityService {
	
	@Resource
	private RedisUtil redisUtil;
	
	public UserVo getUserVoByToken(String token){
		if (StringUtil.isEmpty(token)) {
			return null;
		}
		TokenInfo tokenInfo = JWTUtil.unsign(token, TokenInfo.class);
		if(tokenInfo==null){
			return null;
		}
		UserVo userVo = (UserVo)redisUtil.get(Const.REDIS_APPTOKEN+tokenInfo.getIndustryId()+tokenInfo.getComKey()+tokenInfo.getUserKey());
		return userVo;
	}
	
	public String setUserVoToToken(UserVo userVo){
		if(userVo==null){
			return null;
		}
		String tokenString = JWTUtil.getToken(userVo.getUserKey(), userVo.getComKey(), userVo.getDetailIndustryId(), null);
        redisUtil.setIntervalDay(Const.REDIS_APPTOKEN+userVo.getDetailIndustryId()+userVo.getComKey()+userVo.getUserKey(), userVo, 365);
		return tokenString;
	}
	
	public int clearLoginUser(String token){
		if (StringUtil.isEmpty(token)) {
			return Const.ERROR_CODE;
		}
		TokenInfo tokenInfo = JWTUtil.unsign(token, TokenInfo.class);
		if(tokenInfo==null){
			return Const.ERROR_CODE;
		}
		boolean state = redisUtil.del(Const.REDIS_APPTOKEN+tokenInfo.getIndustryId()+tokenInfo.getComKey()+tokenInfo.getUserKey());
		return state==true?Const.SUCCESS_CODE:Const.ERROR_CODE;
	}

}
