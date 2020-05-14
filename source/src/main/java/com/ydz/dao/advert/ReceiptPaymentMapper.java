package com.ydz.dao.advert;

import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.util.PageData;

public interface ReceiptPaymentMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ReceiptPayment record);

    int insertSelective(ReceiptPayment record);

    ReceiptPayment selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(ReceiptPayment record);

    int updateByPrimaryKey(ReceiptPayment record);
}