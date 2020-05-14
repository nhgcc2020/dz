package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.SmsLog;
import com.ydz.util.PageData;

public interface SmsLogMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(SmsLog record);

    int insertSelective(SmsLog record);

    List<SmsLog> selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(SmsLog record);

    int updateByPrimaryKey(SmsLog record);
}