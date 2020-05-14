/**   
 * @Title: AppExpenseController.java 
 * @Package com.ydz.app.controller 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 20, 2017 5:00:01 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.app.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.expense.ExpenseBook;
import com.ydz.entity.expense.ExpenseBookDetailVO;
import com.ydz.entity.system.Employee;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.ExpenseBookService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppExpenseController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 20, 2017 5:00:01 PM 
 * @Description: app处理费用业务
 */
@RestController
@RequestMapping(value = "app/expense", produces = "application/json;charset=UTF-8")
public class AppExpenseController extends BaseController{
	
	@Resource private EmployeeService employeeService;
	@Resource private ExpenseBookService expenseBookService;
	
	@Resource private CommonService commonService;
	
	@RequestMapping(value = "getExpenseTypeForDropdown")
	public String getExpenseTypeForDropdown(){
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pdData = this.getPageData();
		pdData.put("comKey", userVo.getComKey());
		pdData.put("industryId", userVo.getDetailIndustryId());
		pdData.put("settingClass", Const.COMPANY_SETTING_CLASS_PREFIX_STRING+pdData.getString("settingClass"));
		return JsonUtil.toCompatibleJSONString(expenseBookService.listComSettingClasses(pdData));
	}
	
	@RequestMapping(value = "listSpender")
	public String listSpender(HttpServletRequest request){
		UserVo userVo = this.getAppCurrentUserVo();
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		List<Employee> employees = employeeService.getAllEmployeesForDropdown(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}
	
	@RequestMapping(value = "selectOneExpenseBook")
	public String selectOneExpenseBook(HttpServletRequest request){
		PageData pd = this.getPageData();
		String expenseNo = pd.getString("expenseNo");
		if(StringUtil.isEmpty(expenseNo)){
			return JsonUtil.toJsonString(ResultUtil.error(1, "请选择需要修改的费用单"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		ExpenseBook expenseBook = expenseBookService.getOneExpenseBookAndDetail(expenseNo, userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(expenseBook);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "listExpenseBookDetailVOs")
	public String listExpenseBookDetailVOs(HttpServletRequest request){
		UserVo userVo = this.getAppCurrentUserVo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
		pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
		
		if (StringUtil.isEmpty(pd.getString("spenderKey"))
				||"ALL".equalsIgnoreCase(pd.getString("spenderKey"))) {
			pd.put("spenderKey",null);
		}
		if (StringUtil.isEmpty(pd.getString("expenseTypeDetail"))
				||"ALL".equalsIgnoreCase(pd.getString("expenseTypeDetail"))) {
			pd.put("expenseTypeDetail",null);
		}
		page.setPd(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		List<ExpenseBookDetailVO> bookDetailVOs = expenseBookService.listExpenseBookDetailVOs(page);
		resultMap.setRows(bookDetailVOs);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "insert")
	public String addExpenseBook(@RequestBody ExpenseBook expenseBook){
		if(expenseBook == null
				||expenseBook.getDetails() == null){
			return JsonUtil.toJsonString(ResultUtil.error(1, "保存失败，请重试"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
		int result = 0;
		try {
			result = expenseBookService.insertExpenseBookAndDetail(expenseBook, userVo);
			if(result>0){
				return JsonUtil.toJsonString(ResultUtil.successMsg("保存成功"));
			}else{
				return JsonUtil.toJsonString(ResultUtil.error(1, "保存失败，请重试"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toJsonString(ResultUtil.error(1, "保存失败，请重试"));
		}
	}
	
	@RequestMapping(value = "update")
	public String updateExpenseBook(@RequestBody ExpenseBook expenseBook){
		UserVo userVo = this.getAppCurrentUserVo();
		if(expenseBook == null
				||expenseBook.getDetails() == null){
			return JsonUtil.toJsonString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，请重试"));
		}
		int result = 0;
		try {
			result = expenseBookService.updateExpenseBookAndDetail(expenseBook, userVo);
			if(result>0){
				return JsonUtil.toJsonString(ResultUtil.successMsg("保存成功"));
			}else{
				return JsonUtil.toJsonString(ResultUtil.error(1, "保存失败，请重试"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toJsonString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "保存失败，请重试"));
		}
	}
	

}
