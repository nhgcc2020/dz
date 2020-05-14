package com.ydz.controller.expense;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.ComSettingClass;
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
 * @ClassName: ExpenseBookController 
 * @Description: 费用控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月22日 上午10:51:50 
 * 
 */
@Controller
@RequestMapping(value = "ydz/expensebook", produces = "application/json;charset=UTF-8")
public class ExpenseBookController extends BaseController{
	
	@Resource private EmployeeService employeeService;
	@Resource private ExpenseBookService expenseBookService;
	
	@Resource private CommonService commonService;
	
	/**
	 * 
	 * @Title: getExpenseTypeInfo 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 根据类型获取对应的下拉框
	 * 01日常支出 02工资支出
	 */
	@RequestMapping(value = "getExpenseTypeForDropdown")
	@ResponseBody
	public String getExpenseTypeForDropdown(){
		UserVo userVo = this.getSessionUservo();
		PageData pdData = this.getPageData();
		pdData.put("comKey", userVo.getComKey());
		pdData.put("industryId", userVo.getDetailIndustryId());
		pdData.put("settingClass", Const.COMPANY_SETTING_CLASS_PREFIX_STRING+pdData.getString("settingClass"));
		return JsonUtil.toCompatibleJSONString(expenseBookService.listComSettingClasses(pdData));
	}
	
	@RequestMapping(value = "forward-add")
	public ModelAndView addNewExpense(){
		PageData pd = this.getPageData();
		String expenseType = pd.getString("expenseType");
		if (StringUtil.isEmpty(expenseType)) {
			expenseType = "0";
		}
		if ("0".equalsIgnoreCase(expenseType)) {
			return new ModelAndView("jsp/expense/expense-add");
		}else{
			return new ModelAndView("jsp/expense/expense-wages-add");
		}
	}
	
	/**
	 * 
	 * @Title: updateExpense 
	 * @param expenseNo
	 * @param type 区分修改还是创建相似。update表示修改 copyAdd表示创建相似
	 * @return
	 * @return ModelAndView
	 * @throws 
	 * @Description: 修改费用单跳转
	 */
	@RequestMapping(value = "forward-update")
	public ModelAndView updateExpense(String expenseNo,String type){
		PageData pd = this.getPageData();
		String expenseType = pd.getString("expenseType");
		if (StringUtil.isEmpty(expenseType)) {
			expenseType = "0";
		}
		if ("0".equalsIgnoreCase(expenseType)) {
			return new ModelAndView("jsp/expense/expense-update").addObject("expenseNo", expenseNo).addObject("type",type);
		}else {
			return new ModelAndView("jsp/expense/expense-wages-update").addObject("expenseNo", expenseNo).addObject("type",type);
		}
		
	}
	
	/**
	 * 
	 * @Title: listSpender 
	 * @param request
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 返回费用的经办人列表
	 */
	@RequestMapping(value = "listSpender")
	@ResponseBody
	public String listSpender(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		List<Employee> employees = employeeService.getAllEmployeesForDropdown(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}
	
	@RequestMapping(value = "selectOneExpenseBook")
	@ResponseBody
	public String selectOneExpenseBook(HttpServletRequest request){
		PageData pd = this.getPageData();
		String expenseNo = pd.getString("expenseNo");
		if(StringUtil.isEmpty(expenseNo)){
			return JsonUtil.toJsonString(ResultUtil.error(1, "请选择需要修改的费用单"));
		}
		UserVo userVo = this.getSessionUservo();
		ExpenseBook expenseBook = expenseBookService.getOneExpenseBookAndDetail(expenseNo, userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(expenseBook);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "listExpenseBookDetailVOs")
	@ResponseBody
	public String listExpenseBookDetailVOs(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(pd.getString("startDate"))) {
			pd.put("startDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("endDate"))) {
			pd.put("endDate", null);
		}
		pd.put("expenseExplain", pd.getString("searchKey"));
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
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "insert")
	@ResponseBody
	public String addExpenseBook(@RequestBody ExpenseBook expenseBook){
		if(expenseBook == null
				||expenseBook.getDetails() == null){
			return JsonUtil.toJsonString(ResultUtil.error(1, "保存失败，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
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
	@ResponseBody
	public String updateExpenseBook(@RequestBody ExpenseBook expenseBook){
		UserVo userVo = this.getSessionUservo();
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
	
	@RequestMapping(value = "delete")
	@ResponseBody
	public String deleteExpenseBook(){
		PageData pd = this.getPageData();
		String expenseNo = pd.getString("expenseNo");
		if (StringUtil.isEmpty(expenseNo)) {
			return JsonUtil.toJsonString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "删除失败，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = expenseBookService.deleteExpenseBook(pd);
			if(result>0){
				return JsonUtil.toJsonString(ResultUtil.successMsg("删除成功"));
			}else{
				return JsonUtil.toJsonString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "删除失败，请重试"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toJsonString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "删除失败，请重试"));
		}
	}
	
	@RequestMapping(value = "listExpenseTypeSetting")
	@ResponseBody
	public String listExpenseTypeSetting(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(pd.getString("settingClass"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("错误的查询"));
		}
		pd.put("settingClass", Const.COMPANY_SETTING_CLASS_PREFIX_STRING+pd.getString("settingClass"));
		return JsonUtil.toCompatibleJSONString(commonService.listComSettingClasses(pd));
		
	}
	/**
	 * 
	 * @Title: expenseTypeSetting 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 新建,修改，删除费用类型配置
	 */
	@RequestMapping(value = "saveExpenseTypeSetting")
	@ResponseBody
	public String saveExpenseTypeSetting(ComSettingClass comSettingClass){
		if (comSettingClass==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		comSettingClass.setComKey(userVo.getComKey());
		comSettingClass.setIndustryId(userVo.getDetailIndustryId());
		int result = 0;
		try {
			if (StringUtil.isEmpty(comSettingClass.getTypeCode())) {
				result = expenseBookService.insertComSettingClass(comSettingClass);
			}else{
				result = expenseBookService.updateComSettingClass(comSettingClass);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
}
