package com.ydz.dao.common;

import java.util.LinkedList;
import java.util.List;

import com.ydz.entity.common.MenuInitDict;
import com.ydz.util.PageData;

public interface MenuInitDictMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(MenuInitDict record);

    int insertSelective(MenuInitDict record);

    MenuInitDict selectOneByPrimaryKey(PageData pd);
    
    List<MenuInitDict> selectListByPrimaryKey(PageData pd);
    
    LinkedList<MenuInitDict> selectMenuByInit(PageData pd);

    int updateByPrimaryKeySelective(MenuInitDict record);

    int updateByPrimaryKey(MenuInitDict record);
}