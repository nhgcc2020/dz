/**   
 * @Title: RentalTradeEnum.java 
 * @Package com.ydz.enums 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午6:23:31 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: RentalTradeEnum 
 * @Description: 租赁交易相关枚举类
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午6:23:31 
 * 
 */
public enum RentalTradeEnum {
	
	PERIOD_TRIAL("T","试用期"),
	PERIOD_USING("1","使用中"),
	PERIOD_OUTDATE("0","已过期"),
	
	TRADE_TYPE_FREE("0","免费"),
	TRADE_TYPE_TRIAL("T","试用"),
	TRADE_TYPE_NEWPAY("1","新购"),
	TRADE_TYPE_RENEW("2","续费"),
	TRADE_TYPE_CHNAGE("3","更改"),
	
	INVOICE_YES("1","已开票"),
	INVOICE_NO("0","未开票"),
	
	PAYMENT_FREE("0","免费"),
	PAYMENT_TRIAL("T","试用"),
	PAYMENT_ALIPAY("1","支付宝"),
	PAYMENT_WECHAT("2","微信"),
	
	VERSION_FREE_EDITION("0T","免费版"),
	VERSION_BASIC_EDITION("01","基础版"),
	VERSION_PROFESSIONAL_EDITION("02","专业版"),
	VERSION_ADVANCED_EDITION("03","高级版"),
	
	OUT_DATE_NO("1","未过期"),
	OUT_DATE_YES("0","已过期"),
	
	PAID_NO("0","未支付"),
	PAID_YES("1","已支付"),
	
	VOUCHER_STATUS_UNUSED("0","未使用"),
	VOUCHER_STATUS_USED("1","已使用"),
	VOUCHER_STATUS_OUTDATE("2","已过期")
	
	;
	
	
	private String code;
	private String desc;
	
	private RentalTradeEnum(String code,String desc) {
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
	
	public static RentalTradeEnum codeOf(String index){
		for (RentalTradeEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
