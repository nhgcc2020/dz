/**   
 * @Title: ContractProjectParaVO.java 
 * @Package com.ydz.entity.project 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 1, 2017 3:18:59 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.project;

import java.io.Serializable;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

/** 
 * @ClassName: ContractProjectParaVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 1, 2017 3:18:59 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class ContractProjectParaVO implements Serializable{

	private static final long serialVersionUID = 1075292555498825075L;
	
	@JSONField(ordinal = 1)
	private ContractProject contractProject;
	@JSONField(ordinal = 2)
	private List<ContractReturnMoneyPlan> plans;
	@JSONField(ordinal = 3)
	private List<ContractInvoice> invoices;
	@JSONField(ordinal = 4)
	private List<ContractReturnMoneyRecord> returnRecords;
	public ContractProject getContractProject() {
		return contractProject;
	}
	public void setContractProject(ContractProject contractProject) {
		this.contractProject = contractProject;
	}
	public List<ContractReturnMoneyPlan> getPlans() {
		return plans;
	}
	public void setPlans(List<ContractReturnMoneyPlan> plans) {
		this.plans = plans;
	}
	public List<ContractInvoice> getInvoices() {
		return invoices;
	}
	public void setInvoices(List<ContractInvoice> invoices) {
		this.invoices = invoices;
	}
	public List<ContractReturnMoneyRecord> getReturnRecords() {
		return returnRecords;
	}
	public void setReturnRecords(List<ContractReturnMoneyRecord> returnRecords) {
		this.returnRecords = returnRecords;
	}
	
	
	
}
