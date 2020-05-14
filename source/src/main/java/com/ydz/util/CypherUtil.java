package com.ydz.util;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import com.ydz.util.*;

/** 
* @ClassName: CypherUtil 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月23日 下午8:39:17 
* @Description: TODO(这里用一句话描述这个类的作用) 
*  
*/
public class CypherUtil {
	   
	/**
	 * 
	* @Title: getSalt 
	* @param @param userId
	* @param @return
	* @return String
	* @throws 
	* @Description: 获取加密盐值
	*
	 */
	public static String getSalt(String key){
		return key + new SecureRandomNumberGenerator().nextBytes().toHex();
	}
	
	/**
	 * 
	* @Title: getEncryptedPassword 
	* @param @param userId
	* @param @param password
	* @param @param salt
	* @param @return
	* @return String
	* @throws 
	* @Description: 获得加密码
	*
	 */
	public static String getEncryptedPassword(String password,String salt){
	    SimpleHash hash = new SimpleHash(Const.ALGORITHMNAME, password, salt, Const.HASHITERATIONS); 
	    String encodedPassword = hash.toHex();  
		return encodedPassword;
	}
	
	public static void main(String[] args) {
		String userId = "18516585377";
		String password = "123";
		
//		String salt = CypherUtil.getSalt(UuidUtil.get32UUID().substring(0, 11));
		String salt = "75888c7940ea7dadffc2107ce315605917e49f983a5";
		String pass = CypherUtil.getEncryptedPassword(password,salt);
		System.out.println(salt);
		System.out.println(pass);
	}
}
