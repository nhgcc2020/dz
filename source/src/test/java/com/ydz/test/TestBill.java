/**   
 * @Title: TestBill.java 
 * @Package com.ydz.test 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2019 10:17:24 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.test;

import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;

/** 
 * @ClassName: TestBill 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2019 10:17:24 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class TestBill {
	@Autowired
	public static void main(String[] args) {
	    String host = "https://fapiaoocr.market.alicloudapi.com";
	    String path = "/textread";
	    String method = "POST";
	    String appcode = "f33e5cdb577e43f3877fd1b045c950df";
	    Map<String, String> headers = new HashMap<String, String>();
	    //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
	    headers.put("Authorization", "APPCODE " + appcode);
	    //根据API的要求，定义相对应的Content-Type
	    headers.put("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
	    Map<String, String> querys = new HashMap<String, String>();
	    Map<String, String> bodys = new HashMap<String, String>();
	    
	    String url = "/Users/ZhaoTech/Downloads/IMG_7751.jpg";        
        String str = Base64Utils.ImageToBase64ByLocal(url);
	    bodys.put("src", "图片base64编码");


	    try {
	    	/**
	    	* 重要提示如下:
	    	* HttpUtils请从
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
	    	* 下载
	    	*
	    	* 相应的依赖请参照
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
	    	*/
//	    	HttpResponse response = HttpUtils.doPost(host, path, method, headers, querys, bodys);
//	    	System.out.println(response.toString());
	    	//获取response的body
	    	//System.out.println(EntityUtils.toString(response.getEntity()));
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	}
}
