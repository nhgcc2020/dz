package com.ydz.controller.pay;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.wechat.pay.WXPayUtil;

import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by Administrator on 2017/11/2.
 */
@RestController
@RequestMapping(value = "wechat", produces = "plain/text; charset=UTF-8")
public class TestWechatPayController {

    /**
     * 支付
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "doPay")
    public Map<String, String> doPay() throws Exception {

    	String outTradeNo = "2017110721090502762333";

        String strA =
                "appid=wx3f569c5ced5933fd" +
                        "&body=仁石科技的对账单" +
                        "&mch_id=1393746702" +
                        "&nonce_str=tutm9na71mgm2587x86t20m6d5fd5dha" +
                        "&notify_url=http://uwr289.natappfree.cc/wechat/testcallback" +
                        "&out_trade_no="+outTradeNo +
                        "&spbill_create_ip=123.120.12.123" +
                        "&sub_mch_id=1489676432" +
                        "&total_fee=1" +
                        "&trade_type=NATIVE";
        String stringSignTemp =strA +"&key=shanghairenshikejiyiduizhangosky";

        String sign  = WXPayUtil.MD5(stringSignTemp).toUpperCase();

        String reqBody = "<xml>" +
                "<appid>wx3f569c5ced5933fd</appid>" +//公众账号ID
                "<body>仁石科技的对账单</body>" +      //商品描述
                "<mch_id>1393746702</mch_id>" +     //商户号
                "<notify_url>http://uwr289.natappfree.cc/wechat/testcallback</notify_url>" + //通知地址
                "<nonce_str>tutm9na71mgm2587x86t20m6d5fd5dha</nonce_str>" +         //随机字符串
                "<out_trade_no>"+outTradeNo+"</out_trade_no>" +         			//商户订单号
                "<sub_mch_id>1489676432</sub_mch_id>" +                             //子商户号
                "<spbill_create_ip>123.120.12.123</spbill_create_ip>" +              //终端IP
                "<sign>"+sign+"</sign>" +                                           //签名
                "<trade_type>NATIVE</trade_type>" +                                 //交易类型
                "<total_fee>1</total_fee>" +                                        //标价金额 “分”
                "</xml>";
        URL httpUrl = new URL("https://api.mch.weixin.qq.com/pay/unifiedorder");

        String UTF8 = "UTF-8";
        HttpURLConnection httpURLConnection = (HttpURLConnection) httpUrl.openConnection();
        httpURLConnection.setRequestProperty("Host", "api.mch.weixin.qq.com");
        httpURLConnection.setDoOutput(true);
        httpURLConnection.setRequestMethod("POST");
        httpURLConnection.setConnectTimeout(10*1000);
        httpURLConnection.setReadTimeout(10*1000);
        httpURLConnection.connect();
        OutputStream outputStream = httpURLConnection.getOutputStream();
        outputStream.write(reqBody.getBytes(UTF8));

        //获取内容
        InputStream inputStream = httpURLConnection.getInputStream();
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, UTF8));
        final StringBuffer stringBuffer = new StringBuffer();
        String line = null;
        while ((line = bufferedReader.readLine()) != null) {
            stringBuffer.append(line);
        }
        String resp = stringBuffer.toString();
        if (stringBuffer!=null) {
            try {
                bufferedReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (inputStream!=null) {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (outputStream!=null) {
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        System.out.println(resp);
        Map<String, String> hm = WXPayUtil.xmlToMap(resp);
        Map<String,String> result = new HashMap<String,String>();
        if(hm.get("return_code").equals("FAIL")){
            System.out.println("失败,原因："+hm.get("err_code_des"));
            result.put("status","0");
            result.put("msg",hm.get("err_code_des"));
            //todo 具体业务逻辑
        }else{
            System.out.println("成功");
            result.put("status","1");
            result.put("url",hm.get("code_url"));

        }
        return result;
    }


    @RequestMapping(value = "testcallback")
    public String notify(HttpServletRequest request,HttpServletResponse response) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while((line = br.readLine())!=null){
            sb.append(line);
        }
        Map<String, String> hm = WXPayUtil.xmlToMap(sb.toString());
        System.out.println(hm);
        //返回数据格式参考 {transaction_id=4200000022201711022036048621,nonce_str=b1089cb0231011e7b7e1484520356fdc, bank_type=CFT, openid=osKOSwy4mtrqtLE8J2RJ5uOxqIFo, sign=3EC43548807313BD6575A6C7B80D67A8, fee_type=CNY, mch_id=1393746702, sub_mch_id=1489676432, cash_fee=1, out_trade_no=20171909105959000000111119, appid=wx3f569c5ced5933fd, total_fee=1, trade_type=NATIVE, result_code=SUCCESS, time_end=20171102223258, is_subscribe=Y, return_code=SUCCESS}
        if(hm.get("result_code").equals("SUCCESS")){
            String callback = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
            responseContent(response,callback);
        }
        return "1";
    }

    /**
     * 响应xml
     * @param response
     * @param content
     */
    public static void responseContent(HttpServletResponse response, String content){
        try {
            //把xml字符串写入响应
            byte[] xmlData = content.getBytes();

            response.setContentLength(xmlData.length);

            ServletOutputStream os = response.getOutputStream();
            os.write(xmlData);

            os.flush();
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
