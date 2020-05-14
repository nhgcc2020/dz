package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.RentalTrade;
import com.ydz.util.PageData;
import com.ydz.vo.RentalTradeVO;

/** 
 * @ClassName: RentalTradeMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月5日 下午9:22:29 
 * 
 */
public interface RentalTradeMapper {
	
	List<RentalTrade> selectByPrimaryKey(PageData pd);
	
	List<RentalTradeVO> listPageRentalTradeVO(Page page);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(RentalTrade record);
	
	int updateByPrimaryKeySelective(RentalTrade record);
	
	int updateStatusByTradeKey(PageData pd);
}
