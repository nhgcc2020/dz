package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.RoleUser;
import com.ydz.util.PageData;

/** 
 * @ClassName: RoleUserMapper 
 * @Description: 用户角色表
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月31日 上午10:45:21 
 * 
 */
public interface RoleUserMapper {

	List<RoleUser> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertList(List<RoleUser> roleUsers);
	
	int insertSelective(RoleUser roleUser);
	
	int updateByPrimaryKeySelective(RoleUser roleUser);
}
