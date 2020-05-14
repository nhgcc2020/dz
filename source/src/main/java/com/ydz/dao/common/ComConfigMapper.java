package com.ydz.dao.common;


import java.util.List;

import com.ydz.entity.common.ComConfig;
import com.ydz.util.PageData;

public interface ComConfigMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ComConfig record);

    int insertSelective(ComConfig record);

    List<ComConfig> selectByPrimaryKey(PageData pd);
    
    int updateByPrimaryKeySelective(ComConfig record);

    int updateByPrimaryKey(ComConfig record);
}