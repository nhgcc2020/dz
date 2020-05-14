package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.PermissionInit;
import com.ydz.util.PageData;


public interface PermissionInitMapper {
    int deleteByPrimaryKey(Long uid);

    int insertBatch(List<PermissionInit> inits);

    int insertSelective(PermissionInit record);

    List<PermissionInit> selectListByPrimaryKey(PageData pd);
    
    PermissionInit selectOneByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(PermissionInit record);

    int updateByPrimaryKey(PermissionInit record);
}