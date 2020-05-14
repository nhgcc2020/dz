package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignWorkingProcedure;
import com.ydz.util.PageData;

public interface AssignWorkingProcedureMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(AssignWorkingProcedure record);

    int insertSelective(AssignWorkingProcedure record);

    AssignWorkingProcedure selectByPrimaryKey(PageData pd);
    
    List<AssignWorkingProcedure> listPageAssignWorkingProcedure(Page page);

    int updateByPrimaryKeySelective(AssignWorkingProcedure record);

    int updateByPrimaryKey(AssignWorkingProcedure record);
}