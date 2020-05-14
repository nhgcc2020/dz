package com.ydz.dao.advert;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseCheckingOrder;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.AllPurchaseCheckingOrderVO;
import com.ydz.vo.OrderTotalVO;

public interface PurchaseCheckingOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<PurchaseCheckingOrder> records);

    int insertSelective(PurchaseCheckingOrder record);

    PurchaseCheckingOrder selectByPrimaryKey(PageData pd);
    
    List<PurchaseCheckingOrder> listPagePurchaseCheckingOrder(Page page);

    List<PurchaseCheckingOrder> listPagePurchaseCheckingOrderConcat(Page page);
    
    int updateByPrimaryKeySelective(PurchaseCheckingOrder record);

    int updateByPrimaryKey(PurchaseCheckingOrder record);

    int updateBatchByPurchaseCheckingNoIn(PageData pd);
    
    TodoCountVO selectCountOrderStatus(PageData pd);
    
    OrderTotalVO selectSumPurchaseCheckingOrder(PageData pd);
    
    List<AllPurchaseCheckingOrderVO> listPageTotalPurchaseCheckingOrder(Page page);
}