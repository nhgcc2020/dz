package com.ydz.dao.system;

import com.ydz.entity.system.RentalInvoice;
import com.ydz.util.PageData;

public interface RentalInvoiceMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(RentalInvoice record);

    int insertSelective(RentalInvoice record);

    RentalInvoice selectByPrimaryKey(Long uid);

    int updateByPrimaryKeySelective(RentalInvoice record);

    int updateByPrimaryKey(RentalInvoice record);
}