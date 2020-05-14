/**
 * 
 */
package com.ydz.service.advert;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.util.PageData;
import com.ydz.dao.DaoSupport;
import com.ydz.entity.advert.CheckingInvoice;

/** 
* @ClassName: InvoiceService 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年6月15日 下午3:55:51 
* @Description: 开票Service
*  
*/
@Service("inoviceService")
public class InvoiceService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public void insertInovice(CheckingInvoice invoice) throws Exception{
		dao.save("CheckingInvoiceMapper.insertSelective", invoice);
	}
	
	public void insertInovice(List<CheckingInvoice> invoices) throws Exception{
		dao.batchSave("CheckingInvoiceMapper.insertSelective", invoices);
	}
	
	public void updateInvoice(CheckingInvoice invoice) throws Exception{
		dao.update("CheckingInvoiceMapper.updateByPrimaryKeySelective", invoice);
	}
	
	public void updateInvoice(List<CheckingInvoice> invoices) throws Exception{
		dao.batchUpdate("CheckingInvoiceMapper.updateByPrimaryKeySelective", invoices);
	}
	
	public void deleteInvoice(CheckingInvoice invoice) throws Exception{
		dao.delete("CheckingInvoiceMapper.updateByPrimaryKeySelective", invoice);
	}
	
	public void deleteInvoice(List<CheckingInvoice> invoices) throws Exception{
		dao.batchDelete("CheckingInvoiceMapper.updateByPrimaryKeySelective", invoices);
	}
	
	@SuppressWarnings("unchecked")
	public List<CheckingInvoice> listInvoice(PageData pd) throws Exception{
		return (List<CheckingInvoice>)dao.findForList("CheckingInvoiceMapper.selectByPrimaryKey", pd);
	}
	
	public CheckingInvoice getInvoice(PageData pd) throws Exception{
		return (CheckingInvoice) dao.findForObject("CheckingInvoiceMapper.selectByPrimaryKey", pd);
	}


}
