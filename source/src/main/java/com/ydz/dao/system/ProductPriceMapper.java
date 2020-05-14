package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComProPriceVO;
import com.ydz.entity.system.ProductPrice;
import com.ydz.util.PageData;

/** 
 * @ClassName: ProductPriceMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月15日 下午6:10:20 
 * 
 */
public interface ProductPriceMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(ProductPrice record);

    int insertSelective(ProductPrice record);
    
    List<ProductPrice> listAllProductPriceInit(PageData pd);

    List<ComProPriceVO> listProductPrice(PageData pd);
    
    List<ComProPriceVO> listFastProductPrice(PageData pd);
    
    List<ComProPriceVO> listFastProductPriceUnion(PageData pd);

    List<ComProPriceVO> listDropdownProductPrice(PageData pd);
    
    int updateByPrimaryKeySelective(ProductPrice record);

    int updateByPrimaryKey(ProductPrice record);
}
