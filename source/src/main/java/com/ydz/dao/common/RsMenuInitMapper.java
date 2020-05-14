package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.init.RsMenuInit;
import com.ydz.util.PageData;
import com.ydz.vo.RoleMenuVO;

public interface RsMenuInitMapper {
    int deleteByPrimaryKey(Long uid);

    int insert(RsMenuInit record);

    int insertSelective(RsMenuInit record);

//    RsMenuInit selectOneByPrimaryKey(PageData pd);

    List<RsMenuInit> selectListByPrimaryKey(PageData pd);
    
    List<RoleMenuVO> selectListVOByPrimaryKey(PageData pd);
    
    int updateByPrimaryKeySelective(RsMenuInit record);

    int updateByPrimaryKey(RsMenuInit record);
}