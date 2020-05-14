/**
 * 
 */
package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.common.Province;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: ProvinceMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月26日 下午3:41:36 
 * 
 */
public interface ProvinceMapper {
	
	List<Province> listAllProvince(PageData pd);
	
	List<SelectVo> listAllProvinceAsVo();
	
	Province selectByProvice(PageData pd);
	
	Province selectByAreaId(PageData pd);
	
	int deleteByPrimaryKey(Integer id);
	
	int insert(Province province);
	
	int insertSelective(Province province);
	
	int updateByPrimaryKeySelective(Province province);
	
	int updateByPrimaryKey(Province province);

}
