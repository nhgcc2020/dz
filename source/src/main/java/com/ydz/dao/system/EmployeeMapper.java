package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.advert.SalesMan;
import com.ydz.entity.system.Employee;
import com.ydz.util.PageData;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: EmployeeMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月16日 下午4:21:13 
 * 
 */
public interface EmployeeMapper {
	
	List<SalesMan> getList4order(PageData pd);
	
	List<Employee> getEmployeesForDropdown(PageData pd);
	
	List<EmployeeVo> getAllInfo(PageData pd);
	
	List<SelectVo> getAllInfoAsVo(PageData pd);
	
	List<Employee> selectByPrimaryKey(PageData pd);
	
	Employee selectOneByKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(Employee employee);
	
	int updateByUserIdSelective(Employee employee);
	
	int updateByPrimaryKeySelective(Employee employee);
	
	int updateByPrimaryKey(Employee employee);

	int updateBatchByMap(PageData pd);

}
