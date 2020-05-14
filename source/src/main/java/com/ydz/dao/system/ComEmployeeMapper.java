package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComEmployee;
import com.ydz.util.PageData;

/** 
 * @ClassName: ComEmployeeMapper 
 * @Description: 公司员工数据处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月16日 下午8:45:54 
 * 
 */
public interface ComEmployeeMapper {
	
	List<ComEmployee> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(ComEmployee comEmployee);
	
	int updateByPrimaryKeySelective(ComEmployee comEmployee);

}
