package com.ydz.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ydz.wechat.util.JsonUtil;
import com.ydz.wechat.util.SendRequestUtil;

/** 
* @ClassName: PublicUtil 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月30日 上午10:58:56 
* @Description: 公共Util类，用公共处理
*  
*/
public class PublicUtil {
	private static String TAOBAO_IP_PATH="http://ip.taobao.com/service/getIpInfo.php";
	private static String IPIP_PATH = "http://freeapi.ipip.net/";
	
	private static PublicUtil util = new PublicUtil();
	private PublicUtil(){}
	
	public static PublicUtil getInstance(){
		return util;
	}
	
	public String getPorjectPath(){
		String nowpath = "";
		nowpath=System.getProperty("user.dir")+"/";
		
		return nowpath;
	}
	
	/**
	 * 获取本机ip
	 * @return
	 */
	public static String getIp(){
		String ip = "";
		try {
			InetAddress inet = InetAddress.getLocalHost();
			ip = inet.getHostAddress();
			//System.out.println("本机的ip=" + ip);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		
		return ip;
	}

	/**
	 * 
	* @Title: getIpLocation2Json 
	* @param @param ip
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据传入的ip获取国家、区域、省、市、县
	*
	 * 返回数据格式：
	{"code":0,
	"data":{
	"ip":"210.75.225.254",
	"country":"\u4e2d\u56fd",
	"area":"\u534e\u5317",
	"region":"\u5317\u4eac\u5e02",
	"city":"\u5317\u4eac\u5e02",
	"county":"",
	"isp":"\u7535\u4fe1",
	"country_id":"86",
	"area_id":"100000",
	"region_id":"110000",
	"city_id":"110000",
	"county_id":"-1",
	"isp_id":"100017"}}
	其中code的值的含义为，0：成功，1：失败。
	 *
	 */
	
	public Map getTaobaoIpLocation(String ip){	
		if(StringUtil.isEmpty(ip)){
			return null;
		}
		Map<String,Object> map = new HashMap<>();
		String ipJson = SendRequestUtil.sendGet(PublicUtil.TAOBAO_IP_PATH,"ip="+ip);
		JSONObject ipJsonObject = JSONObject.parseObject(ipJson);
		if(ipJsonObject==null){
			return map;
		}
        String code   =  ipJsonObject.getString("code");
        if("0".equals(code)){
            JSONObject jsonObject = ipJsonObject.getJSONObject("data");
            map.put("state","0");
            
            map.put("region",jsonObject.getString("region"));
            map.put("region_id",jsonObject.getString("region_id"));
            
            map.put("city",jsonObject.getString("city"));
            map.put("city_id",jsonObject.getString("city_id"));

            map.put("county",jsonObject.getString("county"));
            map.put("county_id",jsonObject.getString("county_id"));

        }else{
            map.put("state","1");
        }
		
		return map;
	}
	
	private String getIPIPIpLocation2Json(String ip){
		return SendRequestUtil.sendGet(PublicUtil.IPIP_PATH,"ip="+ip);
	}
	
	public String getLoginIpLocation(String ip){
		String resultString = null;
		if ("0:0:0:0:0:0:0:1".equalsIgnoreCase(ip)
				||"127.0.0.1".equalsIgnoreCase(ip)) {
			return "开发人员IP";
		}
		String ipString = this.getIPIPIpLocation2Json(ip);
		if(StringUtil.isNotEmpty(ipString)){
			List<String> list = (List<String>) JSONArray.parse(ipString);
			resultString = list.get(1)+list.get(2);
		}
		return resultString;
	}
	
	private String getPhoneLocation2Json(String phone){
		phone = phone.substring(0, 7);
		String dtype = "json";
		String key="7f56eab4be55f7e3cff9dce6abd7d20e";
		return SendRequestUtil.sendGet("http://apis.juhe.cn/mobile/get", "phone="+phone+"&dtype="+dtype+"&key="+key);
	}
	
	/**
	 * 
	* @Title: getPhoneLocation 
	* @param @param phone
	* @param @return
	* @return Map
	* @throws 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	*
	 */
	public Map getPhoneLocation(String phone){
		Map<String,Object> map = new HashMap<>();
		JSONObject phoneJsonObject = JSONObject.parseObject(this.getPhoneLocation2Json(phone));
		String resultcode = phoneJsonObject.getString("resultcode");
		if("200".equals(resultcode)){
			JSONObject jsonObject = phoneJsonObject.getJSONObject("result");
			map.put("state", "0");
			map.put("region", jsonObject.getString("province"));
			map.put("city", jsonObject.getString("city"));
		}else{
			map.put("state", "1");
		}
		return map;
	}
	
	/**
	 * 
	* @Title: getShortUrl 
	* @param @param longUrl
	* @param @return
	* @return String
	* @throws 
	* @Description: 传入长地址转为短地址
	 */
	public String getShortUrl(String longUrl){
		if(StringUtil.isEmpty(longUrl)){
			return null;
		}
		String param = null;
		String result = null;
		try {
			param = "is_api=1&lurl="+java.net.URLEncoder.encode(longUrl,"UTF-8");
		    result = SendRequestUtil.sendGet("http://6du.in/", param);
			if (StringUtil.isEmpty(result)) {
				return longUrl;
			}
			return result;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return longUrl;
	}

	
	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
		String result = PublicUtil.getInstance().getShortUrl("http://www.yiduizhang.com");
		System.out.println(result);
	}
	
}