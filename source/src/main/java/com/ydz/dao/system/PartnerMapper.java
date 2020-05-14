package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.Partner;
import com.ydz.entity.system.PartnerVO;
import com.ydz.util.PageData;


public interface PartnerMapper {
	
    int deleteByPrimaryKey(PageData pd);

    int insert(Partner record);

    int insertSelective(Partner record);

    Partner selectByPrimaryKey(PageData pd);
    
    List<PartnerVO> listPageRartnerByComKey(Page page);

    int updateByPrimaryKeySelective(Partner record);

    int updateByPrimaryKey(Partner record);
    
//    List<PartnerVO> selectDropdownPartner(PageData pd);

    PartnerVO checkPartner(PageData pageData);

    PartnerVO findPartnerByCPKey(PageData pageData);
    
    PartnerVO getComPartnerAndPartnerInfo(PageData pd);

    List<PartnerVO> listByPhone(PageData pageData);
    //读取单条记录
    PartnerVO getPartnerAndContacterByPartnerKey(PageData pd);
    
    List<Partner> listPartners(PageData pd);
}
