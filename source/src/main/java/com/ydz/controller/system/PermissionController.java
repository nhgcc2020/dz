package com.ydz.controller.system;

import com.ydz.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by ydz on 2016/7/26.
 */
@Controller
@RequestMapping(value = "permission")
public class PermissionController extends BaseController {

    /**
     * 保存设置的权限
     * @param codeStr 权限code 字符串"," 分隔
     * @return
     */
    @RequestMapping(value = "savePermission")
    @ResponseBody
    public String savePermission(String codeStr){
        //todo 具体保存逻辑
        return "";
    }
}
