package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.init.RoleMenuInit;
import com.ydz.util.PageData;

public interface RoleMenuInitMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(RoleMenuInit record);

    int insertSelective(RoleMenuInit record);

    List<RoleMenuInit> selectListByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(RoleMenuInit record);

    int updateByPrimaryKey(RoleMenuInit record);
}