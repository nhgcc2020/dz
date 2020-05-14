/**   
 * @Title: AssignException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 13, 2017 10:13:22 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: AssignException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 13, 2017 10:13:22 AM 
 * @Description: 派工异常处理类
 */
public class AssignException extends RuntimeException{

	private static final long serialVersionUID = 8597109314347187222L;

	public AssignException() {
		// TODO Auto-generated constructor stub
	}
	
	public AssignException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public AssignException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public AssignException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
