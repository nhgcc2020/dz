package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignTaskDetail;
import com.ydz.util.PageData;

public interface AssignTaskDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(AssignTaskDetail record);
    
    int insertSelective(AssignTaskDetail record);
    
    int insertList(List<AssignTaskDetail> details);

    AssignTaskDetail selectByPrimaryKey(PageData pd);

    List<AssignTaskDetail> listPageByPrimaryKey(Page page);

    int updateByPrimaryKeySelective(AssignTaskDetail record);

    int updateByPrimaryKey(AssignTaskDetail record);
    
    int updateBatch(PageData pd);
    
    List<AssignTaskDetail> selectDoingTaskEmployee(PageData pd);
    
    List<AssignTaskDetail> selectValidTaskDetail(PageData pd);
}