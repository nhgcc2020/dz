package com.ydz.controller.base;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ydz.entity.system.User;
import com.ydz.util.Const;
import com.ydz.vo.UserVo;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.annotation.SessionAttributesHandler;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.entity.Page;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.UuidUtil;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());

	private static final long serialVersionUID = 6357869213649815390L;
	
	/**
	 * 得到PageData
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**
	 * 得到ModelAndView
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		
		return request;
	}

	/**
	 * 获取当前Shiro session中的用户
	 * @return
	 */
	public UserVo getSessionUservo(){
		return (UserVo) getShiroSession().getAttribute(Const.SESSION_USER);
	}

	/**
	 * 
	* @Title: getCurrentSession 
	* @param @return
	* @return HttpSession
	* @throws 
	* @Description: 获取httpsession对象
	*
	 */
	public HttpSession getCurrentSession(){
		return this.getRequest().getSession();
	}
	
	/**
	 * 
	* @Title: getCurrentUserVo 
	* @return
	* @return UserVo
	* @throws 
	* @Description: 获取微信当前用户对象
	 */
	public UserVo getWxCurrentUserVo(){
		return (UserVo) this.getCurrentSession().getAttribute(Const.SESSION_WECHAT);
	}
	
	public UserVo getAppCurrentUserVo(){
		return (UserVo) this.getRequest().getAttribute(Const.SESSION_APP_USER);
	}
	

	/**
	 * 得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		
		return UuidUtil.get32UUID();
	}
	
	/**
	 * 得到分页列表的信息 
	 */
	public Page getPage(){
		
		return new Page();
	}

	/**
	 * 获取带有分页信息的page对象
	 */
	public Page getPageWithParameter(){
		Page page = getPage();
		HttpServletRequest request = getRequest();
		String pageSize = request.getParameter("rows");
		String pageNo = request.getParameter("page");
		if(StringUtil.isEmpty(pageSize)){
			pageSize = request.getParameter("pageSize");
		}
		if(StringUtil.isEmpty(pageNo)){
			pageNo = request.getParameter("pageNo");
		}
		page.setShowCount(Integer.parseInt(pageSize));
		page.setCurrentPage(Integer.parseInt(pageNo));
		return page;
	}

	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}

	/**
	 * 获取用户IP
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		ip = ip==null?"":ip;
		List<String> listIP = Tools.strArray2List(StringUtil.StrList(ip));
		return listIP.get(0);
	}

	/**
	 * 获取验证码
	 * @param code
	 * @return
     */
	public String checkVerificationCode(String code){
		Map<String,Object> map = (Map<String, Object>) getRequest().getSession().getAttribute(Const.SESSION_VERIFICATION_CODE);

		if(map==null || map.get("code") == null){
			return "0";
		}
		String realCode = String.valueOf(map.get("code"));
		Date codeDate = (Date) map.get("time");
		Date now = new Date();
		if(code!= null && realCode != null && (codeDate.getTime()+(10*60*1000)) >= now.getTime() && code.equals(realCode)){
			return "1";
		}else{
			return "0";
		}
	}

	/**
	 * 获取验证码 （要求发送的手机号必须为当前用户的userid）
	 * @param code
	 * @return
	 */
	public boolean checkVerificationCodeByUserVo(String code){
		Map<String,Object> map = (Map<String, Object>) getRequest().getSession().getAttribute(Const.SESSION_VERIFICATION_CODE);
		UserVo userVo = (UserVo) getRequest().getSession().getAttribute(Const.SESSION_USER);

		if(map==null || map.get("code") == null || map.get("phone") == null || !map.get("phone").equals(userVo.getUserId())){
			return false;
		}


		String realCode = String.valueOf(map.get("code"));
		Date codeDate = (Date) map.get("time");


		Date now = new Date();
		if(code!= null && realCode != null && (codeDate.getTime()+(10*60*1000)) >= now.getTime() && code.equals(realCode)){
			return true;
		}else{
			return false;
		}
	}

	public boolean checkNewCodeByUserVo(String code){
		Map<String,Object> map = (Map<String, Object>) getRequest().getSession().getAttribute(Const.SESSION_VERIFICATION_CODE_NEW);
		UserVo userVo = (UserVo) getRequest().getSession().getAttribute(Const.SESSION_USER);

		if(map == null || map.get("newCode") == null){
			return false;
		}


		String realCode = String.valueOf(map.get("newCode"));
		Date codeDate = (Date) map.get("time");


		Date now = new Date();
		if(code!= null && realCode != null && (codeDate.getTime()+(10*60*1000)) >= now.getTime() && code.equals(realCode)){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 
	* @Title: getShiroSession 
	* @return
	* Session
	* @throws 
	* @Description: 获取Shiro Session
	 */
	public Session getShiroSession(){
		return SecurityUtils.getSubject().getSession(); 
	}


}
