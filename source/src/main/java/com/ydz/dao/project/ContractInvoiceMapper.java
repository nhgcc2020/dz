package com.ydz.dao.project;

import java.util.List;

import com.ydz.entity.project.ContractInvoice;
import com.ydz.util.PageData;

public interface ContractInvoiceMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<ContractInvoice> records);

    int insertSelective(ContractInvoice record);

    ContractInvoice selectByPrimaryKey(PageData pd);
    
    List<ContractInvoice> listContractInvoices(PageData pd);

    int updateByPrimaryKeySelective(ContractInvoice record);

    int updateByPrimaryKey(ContractInvoice record);
}