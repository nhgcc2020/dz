/**   
 * @Title: WechatException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 12, 2017 6:35:47 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: WechatException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 12, 2017 6:35:47 PM 
 * @Description: 微信异常处理类
 */
public class WechatException extends RuntimeException{

	private static final long serialVersionUID = 813404625033448925L;

	public WechatException() {
		// TODO Auto-generated constructor stub
	}
	
	public WechatException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public WechatException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public WechatException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  
}
