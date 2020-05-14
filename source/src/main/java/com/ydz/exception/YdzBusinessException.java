/**   
 * @Title: YdzBusinessException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 10, 2017 11:51:09 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: YdzBusinessException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 10, 2017 11:51:09 AM 
 * @Description: 业务异常，用于处理业务中的错误部分，手动抛出
 */
public class YdzBusinessException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public YdzBusinessException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public YdzBusinessException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public YdzBusinessException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public YdzBusinessException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
