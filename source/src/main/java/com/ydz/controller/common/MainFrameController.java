package com.ydz.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.ydz.dao.system.CompanyMapper;
import com.ydz.service.system.RoleService;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserCompanyVO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.ResultMap;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Menu;
import com.ydz.entity.system.RentalPeriod;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: MainFrameController 
 * @Description: 主框架控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月26日 下午8:18:16 
 * 
 */
@Controller
@RequestMapping("ydz/mainframe")
public class MainFrameController extends BaseController{
	
	@Resource
	private CommonService commonService;
	@Resource
	private CompanyService companyService;
	@Resource
	private UserService userService;
	@Resource
	private MenuService menuService;
	@Resource
	private RoleService roleService;
	@Resource
	private SalesOrderService salesOrderService;
	@Resource
	private EmployeeService employeeService;

	@Resource
	private CompanyMapper companyMapper;

	@Resource
	private TradeService tradeService;

	@RequestMapping(value="mainBanner")
	@ResponseBody
	public String getMainBannerInfo() throws Exception{
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		UserVo userVo = this.getSessionUservo();
		
		if (userVo == null) {
			System.out.println("=====用户session对象为空");
		}

		//多公司切换
		PageData pageDataPara = new PageData();
		pageDataPara.put("userKey",userVo.getUserKey());
		List<Company> companies = companyMapper.getByEmpUserKey(pageDataPara);
		jsonMap.put("companies", companies);
		jsonMap.put("defaultCom", userVo.getDefaultCom());
		jsonMap.put("currentCom", userVo.getComKey());
		jsonMap.put("comType", userVo.getComType());
		jsonMap.put("industryId", userVo.getDetailIndustryId());
		
		//消息计数
		PageData pdPara = this.getPageData();
		pdPara.put("acceptComKey", userVo.getComKey());
		pdPara.put("status", "0"); //未读消息
		jsonMap.put("msgCount", commonService.getCountMessageUnRead(pdPara));
		
		/*
		 * 动态出现企业账户中心入口
		 * 1.comType是企业的
		 * 2.roleKey是管理员角色
		 */
		if (CompanyEnum.COM_TYPE_ENTERPRISE.getCode().equalsIgnoreCase(userVo.getComType())
				&&userVo.getRoleKeys().equalsIgnoreCase("ADMIN")) {
			jsonMap.put("roleKey", "1");
			jsonMap.put("scriptCode", "document.getElementById(\"main_botton\").innerHTML += \"<span class='main_botton_span_sec'>管理企业</span>\"");
		}else{
			jsonMap.put("roleKey", "0");
		}
		
		/* 是否显示创建"销售订单"
		 * 1.行业不能为00通用行业
		 * 2.软件版本不能是0T免费版
		 * 3.并且不能过期
		 */
		String addOrder = "document.getElementById(\"invent_add_list_first\").innerHTML += '<li c-onclick=\"salesOrderAdd()\">"
					+ "<a href=\"javascript:void(0)\" ><span>销售订单</span></a></li>';";
		String addPartner = "document.getElementById(\"invent_add_list_first\").innerHTML += '<li onclick=\"openPartner()\">"
				+ "<a href=\"javascript:void(0)\" ><span>生意伙伴</span></a></li>';";
		if(!Const.INDUSTRY_GENERAL.equalsIgnoreCase(userVo.getDetailIndustryId())
				&&!RentalTradeEnum.VERSION_FREE_EDITION.getCode().equalsIgnoreCase(userVo.getRentalVersion())
				&&RentalTradeEnum.OUT_DATE_NO.getCode().equalsIgnoreCase(userVo.getIsMaturity())){
			jsonMap.put("addsoKey", "1");
			jsonMap.put("addsoScriptCode", addOrder);
		}else{
			jsonMap.put("addsoKey", "0");
		}
		
		String menuIdAccess = companyService.getOneComEmployee(userVo.getComKey(), userVo.getUserKey()).getMenuId();
		if(menuIdAccess.indexOf("CP")<0){
			jsonMap.put("addPartner", "0");
		}else{
			jsonMap.put("addPartner", "1");
			jsonMap.put("addPartnerScriptCode", addPartner);
		}
		if(menuIdAccess.indexOf("1-04")<0){
			jsonMap.put("addsoKey", "0");
		}else{
			jsonMap.put("addsoKey", "1");
			jsonMap.put("addsoScriptCode", addOrder);
		}
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}
	
	@RequestMapping(value="setDefaultCompany")
	@ResponseBody
	public String setDefaultCompany(HttpServletRequest request) throws Exception{
		User user =  new User();
		user.setUserKey(getSessionUservo().getUserKey());
		user.setDefaultCom(request.getParameter("comKey"));
		
		String msg = "0";
		try {
			userService.updateUser(user);
			UserVo userVo = this.getSessionUservo();
	    	userVo.setDefaultCom(request.getParameter("comKey"));
	    	getShiroSession().setAttribute(Const.SESSION_USER, userVo);
			msg = "1";
		} catch (Exception e) {
			msg = "0";
			e.printStackTrace();
		}
		return msg;
	}
	
