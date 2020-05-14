package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.Department;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: DepartmentMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月30日 下午7:34:08 
 * 
 */
public interface DepartmentMapper {

	List<SelectVo> selectByPrimaryKeyForVo(PageData pd);
	
	List<Department> listPageByPrimaryKeyData(Page page);
	
	Department selectOneByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	String getMaxDeptId(PageData pd);
	
	Integer getMaxSortItem(PageData pd);
	
	int insertList(List<Department> depts);
	
	int insertSelective(Department dept);
	
	int updateByPrimaryKeySelective(Department dept);
	
	int updateByUnionKey(Department dept);
}
