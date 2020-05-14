package com.ydz.util.Security;

import org.apache.commons.codec.binary.Base64;

/**
 * Created by ydz on 2016/6/24.
 */
public class CipherUtil {

    /**
     * 加密
     * todo 目前为base64对字符串进行编码
     * @param str
     * @return
     */
    public static String encrypt(String str){
        byte[] bytes = str.getBytes();
        return Base64.encodeBase64String(bytes);
    }

    /**
     * 解密
     * todo 目前为base64对字符串进行解码
     * @param str
     * @return
     */
    public static String decrypt(String str){
        byte[] bytes = Base64.decodeBase64(str);
        return new String(bytes);
    }
    
    /**
     * 
     * @Title: decryptForChn 
     * @param 结果中含中文的加密串
     * @return
     * @return String
     * @throws 
     * @Description: 解密结果中含有中文的会出现乱码，本方法用于处理含中文的解密
     */
    public static String decryptForChn(String str){
    	 byte[] bytes = Base64.decodeBase64(str.replaceAll(" ", "+"));
         return new String(bytes);
    }
    
    public static void main(String[] args) {
		String string =  "eyJpbnZpdGVyIjoiNDJkNTJhOGQzY2MwNGNiMWIzNjUxZTJiNjA5NDk1MTYiLCJyb2xlS2V5IjoiMDA3IiwibmFtZSI6IuWbm+efsyIsImNvbUtleSI6ImE4NWI1OThmYWY0MjQwNzc4MDBlZGIxMzM0NzQ1ZWUyIiwiaW52aXRlZSI6IjE4NTE2NTg1Mzc3In0=";
		String string1 = "eyJpbnZpdGVyIjoiNDJkNTJhOGQzY2MwNGNiMWIzNjUxZTJiNjA5NDk1MTYiLCJyb2xlS2V5IjoiMDA3IiwibmFtZSI6IuWbm efsyIsImNvbUtleSI6ImE4NWI1OThmYWY0MjQwNzc4MDBlZGIxMzM0NzQ1ZWUyIiwiaW52aXRlZSI6IjE4NTE2NTg1Mzc3In0=";
		System.out.println(CipherUtil.decrypt(string));
		System.out.println(CipherUtil.decryptForChn(string1));
	}


}
