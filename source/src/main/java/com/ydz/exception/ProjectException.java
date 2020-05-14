/**   
 * @Title: ProjectException.java 
 * @Package com.ydz.exception 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 1, 2017 3:47:37 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.exception;

/** 
 * @ClassName: ProjectException 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 1, 2017 3:47:37 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class ProjectException extends RuntimeException{

	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 7842937981019837315L;
	
	public ProjectException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public ProjectException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public ProjectException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public ProjectException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  

}
