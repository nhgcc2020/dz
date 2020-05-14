package com.ydz.dao.pay;

import com.ydz.entity.pay.PayMerchantId;
import com.ydz.util.PageData;

public interface PayMerchantIdMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(PayMerchantId record);

    int insertSelective(PayMerchantId record);

    PayMerchantId selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(PayMerchantId record);

    int updateByPrimaryKey(PayMerchantId record);
}