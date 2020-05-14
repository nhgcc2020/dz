/**   
 * @Title: OpportunityQuotationParaVO.java 
 * @Package com.ydz.entity.opportunity 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 4:02:06 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.project;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: OpportunityQuotationParaVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 4:02:06 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class OpportunityQuotationParaVO implements Serializable{

	/** 
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么) 
	 */ 
	private static final long serialVersionUID = 4835778318213976063L;
	
	private OpportunityQuotation opportunityQuotation;
	@JSONField(ordinal=100)
	private List<OpportunityQuotationDetail> details;
	public OpportunityQuotation getOpportunityQuotation() {
		return opportunityQuotation;
	}
	public void setOpportunityQuotation(OpportunityQuotation opportunityQuotation) {
		this.opportunityQuotation = opportunityQuotation;
	}
	public List<OpportunityQuotationDetail> getDetails() {
		return details;
	}
	public void setDetails(List<OpportunityQuotationDetail> details) {
		this.details = details;
	}
	

}
