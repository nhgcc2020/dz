package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.Dict;
import com.ydz.util.PageData;

public interface DictMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(Dict record);

    int insertSelective(Dict record);

    Dict selectByPrimaryKey(String key);
    
    List<Dict> listDictValue(PageData pd);
    
    int updateByPrimaryKeySelective(Dict record);

    int updateByPrimaryKey(Dict record);
}