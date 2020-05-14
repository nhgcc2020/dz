package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.project.ContractProject;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.util.PageData;
import com.ydz.vo.OrderTotalVO;

public interface ContractProjectMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(ContractProject record);

    int insertSelective(ContractProject record);

    ContractProject selectByPrimaryKey(PageData pd);
    
    TodoCountVO selectCountContract(PageData pd);
    
    List<ContractProject> listPageContractProjects(Page page);
    
    OrderTotalVO getSumContractMoney(PageData pd);

    int updateByPrimaryKeySelective(ContractProject record);

    int updateContractByPara(PageData pd);
}