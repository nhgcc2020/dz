package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.Employee;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.PageData;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pengxuyang on 17/1/12.
 */
@Controller
@RequestMapping(value = "wx/employee",produces = "plain/text; charset=UTF-8")
public class WxEmployeeController extends BaseController {

    @Resource(name = "employeeService")
    EmployeeService employeeService;

    /**
     * 邀请员工加入公司:
     * @return
     */
    @RequestMapping(value = "inviteEmployee")
    @ResponseBody
    public String inviteEmployee(HttpServletRequest request, Employee employee){
        UserVo userVo = getWxCurrentUserVo();
        Map<String,Object> callback = new HashMap<>();
        if(employee.getRoleKey() == null || "".equals(employee.getRoleKey())){
            callback.put("state","0");
            callback.put("msg","请选择角色");
            return JSON.toJSONString(callback);
        }
        try {
            Map<String,Object> result  =  employeeService.inviteEmployee(userVo,employee);
            return JSON.toJSONString(result);
        } catch (Exception e) {
            e.printStackTrace();
            //失败则返回0
            callback.put("state","0");
            callback.put("msg","操作失败");
            return JSON.toJSONString(callback);
        }
    }

    /**
     * 员工信息
     * @param request
     * @return
     */
    @RequestMapping(value = "info")
    @ResponseBody
    public String getAllEmployee(HttpServletRequest request){

        UserVo operator = getWxCurrentUserVo();
        List<EmployeeVo> employees = null;
        try {
            PageData pd = new PageData();
            pd.put("comKey",operator.getComKey());
            employees  =  employeeService.getAllEmployee(pd);
            for(EmployeeVo employeeVo :employees ){
                String status = employeeVo.getStatus();
                if("1".equals(status)){
                    employeeVo.setStatusView("邀请中");
                }else if("2".equals(status)){
                    employeeVo.setStatusView("待审核");
                }else if("3".equals(status)){
                    employeeVo.setStatusView("正常");
                }else if("4".equals(status)){
                    employeeVo.setStatusView("已离职");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String empJson = JSON.toJSONString(employees);
        return empJson;
    }



}
