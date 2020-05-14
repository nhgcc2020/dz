/**   
 * @Title: OrderException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 8, 2017 2:19:49 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: OrderException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 8, 2017 2:19:49 PM 
 * @Description: 订单类异常处理
 * 1.销售订单
 * 2.采购订单
 */
public class OrderException extends RuntimeException{

	private static final long serialVersionUID = 4942762247354300398L;
	
	public OrderException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public OrderException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public OrderException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public OrderException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
