package com.ydz.dao.system;

import java.util.LinkedList;
import java.util.List;

import com.ydz.entity.system.ComPartner;
import com.ydz.entity.system.PartnerVO;
import com.ydz.util.PageData;
import com.ydz.vo.ComPartnerTotalPriceVO;

/** 
 * @ClassName: ComPartnerMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月27日 下午3:05:05 
 * 
 */
public interface ComPartnerMapper {
	
	int deleteByPrimaryKey(PageData pd);

	List<ComPartner> selectByPrimaryKey(PageData pd);
	
	ComPartner selectMyPartnerKey(PageData pd);
	
	LinkedList<PartnerVO> selectPartnerDropdown(PageData pd);
	
	int insertSelective(ComPartner record);
	
	int updateByPrimaryKeySelective(ComPartner record);

	int updateByPrimaryKeySelectiveByUid(ComPartner record);
	
//	ComPartnerTotalPriceVO selectComPartnerTotalPriceByCustomerKey(PageData pd);
	List<ComPartnerTotalPriceVO> selectComPartnerTotalPriceByCustomerKey(PageData pd);
	
//	ComPartnerTotalPriceVO selectComPartnerTotalPriceBySupplierKey(PageData pd);
	List<ComPartnerTotalPriceVO> selectComPartnerTotalPriceBySupplierKey(PageData pd);

}
