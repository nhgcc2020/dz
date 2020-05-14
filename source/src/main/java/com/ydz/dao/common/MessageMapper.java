package com.ydz.dao.common;

import com.ydz.entity.Page;
import com.ydz.entity.common.Message;
import com.ydz.util.PageData;
import com.ydz.vo.MessageCompanyVO;

import java.util.List;

public interface MessageMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectOneByPrimaryKey(PageData pd);
    
    List<Message> listPageMessages(Page page);
    
    int selectCountReadStatus(PageData pd);
    
    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<MessageCompanyVO> listPageFriendRequest(Page page);


}