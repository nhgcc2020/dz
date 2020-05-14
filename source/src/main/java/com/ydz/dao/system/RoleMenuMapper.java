package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.RoleMenu;
import com.ydz.util.PageData;

public interface RoleMenuMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<RoleMenu> roleMenus);

    int insertSelective(RoleMenu record);

    List<RoleMenu> selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(RoleMenu record);

    int updateByPrimaryKey(RoleMenu record);
}