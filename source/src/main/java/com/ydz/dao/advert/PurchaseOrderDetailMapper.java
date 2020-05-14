package com.ydz.dao.advert;

import java.util.List;
import java.util.Map;

import com.ydz.entity.Page;
import com.ydz.entity.advert.PurchaseCheckingOrderDetail;
import com.ydz.entity.advert.PurchaseOrderDetail;
import com.ydz.util.PageData;
import com.ydz.vo.TotalPurchaseOrderDetailVO;

public interface PurchaseOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<PurchaseOrderDetail> records);

    int insertSelective(PurchaseOrderDetail record);

    PurchaseOrderDetail selectByPrimaryKey(PageData pd);

    List<PurchaseOrderDetail> selectListByPrimaryKey(PageData pd);
    
    List<PurchaseOrderDetail> listPagePurchaseOrderDetail(Page page);

    int updateByPrimaryKeySelective(PurchaseOrderDetail record);
    
    int updateByMapPara(PageData pd);

    //根据采购对账单号（集合）批量查询采购对账单明细
    List<PurchaseOrderDetail> batchSelectPurchaseOrderDetail(Map<String,Object> map);
    
    int getCountOrderDetail(PageData pd);
    
    String getGroupBusinessDesc(PageData pd);
    
    int updateBatchDetailByPurchaseNoIn(PageData pd);
    
    List<TotalPurchaseOrderDetailVO> listPageTotalPurchaseDetail(Page page);
}