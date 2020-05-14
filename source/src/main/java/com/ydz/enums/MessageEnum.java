/**   
 * @Title: MessageEnum.java 
 * @Package com.ydz.enums 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午6:56:22 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: MessageEnum 
 * @Description: 消息类枚举
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午6:56:22 
 * 
 */
public enum MessageEnum {
	
	SMS_VERIFICATION_CODE("1","验证码"),
	SMS_INVITE_EMPLOYEE("2","邀请员工"),
	SMS_INVITE_PARTNER("3","邀请企业"),
	SMS_APPLY_EMPLOYEE("4","员工申请回执"),

	MESSAGE_TYPE_SYSTEM("01","系统通知"),
	MESSAGE_TYPE_TRADE("02","交易提醒"),
	MESSAGE_TYPE_SECURITY("03","安全消息"),
	MESSAGE_TYPE_ACTIVITY("04","活动消息"),
	MESSAGE_TYPE_SUBSCRIPTION("05","订阅消息"),
	MESSAGE_TYPE_OTHER("06","其他消息"),
	MESSAGE_TYPE_APPLY_JOIN("07","申请加入"),
	MESSAGE_TYPE_PARTNER_ALERT("08","合作伙伴好友提醒"),
	
	UNREAD("0","未读"),
	MARKREAD("1","已读"),
	
	FRIEND_YES("1","成为好友"),
	FRIEND_NO("0","非好友")
	
	
	;
	
	
	private String code;
	private String desc;
	
	private MessageEnum(String code,String desc) {
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
	
	public static MessageEnum codeOf(String index){
		for (MessageEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
