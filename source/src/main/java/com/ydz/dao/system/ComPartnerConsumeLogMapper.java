package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.ComPartnerConsumeLog;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface ComPartnerConsumeLogMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ComPartnerConsumeLog record);

    int insertSelective(ComPartnerConsumeLog record);

    ComPartnerConsumeLog selectByPrimaryKey(PageData pd);
    
    List<ComPartnerConsumeLog> listPageByPrimaryKey(Page page);
    
    OrderTotalVO getSumTotalVO(PageData pd);

    int updateByPrimaryKeySelective(ComPartnerConsumeLog record);

    int updateByPrimaryKey(ComPartnerConsumeLog record);
}