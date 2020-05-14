package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.InstallationCheckingOrder;
import com.ydz.entity.assignment.InstallationCheckingOrderVO;
import com.ydz.util.PageData;

public interface InstallationCheckingOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(InstallationCheckingOrder record);

    int insertSelective(InstallationCheckingOrder record);

    InstallationCheckingOrder selectByPrimaryKey(PageData pd);
    
    List<InstallationCheckingOrderVO> listPageCheckingOrdersConcat(Page page);

    int updateByPrimaryKeySelective(InstallationCheckingOrder record);

    int updateByPrimaryKey(InstallationCheckingOrder record);
}