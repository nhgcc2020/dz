package com.ydz.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.init.PermissionInit;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.RoleService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.vo.RoleMenuVO;
import com.ydz.vo.SelectVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;


/** 
* @ClassName: RoleController 
* @Description: 角色控制器
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年11月9日 下午2:22:51 
* 
*/
@Controller
@RequestMapping(value="system/role",produces="application/json;charset=UTF-8")
public class RoleController extends BaseController {
	
	@Resource(name="menuService")
	private MenuService menuService;
	@Resource(name="roleService")
	private RoleService roleService;

	/**
	 * 获取该公司的所有角色 为前端页面的 角色选择框提供信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "select-info")
	@ResponseBody
	public String getDepartmentForVo(HttpServletRequest request){
		UserVo operator = getSessionUservo();
		try {
			List<SelectVo> roles = roleService.getAllRoleForVo(operator.getComKey());
			//todo 按照固定格式（前端固定格式）
			return JSON.toJSONString(roles);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
	}

	/**
	 * 
	* @Title: getComRolePermission 
	* @param request
	* @return
	* @return String
	* @throws 
	* @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	@RequestMapping(value = "/role-permission/query")
	@ResponseBody
	public String getComRolePermission(HttpServletRequest request){
		UserVo userVo = this.getSessionUservo();
		PageData pdPara = this.getPageData();
		String roleKey = request.getParameter("roleKey");
		if(roleKey == null){
			roleKey = Const.ROLE_PARTNER;
		}
		try {
			Map<String, Object> mapResult = new HashMap<>();
			pdPara.put("comKey", userVo.getComKey());
			pdPara.put("roleKey", roleKey);
			
			mapResult.put("roleMenus", roleService.getRoleMenusForPermission(userVo.getDetailIndustryId(), roleKey, 
					userVo.getComKey(), userVo.getRentalVersion()));
			mapResult.put("roles", roleService.listRolesByCom(userVo.getComKey())); 
			return JsonUtil.toCompatibleJSONString(mapResult);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
	}
	
	@RequestMapping(value = "/role-permission/saveAndUpdate")
	@ResponseBody
	public String updateRolePermission(@RequestBody List<RoleMenuVO> roleMenuVOs){
		try {
			UserVo userVo = this.getSessionUservo();
//			roleService.saveOrUpdateRoleMenu(roleMenuVOs, userVo.getComKey(), userVo.getDetailIndustryId(), userVo.getUserKey());
			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
	}
}
