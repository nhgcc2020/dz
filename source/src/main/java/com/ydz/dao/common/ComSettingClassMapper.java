package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.ComSettingClass;
import com.ydz.util.PageData;

public interface ComSettingClassMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<ComSettingClass> records);

    int insertSelective(ComSettingClass record);

    List<ComSettingClass> selectByPrimaryKey(PageData pd);
    
    Integer selectMaxTypeCodeByPrimaryKey(PageData pd);
    
    int updateByPrimaryKeySelective(ComSettingClass record);

    int updateByPrimaryKey(ComSettingClass record);
}