package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.system.Employee;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;

public interface AssignTaskMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(AssignTask record);

    int insertSelective(AssignTask record);

    AssignTask selectByPrimaryKey(PageData pd);
    
    List<AssignTask> listPageTodoTask(Page page);
    
    List<AssignTask> listPageByPrimaryKey(PageData pd);
    
    List<AssignTask> listPageAssignTasks(Page page);
    
    List<Employee> listTaskEmployee(PageData pd);
    
    TodoCountVO selectCountAssignStatus(PageData pd);

    int updateByPrimaryKeySelective(AssignTask record);

    int updateByPrimaryKey(AssignTask record);
    
    int updateBatch(PageData pd);
}