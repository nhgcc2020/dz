package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.Menu;
import com.ydz.util.PageData;

public interface MenuMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<Menu> records);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
}