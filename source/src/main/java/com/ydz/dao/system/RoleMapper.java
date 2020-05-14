package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.Role;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;

/** 
 * @ClassName: RoleMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月30日 下午4:49:15 
 * 
 */
public interface RoleMapper {
	
	List<SelectVo> selectByPrimaryKeyForVo(PageData pd);
	
	List<Role> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertList(List<Role> roles);
	
	int insertSelective(Role role);
	
	int updateByPrimaryKeySelective(Role role);
	
}
