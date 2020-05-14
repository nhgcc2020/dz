package com.ydz.resolver;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;

/** 
* @ClassName: MyExceptionResolver 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月4日 下午3:34:57 
* @Description: TODO(这里用一句话描述这个类的作用) 
*  
*/
public class YdzExceptionResolver implements HandlerExceptionResolver{

	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		// TODO Auto-generated method stub
		System.out.println("==============异常开始=============");
		System.out.println(DateUtil.DateToString(new Date(), DateStyle.YYYY_MM_DD_HH_MM_SS_CN));
		ex.printStackTrace();
		System.out.println(DateUtil.DateToString(new Date(), DateStyle.YYYY_MM_DD_HH_MM_SS_CN));
		System.out.println("==============异常结束=============");
		ModelAndView mv = new ModelAndView("error");
		mv.addObject("exception", ex.toString().replaceAll("\n", "<br/>"));
		return mv;
	}

}
