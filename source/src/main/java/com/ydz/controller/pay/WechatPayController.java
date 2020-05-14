package com.ydz.controller.pay;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.pay.PayMerchantId;
import com.ydz.entity.pay.PaySettlement;
import com.ydz.enums.OrderEnum;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PaySettlementService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.jwt.JWTUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.wechat.pay.WXPayUtil;
import com.ydz.wechat.pay.YdzWechatPayUtil;
import com.ydz.wechat.util.JsonUtil;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by Administrator on 2017/11/2.
 */
@RestController
@RequestMapping(value = "wechat/pay", produces = "plain/text; charset=UTF-8")
public class WechatPayController extends BaseController{
	
	@Resource private SalesOrderService salesOrderService;
	@Resource private PaySettlementService paySettlementService;
	@Resource private CommonService commonService;
	@Resource private DZConfig dzConfig;

    /**
     * 
     * @Title: doPay 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 发起支付请求
     */
    @RequestMapping(value = "doPay")
    public String doPay(HttpServletRequest request) throws Exception {
    	PageData pd = this.getPageData();
    	PaySettlement paySettlement = JWTUtil.unsign(pd.getString("key"), PaySettlement.class);
    	if (paySettlement==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法支付，请联系收款方"));
		}
    	if (paySettlement.getPayMoney()==null) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法支付，请联系收款方"));
    	}
		String randomString = WXPayUtil.generateNonceStr();
		
		
		pd.clear();
		pd.put("comKey", paySettlement.getComKey());
		PayMerchantId subPayMerchant = paySettlementService.selectOneMerchantId(pd);
		if (subPayMerchant==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法支付，请联系收款方"));
		}
		
//		paySettlement.setPayMoney(BigDecimal.ONE);
		pd.put("orderDesc", paySettlement.getOrderDesc());
		pd.put("randomString", randomString);
		pd.put("callback", dzConfig.webPath+"/wechat/pay/callback");
		pd.put("tradeNo", paySettlement.getTradeNo());
		pd.put("clientIP", this.getIpAddr(request));
//		pd.put("clientIP", "123.12.12.23");
		pd.put("subMerchantId", subPayMerchant.getMerchantId());
		pd.put("payMoney", Integer.toString(paySettlement.getPayMoney().intValue()));
		
		String reqBody = YdzWechatPayUtil.getReqBody(pd);
    	
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
            return JsonUtil.toCompatibleJSONString(result);
        }else{
//            System.out.println("成功");
            paySettlement.setClientIp(pd.getString("clientIP"));
            paySettlement.setIsPayed("0");
            paySettlement.setCreateTime(new Date());
            paySettlementService.insertOnePaySettlement(paySettlement);
            result.put("status","1");
            result.put("url",hm.get("code_url"));
            return JsonUtil.toCompatibleJSONString(result);
        }
    }


    @RequestMapping(value = "callback")
    public String notify(HttpServletRequest request,HttpServletResponse response) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while((line = br.readLine())!=null){
            sb.append(line);
        }
        Map<String, String> hm = WXPayUtil.xmlToMap(sb.toString());
        if(hm.get("result_code").equals("SUCCESS")){
        	String callback = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
	        String back_tradeNo = hm.get("out_trade_no");
	        responseContent(response,callback);
	        int result = paySettlementService.SavePaySalesCheckingOrder(back_tradeNo,OrderEnum.ACCOUNT_PAYEE_TYPE_WECHATAPP.getCode());
	        if (result <= 0) {
	        	responseContent(response,callback);
	        	throw new RuntimeException("微信付款失败");
			}else{
				responseContent(response,callback);
				return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("支付成功"));
			}
        }else {
        	return JsonUtil.toCompatibleJSONString(ResultUtil.error("支付失败，请联系收款方"));
		}
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
    
    @RequestMapping(value = "paykey")
    @ResponseBody
    public String getpayKey(){
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("salescheckingNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法支付，请联系收款方"));
		}
    	SalesCheckingOrder checkingOrder = null;
    	try {
			checkingOrder = salesOrderService.selectOneSalesCheckingOrder(pd);
			
			if (checkingOrder==null) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法支付，请联系收款方"));
			}
			pd.put("comKey", checkingOrder.getComKey());
			pd.put("checkingNo", checkingOrder.getSalescheckingNo());
			ReceiptPayment receiptPayment = salesOrderService.getReceiptPaymentInfo(pd);
			if (receiptPayment!=null) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("已经付款过了，请勿重复支付"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	PaySettlement paySettlement = new PaySettlement();
    	paySettlement.setTradeNo(CodeBuilderUtil.getInstance().getPaySerial());
    	paySettlement.setComKey(checkingOrder.getComKey());
    	paySettlement.setCheckingNo(checkingOrder.getSalescheckingNo());
    	paySettlement.setOrderDesc(checkingOrder.getOrderCycle()+" 的结算单");
    	paySettlement.setIndustryId(checkingOrder.getIndustryId());
    	paySettlement.setPartnerKey(checkingOrder.getPartnerKey());
    	paySettlement.setCreator(checkingOrder.getCreator());
    	paySettlement.setPayMoney(checkingOrder.getReceivablesMoney().multiply(dzConfig.payWechat));
    	
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.put("paykey", JWTUtil.getTokenByWechatPay(paySettlement));
    	resultMap.put("tradeNo", paySettlement.getTradeNo());
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
    
    @RequestMapping(value = "polling")
    @ResponseBody
    public String getPolling(){
    	PageData pd = this.getPageData();
    	PaySettlement paySettlement = paySettlementService.selectOnePaySettlement(pd);
    	if (paySettlement==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("支付不成功"));
		}
    	if ("1".equals(paySettlement.getIsPayed())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("支付成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("-1","支付不成功"));
		}
    }
    
}
