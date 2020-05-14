package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.RoleService;
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
@RequestMapping(value="wx/role",produces="application/json;charset=UTF-8")
public class WxRoleController extends BaseController {

    @Resource(name="roleService")
    private RoleService roleService;

    /**
     * 获取该公司的所有角色 为前端页面的 角色选择框提供信息
     * @param request
     * @return
     */
    @RequestMapping(value = "select-info")
    @ResponseBody
    public String getDepartmentForVo(HttpServletRequest request) throws Exception {
        UserVo operator = getWxCurrentUserVo();
        List<SelectVo> roles = roleService.getAllRoleForVo(operator.getComKey());
        //todo 按照固定格式（前端固定格式）
        return JSON.toJSONString(roles);
    }

}
