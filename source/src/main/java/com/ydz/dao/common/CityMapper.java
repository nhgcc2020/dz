package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.City;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: CityMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月26日 下午3:56:20 
 * 
 */
public interface CityMapper {
	List<City> listAllCityByProvince(PageData pd);
	
	List<SelectVo> listAllCityByProvinceAsVo();
	
	City selectByCity(PageData pd);
	
	int deleteByPrimaryKey(Integer id);
	
	int insert(City city);
	
	int insertSelective(City city);
	
	int updateByPrimaryKeySelective(City city);
	
	int updateByPrimaryKey(City city);
}
