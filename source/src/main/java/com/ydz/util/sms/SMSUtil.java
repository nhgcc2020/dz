package com.ydz.util.sms;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import com.ydz.util.StringUtil;
import com.ydz.wechat.util.JsonUtil;

import java.io.IOException;
import java.util.Map;

/**
 * 
* @ClassName: SMSUtil 
* @Description: 短信处理工具类
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2017年3月13日 下午3:02:14 
*
 */
public class SMSUtil {

	private static TaobaoClient client = 
			new DefaultTaobaoClient("http://gw.api.taobao.com/router/rest", "23370416", "695c7bd34cf85637f8584dd539b72b18");

	/**
	模板类型: 验证码
	<br>模板名称: 密码找回验证码
	<br>模板ID: SMS_9681068
	<br>模板内容: 验证码${code}，您正在尝试找回易对账的登录密码，请妥善保管账户信息。
	<br>申请说明: 找回密码验证码
	 */
    public static Map<String, Object> sendRetrieveCode(String code,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        req.setSmsParamString("{code:'"+code+"'}");
        req.setRecNum(phoneNum);
        req.setSmsTemplateCode("SMS_9681068");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }
    
    /**
	模板类型: 验证码
    <br>模板名称: 用户注册验证码
    <br>模板ID: SMS_5027358
    <br>模板内容: 验证码${code}，您正在注册成为${product}用户，感谢您的支持！
    <br>申请说明:
	 */
    public static Map<String, Object> sendCode(String code,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        //{code:"+String.valueOf(code)+",product:易对账}
        req.setSmsParamString("{code:'"+code+"',product:'易对账'}");
        req.setRecNum(phoneNum);
        req.setSmsTemplateCode("SMS_5027358");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }

    /**
     * 邀请生意伙伴（个人）用户邀请通知(live)<br>
    <br>模板类型: 短信通知
    <br>模板名称: 用户邀请通知(live-https)
    <br>模板ID: SMS_18360555
    <br>模板内容: ${company}的${name}邀您使用“易对账”记账-对账软件，点击https://yiduizhang.com/${para} 注册使用。订单确认-往来对账-在线支付更轻松。
    <br>申请说明: 修改模板中文字内容
     */
    public static Map<String,Object> sendInviteMsg(String company,String name,String url,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        req.setSmsParamString("{company:'"+company+"',name:'"+name+"',para:'"+url+"'}");
        req.setRecNum(phoneNum);
        //test: SMS_18210583  live: SMS_18360555 live-https:SMS_85805064
        req.setSmsTemplateCode("SMS_85805064");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }

    /**
     * 邀请生意伙伴（企业） 企业用户邀请通知(live)<br>
	    <br>模板类型: 短信通知
		<br>模板名称: 企业用户邀请通知(live-https)
		<br>模板ID: SMS_35925014
		<br>模板内容: ${company}的${name}邀您的企业${companyInvited}，使用“易对账”记账-对账软件，点击https://yiduizhang.com/${para} 注册使用。订单确认-往来对账-在线支付更轻松。
		<br>申请说明: 邀请企业性质的公司短信
     */
    public static Map<String,Object> sendInviteMsg4Com(String company,String name,String companyInvited,String url,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        req.setSmsParamString("{company:'"+company+"',name:'"+name+"',companyInvited:'"+companyInvited+"',para:'"+url+"'}");
        req.setRecNum(phoneNum);
        //test: 暂无  live: SMS_35925014 live-https:SMS_85985008
        req.setSmsTemplateCode("SMS_85985008");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }

    /**
 		模板类型: 短信通知
	<br>模板名称: 通知员工加入公司模板(live)
	<br>模板ID: SMS_18245706
	<br>模板内容: ${name}邀您加入${company}，点击https://yiduizhang.com/${para} 注册使用“易对账”记账-对账软件。
	<br>申请说明: 用于生产环境管理员添加员工后，通知对应员工
     */
    public static Map<String,Object> sendInviteEmpMsg(String company,String name,String url,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        req.setSmsParamString("{name:'"+name+"',company:'"+company+"',para:'"+url+"'}");
        req.setRecNum(phoneNum);
        //test: SMS_18345625  live: SMS_18245706 live-https: SMS_86145015
        req.setSmsTemplateCode("SMS_86145015");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }

