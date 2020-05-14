package com.ydz.dao.system;

import com.ydz.entity.system.RefuseLogin;
import com.ydz.util.PageData;

public interface RefuseLoginMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(RefuseLogin record);

    int insertSelective(RefuseLogin record);

    RefuseLogin selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(RefuseLogin record);

    int updateByPrimaryKey(RefuseLogin record);
}