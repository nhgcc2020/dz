package com.ydz.dao.advert;

import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesMan;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface SalesOrderMapper {
	
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<SalesOrder> records);

    int insertSelective(SalesOrder record);

    SalesOrder selectByPrimaryKey(PageData pd);

    List<SalesOrder> listPageSalesOrder(Page page);
    
    List<SalesOrder> listPageSalesOrderConcat(Page page);

    List<SalesMan> listSalesMan(PageData pd);

    int updateByPrimaryKeySelective(SalesOrder record);

    int updateSalesOrderByMapPara(PageData pd);
    //根据销售订单号批量查询销售订单订单
    List<SalesOrder> listSalesOrderByOrderNos(Map<String,Object> map);
//    根据采购订单号批量查询协同销售订单
    List<SalesOrder> listSalesOrderByPurchaseOrderNos(Map<String,Object> map);

    TodoCountVO selectCountOrderStatus(PageData pd);
    
    String selectOrderCycle(PageData pd);

    int updateBatchBySalesNoIn(PageData pd);
    
    OrderTotalVO selectSumSalesOrder(PageData pd);

    int salesOrderCount(PageData pd);

    //根据partnerKey修改partnerName和partnerShortname
    int updateByPartnerKey(SalesOrder record);
}
