package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComPartnerProPrice;
import com.ydz.util.PageData;

public interface ComPartnerProPriceMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ComPartnerProPrice record);
    
    int insertList(List<ComPartnerProPrice> records);

    int insertSelective(ComPartnerProPrice record);

    ComPartnerProPrice selectByPrimaryKey(PageData pd);
    
    List<ComPartnerProPrice> selectComParnter(PageData pd);

    int updateByPrimaryKeySelective(ComPartnerProPrice record);

    int updateByPrimaryKey(PageData pd);
}