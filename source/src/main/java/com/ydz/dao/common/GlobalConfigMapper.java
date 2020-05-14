package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.GlobalConfig;
import com.ydz.util.PageData;

public interface GlobalConfigMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(GlobalConfig record);

    int insertSelective(GlobalConfig record);

    GlobalConfig selectByPrimaryKey(PageData pd);
    
    List<GlobalConfig> selectListByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(GlobalConfig record);

    int updateByPrimaryKey(GlobalConfig record);
}