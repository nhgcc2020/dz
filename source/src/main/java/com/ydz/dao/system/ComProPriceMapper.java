package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComProPrice;
import com.ydz.entity.system.ComProPriceVO;
import com.ydz.util.PageData;

public interface ComProPriceMapper {
    int deleteByPrimaryKey(PageData pd);
    
    int deleteAllCompany(PageData pd);

    int insertBatch(List<ComProPrice> records);

    int insertSelective(ComProPrice record);

    ComProPrice selectByPrimaryKey(PageData pd);
    
    List<ComProPrice> listComProPrice(PageData pd);
    
    List<ComProPrice> selectComProPriceAndPriceLevel(PageData pd);
    
//    List<ComProPrice> selectComProPrices(PageData pd);
    
    int updateByPrimaryKeySelective(ComProPrice record);
    
    int updateByPrimaryKey(PageData pd);

    List<ComProPrice> selectComProPricesToExcel(PageData pd);
    
    ComProPrice selectMaxCategoryId(PageData pd);
    
    List<ComProPrice> selectComPartnerProPriceAndPriceLevel(PageData pd);
    
    List<ComProPrice> listComProPricesByDesc(PageData pd);
    
    List<ComProPrice> listComPartnerProPricesByDesc(PageData pd);
}