package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.InstallationCheckingOrderDetail;
import com.ydz.util.PageData;

public interface InstallationCheckingOrderDetailMapper {
    int deleteByPrimaryKey(Long uid);

    int insertList(List<InstallationCheckingOrderDetail> records);

    int insertSelective(InstallationCheckingOrderDetail record);

    InstallationCheckingOrderDetail selectByPrimaryKey(PageData pd);
    
    List<InstallationCheckingOrderDetail> listPageByPrimaryKey(Page page);

    int updateByPrimaryKeySelective(InstallationCheckingOrderDetail record);

    int updateByPrimaryKey(InstallationCheckingOrderDetail record);
}