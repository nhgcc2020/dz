package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.RolePermission;
import com.ydz.util.PageData;

public interface RolePermissionMapper {
	
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<RolePermission> records);

    int insertSelective(RolePermission record);

    RolePermission selectOneByPrimaryKey(PageData pd);
    
    List<RolePermission> listByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(RolePermission record);

    int updateByPrimaryKey(RolePermission record);
}