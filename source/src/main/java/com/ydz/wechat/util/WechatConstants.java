package com.ydz.wechat.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * wechat constants.
 *
 * @author pxy
 * @since 2016-5-13
 */
@Component
public class WechatConstants {
    //域名
    @Value("${wechat.domainName}")
    public String domainName;

    //redis中的存储Token的Key
    @Value("${wechat.tokenKey}")
    public String tokenKey;

    @Value("${wechat.grantType}")
    public String grantType;

    @Value("${wechat.appId}")
    public String appId;

    @Value("${wechat.secret}")
    public String secret;

    @Value("${wechat.apiUrl}")
    public String apiUrl;

    @Value("${wechat.userInfoUrl}")
    public String userInfoUrl;

    @Value("${wechat.sendMsgUrl}")
    public String sendMsgUrl;

    @Value("${wechat.notifyMessageUrl}")
    public String notifyMessageUrl;

    @Value("${wechat.sns.oauth2Url}")
    public String oauth2Url;

    @Value("${wechat.sns.userInfoUrl}")
    public String snsUserInfoUrl;
    
    //========采购订单
    @Value("${wechat.pOrder.templateId}")
    public String pOrderTemplateId;
    @Value("${wechat.pOrder.first}")
    public String pOrderFirst;
    @Value("${wechat.pOrder.remark}")
    public String pOrderRemark;
    @Value("${wechat.pOrder.defaultCaseDesc}")
    public String defaultCaseDesc;
    
    //========采购对账单
    @Value("${wechat.pcheckingOrder.templateId}")
    public String pcheckingOrderTemplateId;
    @Value("${wechat.pcheckingOrder.first}")
    public String pcheckingOrderFirst;
    @Value("${wechat.pcheckingOrder.remark}")
    public String pcheckingOrderRemark;
    @Value("${wechat.pcheckingOrder.defaultCaseDesc}")
    public String checkingDefaultCaseDesc;

    @Value("${wechat.qrConnectUrl}")
    public String qrConnectUrl;

    @Value("${wechat.tokenTime}")
    public String tokenTime;


}
