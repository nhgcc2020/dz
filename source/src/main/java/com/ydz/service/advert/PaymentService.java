package com.ydz.service.advert;

import com.pingplusplus.Pingpp;
import com.pingplusplus.model.Charge;
import com.ydz.config.DZConfig;
import com.ydz.payment.PingPPConstants;
import com.ydz.util.StringUtil;
import com.ydz.vo.PaymentVo;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.math.BigDecimal;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by pengxuyang on 16/10/10.
 */
@Service
public class PaymentService {

    @Resource
    PingPPConstants pingPPConstants;

    @Resource
    DZConfig dzConfig;
    /**
     * 
    * @Title: makeAliChargeMap 
    * @param paymentVo
    * @return
    * @return Map
    * @throws 
    * @Description: 支付宝支付构造传递参数
     */
    public Map makeAliChargeMap(PaymentVo paymentVo){
        Map<String, Object> chargeMap = new HashMap<String, Object>();
        Pingpp.apiKey = pingPPConstants.apiKey;

        BigDecimal amount = new BigDecimal(0);
        if(StringUtil.isNotEmpty(paymentVo.getActualPayNum())){
        	amount = new BigDecimal(paymentVo.getActualPayNum());
        }
        chargeMap.put("amount", amount.multiply(dzConfig.payAmountUnit));//订单总金额, 人民币单位：分（如订单总金额为 1 元，此处请填 100）
//      chargeMap.put("amount", 10);//订单总金额, 人民币单位：分（如订单总金额为 1 元，此处请填 100）
        chargeMap.put("currency", "cny");
        chargeMap.put("subject", "易对账软件服务-"+paymentVo.getRentalVersionValue());
        chargeMap.put("body", "易对账软件服务-"+paymentVo.getRentalVersionValue());
        chargeMap.put("order_no", paymentVo.getTradeKey());// 推荐使用 8-20 位，要求数字或字母，不允许其他字符
        chargeMap.put("channel", "alipay_pc_direct");// 支付使用的第三方支付渠道取值，请参考：https://www.pingxx.com/api#api-c-new
        chargeMap.put("client_ip", "127.0.0.1"); // 发起支付请求客户端的 IP 地址，格式为 IPV4，如: 127.0.0.1

        Map<String, String> app = new HashMap<String, String>();
        app.put("id", pingPPConstants.appId);
        chargeMap.put("app", app);

        Map<String, Object> extra = new HashMap<String, Object>();
        extra.put("success_url",pingPPConstants.aliSuccessUrl);
        chargeMap.put("extra", extra);
        return chargeMap;
    }

    /**
     * 
    * @Title: makeWXChargeMap 
    * @param paymentVo
    * @return
    * @return Map
    * @throws 
    * @Description: 微信支付构造传递参数
     */
    public Map makeWXChargeMap(PaymentVo paymentVo){
        // 设置 API Key
        Pingpp.apiKey = pingPPConstants.apiKey;
        // 设置私钥路径，用于请求签名
        URL privateKeyFilePath = this.getClass().getClassLoader().getResource("your_rsa_private_key.pem");
        Pingpp.privateKeyPath = privateKeyFilePath.getPath();

        Map<String, Object> chargeMap = new HashMap<String, Object>();
        BigDecimal amount = new BigDecimal(0);
        if(StringUtil.isNotEmpty(paymentVo.getActualPayNum())){
        	amount = new BigDecimal(paymentVo.getActualPayNum());
        }
//        chargeMap.put("amount", amount.multiply(new BigDecimal(dzConfig.payAmountUnit)));//订单总金额, 人民币单位：分（如订单总金额为 1 元，此处请填 100）
        chargeMap.put("amount", amount.multiply(dzConfig.payAmountUnit));//订单总金额, 人民币单位：分（如订单总金额为 1 元，此处请填 100）
//        chargeMap.put("amount", 0.01);//订单总金额, 人民币单位：分（如订单总金额为 1 元，此处请填 100）
        chargeMap.put("currency", "cny");
        //todo
        chargeMap.put("subject", "易对账软件服务-"+paymentVo.getRentalVersionValue());
        chargeMap.put("body", "易对账软件服务-"+paymentVo.getRentalVersionValue());
        chargeMap.put("order_no", paymentVo.getTradeKey());// 推荐使用 8-20 位，要求数字或字母，不允许其他字符
        chargeMap.put("channel", "wx_pub_qr");// 支付使用的第三方支付渠道取值，请参考：https://www.pingxx.com/api#api-c-new
        chargeMap.put("client_ip", "127.0.0.1"); // 发起支付请求客户端的 IP 地址，格式为 IPV4，如: 127.0.0.1

        Map<String, String> app = new HashMap<>();
        app.put("id", pingPPConstants.appId);
        chargeMap.put("app", app);

        Map<String, Object> extra = new HashMap<>();
        extra.put("product_id",paymentVo.getTradeKey());
        chargeMap.put("extra", extra);
        return chargeMap;
    }
}
