package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.project.ContractReturnMoneyPlan;
import com.ydz.util.PageData;

public interface ContractReturnMoneyPlanMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<ContractReturnMoneyPlan> records);

    int insertSelective(ContractReturnMoneyPlan record);

    ContractReturnMoneyPlan selectByPrimaryKey(PageData pd);
    
    List<ContractReturnMoneyPlan> listContractReturnMoneyPlans(PageData pd);

    int updateByPrimaryKeySelective(ContractReturnMoneyPlan record);

    int updateByPrimaryKey(ContractReturnMoneyPlan record);
}