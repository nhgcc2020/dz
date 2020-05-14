package com.ydz.dao.invite;

import java.math.BigDecimal;
import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.invite.InviteReward;
import com.ydz.util.PageData;

public interface InviteRewardMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(InviteReward record);

    int insertSelective(InviteReward record);

    InviteReward selectByPrimaryKey(Long uid);

    int updateByPrimaryKeySelective(InviteReward record);

    int updateByPrimaryKey(InviteReward record);
    
    List<InviteReward> listPageInviteReward(Page page);

    BigDecimal getSumReward(PageData pd);

    List<InviteReward> getListByKey(PageData pd);
}