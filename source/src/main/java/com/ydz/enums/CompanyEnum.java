/**   
 * @Title: CompanyEnum.java 
 * @Package com.ydz.enums 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午7:49:33 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: CompanyEnum 
 * @Description: 公司相关枚举类，包括公司，员工，合作伙伴
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午7:49:33 
 * 
 */
public enum CompanyEnum {

	//公司
	COM_TYPE_ENTERPRISE("1","公司"),
	COM_TYPE_PERSONAL("2","个人"),
	
	COM_ATTR_LIMITED("1","有限公司"),
	COM_ATTR_HOUSEHOLD("2","个体工商户"),
	COM_ATTR_PROMOTER("3","对账大使"),
	
	//行业
	INDUSTRY_CLASS_SHEJI("1A","小型广告设计工作室"),
	INDUSTRY_CLASS_CHUANMEI("1B","综合型广告传媒公司"),
	INDUSTRY_CLASS_JIAGONGZHIZUO("1C","广告加工制作企业"),
	INDUSTRY_CLASS_TUWENKUAIYIN("1D","数码图文快印店"),
	
	//员工
	EMPLOYEE_STATUS_PENDING_INVITE("0","待邀请"),
	EMPLOYEE_STATUS_INVITING("1","邀请中"),
	EMPLOYEE_STATUS_PENDING_CHECK("2","待审核"),
	EMPLOYEE_STATUS_NORMAL("3","正常"),
	EMPLOYEE_STATUS_DISMISSION("4","离职"),
	EMPLOYEE_STATUS_REFUSED("5","拒绝申请"),
	
	//合作伙伴
	PARTNER_TYPE_CUSTOMER("1","客户"),
	PARTNER_TYPE_SUPPLIER("2","供应商"),
	PARTNER_TYPE_ALL("A","客户&供应商"),
	
	PARTNER_ATTR_COMPANY("1","公司"),
	PARTNER_ATTR_PERSONAL("2","个人"),
	
	PARTNER_STATUS_FRIEND_NO("0","非好友"),
	PARTNER_STATUS_FRIEND_YES("1","互为好友"),
	PARTNER_STATUS_APPLYING("2","申请中"),
	PARTNER_STATUS_REFUSED("3","已拒绝"),
	PARTNER_STATUS_PENDING_APPLY("4","待申请"),
	PARTNER_STATUS_PENDING_INVITE("5","待邀请"),
	PARTNER_STATUS_INVITING("6","邀请中"),
	
	PARTNER_LEVEL_VIP("1","重点客户"),
	PARTNER_LEVEL_GENERAL("2","普通客户"),
	PARTNER_LEVELL_INDIVIDUAL("3","零散客户"),
	
	PRICING_TYPE_SERVICE("1","服务定价"),
	PRICING_TYPE_PRODUCT("2","产品定价"),
	
	CONFIG_TYPE_EXPENSE_DAILY("EXPENSE_01","日常支出"),
	CONFIG_TYPE_EXPENSE_SALARY("EXPENSE_02","工资支出"),
	
	INVITE_TYPE_COMPANY("1","公司"),
	INVITE_TYPE_PERSONAL("2","个人")
	
	;
	
	private String code;
	private String desc;
	
	private CompanyEnum(String code,String desc) {
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
	
	public static CompanyEnum codeOf(String index){
		for (CompanyEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}
}
