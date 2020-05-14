package com.ydz.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.security.TokenInfo;
import com.ydz.entity.system.User;
import com.ydz.enums.SystemEnum;
import com.ydz.service.system.RoleService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.jwt.JWTUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.UserCompanyVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppAccountController 
 * @Description: app账号处理控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 上午10:28:38 
 * 
 */
@RestController
@RequestMapping(value = "app/account", produces = "application/json;charset=UTF-8")
public class AppAccountController extends BaseController{
	@Resource
	private SecurityService securityService;
	
	@Resource
	private UserService userService;
	@Resource
	private RoleService roleService;
	@Resource
	private RedisUtil redisUtil;
	
    @RequestMapping(value = "/loginapp", method = RequestMethod.POST)
	public String loginApp(HttpServletRequest request) throws Exception{
		PageData pd = this.getPageData();
		String userId = pd.getString("userId");
		String password = pd.getString("password");
		if(StringUtil.isEmpty(userId)
				||StringUtil.isEmpty(password)){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "用户名或密码错误，请再试一次"));
		}
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(userId,password);
	        try{
	            subject.login(token);
	            
	            UserCompanyVO userCompanyVO = userService.selectUserComByUserId(userId);
	            if(userCompanyVO == null){
	                return JSONArray.toJSONString(ResultUtil.error(1, "登录出错，请联系管理员"));
	            }
	            UserVo userVo = new UserVo();
	            userVo.setUid(userCompanyVO.getUid());
	            userVo.setUserKey(userCompanyVO.getUserKey());
	            userVo.setUserId(userCompanyVO.getUserId());
	            userVo.setNickName(userCompanyVO.getNickName());
	            userVo.setRealName(userCompanyVO.getRealName());
	            userVo.setAvatarPath(userCompanyVO.getAvatarPath());
	            userVo.setRegisterIp(userCompanyVO.getRegisterIp());

	            userVo.setComKey(userCompanyVO.getDefaultCom());
	            userVo.setComName(userCompanyVO.getComName());
	            userVo.setComShortname(userCompanyVO.getComShortname());
	            userVo.setComLogoPath(userCompanyVO.getComLogoPath());
	            userVo.setComIsvalid(userCompanyVO.getComIsvalid());
	            userVo.setComType(userCompanyVO.getComType());
	            userVo.setDefaultCom(userVo.getComKey());
	            
	            userVo.setDetailIndustryId(userCompanyVO.getIndustryId()); //查询对应的小行业ID
	            
	            //设置角色信息
	            if("1".equalsIgnoreCase(userCompanyVO.getIsAdmin())
	                    ||"1".equalsIgnoreCase(userCompanyVO.getIsBoss())){
	                userVo.setRoleKeys("ADMIN");
	            }else{
	            	pd.clear();
	                pd.put("comKey",userVo.getComKey());
	                pd.put("userKey",userVo.getUserKey());
	                userVo.setRoleKeys(roleService.getRolesStringByUser(pd));
	            }
	            userVo.setIsAdmin(userCompanyVO.getIsAdmin());
	            userVo.setIsBoss(userCompanyVO.getIsBoss());
	            return JsonUtil.toCompatibleJSONString(ResultUtil.appLogin("登陆成功", securityService.setUserVoToToken(userVo)));
	        }catch(AuthenticationException ex){
	            ex.printStackTrace();
	            return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "用户名或密码错误"));
	        }
	}
    
    @RequestMapping(value = "/logoutapp", method = RequestMethod.GET)
    public String logout(HttpServletRequest request){
    	int result = securityService.clearLoginUser(this.getPageData().getString("token"));
		if (result == Const.ERROR_CODE) {
			return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR_VERIFY.getCode()).intValue(), "验证失败"));
		}
		return JSONArray.toJSONString(ResultUtil.appLogout("退出成功", null));
    }
}
