package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.system.Department;
import com.ydz.service.system.DepartmentService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;
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
 * Created by pxy on 2016/6/13.
 */
@Controller
@RequestMapping(value = "department",produces = "plain/text; charset=UTF-8")
public class DepartmentController extends BaseController {

    @Resource(name = "departmentService")
    DepartmentService departmentService;

    /**
     * 获取该公司的所有部门信息 为前端页面的 部门选择框提供信息
     * @param request
     * @return
     */
    @RequestMapping(value = "select-info")
    @ResponseBody
    public String getDepartmentForVo(HttpServletRequest request){
        UserVo operator = getSessionUservo();
        try {
            List<SelectVo> departments = departmentService.getAllDeptmentForVo(operator.getComKey());
            //todo 按照固定格式（前端固定格式）
            return JSON.toJSONString(departments);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @RequestMapping(value = "info")
    @ResponseBody
    public String getDepartment(HttpServletRequest request, Page page){

        String pageSize = request.getParameter("pageSize");
        String pageNo = request.getParameter("pageNo");
        UserVo operator = getSessionUservo();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
             pd.put("comKey", operator.getComKey());
            page.setShowCount(Integer.parseInt(pageSize));
            page.setCurrentPage(Integer.parseInt(pageNo));
            page.setPd(pd);
            List<Department> allDeptment = departmentService.getAllDeptment(page);
            //todo 按照固定格式（前端固定格式）
            Map<String,Object> mapPage = new HashMap<>();
            mapPage.put("$entityCount",page.getTotalResult());
            mapPage.put("$data",allDeptment);

            return JSON.toJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * 根据id  进行新增和修改
     * @param department
     * @return
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public String save(Department department,HttpServletRequest request){
        UserVo userVo = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        try {
            Integer result = departmentService.saveOrModifyDeptment(department,userVo);
            return String.valueOf(result);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @RequestMapping(value = "delete")
    @ResponseBody
    public String delete(String deptId){
        UserVo userVo = getSessionUservo();
        Department department = new Department();
        department.setDeptId(deptId);
        department.setIsValid("0");
        department.setComKey(userVo.getComKey());
        try {
            int result = departmentService.updateDeptment(department);
            return String.valueOf(result);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }

    }

}
