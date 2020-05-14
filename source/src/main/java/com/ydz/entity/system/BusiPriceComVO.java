package com.ydz.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class BusiPriceComVO extends BusiPriceCom implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4305223972836635338L;
    
    private List<BusiPriceComVO> busiPriceComVos;
    
	public List<BusiPriceComVO> getBusiPriceComVos() {
		return busiPriceComVos;
	}

	public void setBusiPriceComVos(List<BusiPriceComVO> busiPriceComVos) {
		this.busiPriceComVos = busiPriceComVos;
	}

	@Override
	public String toString() {
		return "BusiPriceComVO [busiPriceComVos=" + busiPriceComVos + "]";
	}
	
	

}
