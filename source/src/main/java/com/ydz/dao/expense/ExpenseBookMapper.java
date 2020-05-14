package com.ydz.dao.expense;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.expense.ExpenseBook;
import com.ydz.util.PageData;

public interface ExpenseBookMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ExpenseBook record);

    int insertSelective(ExpenseBook record);

    ExpenseBook selectByPrimaryKey(PageData pd);

    int updateByPrimaryKeySelective(ExpenseBook record);

    int updateByPrimaryKey(ExpenseBook record);
    
    List<ExpenseBook> listPageExpenseBooks(Page page);
}