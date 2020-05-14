package com.ydz.wechat.util;

import com.alibaba.fastjson.JSON;
import com.ydz.exception.OrderException;
import com.ydz.exception.WechatException;
import com.ydz.util.Logger;
import com.ydz.util.StringUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.wechat.vo.PurchaseMsgVO;

import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by pxy on 2016/5/13.
 */
@Component
public class WechatUtil {
	
	public Logger logger = Logger.getLogger(this.getClass());

    public static String testToken = "";

    @Resource
    WechatConstants wechatConstants;

    @Resource
    RedisUtil redisUtil;

    //获取token
    public String getToken(){
        /////=====华丽分割线 ：以下为生产环境使用=====Start
        //1.首先从redis获取
        String token = (String) redisUtil.get(wechatConstants.tokenKey);
        //2.如果token为null(即：失效) ，则需重新获取然后设置时间
        if(token != null){
            return token;
        }else {
            //获取token
            String param =  "grant_type="+ wechatConstants.grantType+"&" +
                    "appid="+wechatConstants.appId+"&"+
                    "secret="+wechatConstants.secret;
            String result = SendRequestUtil.sendGet(wechatConstants.apiUrl,param);
            try {
                Map<String,Object> map = JsonUtil.jsonToMap(result);
                token = (String) map.get("access_token");
                redisUtil.setIntervalMinute(wechatConstants.tokenKey,token,Integer.valueOf(wechatConstants.tokenTime));
                return token;
            } catch (IOException e) {
                e.printStackTrace();
                return "0";
            }
        }
        //=====End=====
    }

    public String getOauthToken(String code) throws Exception {
        Map<String,Object> para = new HashMap<>();
        para.put("appid",wechatConstants.appId);
        para.put("secret",wechatConstants.secret);
        para.put("code",code);
        para.put("grant_type","authorization_code");

        String param =  "appid="+ wechatConstants.appId+"&" +
                "secret="+wechatConstants.secret+"&"+
                "code="+code+"&"+
                "grant_type=authorization_code";

        return SendRequestUtil.sendGet(wechatConstants.oauth2Url,param);
    }

    /**
     * 
     * @Title: sendTemMsg 
     * @param purchaseMsgVO
     * @return
     * @return String
     * @throws 
     * @Description: 向绑定微信服务号的用户发送订单信息
     * 示例：
     * 您有一张待收货订单未处理
		keyword1项目名称：会展活动
		keyword2订单来源：上海仁石科技有限公司
		keyword3订单编号：XS201608152411239
		keyword4订单金额：12600.00元
		keyword5订单日期：2016-08-31
		keyword6订单周期：2017-11-25 至 2017-11-25
		如有疑问，请拨打咨询热线021-61552159。
     */
    public String sendTemMsg(PurchaseMsgVO purchaseMsgVO,String type){
        String token = getToken();
        String url = wechatConstants.notifyMessageUrl + token;
        Map<String,Object> map = new HashMap<>();
        map.put("touser",purchaseMsgVO.getOpenId());
//        map.put("template_id","Xx4DK_iDLhTaxp1xntdPHWnh4PwIgJ0U6i66eeIwl3M");
        map.put("template_id",purchaseMsgVO.getTemplateId()); 
        String callBackUrl = null;
        if ("PO".equals(type)) {
        	callBackUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wechatConstants.appId+"&redirect_uri="
        			+ wechatConstants.domainName+"/wx/acct/purData?purchaseNo=" + purchaseMsgVO.getOrderNo()
        			+ "&response_type=code&scope=snsapi_base&state=ydztest#wechat_redirect";
		}else if("PCO".equals(type)) {
			callBackUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wechatConstants.appId+"&redirect_uri="
        			+ wechatConstants.domainName+"/wx/acct/purData?purchasecheckingNo=" + purchaseMsgVO.getOrderNo()
        			+ "&response_type=code&scope=snsapi_base&state=ydztest#wechat_redirect";
		}
        map.put("url",callBackUrl);

        Map<String,Object> dataMap = new HashMap<>();

        Map<String,Object> userDataMap = new HashMap<>();
        userDataMap.put("value",purchaseMsgVO.getFirst()+"\n");
        dataMap.put("first",userDataMap);

        Map<String,Object> dateDataMap = new HashMap<>();
        dateDataMap.put("value",purchaseMsgVO.getProjectName()+"");
        dataMap.put("keyword1",dateDataMap);

        Map<String,Object> CardNumber = new HashMap<>();
        CardNumber.put("value",purchaseMsgVO.getOrderSource()+"");
        dataMap.put("keyword2",CardNumber);

        Map<String,Object> Type = new HashMap<>();
        Type.put("value",purchaseMsgVO.getOrderNo()+"");
        dataMap.put("keyword3",Type);

        Map<String,Object> Money = new HashMap<>();
        Money.put("value",purchaseMsgVO.getOrderMoney()+"元");
        Money.put("color","#ff0000");
        dataMap.put("keyword4",Money);

        Map<String,Object> orderDate = new HashMap<>();
        orderDate.put("value",purchaseMsgVO.getOrderDate()+"");
        dataMap.put("keyword5",orderDate);
        
        if (StringUtil.isNotEmpty(purchaseMsgVO.getOrderCycle())) {
        	Map<String,Object> orderCycle = new HashMap<>();
        	orderCycle.put("value",purchaseMsgVO.getOrderCycle()+"");
            dataMap.put("keyword6",orderCycle);
		}
        Map<String,Object> remark = new HashMap<>();
        remark.put("value","\n"+purchaseMsgVO.getRemark()+"\n");
        dataMap.put("remark",remark);

        map.put("data",dataMap);
        String json = JSON.toJSONString(map);
        try {
            String result = SendRequestUtil.sendPost(url,json);
            return result;
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new WechatException("采购单/采购对账单微信推送失败");
        }

    }

    //根据用户openID获取用户信息
    public static String getUserInfo(String FromUserName) throws IOException {
        String token = "";
                //Token.returnToken();
        //通过获取的openId 获取用户的具体信息
        String param = "access_token="+token+
                "&openid="+FromUserName+
                "&lang=zh_CN";
        //return  SendRequestUtil.sendGet(WechatConstants.USER_INFO_URL,param);
        return "";
    }

    //发送普通消息
    public String sendMsg(String FromUserName,String text) throws IOException {
        Map<String ,Object> para = new HashMap<>();
        para.put("touser",FromUserName);
        para.put("msgtype","text");
        logger.info(JsonUtil.toCompatibleJSONString(para));
        Map<String,Object> content = new HashMap<>();
        content.put("content",text);
        para.put("text",content);
        String json =  JsonUtil.mapToJson(para); 
        String result =  SendRequestUtil.sendPost("https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+getToken(),json);
        return result;
    }
}
