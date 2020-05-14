package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.InstallationOrderDetail;
import com.ydz.entity.assignment.InstallationOrderVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface InstallationOrderDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<InstallationOrderDetail> records);

    int insertSelective(InstallationOrderDetail record);

    InstallationOrderDetail selectByPrimaryKey(PageData pd);
    
    List<InstallationOrderDetail> listPageByPrimaryKey(Page page);
    
    List<InstallationOrderDetail> listDetailsByPrimaryKey(PageData pd);
    
    List<InstallationOrderVO> listPageInstallationOrderDetailConcat(Page page);
    
    OrderTotalVO selectOrderTotalVO(Page page);

    int updateByPrimaryKeySelective(InstallationOrderDetail record);

    int updateByPrimaryKey(InstallationOrderDetail record);
}