    /**
     	模板类型: 验证码
		<br>模板名称: 修改密码验证码
		<br>模板ID: SMS_9670951
		<br>模板内容: 验证码${code}，您正在尝试修改易对账的登录密码，请妥善保管账户信息。
		<br>申请说明: 修改密码验证
     */
    public static Map<String, Object> sendModPwdCode(String code,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        //{code:"+String.valueOf(code)+",product:易对账}
        req.setSmsParamString("{code:'"+code+"'}");
        req.setRecNum(phoneNum);
        req.setSmsTemplateCode("SMS_9670951");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }


    /**
     	模板类型: 短信通知
		<br>模板名称: 同意员工申请模板
		<br>模板ID: SMS_41985037
		<br>模板内容: ${company}已同意您的加入申请，感谢您的支持
		<br>申请说明: 管理员同意员工申请后的短信通知
     */
    public static Map<String, Object> sendSussessToEmp(String comPanyName,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        req.setSmsParamString("{company:'"+comPanyName+"'}");
        req.setRecNum(phoneNum);
        req.setSmsTemplateCode("SMS_41985037");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }

    /**
     	模板类型: 短信通知
		<br>模板名称: 拒绝员工申请模板
		<br>模板ID: SMS_42075036
		<br>模板内容: ${company}，已拒绝您的加入申请，感谢您的支持
		<br>申请说明: 管理员拒绝员工申请后的短信通知
     */
    public static Map<String, Object> sendFailToEmp(String comPanyName,String phoneNum) throws ApiException, IOException {
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend( "extend" );
        req.setSmsType( "normal" );
        req.setSmsFreeSignName("易对账");
        //{code:"+String.valueOf(code)+",product:易对账}
        req.setSmsParamString("{company:'"+comPanyName+"'}");
        req.setRecNum(phoneNum);
        req.setSmsTemplateCode("SMS_42075036");
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
        return stringObjectMap;
    }
    
