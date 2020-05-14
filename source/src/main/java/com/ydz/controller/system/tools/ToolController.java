package com.ydz.controller.system.tools;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.taobao.api.ApiException;
import com.ydz.util.*;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;

/** 
 * 类名称：ToolController
 * 创建人：yiduizhang 
 * 创建时间：2016年4月4日
 * @version
 */
@Controller
@RequestMapping(value="/tool", produces = "plain/text; charset=UTF-8")
public class ToolController extends BaseController {
	
	
	/**
	 * 去接口测试页面
	 */
	@RequestMapping(value="/interfaceTest")
	public ModelAndView editEmail() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/interfaceTest");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 *	接口内部请求
	 * @param 
	 * @throws Exception
	 */
	@RequestMapping(value="/severTest")
	@ResponseBody
	public Object severTest(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success",str = "",rTime="";
		try{
			long startTime = System.currentTimeMillis(); 					//请求起始时间_毫秒
			URL url = new URL(pd.getString("serverUrl"));
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod(pd.getString("requestMethod"));		//请求类型  POST or GET	
			BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
			long endTime = System.currentTimeMillis(); 						//请求结束时间_毫秒
			String temp = "";
			while((temp = in.readLine()) != null){ 
				str = str + temp;
			}
			rTime = String.valueOf(endTime - startTime); 
		}
		catch(Exception e){
			errInfo = "error";
		}
		map.put("errInfo", errInfo);	//状态信息
		map.put("result", str);			//返回结果
		map.put("rTime", rTime);		//服务器请求时间 毫秒
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 发送邮件页面
	 */
	@RequestMapping(value="/goSendEmail")
	public ModelAndView goSendEmail() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/email");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 二维码页面
	 */
	@RequestMapping(value="/goTwoDimensionCode")
	public ModelAndView goTwoDimensionCode() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/twoDimensionCode");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 *	生成二维码
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/createTwoDimensionCode")
	@ResponseBody
	public Object createTwoDimensionCode(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success", encoderImgId = this.get32UUID()+".png"; //encoderImgId此处二维码的图片名
		String encoderContent = pd.getString("encoderContent");				//内容
		if(null == encoderContent){
			errInfo = "error";
		}else{
			try {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHTWODIMENSIONCODE + encoderImgId;  //存放路径
				TwoDimensionCode.encoderQRCode(encoderContent, filePath, "png");							//执行生成二维码
			} catch (Exception e) {
				errInfo = "error";
			}
		}
		map.put("result", errInfo);						//返回结果
		map.put("encoderImgId", encoderImgId);			//二维码图片名
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 *	解析二维码
	 * @param
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/readTwoDimensionCode")
	@ResponseBody
	public Object readTwoDimensionCode(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success",readContent="";
		String imgId = pd.getString("imgId");//内容
		if(null == imgId){
			errInfo = "error";
		}else{
			try {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHTWODIMENSIONCODE + imgId;  //存放路径
				readContent = TwoDimensionCode.decoderQRCode(filePath);//执行读取二维码
			} catch (Exception e) {
				errInfo = "error";
			}
		}
		map.put("result", errInfo);						//返回结果
		map.put("readContent", readContent);			//读取的内容
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	/**
	 * 多级别树页面
	 */
	@RequestMapping(value="/ztree")
	public ModelAndView ztree() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/ztree");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 地图页面
	 */
	@RequestMapping(value="/map")
	public ModelAndView map() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/map");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 获取地图坐标页面
	 */
	@RequestMapping(value="/mapXY")
	public ModelAndView mapXY() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/tools/mapXY");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 *	根据经纬度计算距离
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/getDistance")
	@ResponseBody
	public Object getDistance(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success",distance="";
		try {
			distance  = MapDistance.getDistance(pd.getString("ZUOBIAO_Y"),pd.getString("ZUOBIAO_X"),pd.getString("ZUOBIAO_Y2"),pd.getString("ZUOBIAO_X2"));
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		map.put("distance", distance);			//距离
		return AppUtil.returnObject(new PageData(), map);
	}




	/**
	 * 发送验证码
	 * @return
	 */
	@RequestMapping(value = "sendNewCode")
	@ResponseBody
	public String sendNewCode(String phone){
		long code = CodeBuilderUtil.getInstance().getSmsRandomCode(6);
		try {
			Map<String,Object> resMap =	SMSUtil.sendCode(String.valueOf(code),phone);

			Map<String,Object> map = new HashMap<>();
			map.put("newCode",code);
			map.put("newTime",new Date());
			getRequest().getSession().setAttribute(Const.SESSION_VERIFICATION_CODE_NEW,map);
			return "";
		} catch (ApiException e) {
			e.printStackTrace();
			return "fail";
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}
	}

	/**
	 * 发送验证码
	 * @return
     */
	@RequestMapping(value = "sendVerCode")
	@ResponseBody
	public String sendVerificationCode(String phone){
		long code = CodeBuilderUtil.getInstance().getSmsRandomCode(6);
		try {
			Map<String,Object> resMap =	SMSUtil.sendCode(String.valueOf(code),phone);
	
			Map<String,Object> map = new HashMap<>();
			map.put("code",code);
			map.put("time",new Date());
			getRequest().getSession().setAttribute(Const.SESSION_VERIFICATION_CODE,map);
			return "";
		} catch (ApiException e) {
			e.printStackTrace();
			return "fail";
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping(value = "sendRetrieveCode")
	@ResponseBody
	public String sendRetrieveCode(String phone){
		long code = CodeBuilderUtil.getInstance().getSmsRandomCode(6);
		try {
			Map<String,Object> resMap =	SMSUtil.sendRetrieveCode(String.valueOf(code),phone);
			Map<String,Object> map = new HashMap<>();
			map.put("code",code);
			map.put("time",new Date());
			getRequest().getSession().setAttribute(Const.SESSION_VERIFICATION_CODE,map);
			return "";
		} catch (ApiException e) {
			e.printStackTrace();
			return "fail";
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}
	}





	/**
	 * 校验验证码
	 * @return
	 */
	@RequestMapping("verificateCode")
	@ResponseBody
	public String getSendVerificationCode(String code){
		return  checkVerificationCode(code);
	}


	@RequestMapping(value = "getPinYinHeadChar", produces = "plain/text; charset=UTF-8")
	@ResponseBody
	public String getPinYinHeadChar(String str){
		String headStr = GetPinyin.getPinYinHeadChar(str);
		return headStr;
	}

}
