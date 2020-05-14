package com.ydz.dao.advert;

import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesCheckingOrderDetail;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.AllSalesCheckingOrderVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.SalesCheckingOrderVO;

public interface SalesCheckingOrderMapper {
	
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<SalesCheckingOrder> records);

    int insertSelective(SalesCheckingOrder record);

    SalesCheckingOrder selectByPrimaryKey(PageData pd);
    
    List<SalesCheckingOrder> listPageSalesCheckingOrder(Page page);
    
//    List<SalesCheckingOrder> listPageSalesCheckingOrderConcat(Page page);

    int updateByPrimaryKeySelective(SalesCheckingOrder record);

    int updateByPrimaryKey(SalesCheckingOrder record);
    //根据订单号批量查询订单
    List<SalesCheckingOrder> listCheckingOrderByOrderNos(Map<String,Object> map);

    int updateBatchBySalesCheckingNoIn(PageData pd);
    
    TodoCountVO selectCountOrderStatus(PageData pd);
    
    OrderTotalVO selectSumSalesCheckingOrder(PageData pd);

    List<AllSalesCheckingOrderVO>  listPageAllSalesCheckingOrder(Page page);
    
    List<AllSalesCheckingOrderVO>  listPageAllSalesCheckingOrderConCat(Page page);
    
    List<SalesCheckingOrder> getSalescheckingOrderNos(PageData pd);

    int updateByPartnerKey(SalesCheckingOrder record);
    
    String selectSalesNoIns(PageData pd);
}