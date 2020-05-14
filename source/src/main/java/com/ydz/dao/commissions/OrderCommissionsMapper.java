package com.ydz.dao.commissions;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.commissions.CommissionsCheckingOrderDetail;
import com.ydz.entity.commissions.OrderCommissions;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface OrderCommissionsMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<OrderCommissions> records);

    int insertSelective(OrderCommissions record);

    OrderCommissions selectByPrimaryKey(PageData pd);
    
    List<OrderCommissions> listPageByPrimaryKey(Page page);
    
    List<CommissionsCheckingOrderDetail> listPageSalesCheckingOrderForCommissions(Page page);
    
	OrderTotalVO selectSumSalesCheckingOrderAndSettlement(PageData pd);
	
	List<OrderCommissions> listPageAssignTasksForCommission(Page page);
	
	List<OrderCommissions> listPageOrderCommissionByDesign(Page page);
	
	OrderTotalVO selectSumDesignerCommission(PageData pd);

    int updateByPrimaryKeySelective(OrderCommissions record);

    int updateByPrimaryKey(OrderCommissions record);
    
    int updateBatchStatusByPrimaryKey(PageData pd);
}