package com.ydz.dao.commissions;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.commissions.CommissionsCheckingOrder;
import com.ydz.entity.commissions.CommissionsCheckingOrderVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface CommissionsCheckingOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(CommissionsCheckingOrder record);

    int insertSelective(CommissionsCheckingOrder record);

    CommissionsCheckingOrder selectByPrimaryKey(PageData pd);
    
    List<CommissionsCheckingOrder> listPageByPrimaryKey(Page page);
    
    List<CommissionsCheckingOrderVO> listPageByPrimaryKeyConcat(Page page);
    
    OrderTotalVO getSumTotalVO(Page page);

    int updateByPrimaryKeySelective(CommissionsCheckingOrder record);

    int updateByPrimaryKey(CommissionsCheckingOrder record);
}