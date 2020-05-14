/**   
 * @Title: AssignEnum.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:33:06 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: AssignEnum 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:33:06 AM 
 * @Description: 派工，绩效枚举常量类  
 */
public enum AssignEnum {
	
	//绩效提成
	COMMISSION_SETTLEMENT_YES("1","已核算"),
	COMMISSION_SETTLEMENT_NO("0","未核算"),
	
	COMMISSION_ALLOCATION_TYPE_RATE("1","按比例"),
	
	//派工状态
	ASSIGN_STATUS_DESIGNING("1","设计中"),
	ASSIGN_STATUS_DONE("2","完工"),
	
	ASSIGN_STATUS_WORKING("5","制作中"),
	
	ASSIGN_STATUS_CANCEL("C","作废"),
	
	ASSIGN_SALESORDER_NO("0","未派工"),
	ASSIGN_SALESORDER_YES("1","已派工"),
	
	//工序
	ASSIGN_PROCEDURE_NONE("00","简单加工"),
	ASSIGN_PROCEDURE_XIEZHENDAYIN("01","写真打印"),
	ASSIGN_PROCEDURE_XIEZHENHOUDAO("02","写真后道"),
	ASSIGN_PROCEDURE_PENHUIDAYIN("03","喷绘打印"),
	ASSIGN_PROCEDURE_PENHUIHOUDAO("04","喷绘后道"),
	ASSIGN_PROCEDURE_UVDAYIN("05","UV打印"),
	ASSIGN_PROCEDURE_TIAOFUDAYIN("06","条幅打印"),
	ASSIGN_PROCEDURE_TIAOFUHOUDAO("07","条幅后道"),
	ASSIGN_PROCEDURE_HOUDAOJIAGONG("08","后道加工"),
	ASSIGN_PROCEDURE_HUWAIDAYIN("09","户外打印"),
	
	//安装
	INSTALLATION_STATUS_NO("0","未安装"),
	INSTALLATION_STATUS_YES("1","已安装")
	
	;
	
	private String code;
	private String desc;
	
	private AssignEnum(String code,String desc) {
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
	
	public static AssignEnum codeOf(String index){
		for (AssignEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
