/**   
 * @Title: SystemEnum.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月25日 下午3:22:25 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: SystemEnum 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月25日 下午3:22:25 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public enum SystemEnum {
	
	REG_TYPE_PC("0","电脑注册"),
	REG_TYPE_IOS("1","苹果APP注册"),
	REG_TYPE_ANDROID("2","安卓APP注册"),
	REG_TYPE_IOS_BROWSER("3","苹果浏览器注册"),
	REG_TYPE_ANDROID_BROWSER("4","安卓浏览器注册"),
	
	RETURN_INFO_ERROR("0","操作失败"),
	RETURN_INFO_SUCCESS_EXECUTE("1","操作成功"),
	RETURN_INFO_SUCCESS_SAVE("2","保存成功"),
	RETURN_INFO_SUCCESS_UPDATE("3","修改成功"),
	RETURN_INFO_SUCCESS_DELETE("4","删除成功"),
	RETURN_INFO_SUCCESS_LOGIN("5","登陆成功"),
	RETURN_INFO_SUCCESS_QUERY("6","查询成功"),
	RETURN_INFO_SUCCESS_LOGOUT("7","退出成功"),
	RETURN_INFO_ERROR_VERIFY("-1","验证失败"),
	
	;
	
	private String code;
	private String desc;
	
	private SystemEnum(String code,String desc) {
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
	
	public static SystemEnum codeOf(String index){
		for (SystemEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}
}
