/**   
 * @Title: JWTUtil.java 
 * @Package com.ydz.util.jwt 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月12日 下午6:50:35 
 * @version  
 */
package com.ydz.util.jwt;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.auth0.jwt.JWTSigner;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.internal.com.fasterxml.jackson.databind.ObjectMapper;
import com.ydz.entity.pay.PaySettlement;
import com.ydz.entity.security.TokenInfo;


/** 
 * @ClassName: JWTUtil 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月12日 下午6:50:35 
 * 
 */
public class JWTUtil {
	
		  
	/**
	 * 秘钥
	 */
	 private static final byte[] SECRET = "XX#$%()(#*!()!KL<><MQLMNQNQJQK yiduizhang18516585377>?N<:{LWPW".getBytes();  
	 private static final String EXP = "exp";  
	 private static final String PAYLOAD = "payload";  
	 
	/**
	 * 
	 * @Title: sign 
	 * @param object
	 * @param maxAge
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 加密生成token
	 */
    private static <T> String sign(T object, long maxAge) {  
        try {  
            final JWTSigner signer = new JWTSigner(SECRET);  
            final Map<String, Object> claims = new HashMap<String, Object>();  
            ObjectMapper mapper = new ObjectMapper();  
            String jsonString = mapper.writeValueAsString(object);  
            claims.put(PAYLOAD, jsonString);  
            claims.put(EXP, System.currentTimeMillis() + maxAge);  
            return signer.sign(claims);  
        } catch(Exception e) {  
            return null;  
        }  
    }  
	      
	      
	/**
	 *   
	 * @Title: unsign 
	 * @param jwt
	 * @param classT
	 * @return
	 * @return T
	 * @throws 
	 * @Description: 解密token
	 */
    public static<T> T unsign(String jwt, Class<T> classT) {  
        final JWTVerifier verifier = new JWTVerifier(SECRET);  
        try {  
            final Map<String,Object> claims= verifier.verify(jwt);  
            if (claims.containsKey(EXP) && claims.containsKey(PAYLOAD)) {  
                long exp = (Long)claims.get(EXP);  
                long currentTimeMillis = System.currentTimeMillis();  
                if (exp > currentTimeMillis) {  
                    String json = (String)claims.get(PAYLOAD);  
                    ObjectMapper objectMapper = new ObjectMapper();  
                    return objectMapper.readValue(json, classT);  
                }  
            }  
            return null;  
        } catch (Exception e) {  
            return null;  
        }  
    }  
    
    public static String getToken(String userKey,String comKey,String industry,String remarks){
    	TokenInfo token = new TokenInfo();
    	token.setUserKey(userKey);
    	token.setComKey(comKey);
    	token.setIndustryId(industry);
    	token.setRemarks(remarks);
    	return JWTUtil.sign(token, 30L * 24L * 3600L * 1000L);
    }
    
    
    public static String getTokenByWechatPay(PaySettlement paySettlement){
    	return JWTUtil.sign(paySettlement, 30L * 24L * 3600L * 1000L);
    }
	      
}
