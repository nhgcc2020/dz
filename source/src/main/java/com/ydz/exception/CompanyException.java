/**   
 * @Title: CompanyException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 14, 2017 11:00:43 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: CompanyException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 14, 2017 11:00:43 AM 
 * @Description: 公司相关类的异常处理。包括公司，合作伙伴，员工等
 */
public class CompanyException extends RuntimeException{

	private static final long serialVersionUID = 4942762247354300398L;
	
	public CompanyException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public CompanyException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public CompanyException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public CompanyException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
