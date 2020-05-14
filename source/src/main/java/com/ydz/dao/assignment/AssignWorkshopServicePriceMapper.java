package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.assignment.AssignWorkshopServicePrice;
import com.ydz.util.PageData;

public interface AssignWorkshopServicePriceMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(AssignWorkshopServicePrice record);

    int insertSelective(AssignWorkshopServicePrice record);

    AssignWorkshopServicePrice selectOneByPrimaryKey(PageData pd);
    
    List<AssignWorkshopServicePrice> selectListByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(AssignWorkshopServicePrice record);

    int updateByPrimaryKey(AssignWorkshopServicePrice record);
}