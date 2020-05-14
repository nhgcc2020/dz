package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComRolePermission;
import com.ydz.util.PageData;

public interface ComRolePermissionMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ComRolePermission record);

    int insertSelective(ComRolePermission record);
    
    int insertList(List<ComRolePermission> records);

    ComRolePermission selectOneByPrimaryKey(PageData pd);
    
    List<ComRolePermission> selectListByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(ComRolePermission record);

    int updateByPrimaryKey(ComRolePermission record);
}