package com.ydz.dao.system;

import com.ydz.entity.system.RentalTradeDiscount;
import com.ydz.util.PageData;

public interface RentalTradeDiscountMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(RentalTradeDiscount record);

    int insertSelective(RentalTradeDiscount record);

    RentalTradeDiscount selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(RentalTradeDiscount record);

    int updateByPrimaryKey(RentalTradeDiscount record);
}