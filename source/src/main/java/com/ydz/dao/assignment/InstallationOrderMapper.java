package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.InstallationOrder;
import com.ydz.entity.assignment.InstallationOrderVO;
import com.ydz.util.PageData;
import com.ydz.vo.TotalSalesOrderDetailVO;

public interface InstallationOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(InstallationOrder record);

    int insertSelective(InstallationOrder record);

    InstallationOrder selectByPrimaryKey(PageData pd);
    
    List<InstallationOrder> listPageByPrimaryKey(Page page);
    
    List<InstallationOrder> listOrderByPrimaryKey(PageData pd);
    
    List<TotalSalesOrderDetailVO> listPageSalesOrderAndDetails(Page page);
    
    InstallationOrderVO getSumMoneyByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(InstallationOrder record);

    int updateByPrimaryKey(InstallationOrder record);
    
    int updateStatusByPrimaryKey(PageData pd);
}