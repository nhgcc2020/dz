package com.ydz.dao.commissions;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.commissions.CommissionsCheckingOrderDetail;
import com.ydz.util.PageData;

public interface CommissionsCheckingOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<CommissionsCheckingOrderDetail> details);

    int insertSelective(CommissionsCheckingOrderDetail record);

    CommissionsCheckingOrderDetail selectByPrimaryKey(PageData pd);
    
    List<CommissionsCheckingOrderDetail> listPageDetailsByPrimaryKey(Page page);

    int updateByPrimaryKeySelective(CommissionsCheckingOrderDetail record);

    int updateByPrimaryKey(CommissionsCheckingOrderDetail record);
}