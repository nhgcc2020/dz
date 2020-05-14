package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.DepartmentInit;
import com.ydz.util.PageData;

/** 
 * @ClassName: DepartmentInitMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月29日 下午10:12:08 
 * 
 */
public interface DepartmentInitMapper {
	
	List<DepartmentInit> selectByPrimaryKey(PageData pd);
	
	int insertSelective(DepartmentInit record);
	
	int updateByPrimaryKeySelective(DepartmentInit record);
}
