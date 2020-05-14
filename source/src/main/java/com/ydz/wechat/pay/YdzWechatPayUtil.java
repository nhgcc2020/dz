package com.ydz.wechat.pay;

import com.ydz.util.PageData;

/** 
 * @ClassName: YdzWechatPayUtil 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 8, 2017 2:06:58 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class YdzWechatPayUtil {
	
	private static final String APP_ID = "wx3f569c5ced5933fd";
	private static final String MERCHANT_ID = "1393746702";
	private static final String KEY="shanghairenshikejiyiduizhangosky";
	
	private static String getSignString(PageData pd) throws Exception{

		String sign = "appid="+APP_ID+
				"&body=" + pd.getString("orderDesc") +
				"&mch_id=" + MERCHANT_ID +
				"&nonce_str=" + pd.getString("randomString") + 
				"&notify_url=" + pd.getString("callback") + 
				"&out_trade_no=" + pd.getString("tradeNo") +
				"&spbill_create_ip=" + pd.getString("clientIP") +
				"&sub_mch_id=" + pd.getString("subMerchantId") +
				"&total_fee=" + pd.getString("payMoney") +
				"&trade_type=NATIVE" +
				"&key=" + KEY;
		return WXPayUtil.MD5(sign).toUpperCase();
	}
	
	/**
	 * 
	 * @Title: getReqBody 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 属性描述<br>
	 * appid 公众号ID(已有) <br>
	 * orderDesc 商品描述<br>
	 * merchantId 商户号(已有)<br>
	 * callback 回调通知地址<br>
	 * randomString 随机字符串<br>
	 * tradeNo 商户交易单号<br>
	 * subMerchantId 子商户号<br>
	 * clientIP 客户端IP<br>
	 * sign 签名<br>
	 * tradeType 交易类型默认NATIVE(已有)<br>
	 * payMoney 支付金额(单位：分)<br>
	 * 
	 */
	public static String getReqBody(PageData pd) throws Exception{
		String reqBody = "<xml>" +
                "<appid>" + APP_ID + "</appid>" +								//公众账号ID
                "<body>" + pd.getString("orderDesc") + "</body>" +      		//商品描述
                "<mch_id>" + MERCHANT_ID+"</mch_id>" +     						//商户号
                "<notify_url>"+pd.getString("callback")+"</notify_url>" + 		//通知地址
                "<nonce_str>"+pd.getString("randomString")+"</nonce_str>" +        //随机字符串
                "<out_trade_no>"+pd.getString("tradeNo")+"</out_trade_no>" +        //商户订单号
                "<sub_mch_id>"+pd.getString("subMerchantId")+"</sub_mch_id>" +      //子商户号
                "<spbill_create_ip>"+pd.getString("clientIP")+"</spbill_create_ip>" + //终端IP
                "<sign>"+getSignString(pd)+"</sign>" +                              //签名
                "<trade_type>NATIVE</trade_type>" +                                //交易类型
                "<total_fee>"+pd.getString("payMoney")+"</total_fee>" +             //标价金额 “分”
                "</xml>";
		return reqBody;
	}

}
