package com.ydz.dao.advert;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesCheckingOrderDetail;
import com.ydz.util.PageData;
import com.ydz.vo.SalesCheckingOrderDetailVO;
import com.ydz.vo.TotalSalesCheckingOrderDetailVO;

public interface SalesCheckingOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<SalesCheckingOrderDetail> records);

    int insertSelective(SalesCheckingOrderDetail record);

    SalesCheckingOrderDetail selectByPrimaryKey(PageData pd);
    //批量查询订单详情
    List<SalesCheckingOrderDetail> selectListByPrimaryKey(PageData pageData);

    List<SalesCheckingOrderDetail> listPageSalesCheckingOrderDetail(Page page);

    int updateByPrimaryKeySelective(SalesCheckingOrderDetail record);

    int updateByPrimaryKey(SalesCheckingOrderDetail record);
    
    int getCountOrderDetail(PageData pd);
    
    int updateBatchDetailBySalesCheckingNoIn(PageData pd);

    List<SalesCheckingOrderDetailVO> selectSalesCheckingOrderVO(PageData pageData);
    
    List<TotalSalesCheckingOrderDetailVO> selectSalesCheckingOrderDetailVO(PageData pageData);
    
    List<TotalSalesCheckingOrderDetailVO> listPageSalesCheckingOrderDetailVO(Page page);
    
    String getGroupBusinessDesc(PageData pd);
}