    /**
		模板类型: 短信通知
		<br>模板名称: 好友合作伙伴申请通知
		<br>模板ID: SMS_56635070
		<br>模板内容: ${partnerName} 申请您成为他的好友，赶紧登陆易对账通过工作台同意对方的申请吧。成为好友，对账有凭有据。
		<br>申请说明: 用于用户的客户或者供应商申请成为好友的通知信息
     */
    public static Map<String, Object> sendApplyTobeFriend(String receiveNum,String partnerName) throws ApiException, IOException {
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{partnerName:'"+partnerName+"'}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_56635070");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }

    /**
		模板类型: 短信通知
		<br>模板名称: 用户注册公司时通知(内部使用)
		<br>模板ID: SMS_56115087
		<br>模板内容: 通知：${name}使用${phoneNo}注册了${companyName}，请关注。
		<br>申请说明: 用于第一时间知道用户注册的公司信息便于后续跟踪使用情况。用户注册公司后发消息给boss
     */
    /*模板类型: 短信通知
    模板名称: 用户主动注册提醒
    模板ID: SMS_110260023
    模板内容: ${userName}通过${regType}用${userId}注册了${account}，注册地（${location}）
    申请说明: 用户不同注册类型的提醒通知，便于营销跟踪
    */
    public static Map<String, Object> sendNewCompanyToBoss(String receiveNum, String userName,String regTypeDesc, 
    		String phoneNo,String companyName,String location) 
    		throws ApiException, IOException {
    	if (StringUtil.isEmpty(receiveNum)) {
			return null;
		}
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	//{code:"+String.valueOf(code)+",product:易对账}
    	String smsMsg = "{userName:'"+userName+"',regType:'"+regTypeDesc+"',userId:'"+phoneNo+"',account:'"+companyName+"',location:'"+location+"'}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_110260023");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    /**
     * 
     * @Title: notifyComPartnerOrderChecking 
     * @param comShortname
     * @param orderCyl
     * @return
     * @return Map<String,Object>
     * @throws Exception 
     * @throws 
     * @Description:
		模板类型: 短信通知
		模板名称: 生成好友客户的对账单提醒yiduizhang
		模板ID: SMS_91800021
		模板内容: 您的生意伙伴${comShortname}创建的一笔对账单${orderCycle}，金额${totalPrice}元，请点击https://yiduizhang.com/${shareKey}查看，或打开“易对账”APP查看更多订单/对账单。
		申请说明: 用于用户生成对账单时提醒好友客户查看
     */
    public static Map<String,Object> notifyComPartnerOrderChecking(String receiveNum, String comShortname,String orderCycle,String totalPrice,String shareAddr) 
    		throws Exception{
    	if (StringUtil.isEmpty(comShortname)) {
			return null;
		}
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{comShortname:'"+comShortname+"',orderCycle:'"+orderCycle+"',totalPrice:'"+totalPrice+"',shareKey:'"+"st/"+shareAddr+" '}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_91800021");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    /**
     * 
     * @Title: notifyComPartnerOrderCheckingNoFriend 
     * @param receiveNum
     * @param comShortname
     * @param orderCycle
     * @return
     * @throws Exception
     * @return Map<String,Object>
     * @throws 
     * @Description:
		模板类型: 短信通知
		模板名称: 供应商生成非好友客户的对账单yiduizhang
		模板ID: SMS_91905005
		模板内容: 您的生意伙伴${comShortname}创建的一笔对账单${orderCycle}，金额${totalPrice}元，请点击https://yiduizhang.com/${shareKey}查看。
		申请说明: 用户的对账单通知客户已发送
     */
    public static Map<String,Object> notifyComPartnerOrderCheckingNoFriend(String receiveNum, String comShortname,String orderCycle,String totalPrice,String shareAddr) 
    		throws Exception{
    	if (StringUtil.isEmpty(comShortname)) {
			return null;
		}
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{comShortname:'"+comShortname+"',orderCycle:'"+orderCycle+"',totalPrice:'"+totalPrice+"',shareKey:'"+"st/"+shareAddr+" '}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_91905005");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    /**
     * 
     * @Title: main 
     * @param args
     * @return void
     * @throws 
     * @Description: 
     *  模板类型: 短信通知
		模板名称: 提醒安装工有安装任务-https
		模板ID: SMS_105090086
		模板内容: 您有一笔安装任务${installationNo} ，点击链接https://yiduizhang.com/${shareKey}查看具体任务。
		申请说明: 用于提醒安装工查看安装任务。
     */
    public static Map<String,Object> notifyInstallationOrderForInstaller(String receiveNum, String installationNo,String shareAddr) 
    		throws Exception{
    	if (StringUtil.isEmpty(installationNo)) {
			return null;
		}
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{installationNo:'"+installationNo+"',shareKey:'"+"st/"+shareAddr+" '}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_105090086");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    /**
     * 
     * @Title: main 
     * @param args
     * @return void
     * @throws 
     * @Description: 
     *  模板类型: 短信通知
		模板名称: 提醒安装工查看安装对账单-https
		模板ID: SMS_105130084
		模板内容: 您有一笔安装对账单${installationcheckingNo}，点击链接https://yiduizhang.com/${shareKey}查看对账单详情。
		申请说明: 用于提醒安装工查看安装对账单详情页面。
     */
    public static Map<String,Object> notifyInstallationCheckingOrderForInstaller(String receiveNum, String installationcheckingNo,String shareAddr) 
    		throws Exception{
    	if (StringUtil.isEmpty(installationcheckingNo)) {
    		return null;
    	}
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{installationcheckingNo:'"+installationcheckingNo+"',shareKey:'"+"st/"+shareAddr+" '}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_105130084");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    /**
     * 
     * @Title: notifyRechargeComPartner 
     * @param receiveNum
     * @param installationcheckingNo
     * @param shareAddr
     * @return
     * @throws Exception
     * @return Map<String,Object>
     * @throws 
     * @Description: 
     * 模板类型: 短信通知
		模板名称: 通知用户充值成功
		模板ID: SMS_107055098
		模板内容: 您的预存款账户于${rechargeDate} 在${comShortname}发生一笔充值，充值金额${rechargeMoney}元，充值人：${rechargeName}，账户余额：${balanceMoney}元。
		申请说明: 用于用户预先充值获取折扣的通知
     */
    public static Map<String,Object> notifyRechargeComPartner(String receiveNum, String rechargeDate,String comShortname,
    		String rechargeMoney,String rechargeName,String balanceMoney) 
    		throws Exception{
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{rechargeDate:'"+rechargeDate+"',comShortname:'"+comShortname+"',rechargeMoney:'"+rechargeMoney
				+"',rechargeName:'"+rechargeName+"',balanceMoney:'"+balanceMoney+"'}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_107055098");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    /**
     * 
     * @Title: notifyConsumeComPartner 
     * @param receiveNum
     * @param rechargeDate
     * @param comShortname
     * @param rechargeMoney
     * @param rechargeName
     * @param balanceMoney
     * @return
     * @throws Exception
     * @return Map<String,Object>
     * @throws 
     * @Description: 
     * 模板类型: 短信通知
		模板名称: 客户预存款账户扣款通知
		模板ID: SMS_107815011
		模板内容: 您的预存款账户于${rechargeDateTime}在${comShortname}发生一笔对账单扣款，对账单号：${checkingNo}，扣款金额：${consumeMoney}元，账户余额：${balanceMoney}元。
		申请说明: 用于通知客户的预存款扣钱及余额变动。
     */
    public static Map<String,Object> notifyConsumeComPartner(String receiveNum, String rechargeDateTime,String comShortname,
    		String checkingNo,String consumeMoney,String balanceMoney) 
    				throws Exception{
    	AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
    	req.setExtend( "extend" );
    	req.setSmsType( "normal" );
    	req.setSmsFreeSignName("易对账");
    	String smsMsg = "{rechargeDateTime:'"+rechargeDateTime+"',comShortname:'"+comShortname+"',checkingNo:'"+checkingNo
    			+"',consumeMoney:'"+consumeMoney+"',balanceMoney:'"+balanceMoney+"'}";
    	req.setSmsParamString(smsMsg);
    	req.setRecNum(receiveNum);
    	req.setSmsTemplateCode("SMS_107815011");
    	AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
    	Map<String,Object> stringObjectMap = JsonUtil.jsonToMap(rsp.getBody());
    	return stringObjectMap;
    }
    
    public static void main(String[] args) {
		try {
////			SMSUtil.notifyComPartnerOrderChecking("18516585377", "石四科技","(2017-08-01 ~ 2017-08-30)");
//			SMSUtil.notifyComPartnerOrderCheckingNoFriend("18516585377", "石四科技","(2017-08-01 ~ 2017-08-30)","2389.98","http://6du.in/2Tgkjw");
//			${userName}通过${regType}用${userId}注册了${account}，注册地（${location}）
			String userName = "赵四";
			String regTypeDesc = "苹果手机APP";
			String userId = "18516585377";
			String companyName = "上海仁石科技有限公司";
			String location = "上海市徐汇区";
//			String smsMsg = "{userName:'"+userName+"',regType:'"+regTypeDesc+"',userId:'"+userId+"',account:'"+companyName+"',location:'"+location+"'}";
			SMSUtil.sendNewCompanyToBoss("18516585377", userName, regTypeDesc, userId, companyName, location);
//			System.out.println(smsMsg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
