package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.common.OperateLog;
import com.ydz.util.PageData;

public interface OperateLogMapper {

    int insertSelective(OperateLog record);

    List<OperateLog> listPageOperateLogs(Page page);

}