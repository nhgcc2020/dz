/**   
 * @Title: YdzSystemRuntimeException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 10, 2017 11:54:36 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: YdzSystemRuntimeException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 10, 2017 11:54:36 AM 
 * @Description: 系统级运行异常，比如数据库处理失败或其他与系统本身有关的异常  
 */
public class YdzSystemRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public YdzSystemRuntimeException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    /** 
     * @param message 
     */  
    public YdzSystemRuntimeException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    /** 
     * @param cause 
     */  
    public YdzSystemRuntimeException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    /** 
     * @param message 
     * @param cause 
     */  
    public YdzSystemRuntimeException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
