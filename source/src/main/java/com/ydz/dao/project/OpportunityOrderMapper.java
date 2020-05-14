package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.system.Employee;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface OpportunityOrderMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(OpportunityOrder record);

    int insertSelective(OpportunityOrder record);

    OpportunityOrder selectByPrimaryKey(PageData pd);
    
    List<OpportunityOrder> listPageOpportOrders(Page page);
    
    List<Employee> listParticipanEmployees(PageData pd);
    
    OrderTotalVO getSumOpportQuotMoney(PageData pd);
    
    List<TodoCountVO> selectCountOppoSection(PageData pd);

    int updateByPrimaryKeySelective(OpportunityOrder record);

    int updateByPara(PageData pd);
}