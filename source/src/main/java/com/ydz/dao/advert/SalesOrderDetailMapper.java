package com.ydz.dao.advert;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.util.PageData;
import com.ydz.vo.TotalSalesOrderDetailVO;

public interface SalesOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<SalesOrderDetail> records);

    int insertSelective(SalesOrderDetail record);

    SalesOrderDetail selectByPrimaryKey(PageData pd);
    
    List<SalesOrderDetail> listPageSalesOrderDetail(Page page);
    
    List<SalesOrderDetail> listPageTotalDetailByOrder(Page page);

    List<TotalSalesOrderDetailVO> selectTotalDetailBySalesNo(PageData pd);

    int updateByPrimaryKeySelective(SalesOrderDetail record);

    int updateByPrimaryKey(SalesOrderDetail record);

    List<SalesOrderDetail> selectSalesOrderDetail(PageData pd);
    
    //根据salseNo集合 批量查询订单详情信息
    List<SalesOrderDetail> selectBatchSalesOrderDetail(Map<String,Object> map);
    
    String getGroupBusinessDesc(PageData pd);
    
    List<SalesOrderDetail> getSalesOrderNos(PageData pd);
    
    int getCountOrderDetail(PageData pd);
    
    int updateBatchDetailBySalesNoIn(PageData pd);
    
    BigDecimal selectDetailTotalPriceBySalesNo(PageData pd);
}