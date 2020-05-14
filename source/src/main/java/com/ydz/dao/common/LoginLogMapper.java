package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.LoginLog;
import com.ydz.util.PageData;

public interface LoginLogMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(LoginLog record);

    int insertSelective(LoginLog record);

    List<LoginLog> selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(LoginLog record);

    int updateByPrimaryKey(LoginLog record);
}