/**   
 * @Title: AppException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 9, 2017 12:08:08 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: AppException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 9, 2017 12:08:08 PM 
 * @Description: App后台的异常处理
 */
public class AppException extends RuntimeException{

	private static final long serialVersionUID = 4988718405572931758L;
	
	public AppException() {
		// TODO Auto-generated constructor stub
	}
	
	public AppException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public AppException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public AppException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
