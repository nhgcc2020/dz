package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.init.MenuTypeInit;
import com.ydz.util.PageData;
import com.ydz.vo.RoleMenuVO;

public interface MenuTypeInitMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(MenuTypeInit record);

    int insertSelective(MenuTypeInit record);

    List<MenuTypeInit> selectListByPrimaryKey(PageData pd);
    
    List<RoleMenuVO> selectListVOByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(MenuTypeInit record);

    int updateByPrimaryKey(MenuTypeInit record);
}