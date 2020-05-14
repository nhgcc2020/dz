package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.service.system.DepartmentService;
import com.ydz.vo.SelectVo;
import com.ydz.vo.UserVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by pengxuyang on 17/1/12.
 */

@Controller
@RequestMapping(value = "wx/department",produces = "plain/text; charset=UTF-8")
public class WxDepartmentController extends BaseController {

    @Resource(name = "departmentService")
    DepartmentService departmentService;

    /**
     * 获取该公司的所有部门信息 为前端页面的 部门选择框提供信息
     * @param request
     * @return
     */
    @RequestMapping(value = "select-info")
    @ResponseBody
    public String getDepartmentForVo(HttpServletRequest request) throws Exception {
        UserVo operator = getWxCurrentUserVo();

        List<SelectVo> departments = departmentService.getAllDeptmentForVo(operator.getComKey());
        return JSON.toJSONString(departments);
    }
}
