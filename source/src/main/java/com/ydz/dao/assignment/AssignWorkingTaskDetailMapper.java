package com.ydz.dao.assignment;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignWorkingTaskDetail;
import com.ydz.entity.assignment.AssignWorkingTaskDetailVO;
import com.ydz.util.PageData;

public interface AssignWorkingTaskDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<AssignWorkingTaskDetail> details);

    int insertSelective(AssignWorkingTaskDetail record);

    List<AssignWorkingTaskDetail> selectByPrimaryKey(PageData pd);
    
    List<AssignWorkingTaskDetail> selectListByPrimaryKey(PageData pd);
    
    List<AssignWorkingTaskDetailVO> listPageAssignWorkingTaskDetailVO(Page page);
    
    List<AssignWorkingTaskDetailVO> listPageSalesNoIns(Page page);

    int updateByPrimaryKeySelective(AssignWorkingTaskDetail record);

    int updateAssignWorkingTaskDetailByMapPara(PageData pd);
    
    int updateThrowUpByKey(PageData pd);
    
    int updateReItemNoByKey(PageData pd);
}