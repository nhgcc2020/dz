package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Service;

import com.ydz.dao.expense.ExpenseBookDetailMapper;
import com.ydz.dao.expense.ExpenseBookMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.expense.ExpenseBook;
import com.ydz.entity.expense.ExpenseBookDetail;
import com.ydz.entity.expense.ExpenseBookDetailVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.common.CommonService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: ExpenseBookService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月11日 上午11:25:17 
 * @Description: 费用记录业务处理类
 */
@Service
public class ExpenseBookService {
	
	@Autowired private ExpenseBookMapper expenseBookMapper;
	@Autowired private ExpenseBookDetailMapper expenseBookDetailMapper;
	
	@Resource private CommonService commonService;
	
	public List<ExpenseBookDetailVO> listExpenseBookDetailVOs(Page page){
		return expenseBookDetailMapper.listPageExpenseBookDetailVOs(page);
	}
	
	public ExpenseBook selectOneExpenseBook(PageData pd){
		return expenseBookMapper.selectByPrimaryKey(pd);
	}
	
	public List<ExpenseBookDetail> selectExpenseBookDetails(PageData pd){
		Page page = new Page();
		page.setPd(pd);
		page.setShowCount(300);
		return expenseBookDetailMapper.listPageExpenseBookDetails(page);
	}
	
	public ExpenseBook getOneExpenseBookAndDetail(String expenseNo,String comKey){
		PageData pd = new PageData();
		pd.put("expenseNo", expenseNo);
		pd.put("comKey", comKey);
		ExpenseBook expenseBook = this.selectOneExpenseBook(pd);
		if (expenseBook == null) {
			return null;
		}
		expenseBook.setDetails(this.selectExpenseBookDetails(pd));
		return expenseBook;
		
	}
	
	/**
	 * 
	 * @Title: insertExpenseBookAndDetail 
	 * @param expenseBook
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 创建费用单及明细
	 */
	public int insertExpenseBookAndDetail(ExpenseBook expenseBook,UserVo userVo) throws Exception{
		List<ExpenseBookDetail> bookDetails = expenseBook.getDetails();
		Date nowDate = new Date();
		expenseBook.setExpenseNo(CodeBuilderUtil.getInstance().getAnyId(10));
		expenseBook.setComKey(userVo.getComKey());
		expenseBook.setIndustryId(userVo.getDetailIndustryId());
		expenseBook.setChargeDate(nowDate);
		expenseBook.setCreateTime(nowDate);
		expenseBook.setCreator(userVo.getUserKey());
		expenseBook.setIsDel("0");
		
		//去除空数据
		Iterator<ExpenseBookDetail> it = bookDetails.iterator();
		while (it.hasNext()) {
			ExpenseBookDetail detail = (ExpenseBookDetail) it.next();
			if (StringUtil.isEmpty(detail.getExpenseDesc())) {
				it.remove();
			}
		}
		if(bookDetails.size()==0){
			return 0;
		}
		
		int i = 1;
		BigDecimal totalMoney = BigDecimal.ZERO;
		for (ExpenseBookDetail detail : bookDetails) {
			detail.setExpenseNo(expenseBook.getExpenseNo());
			detail.setItemNo(i++);
			detail.setIsDel("0");
			detail.setCreateTime(expenseBook.getCreateTime());
			detail.setCreator(expenseBook.getCreator());
			totalMoney = totalMoney.add(detail.getMoney()==null?BigDecimal.ZERO:detail.getMoney());
			if (StringUtil.isEmpty(detail.getExpenseType())) {
				detail.setExpenseType("00");
				detail.setExpenseTypeDesc("未分类");
			}else if ("00".equalsIgnoreCase(detail.getExpenseType())) {
				detail.setExpenseTypeDesc("未分类");
			}
		}
		expenseBook.setTotalMoney(totalMoney);
		expenseBook.setDetailNum(i-1);
		
		
		expenseBookDetailMapper.insertList(bookDetails);
		int result = expenseBookMapper.insertSelective(expenseBook);
		
		return result;
	}
	
	public int updateExpenseBookAndDetail(ExpenseBook expenseBook,UserVo userVo) throws Exception{
		Date nowDate = new Date();
		List<ExpenseBookDetail> details = expenseBook.getDetails();
		expenseBook.setComKey(userVo.getComKey());
		expenseBook.setIndustryId(userVo.getDetailIndustryId());
		expenseBook.setCreateTime(nowDate);
		expenseBook.setCreator(userVo.getUserKey());
		
		//去除空数据
		Iterator<ExpenseBookDetail> it = details.iterator();
		while (it.hasNext()) {
			ExpenseBookDetail detail = (ExpenseBookDetail) it.next();
			if (StringUtil.isEmpty(detail.getExpenseDesc())) {
				it.remove();
			}
		}
		if(details.size()==0){
			return 0;
		}
		int i = 1;
		BigDecimal totalMoney = BigDecimal.ZERO;
		for (ExpenseBookDetail detail : details) {
			detail.setExpenseNo(expenseBook.getExpenseNo());
			detail.setItemNo(i++);
			detail.setIsDel("0");
			detail.setCreateTime(expenseBook.getCreateTime());
			detail.setCreator(expenseBook.getCreator());
			totalMoney = totalMoney.add(detail.getMoney()==null?BigDecimal.ZERO:detail.getMoney());
			if (StringUtil.isEmpty(detail.getExpenseType())) {
				detail.setExpenseType("00");
				detail.setExpenseTypeDesc("未分类");
			}else if ("00".equalsIgnoreCase(detail.getExpenseType())) {
				detail.setExpenseTypeDesc("未分类");
			}
		}
		expenseBook.setTotalMoney(totalMoney);
		expenseBook.setDetailNum(i-1);
		
		//删除旧的费用明细
		PageData pdDel = new PageData();
		pdDel.put("expenseNo", expenseBook.getExpenseNo());
		expenseBookDetailMapper.deleteByPrimaryKey(pdDel);
		
		expenseBookDetailMapper.insertList(details);
		int result = expenseBookMapper.updateByPrimaryKeySelective(expenseBook);
		return result;
	}
	
	public int deleteExpenseBook(PageData pd){
		int result = 0;
		expenseBookDetailMapper.deleteByPrimaryKey(pd);
		result = expenseBookMapper.deleteByPrimaryKey(pd);
		return result;
	}
	
	public List<ComSettingClass> listComSettingClasses(PageData pd){
		return commonService.listComSettingClasses(pd);
	}
	
	public int insertComSettingClass(ComSettingClass comSettingClass)
			throws Exception {
		PageData pd = new PageData();
		pd.put("comKey", comSettingClass.getComKey());
		pd.put("settingClass", Const.COMPANY_SETTING_CLASS_PREFIX_STRING
				+ comSettingClass.getSettingClass());
		int maxTypeCode = commonService.selectMaxTypeCodeByPrimaryKey(pd);
		String typeCode = (maxTypeCode + 1) < 10 ? "0"
				+ Integer.toString(maxTypeCode + 1) : Integer
				.toString((maxTypeCode + 1));
		comSettingClass.setTypeCode(typeCode);
		comSettingClass
				.setSettingClass(Const.COMPANY_SETTING_CLASS_PREFIX_STRING
						+ comSettingClass.getSettingClass());
		comSettingClass.setCreateTime(new Date());
		return commonService.insertComSettingClass(comSettingClass);
	}
	
	public int updateComSettingClass(ComSettingClass comSettingClass) 
			throws Exception{
		return commonService.updateComSettingClass(comSettingClass);
	}

}
