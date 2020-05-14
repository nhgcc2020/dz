package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignWorkingTask;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;

public interface AssignWorkingTaskMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(AssignWorkingTask record);

    int insertSelective(AssignWorkingTask record);

    AssignWorkingTask selectByPrimaryKey(PageData pd);
    
    List<AssignWorkingTask> listPageAssignWorkingTask(Page page);
    
    TodoCountVO selectCountWorkingStatus(PageData pd);

    int updateByPrimaryKeySelective(AssignWorkingTask record);

    int updateByPrimaryKey(AssignWorkingTask record);
}