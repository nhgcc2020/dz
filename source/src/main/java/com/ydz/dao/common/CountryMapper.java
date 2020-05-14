package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.Country;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: CountryMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月26日 下午4:06:11 
 * 
 */
public interface CountryMapper {
	
	Country selectByCountryId(PageData pd);
	
	List<Country> listAllCountryByCity(PageData pd);
	
	int insert(Country country);

}
