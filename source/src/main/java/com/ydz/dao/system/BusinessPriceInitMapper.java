package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.BusinessPriceInit;
import com.ydz.util.PageData;

public interface BusinessPriceInitMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(BusinessPriceInit record);

    int insertSelective(BusinessPriceInit record);

    List<BusinessPriceInit> selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(BusinessPriceInit record);

    int updateByPrimaryKey(BusinessPriceInit record);
}