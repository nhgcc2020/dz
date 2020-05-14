package com.ydz.util.sms;

import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import com.ydz.wechat.util.JsonUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * 
* @ClassName: SMSUtil 
* @Description: 短信处理工具类
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2017年3月13日 下午3:02:14 
*
 */
public class SMSUtils {

	private static TaobaoClient client = 
			new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "LTAIRxVOweQYbsm2", "fDAZMxICYB6pjxLb7T90bGN7LXjrtr");

	
	/**
	 * 
	 * @Title: notifyToChengguan 
	 * @param receiveNum
	 * @param rechargeDateTime
	 * @param comShortname
	 * @param checkingNo
	 * @param consumeMoney
	 * @param balanceMoney
	 * @return
	 * @throws Exception
	 * @return Map<String,Object>
	 * @throws 
	 * @Description:

		模版类型:
		短信通知
		模版名称:
		噪声超标通知执法者
		模版CODE:
		SMS_143866319
		模版内容:
		${userName}队长您好，经平台监测分析，${constructionName}工地（${warningType}）。请前往报警现场处置。
		申请说明:
		噪声超标通知执法者
	 */
    public static Map<String,Object> notifyToChengguan(String receiveNum,String userName, String constructionName,String warningType) 
    				throws Exception{
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend("extend");
    	req.setSmsType("normal");
    	req.setSmsFreeSignName("翼轸信息");
    	String smsMsg = "{userName:'"+userName+"',constructionName:'"+constructionName+"',warningType:'"+warningType+"'}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_143866319");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    public static void main(String[] args) {
		try {
			Map<String,Object> resuMap = new HashMap<String, Object>();
			String userName = "赵四";
			String constructionName = "光谷创业街";
			String warningType = "超标";
			resuMap = SMSUtils.notifyToChengguan("18674061012", userName,constructionName,warningType);
			System.out.println(resuMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
