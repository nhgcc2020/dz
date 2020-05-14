package com.ydz.dao.pay;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.pay.PaySettlement;
import com.ydz.util.PageData;

public interface PaySettlementMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(PaySettlement record);

    int insertSelective(PaySettlement record);

    PaySettlement selectByPrimaryKey(PageData pd);
    
    List<PaySettlement> listPageByPrimaryKey(Page page);

    int updateByPrimaryKeySelective(PaySettlement record);
    
    int updatePaySettlementByPageData(PageData pd);

    int updateByPrimaryKey(PaySettlement record);
}