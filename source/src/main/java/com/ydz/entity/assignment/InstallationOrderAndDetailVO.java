/**   
 * @Title: InstallationOrderAndDetailVO.java 
 * @Package com.ydz.entity.assignment 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 下午2:26:37 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.assignment;

import java.io.Serializable;
import java.util.List;

/** 
 * @ClassName: InstallationOrderAndDetailVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 下午2:26:37 
 * @Description: 安装单及明细值对象
 */
public class InstallationOrderAndDetailVO implements Serializable{

	private static final long serialVersionUID = 1512374855122819145L;
	
	private InstallationOrder order;
	private List<InstallationOrderDetail> details;
	public InstallationOrder getOrder() {
		return order;
	}
	public void setOrder(InstallationOrder order) {
		this.order = order;
	}
	public List<InstallationOrderDetail> getDetails() {
		return details;
	}
	public void setDetails(List<InstallationOrderDetail> details) {
		this.details = details;
	}
	
	
}
