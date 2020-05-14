package com.ydz.payment;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * wechat constants.
 *
 * @author pxy
 * @since 2016-10-10
 */
@Component
public class PingPPConstants {

    //Pingpp 管理平台对应的 API Key，api_key 获取方式：登录 [Dashboard](https://dashboard.pingxx.com)->点击管理平台右上角公司名称->开发信息-> Secret Key
    //sk_test_ibbTe5jLGCi5rzfH4OqPW9KC sk_live_iDCyfPaL48O0L0ejLK1SCaf5
    @Value("${pingpp.apiKey}")
    public String apiKey;

    //Pingpp 管理平台对应的应用 ID，app_id 获取方式：登录 [Dashboard](https://dashboard.pingxx.com)->点击你创建的应用->应用首页->应用 ID(App ID)
    @Value("${pingpp.appId}")
    public  String appId;

    //阿里成功回调
    @Value("${pingpp.aliSuccessUrl}")
    public String aliSuccessUrl;

}
