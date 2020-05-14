package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.project.ContractReturnMoneyRecord;
import com.ydz.util.PageData;

public interface ContractReturnMoneyRecordMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<ContractReturnMoneyRecord> records);

    int insertSelective(ContractReturnMoneyRecord record);

    ContractReturnMoneyRecord selectByPrimaryKey(PageData pd);
    
    List<ContractReturnMoneyRecord> listReturnMoneyRecords(PageData pd);

    int updateByPrimaryKeySelective(ContractReturnMoneyRecord record);

    int updateByPrimaryKey(ContractReturnMoneyRecord record);
}