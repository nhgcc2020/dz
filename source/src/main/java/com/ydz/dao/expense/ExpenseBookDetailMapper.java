package com.ydz.dao.expense;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.expense.ExpenseBookDetail;
import com.ydz.entity.expense.ExpenseBookDetailVO;
import com.ydz.util.PageData;

public interface ExpenseBookDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ExpenseBookDetail record);

    int insertSelective(ExpenseBookDetail record);
    
    int insertList(List<ExpenseBookDetail> details);

    ExpenseBookDetail selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(ExpenseBookDetail record);

    int updateByPrimaryKey(ExpenseBookDetail record);
    
    List<ExpenseBookDetail> listPageExpenseBookDetails(Page page);
    
    List<ExpenseBookDetailVO> listPageExpenseBookDetailVOs(Page page);
}