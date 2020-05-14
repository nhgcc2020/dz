/**   
 * @Title: ExpenseEnum.java 
 * @Package com.ydz.enums 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:29:43 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.enums;

/** 
 * @ClassName: ExpenseEnum 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 11:29:43 AM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public enum ExpenseEnum {
	
	//费用付款方式
	EXPENSE_PAY_CASH("1","现金"),
	EXPENSE_PAY_TRANSFER("2","银行转账"),
	EXPENSE_PAY_CREDITCARD("3","信用卡"),
	EXPENSE_PAY_ALIPAY("4","支付宝"),
	EXPENSE_PAY_WECHAT("5","微信钱包"),
	EXPENSE_PAY_OTHER("6","其他"),
	
	//费用类型
	EXPENSE_TYPE_CHAILV("01","差旅"),
	EXPENSE_TYPE_CANYIN("02","餐饮"),
	EXPENSE_TYPE_DIANHUA("03","电话"),
	EXPENSE_TYPE_JIAOTONG("04","交通"),
	EXPENSE_TYPE_ZHUSU("05","住宿"),
	EXPENSE_TYPE_BANGONG("06","办公"),
	EXPENSE_TYPE_ZULIN("10","租赁"),
	EXPENSE_TYPE_SHUIDIANMEI("11","水电煤"),
	EXPENSE_TYPE_KUAIDIWULIU("12","快递物流"),
	EXPENSE_TYPE_YINGXIAO("13","营销"),
	EXPENSE_TYPE_LAOWUFEI("14","劳务费"),
	
	EXPENSE_TYPE_GONGZI("07","工资"),
	EXPENSE_TYPE_SHEBAO("08","社保"),
	EXPENSE_TYPE_GONGJIJIN("09","公积金"),
	EXPENSE_TYPE_JIANGJIN("16","奖金"),
	EXPENSE_TYPE_YUZHIGONGZI("17","预支工资"),
	
	EXPENSE_TYPE_OTHER("15","其他")
	
	;
	
	private String code;
	private String desc;
	
	private ExpenseEnum(String code,String desc) {
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
	
	public static ExpenseEnum codeOf(String index){
		for (ExpenseEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}

}
