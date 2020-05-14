package com.ydz.dao.advert;

import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;
import com.ydz.util.PageData;
import com.ydz.vo.TotalPurchaseCheckingOrderDetailVO;

public interface PurchaseCheckingOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<PurchaseCheckingOrderDetail> records);

    int insertSelective(PurchaseCheckingOrderDetail record);

    PurchaseCheckingOrderDetail selectByPrimaryKey(PageData pd);

    List<PurchaseCheckingOrderDetail> selectListByPrimaryKey(PageData pd);
    
    List<PurchaseCheckingOrderDetail> listPagePurchaseCheckingOrderDetail(Page page);
    
    List<TotalPurchaseCheckingOrderDetailVO> selectPurchasecheckingOrderDetailVO(PageData pd);

    int updateByPrimaryKeySelective(PurchaseCheckingOrderDetail record);

    int updateByPrimaryKey(PurchaseCheckingOrderDetail record);

    //根据采购对账单号（集合）批量查询采购对账单明细
    List<PurchaseCheckingOrderDetail> batchSelectPurchaseCheckingOrderDetail(Map<String,Object> map);
    
    int getCountOrderDetail(PageData pd);
    
    String getGroupBusinessDesc(PageData pd);
    
    int updateBatchDetailByPurchaseCheckingNoIn(PageData pd);
}