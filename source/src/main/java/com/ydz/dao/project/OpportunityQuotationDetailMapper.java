package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.project.OpportunityQuotationDetail;
import com.ydz.util.PageData;

public interface OpportunityQuotationDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<OpportunityQuotationDetail> records);

    int insertSelective(OpportunityQuotationDetail record);

    OpportunityQuotationDetail selectByPrimaryKey(PageData pd);
    
    List<OpportunityQuotationDetail> listPageOpportQuotDetails(Page page);

    int updateByPrimaryKeySelective(OpportunityQuotationDetail record);

    int updateByPrimaryKey(OpportunityQuotationDetail record);
}