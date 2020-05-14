package com.ydz.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ydz.controller.base.BaseController;
import com.ydz.util.Const;
import com.ydz.util.FileUtil;
import com.ydz.vo.UserVo;

public class CORSFilter extends BaseController implements Filter {

	/** 
	 * @Title: init 
	 * @Description: (非 JavaDoc)
	 * @param filterConfig
	 * @throws ServletException 
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig) 
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	/** 
	 * @Title: doFilter 
	 * @Description: (非 JavaDoc)
	 * @param request
	 * @param response
	 * @param chain
	 * @throws IOException
	 * @throws ServletException 
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain) 
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		httpResponse.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
		httpResponse.setHeader("Access-Control-Max-Age", "3600");
		httpResponse.addHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
		httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
		httpResponse.setHeader("Access-Control-Allow-Origin", "*");
	    chain.doFilter(request, httpResponse);
	}

	/** 
	 * @Title: destroy 
	 * @Description: (非 JavaDoc) 
	 * @see javax.servlet.Filter#destroy() 
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}


}
