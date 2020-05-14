package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.util.PageData;

public interface OpportunityChatMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(OpportunityChat record);

    int insertSelective(OpportunityChat record);

    OpportunityChat selectByPrimaryKey(PageData pd);
    
    List<OpportunityChat> listPageOpportChats(Page page);
    
    List<OpportunityChat> listLatestChat(PageData pd);

    int updateByPrimaryKeySelective(OpportunityChat record);

    int updateByPrimaryKey(OpportunityChat record);
}