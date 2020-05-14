/**   
 * @Title: DownloadYdzClientController.java 
 * @Package com.ydz.controller.download 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月11日 下午6:13:03 
 * @version  
 */
package com.ydz.controller.download;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.util.EncryptUtils;
import com.ydz.util.FileDownload;
import com.ydz.util.StringUtil;

/** 
 * @ClassName: DownloadYdzClientController 
 * @Description: 下载易对账客户端软件处理控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月11日 下午6:13:03 
 * 
 */
@Controller
@RequestMapping(value = "download/file",produces = "plain/text; charset=UTF-8")
public class DownloadYdzClientController extends BaseController{
	
	@Resource
	private DZConfig dzConfig;
	
	/**
	 * 
	 * @Title: exportSalescheckingOrder2Excel 
	 * @param request
	 * @param response
	 * @return
	 * @return ModelAndView
	 * @throws 
	 * @Description: 下载易对账windows客户端软件
	 */
	@RequestMapping("ydzclient")
	public ModelAndView downloadClient(HttpServletRequest request,HttpServletResponse response){
		String version = request.getParameter("key1");
		if(StringUtil.isEmpty(version)){
			return null;
		}
		String fileName = null;
		String filePath = dzConfig.downloadFile;
		if(version.equalsIgnoreCase(EncryptUtils.getInstance().encryptToMD5("32"))){ //6364D3F0F495B6AB9DCF8D3B5C6E0B01
			fileName = "易对账安装包-32位.exe";
			filePath += dzConfig.clientVersion+"-32.exe";
		}else if(version.equalsIgnoreCase(EncryptUtils.getInstance().encryptToMD5("64"))){ //EA5D2F1C4608232E07D3AA3D998E5135
			fileName = "易对账安装包-64位.exe";
			filePath += dzConfig.clientVersion+"-64.exe";
		}
		
		try {
			FileDownload.fileDownload(response, filePath, fileName);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return null;
	}
	
	@RequestMapping("androidapp")
	public ModelAndView downloadAndroidApp(HttpServletRequest request,HttpServletResponse response){
		String type = request.getParameter("key1");
		if(StringUtil.isEmpty(type)){
			return null;
		}
		String fileName = null;
		String filePath = dzConfig.downloadFile;
		if(type.equalsIgnoreCase(EncryptUtils.getInstance().encryptToMD5("android-app"))){ //8D41656D58729589BF122DC28C3271E5
			fileName = "易对账.apk";
			filePath += "yiduizhang.apk";
		}
		
		try {
			FileDownload.fileDownload(response, filePath, fileName);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static void main(String[] args) {
		System.out.println(EncryptUtils.getInstance().encryptToMD5("android-app"));
	}

}
