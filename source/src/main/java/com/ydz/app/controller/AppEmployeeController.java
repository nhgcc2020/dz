/**   
 * @Title: AppEmployeeController.java 
 * @Package com.ydz.app.controller 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午6:15:48 
 * @version  
 */
package com.ydz.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.Employee;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppEmployeeController 
 * @Description: app的员工列表控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午6:15:48 
 * 
 */
@RestController
@RequestMapping(value = "app/employee", produces = "application/json;charset=UTF-8")
public class AppEmployeeController extends BaseController{
	
	 @Autowired
	 private EmployeeService employeeService;

    /**
     * 
     * @Title: getAllEmployee 
     * @param request
     * @return
     * @return String
     * @throws 
     * @Description: 获取公司的员工列表
     */
    @RequestMapping(value = "info", method = RequestMethod.GET)
    public String getAllEmployee(HttpServletRequest request){
    	UserVo userVo = this.getAppCurrentUserVo();
        List<EmployeeVo> employees = null;
        try {
            PageData pd = new PageData();
            pd.put("comKey",userVo.getComKey());
            employees  =  employeeService.getAllEmployee(pd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(employees));
    }
    
    /**
     * 
     * @Title: getOnJobEmployees 
     * @return
     * @return String
     * @throws 
     * @Description: 获取在职的公司员工列表用于下拉框查询
     */
    @RequestMapping(value = "/onJob", method = RequestMethod.GET)
    public String getOnJobEmployees(){
    	UserVo userVo = this.getAppCurrentUserVo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	List<Employee> employees = employeeService.getAllEmployeesForDropdown(pd);
    	return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(employees));
    }
}
