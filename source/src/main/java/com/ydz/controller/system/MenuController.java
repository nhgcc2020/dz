package com.ydz.controller.system;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.ComConfig;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.RoleService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.RoleMenuVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * 类名称：MenuController
 * 创建人：yiduizhang 用于进行菜单控制
 * 创建时间：2016年05月10日
 * @version
 */
@RestController
public class MenuController extends BaseController {

	@Resource(name="menuService")
	private MenuService menuService;
	
	@Resource(name="roleService")
	private RoleService roleService;
	
	@Resource(name = "tradeService")
	private TradeService tradeService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name="employeeService")
	private EmployeeService employeeService;
	
	@Resource(name = "redisUtil")
	RedisUtil redisUtil;


	/**
	 * 
	* @Title: menus 
	* @param @return
	* @param @throws Exception
	* @return Collection<MenuInit>
	* @throws 
	* @Description: 获取主页面加载的菜单
	* 1.如果行业是通用行业00，直接读取通用行业菜单
	* 2.如果行业不是通用行业，需要从菜单表中读取行业版本所对应的初始菜单
	*
	 */
	@RequestMapping(value = "/menus", method = RequestMethod.GET)
	@ResponseBody
	public String menus(HttpServletRequest request) throws Exception {
		Map<String, Object> menuMap = new HashMap<String, Object>();
		UserVo userVo = this.getSessionUservo();
		if (userVo == null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("菜单获取失败"));
		}
		List<RoleMenuVO> menus = null;
		String menuIdUser = null;
		if(Const.INDUSTRY_GENERAL.equalsIgnoreCase(userVo.getDetailIndustryId())){
//			menus = roleService.getGeneralMenuForView(userVo.getDetailIndustryId(), userVo.getRoleKeys(), userVo.getComKey(), userVo.getComType());
		}else{
//			获取员工的可见菜单
			menuIdUser = roleService.getComEmployeeForRole(userVo.getComKey(), userVo.getUserKey()).getMenuId();
			if(StringUtil.isEmpty(menuIdUser)){
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("菜单获取失败"));
			}
			menus = roleService.getIndustryMenuForView(userVo.getDetailIndustryId(), userVo.getRoleKeys(), userVo.getComKey(), userVo.getRentalVersion());
		}
		/**
		 * 拆分设置菜单
		 * 1.有设置菜单的，从主菜单区删除
		 * 2.单独传递设置菜单
		 */
		RoleMenuVO configMenuVO = new RoleMenuVO();
		
		if (menus != null) {
			Iterator<RoleMenuVO> it = menus.iterator();
			while(it.hasNext()){
				RoleMenuVO roleMenuVO = it.next();
				
//				个人公司取消设置菜单
				if(roleMenuVO.getMenuId().indexOf("CONFIG")>0){
					if(CompanyEnum.COM_TYPE_PERSONAL.getCode().equalsIgnoreCase(userVo.getComType())){ //个人去掉设置
						it.remove();
					}
				}
//				如果公司类型是企业并且是管理员的，从菜单中去掉设置并加入设置菜单对象处理
				if(roleMenuVO.getMenuId().indexOf("CONFIG")>0
						&&userVo.getComType().equalsIgnoreCase(CompanyEnum.COM_TYPE_ENTERPRISE.getCode())){
					if("ADMIN".equalsIgnoreCase(userVo.getRoleKeys())){
						BeanutilsCopy.apacheCopyProperties(configMenuVO, roleMenuVO);
					}
					it.remove();
				}
//				如果菜单中没有设置并且可见菜单中也没有该菜单的则删除.排除报表
				if(roleMenuVO.getMenuId().indexOf("CONFIG")<0
						&&menuIdUser.indexOf(roleMenuVO.getMenuId())<0){
					if(!"ADMIN".equalsIgnoreCase(userVo.getRoleKeys())){
						it.remove();
					}
				}

			}
		}
		//如果没有配置菜单，则配置菜单设为空
		if(StringUtil.isEmpty(configMenuVO.getMenuId())){
			configMenuVO = null;
		}
		if (userVo.getComType()
				.equalsIgnoreCase(CompanyEnum.COM_TYPE_PERSONAL.getCode())) { //个人公司没有菜单
			menus = null;
			configMenuVO = null;
		}
		menuMap.put("menus", menus);
		menuMap.put("config", configMenuVO);
		return JsonUtil.toCompatibleJSONString(menuMap);
	}
	
	@RequestMapping(value = "/openPage", method = RequestMethod.GET, produces = "plain/text; charset=UTF-8")
	public ModelAndView openPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		
		PageData pd = this.getPageData();
		String pageName = pd.getString("pageName");
		String url = StringUtil.isNotEmpty(pageName)?pageName:"";
		
		//判断版本有效期，过期跳转
    	if(RentalTradeEnum.OUT_DATE_YES.getCode()
    			.equals(this.getSessionUservo().getIsMaturity())){
    		if (!"c_payment/priceList".equalsIgnoreCase(url)) { //如果是跳转支付页面的，排除过期判断处理
    			mv.setViewName("/jsp/company/service-maturity");
    			return mv;
			}
    	}
		
		if(pageName.indexOf("_")>0){
			if("c_".equalsIgnoreCase(url.substring(0, 2))){
				url = "forward:"+url.substring(2,url.length());
			}else{
				url = "jsp/"+StringUtil.formatMenuUrl(pageName);
			}
		}else{
			url = "jsp/"+pageName;
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		if (pageName.indexOf("assignment_design")>-1) { //设计派工的菜单
			//判断派工的跳转
			pd.put("configKey", Const.COMPANY_CONFIG_ASSIGN_DESIGN);
			ComConfig comConfig = commonService.getOneComConfig(pd);
			if (comConfig==null) {
				url = "jsp/assignment/design-open";
			}
		}else if(pageName.indexOf("assignment_work")>-1){ //制作派工的菜单
			pd.put("configKey", Const.COMPANY_CONFIG_ASSIGN_WORKING);
			ComConfig comConfig = commonService.getOneComConfig(pd);
			if (comConfig==null) { //未开启制作派工
				url = "jsp/assignment/working-open"; //需要开启制作派工
				
				//判断是哪个菜单被点击时跳转了开启制作派工
				if (pageName.indexOf("work-assign-task") > -1) {
					mv.addObject("pageAssignWorking", "1"); //1来自派工任务
				} else if (pageName.indexOf("work-my-task") > -1) {
					mv.addObject("pageAssignWorking", "2");//2来自我的任务
				} else if (pageName.indexOf("workshop-setting") > -1) {
					mv.addObject("pageAssignWorking", "3"); //3来自工序配置
				}
			}else {  //已开启制作派工
				pd.put("configKey", Const.COMPANY_CONFIG_WORKING_PROCEDURE);
				comConfig = commonService.getOneComConfig(pd);
				if (comConfig == null) {
					if (pageName.indexOf("workshop-setting") > -1) {
						url = "jsp/assignment/working-procedure-open"; //开启制作派工后，如果使用工序配置需要开启复杂工序
					}else if (pageName.indexOf("work-my-task") > -1) { //请求菜单为我的任务时如果没有开启复杂工序的直接跳转任务列表显示简单加工
						url = "jsp/assignment/work-procedure-list";
						mv.addObject("workingProcedure",AssignEnum.ASSIGN_PROCEDURE_NONE.getCode());
					}
				}
			}
		}else if(pageName.indexOf("prepaid")>-1){ //预充值
			pd.put("configKey", Const.COMPANY_CONFIG_RECHARGE);
			ComConfig comConfig = commonService.getOneComConfig(pd);
			if (comConfig==null) {
				url = "jsp/prepaid/prepaid-open";
			}
		}
		boolean isRefuseLogin = false;
		pd.put("userId", userVo.getUserId());
		isRefuseLogin = commonService.validateRefuseLogin(pd);
		if (isRefuseLogin==true) {
			url = "404";
		}
		mv.setViewName(url);
		return mv;
	}


	public static void main(String[] args) {
		String url = "assignment_design-assign-task";
		System.out.println(url.indexOf("assignment_work"));
	}

}
