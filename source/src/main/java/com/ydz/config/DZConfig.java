package com.ydz.config;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Created by pengxuyang on 16/11/22.
 */
@Component
public class DZConfig {

    @Value("${dz.filePath.logo}")
    public String filePathLogo;
    
    @Value("${dz.web.path}")
    public String webPath;
    
    @Value("${dz.payment.AmountUnit}")
    public BigDecimal payAmountUnit;
    
    @Value("${dz.payment.wechat}")
    public BigDecimal payWechat;
    
    @Value("${dz.phoneNo.boss}")
    public String bossNum;
    
    @Value("${dz.filePath.download}")
    public String downloadFile;
    
    @Value("${dz.client.version}")
    public String clientVersion;
    
    @Value("${dz.filePath.attachment}")
    public String attachmentFilePath;
    
    @Value("${dz.filePath.ydzHome}")
    public String ydzHome;

}
