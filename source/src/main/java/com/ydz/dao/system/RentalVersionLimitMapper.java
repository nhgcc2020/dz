package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.RentalVersionLimit;
import com.ydz.util.PageData;

public interface RentalVersionLimitMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(RentalVersionLimit record);

    int insertSelective(RentalVersionLimit record);

    RentalVersionLimit selectOneByPrimaryKey(PageData pd);

    List<RentalVersionLimit> selectListByPrimaryKey(PageData pd);
    
    int updateByPrimaryKeySelective(RentalVersionLimit record);

    int updateByPrimaryKey(RentalVersionLimit record);
}