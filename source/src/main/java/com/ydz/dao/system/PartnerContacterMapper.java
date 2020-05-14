package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.Partner;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.util.PageData;


public interface PartnerContacterMapper {
	
    int deleteByPrimaryKey(PageData pd);

    int insert(PartnerContacter record);

    int insertSelective(PartnerContacter record);

    PartnerContacter selectOnePartnerContacter(PageData pd);
    
    List<PartnerContacter> listPartnerContacter(PageData pd);
    
    int updateByPrimaryKeySelective(PartnerContacter record);

    int updateByPrimaryKey(PartnerContacter record);

    int updateByPartnerKey(PartnerContacter record);
}
