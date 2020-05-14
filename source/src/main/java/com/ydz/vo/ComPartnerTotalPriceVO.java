/**   
 * @Title: ComPartnerTotalPriceVO.java 
 * @Package com.ydz.vo 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月25日 下午4:02:35 
 * @version  
 */
package com.ydz.vo;

import java.io.Serializable;

import com.ydz.util.StringUtil;

/** 
 * @ClassName: ComPartnerTotalPriceVO 
 * @Description: 客户/供应商的订单对账单金额及订单数统计
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月25日 下午4:02:35 
 * 
 */
public class ComPartnerTotalPriceVO implements Serializable{

	private static final long serialVersionUID = 3998150078115134533L;
	
	private Integer gt6OrderNum; //超过6个月待对账订单数
    
    private String gt6TotalPrice; //超过6个月待对账订单金额
    
    private Integer gt3OrderNum; //超过3个月待对账订单数
    
    private String gt3TotalPrice; //超过3个月待对账订单金额
    
    private Integer allOrderNum04; //全部待对账的订单数
    
    private String allTotalPrice; //全部待对账合计订单金额
    
    private Integer allOrderNum07; //全部待收款的订单数
    
    private String allReceivablesMoney; //全部待收款合计应收金额
    
    private String partnerKey;

	public Integer getGt6OrderNum() {
		return gt6OrderNum;
	}

	public void setGt6OrderNum(Integer gt6OrderNum) {
		this.gt6OrderNum = gt6OrderNum;
	}

	public String getGt6TotalPrice() {
		if(StringUtil.isEmpty(gt6TotalPrice)){
			gt6TotalPrice = "0.00";
		}
		return gt6TotalPrice;
	}

	public void setGt6TotalPrice(String gt6TotalPrice) {
		this.gt6TotalPrice = gt6TotalPrice;
	}

	public Integer getGt3OrderNum() {
		return gt3OrderNum;
	}

	public void setGt3OrderNum(Integer gt3OrderNum) {
		this.gt3OrderNum = gt3OrderNum;
	}

	public String getGt3TotalPrice() {
		if(StringUtil.isEmpty(gt3TotalPrice)){
			gt3TotalPrice = "0.00";
		}
		return gt3TotalPrice;
	}

	public void setGt3TotalPrice(String gt3TotalPrice) {
		this.gt3TotalPrice = gt3TotalPrice;
	}

	public Integer getAllOrderNum04() {
		return allOrderNum04;
	}

	public void setAllOrderNum04(Integer allOrderNum04) {
		this.allOrderNum04 = allOrderNum04;
	}

	public String getAllTotalPrice() {
		if(StringUtil.isEmpty(allTotalPrice)){
			allTotalPrice = "0.00";
		}
		return allTotalPrice;
	}

	public void setAllTotalPrice(String allTotalPrice) {
		this.allTotalPrice = allTotalPrice;
	}

	public Integer getAllOrderNum07() {
		return allOrderNum07;
	}

	public void setAllOrderNum07(Integer allOrderNum07) {
		this.allOrderNum07 = allOrderNum07;
	}

	public String getAllReceivablesMoney() {
		if(StringUtil.isEmpty(allReceivablesMoney)){
			allReceivablesMoney = "0.00";
		}
		return allReceivablesMoney;
	}

	public void setAllReceivablesMoney(String allReceivablesMoney) {
		this.allReceivablesMoney = allReceivablesMoney;
	}

	public String getPartnerKey() {
		return partnerKey;
	}

	public void setPartnerKey(String partnerKey) {
		this.partnerKey = partnerKey;
	}
}
