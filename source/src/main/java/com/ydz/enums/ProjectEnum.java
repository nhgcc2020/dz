/**   
 * @Title: OpportunityEnum.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:19:12 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: OpportunityEnum 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:19:12 AM 
 * @Description: 商机、报价、项目常量枚举类
 */
public enum ProjectEnum {
	
	//商机、需求报价、谈判、赢单、输单
	OPPORT_ORDER_SECTION_CHANCE("01","商机"),
	OPPORT_ORDER_SECTION_REQUIREMENT("02","需求报价"),
	OPPORT_ORDER_SECTION_NEGOTIATE("03","谈判"),
	OPPORT_ORDER_SECTION_WIN("04","赢单"),
	OPPORT_ORDER_SECTION_LOSE("05","输单"),
	
	//执行中，已完成，意外终止，合同作废
	CONTRACT_STATUS_EXECUTINT("01","执行中"),
	CONTRACT_STATUS_CLOSED("02","已完成"),
	CONTRACT_STATUS_STOP("03","意外终止"),
	CONTRACT_STATUS_CANCEL("04","合同作废"),
	
	//正常、坏账、货抵
	CONTRACT_RETURN_TYPE_NORMAL("R1","正常"),
	CONTRACT_RETURN_TYPE_BAD_DEBT("R2","坏账"),
	CONTRACT_RETURN_TYPE_DEDUCTION("R3","货抵"),
	
	CHAT_TYPE_OPPORTUNITY("1","商机联系"),
	CHAT_TYPE_CONTRACT("2","合同联系")
	
	;
	
	
	private String code;
	private String desc;
	
	private ProjectEnum(String code,String desc) {
		this.code = code;
		this.desc = desc;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public static ProjectEnum codeOf(String index){
		for (ProjectEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
