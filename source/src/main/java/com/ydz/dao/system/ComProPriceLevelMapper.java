package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.ComProPriceLevel;
import com.ydz.util.PageData;

public interface ComProPriceLevelMapper {
    int deleteByPrimaryKey(PageData pd);
    
    int deleteAllCompany(PageData pd);

    int insertBatch(List<ComProPriceLevel> records);

    int insertSelective(ComProPriceLevel record);

    List<ComProPriceLevel> selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(ComProPriceLevel record);

    int updateByPrimaryKey(ComProPriceLevel record);
}