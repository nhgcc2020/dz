package com.ydz.dao.system;

import com.ydz.entity.system.CityLevel;
import com.ydz.util.PageData;

/** 
 * @ClassName: CityLevelMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月3日 下午6:09:10 
 * 
 */
public interface CityLevelMapper {

	CityLevel selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(CityLevel record);
	
	int updateByPrimaryKeySelective(CityLevel record);
}