	/**
	 * 
	 * @Title: ValidateDue 
	 * @param request
	 * @return 返回1表示未到期，返回非1表示已过期需要跳转的url
	 * @throws Exception
	 * @return ModelAndView
	 * @throws 
	 * @Description: 切换公司前验证准备切换的公司是否到期了
	 */
	 @RequestMapping(value = "changeValidateDue", produces = "application/json;charset=UTF-8")
	 @ResponseBody
	 public String validateDue(HttpServletRequest request) throws Exception{
	    	//判断版本有效期，过期跳转 1未到期 0到期
		 	String comKey = request.getParameter("comKey");
			String maturity = tradeService.validateRentalPeriod(comKey);
	    	if(RentalTradeEnum.OUT_DATE_NO.getCode().equals(maturity)){
	    		return "1";
	    	}else{
	    		UserVo userVo = this.getSessionUservo();
	    		
	    		PageData pdPara = this.getPageData();
	        	pdPara.put("comKey", comKey);
	    	  	pdPara.put("userId",userVo.getUserId());
	    		UserCompanyVO userCompanyVO = userService.selectUserComByIdandKey(pdPara);
	    	  	userVo.setComKey(userCompanyVO.getComKey());
	    	  	userVo.setComName(userCompanyVO.getComName());
	    	  	userVo.setComShortname(userCompanyVO.getComShortname());
	    	  	userVo.setComLogoPath(userCompanyVO.getComLogoPath());
	    	  	userVo.setComIsvalid(userCompanyVO.getComIsvalid());
	    	  	userVo.setComType(userCompanyVO.getComType());
	    	  	//查询对应的小行业ID
	    	  	userVo.setDetailIndustryId(userCompanyVO.getIndustryId());
	    	  	//角色信息
	    	  	if("1".equalsIgnoreCase(userCompanyVO.getIsAdmin())
	    			  ||"1".equalsIgnoreCase(userCompanyVO.getIsBoss())){
	    		  	userVo.setRoleKeys("ADMIN");
	    	  	}else{
	    		  PageData pd = new PageData();
	    		  pd.put("comKey",userVo.getComKey());
	    		  pd.put("userKey",userVo.getUserKey());
	    		  userVo.setRoleKeys(roleService.getRolesStringByUser(pd));
	    	  	}
	        	getShiroSession().setAttribute(Const.SESSION_USER, userVo);
	    		
	    		return "/openPage?pageName=company_service-maturity";
	    	}
	 }
	
	@RequestMapping(value="changeCurrentCompany")
    @ResponseBody
    public String changeCurrentCompany(HttpServletRequest request) throws Exception{
	  	UserVo userVo = this.getSessionUservo();
    	String comKey = request.getParameter("comKey");
    	PageData pdPara = this.getPageData();
    	pdPara.put("comKey", comKey);
	  	pdPara.put("userId",userVo.getUserId());
    	//Company company = companyService.getCompanyByKey(pdPara);
	  	UserCompanyVO userCompanyVO = userService.selectUserComByIdandKey(pdPara);
	  	if (userCompanyVO==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("切换失败，请重新登录"));
		}
	  	userVo.setComKey(userCompanyVO.getComKey());
	  	userVo.setComName(userCompanyVO.getComName());
	  	userVo.setComShortname(userCompanyVO.getComShortname());
	  	userVo.setComLogoPath(userCompanyVO.getComLogoPath());
	  	userVo.setComIsvalid(userCompanyVO.getComIsvalid());
	  	userVo.setComType(userCompanyVO.getComType());
	  	userVo.setComAttr(userCompanyVO.getComAttr());
	  	
	  	//查询对应的小行业ID
	  	userVo.setDetailIndustryId(userCompanyVO.getIndustryId());
	  	
	  	//角色信息
	  	if("1".equalsIgnoreCase(userCompanyVO.getIsAdmin())
			  ||"1".equalsIgnoreCase(userCompanyVO.getIsBoss())){
		  	userVo.setRoleKeys("ADMIN");
	  	}else{
		  PageData pd = new PageData();
		  pd.put("comKey",userVo.getComKey());
		  pd.put("userKey",userVo.getUserKey());
		  userVo.setRoleKeys(roleService.getRolesStringByUser(pd));
	  	}
	  	userVo.setIsAdmin(userCompanyVO.getIsAdmin());
        userVo.setIsBoss(userCompanyVO.getIsBoss());
        
        Employee employee = employeeService.getEmployeeByModel(userVo.getUserId(), userVo.getComKey());
        if (employee!=null) {
			userVo.setEmployeeId(employee.getEmployeeId());
		}
        
	  //设置角色的菜单排除项
        userVo.setComExcludeRoleMenus(roleService.getHasRoleMenusExclude(userVo.getComKey(), userVo.getRoleKeys()));
        
        //设置控件权限处理
        //userVo.setComRolePermissions(roleService.listComRolePermissions(pd));

        //获取登陆用户所属公司的使用版本
        Menu menu = menuService.getComMenu(userVo.getComKey(),userVo.getDetailIndustryId());
        if(menu!=null){
        	userVo.setRentalVersion(menu.getRentalVersion());
        }else{
        	userVo.setRentalVersion(RentalTradeEnum.VERSION_BASIC_EDITION.getCode());
        }
        
        RentalPeriod rentalPeriod = tradeService.findRentalPeriod(pdPara);
        if (rentalPeriod!=null) {
			userVo.setPayStatus(rentalPeriod.getStatus());
		}else{
			userVo.setPayStatus(RentalTradeEnum.PERIOD_TRIAL.getCode());
		}
        
    	getShiroSession().setAttribute(Const.SESSION_USER, userVo);
    	return "1";
    }
	
	@RequestMapping(value="validOrderCount")
    @ResponseBody
    public String validOrderCount() throws Exception{
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
	    
        Map<String,Object> resultMap = null;
        if (RentalTradeEnum.PERIOD_TRIAL.getCode().equals(userVo.getPayStatus())) {
        	pd.put("comKey", userVo.getComKey());
        	resultMap = salesOrderService.validOrderCount(pd);
        	return JsonUtil.toCompatibleJSONString(resultMap);
        }else{
        	return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
		}
	        
		
	}
}
