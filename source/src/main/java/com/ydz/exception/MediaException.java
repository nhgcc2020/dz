/**   
 * @Title: MediaException.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 6, 2018 5:31:36 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: MediaException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 6, 2018 5:31:36 PM 
 * @Description: 媒体业务类异常处理
 */
public class MediaException extends RuntimeException{

	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 98172351133845234L;

	public MediaException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public MediaException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public MediaException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public MediaException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  
}
