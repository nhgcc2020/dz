/**   
 * @Title: OpportunityException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 3, 2018 10:21:51 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: OpportunityException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 3, 2018 10:21:51 AM 
 * @Description: 商机报价异常  
 */
public class OpportunityException extends RuntimeException{
	
	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = -7314922816987310283L;

	public OpportunityException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public OpportunityException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public OpportunityException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public OpportunityException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
