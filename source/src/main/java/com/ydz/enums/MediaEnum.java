/**   
 * @Title: MediaEnum.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 6, 2018 5:36:51 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: MediaEnum 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 6, 2018 5:36:51 PM 
 * @Description: 媒体资源枚举类
 */
public enum MediaEnum {
	
	POINT_STATUS_NORMAL("1N","正常"),
	POINT_STATUS_REPAIR("2R","维护"),
	
	PLAN_STATUS_LOCK("1L","锁定"),
	PLAN_STATUS_SOLD("2S","售出")
	
	;
	
	private String code;
	private String desc;
	
	private MediaEnum(String code,String desc) {
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
	
	public static MediaEnum codeOf(String index){
		for (MediaEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
