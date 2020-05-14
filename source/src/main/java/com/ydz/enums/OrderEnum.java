package com.ydz.enums;

/** 
 * @ClassName: OrderEnum 
 * @Description: 订单相关枚举
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月20日 下午1:30:15 
 * 
 */
public enum OrderEnum {
	
	//用于统计的订单类型
	TYPE_SYNCHRO_ORDER("01","协同订单"),
	TYPE_SYNCHRO_CHECKINGORDER("02","协同对账单"),
	TYPE_SALESORDER("03","销售订单"),
	TYPE_SALESCHECKINGORDER("04","销售对账单"),
	TYPE_PURCHASEORDER("05","采购订单"),
	TYPE_PURCHASECHECKINGORDER("06","采购对账单"),
	
	//订单类型属性的划分
	ATTR_TYPE_ASSIGN_DESIGN("D","设计派工"),
	
	//订单状态
	STATUS_DAIJIJIA("01","草稿箱"),
	STATUS_DAIDUIFANGSHOUHUO("02","待对方收货"),
	STATUS_DAISHOUHUO("03","待收货"),
	STATUS_DAIDUIZHANG("04","待对账"),
	STATUS_YIDUIZHANG("05","已对账"),
	STATUS_DAISHOUKUAN("07","待收款"),
	STATUS_YISHOUKUAN("08","已收款"),
	STATUS_DAIFUKUAN("09","待付款"),
	STATUS_YIFUKUAN("10","已付款"),
	STATUS_CANCEL("CC","已作废"),
	
	STATUS_SETTLEMENT_NO("11","未结算"),
	STATUS_SETTLEMENT_YES("12","已结算"),
	
	//收付款对账单类型
	CHECKING_TYPE_SALES("1","销售对账单"),
	CHECKING_TYPE_PURCHASE("2","采购对账单"),
	CHECKING_TYPE_INSTALLATION("3","安装对账单"),
	
	ACCOUNT_PAYEE_TYPE_CASH("00","现金"),
	ACCOUNT_PAYEE_TYPE_WECHAT("01","微信钱包"),
	ACCOUNT_PAYEE_TYPE_ALIPAY("02","支付宝"),
	ACCOUNT_PAYEE_TYPE_ICBC("03","工商银行"),
	ACCOUNT_PAYEE_TYPE_CCB("04","建设银行"),
	ACCOUNT_PAYEE_TYPE_BC("05","中国银行"),
	ACCOUNT_PAYEE_TYPE_ABC("06","农业银行"),
	ACCOUNT_PAYEE_TYPE_TRANSTER("07","其他系统转移"),
	ACCOUNT_PAYEE_TYPE_PREPAY("08","预存款账户"),
	ACCOUNT_PAYEE_TYPE_OTHER("09","其他"),
	ACCOUNT_PAYEE_TYPE_WECHATAPP("10","微信在线"),
	
	CHECKING_TYPE_SALES_COMMISSION("4","销售提成结算单"),
	CHECKING_TYPE_DESIGN_COMMISSION("5","设计提成提成结算单"),
	
	//开票状态
	INVOICE_NO("0","未开票"),
	INVOICE_YES("1","已开票"),
	
	//计价方式
	PRICE_WAY_AREA("01","按面积"),
	PRICE_WAY_QUANTITY("02","按数量"),
	PRICE_WAY_LENGTH("03","按长度"),
	PRICE_WAY_WIDTH("04","按宽度"),
	PRICE_WAY_MAXVALUE("05","按大值"),
	PRICE_WAY_MAXVALUE_SQUARE("06","按大值平方"),
	PRICE_WAY_PERIMETER("07","按周长"),
	
	//对账单类型
	CHECKINGORDER_TYPE_SALES("1","销售对账单"),
	CHECKINGORDER_TYPE_PURCHASE("2","采购对账单")
	
	
	
	;
	
	private String code;
	private String desc;
	
	private OrderEnum(String code,String desc) {
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
	
	public static OrderEnum codeOf(String index){
		for (OrderEnum enumcode : values()) {
			if (enumcode.getCode().equals(index)) {
				return enumcode;
			}
		}
		return null;
	}
	

}
