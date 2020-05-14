package com.ydz.filter;

import com.ydz.controller.base.BaseController;
import com.ydz.util.Const;
import com.ydz.vo.UserVo;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/** 
 * @ClassName: RentalCheckFilter 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月23日 下午6:13:11 
 * 
 */
public class WechatFilter extends BaseController implements Filter{

	private final String[] noFilterUrlList = new String[]{
			"/wx/acct/bindWechat",
			"/wx/acct/purData",
			"/wx/reg/signUp"
	};

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
						 FilterChain filterChain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) servletRequest;
		//当前路径是否过滤
		if (isNoFilter(req.getServletPath())) {
			filterChain.doFilter(servletRequest, servletResponse);
			return;
		}
		HttpServletResponse res = (HttpServletResponse) servletResponse;
		HttpSession session = req.getSession();
		UserVo user = (UserVo) session.getAttribute(Const.SESSION_WECHAT);
		//如果session里没有用户信息就重定向到登录页面
		if (user == null) {
			res.sendRedirect(req.getContextPath() + "/wechat/member/redirect-login.html");
		} else {
			filterChain.doFilter(servletRequest, servletResponse);
		}
		//filterChain.doFilter(servletRequest, servletResponse);
	}

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy() {

	}



	/**
	 * 判断是否过滤
	 *
	 * @param url
	 */
	private boolean isNoFilter(String url) {
		for (int i = 0; i < noFilterUrlList.length; i++) {
			if (url.indexOf(noFilterUrlList[i] + "") > -1) {
				return true;
			}
		}
		return false;
	}
}
