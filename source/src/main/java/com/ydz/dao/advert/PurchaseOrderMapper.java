package com.ydz.dao.advert;

import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface PurchaseOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<PurchaseOrder> records);

    int insertSelective(PurchaseOrder record);

    PurchaseOrder selectByPrimaryKey(PageData pd);
    
    List<PurchaseOrder> listPagePurchaseOrder(Page page);
    
    List<PurchaseOrder> listPagePurchaseOrderConcat(Page page);
    
    List<PurchaseOrder> getPurchaseOrderNoList(Page page);

    int updateByPrimaryKeySelective(PurchaseOrder record);

    int updateByMapPara(PageData pd);
    
    //查询非好友的采购单
    List<PurchaseOrder> listPageNomal(Page page);
    //查询好友的采购单 协同采购
    List<PurchaseOrder> listPageSynch(Page page);

    List<PurchaseOrder> listPurchaseOrderBySalesNos(PageData pd);
    
    List<PurchaseOrder> listPurchaseOrderByPurchaseNos(Map<String,Object> map);
    
    //查询来自相同销售单创建的采购单的数量统计
    List<PurchaseOrder> listFromSalesNoToPurchaseNoNum(PageData pd);
    
    String selectOrderCycle(PageData pd);
    
    int updateBatchByPurchaseNoIn(PageData pd);
    
    TodoCountVO selectCountOrderStatus(PageData pd);
    
    OrderTotalVO selectSumPurchaseOrder(PageData pd);
}