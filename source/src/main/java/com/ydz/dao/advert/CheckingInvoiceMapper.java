package com.ydz.dao.advert;

import com.ydz.entity.Page;
import com.ydz.entity.advert.CheckingInvoice;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.util.PageData;

import java.util.List;
import java.util.Map;

public interface CheckingInvoiceMapper {

    int deleteByPrimaryKey(PageData pd);

    int insertSelective(CheckingInvoice checkingInvoice);



}