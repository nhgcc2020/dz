package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.RentalPeriod;
import com.ydz.util.PageData;

/** 
 * @ClassName: RentalPeriodMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月5日 下午9:32:00 
 * 
 */
public interface RentalPeriodMapper {

	List<RentalPeriod> selectByPrimaryKey(PageData pd);
	
	RentalPeriod selectOneByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(RentalPeriod record);
	
	int updateByPrimaryKeySelective(RentalPeriod record);
	
}
