package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.system.ComPartnerRechargeLog;
import com.ydz.entity.system.PartnerVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface ComPartnerRechargeLogMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ComPartnerRechargeLog record);

    int insertSelective(ComPartnerRechargeLog record);
    
    List<PartnerVO> listPageComPartenr(Page page);

    ComPartnerRechargeLog selectByPrimaryKey(PageData pd);
    
    OrderTotalVO selectSumOrderTotalVO(PageData pd);
    
    List<ComPartnerRechargeLog> listPageByPrimaryKey(Page page);

    int updateByPrimaryKeySelective(ComPartnerRechargeLog record);

    int updateByPrimaryKey(ComPartnerRechargeLog record);
}