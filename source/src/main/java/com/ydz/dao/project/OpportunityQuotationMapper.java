package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.util.PageData;

public interface OpportunityQuotationMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<OpportunityQuotation> records);

    int insertSelective(OpportunityQuotation record);

    OpportunityQuotation selectByPrimaryKey(PageData pd);
    
    List<OpportunityQuotation> listQuotations(PageData pd);
    
    Integer selectMaxVersionByPrimaryKey(PageData pd);
    
    Integer selectMinVersionByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(OpportunityQuotation record);

    int updateByPara(PageData pd);
}