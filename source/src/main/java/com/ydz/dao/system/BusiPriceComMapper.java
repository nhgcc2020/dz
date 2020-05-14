package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.BusiPriceCom;
import com.ydz.entity.system.BusiPriceComVO;
import com.ydz.util.PageData;

/** 
 * @ClassName: BusiPriceComMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月3日 下午3:36:51 
 * 
 */
public interface BusiPriceComMapper {

	List<BusiPriceComVO> selectByPrimaryKey(PageData pd);
	
	List<BusiPriceComVO> selectBusinessPricesForMenu(PageData pd);
	
	int insertBatch(List<BusiPriceCom> busiPriceComs);
	
	int insertSelective(BusiPriceCom busiPriceCom);
	
	int deleteByPrimaryKey(PageData pd);
	
}
