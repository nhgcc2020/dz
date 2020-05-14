package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.InstallStandingBy;
import com.ydz.util.PageData;

public interface InstallStandingByMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(InstallStandingBy record);

    int insertSelective(InstallStandingBy record);
    
    int insertList(List<InstallStandingBy> record);

    InstallStandingBy selectByPrimaryKey(PageData pd);
    
    List<InstallStandingBy> listPageInstallStandingBys(Page page);

    int updateByPrimaryKeySelective(InstallStandingBy record);

    int updateByPrimaryKey(InstallStandingBy record);
    
    int updateStatusByPrimaryKey(PageData pd);
}