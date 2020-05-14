package com.ydz.dao.system;

import com.ydz.entity.system.RentalInvoiceSend;

public interface RentalInvoiceSendMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(RentalInvoiceSend record);

    int insertSelective(RentalInvoiceSend record);

    RentalInvoiceSend selectByPrimaryKey(Long uid);

    int updateByPrimaryKeySelective(RentalInvoiceSend record);

    int updateByPrimaryKey(RentalInvoiceSend record);
}