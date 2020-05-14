package com.ydz.controller.system;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Menu;
import com.ydz.entity.system.RentalPeriod;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.IndustryComService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.RoleService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserCompanyVO;
import com.ydz.vo.UserVo;

/*
 * 总入口
 */
@Controller
@SessionAttributes("industryId")
@RequestMapping(value="login")
public class LoginController extends BaseController {

	@Resource
	private UserService userService;
	@Resource
	private MenuService menuService;
	@Resource
	private RoleService roleService;
	@Resource
	private CompanyService companyService;
	@Resource
	private EmployeeService employeeService;
	@Resource
	private CommonService commonService;
	@Resource
	private IndustryComService industryComService;
	@Resource
	private TradeService tradeService;

    /**
     * 获取登录用户的IP
     *
     * @throws Exception
     */
    public void getRemortIP(String USERNAME) throws Exception {
        PageData pd = new PageData();
        HttpServletRequest request = this.getRequest();
        String ip = "";
        if (request.getHeader("x-forwarded-for") == null) {
            ip = request.getRemoteAddr();
        } else {
            ip = request.getHeader("x-forwarded-for");
        }
        pd.put("USERNAME", USERNAME);
        pd.put("IP", ip);
        //userService.saveIP(pd);
    }
    

    /**
     * 请求登录，验证用户
     */
    @RequestMapping(value = "/login_login", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String login(HttpServletRequest request) throws Exception {
        //回调
        Map<String, Object> callback = new HashMap<>();
        PageData pd = this.getPageData();
        String userId = pd.getString("userId");
        String password = pd.getString("password");
        Subject subject = null;  
		if(StringUtil.isEmpty(userId)){
            callback.put("state", "0");
			callback.put("msg","请输入用户名");
            return JSON.toJSONString(callback);
        }
        if(StringUtil.isEmpty(password)){
            callback.put("state", "0");
            callback.put("msg","请输入密码");
            return JSON.toJSONString(callback);
        }
        
		boolean isRefuseLogin = false;
		isRefuseLogin = commonService.validateRefuseLogin(pd);
		if (isRefuseLogin==true) {
			callback.put("state", "0");
            callback.put("msg","用户名或密码错误");
            return JSON.toJSONString(callback);
		}

        subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(userId,password);
        try{
        	ensureUserIsLoggedOut(); //强行退出之前的session
            subject.login(token);
            subject.getSession().setTimeout(3*24*60*60*1000); //设置超时为3天
            //验证成功(即:不抛出异常)后
//            userId = "18091515080";
            UserCompanyVO userCompanyVO = userService.selectUserComByUserId(userId);
            if(userCompanyVO == null){
                callback.put("state", "0");
                callback.put("type","no_company");
                //放入用户个人信息
                PageData pageData = new PageData();
                pageData.put("userId",userId);
                User userResult = userService.getUserById(pageData);
                UserVo userVo = new UserVo();
                userVo.setUid(userResult.getUid());
                userVo.setUserKey(userResult.getUserKey());
                userVo.setUserId(userResult.getUserId());
                userVo.setNickName(userResult.getNickName());
                userVo.setRealName(userResult.getRealName());
                userVo.setAvatarPath(userResult.getAvatarPath());
                userVo.setRegisterIp(userResult.getRegisterIp());
                getShiroSession().setAttribute(Const.SESSION_USER, userVo);
                return JSON.toJSONString(callback);
            }
            UserVo userVo = new UserVo();
            userVo.setUid(userCompanyVO.getUid());
            userVo.setUserKey(userCompanyVO.getUserKey());
            userVo.setUserId(userCompanyVO.getUserId());
            userVo.setNickName(userCompanyVO.getNickName());
            userVo.setRealName(userCompanyVO.getRealName());
            userVo.setAvatarPath(userCompanyVO.getAvatarPath());
            userVo.setRegisterIp(userCompanyVO.getRegisterIp());

            userVo.setComKey(userCompanyVO.getDefaultCom());
            userVo.setComName(userCompanyVO.getComName());
            userVo.setComShortname(userCompanyVO.getComShortname());
            userVo.setComLogoPath(userCompanyVO.getComLogoPath());
            userVo.setComIsvalid(userCompanyVO.getComIsvalid());
            userVo.setComType(userCompanyVO.getComType());
            userVo.setComAttr(userCompanyVO.getComAttr());
            userVo.setDefaultCom(userVo.getComKey());
            
            userVo.setDetailIndustryId(userCompanyVO.getIndustryId()); //查询对应的小行业ID
            
            Employee employee = employeeService.getEmployeeByModel(userVo.getUserId(), userVo.getComKey());
            if (employee!=null) {
				userVo.setEmployeeId(employee.getEmployeeId());
			}
            
            //设置角色信息
            if("1".equalsIgnoreCase(userCompanyVO.getIsAdmin())
                    ||"1".equalsIgnoreCase(userCompanyVO.getIsBoss())){
                userVo.setRoleKeys("ADMIN");
            }else{
                pd.put("comKey",userVo.getComKey());
                pd.put("userKey",userVo.getUserKey());
                userVo.setRoleKeys(roleService.getRolesStringByUser(pd));
            }
            userVo.setIsAdmin(userCompanyVO.getIsAdmin());
            userVo.setIsBoss(userCompanyVO.getIsBoss());
            
            //设置角色的菜单排除项
//            userVo.setComExcludeRoleMenus(roleService.getHasRoleMenusExclude(userVo.getComKey(), userVo.getRoleKeys()));
//            ComEmployee employee = companyService.getOneComEmployee(userVo.getComKey(),userVo.getUserKey());
//            userVo.setMenuId(employee.getMenuId()); //设置菜单访问
//            userVo.setPermissionCode(employee.getPermissionCode()); //设置控件权限处理
            

            //获取登陆用户所属公司的使用版本
            Menu menu = menuService.getComMenu(userVo.getComKey(),userVo.getDetailIndustryId());
            if(menu!=null){
            	userVo.setRentalVersion(menu.getRentalVersion());
            }else{
            	userVo.setRentalVersion(RentalTradeEnum.VERSION_BASIC_EDITION.getCode());
            }
            pd.put("comKey", userVo.getComKey());
            RentalPeriod rentalPeriod = tradeService.findRentalPeriod(pd);
            if (rentalPeriod!=null) {
				userVo.setPayStatus(rentalPeriod.getStatus());
			}else{
				userVo.setPayStatus(RentalTradeEnum.PERIOD_TRIAL.getCode());
			}
            //插入本次登陆日志信息
            commonService.insertLoginLog(new LoginLog(
            		userVo.getUserKey(), new Date(), this.getIpAddr(request), PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request))));
            
            getShiroSession().setAttribute(Const.SESSION_USER, userVo); //信息写回session

            callback.put("state", "1");
            callback.put("msg","登录成功");
            return JSON.toJSONString(callback);

        }catch(AuthenticationException ex){
            callback.put("state", "0");
            callback.put("msg","用户名或密码错误");
            ex.printStackTrace();
            return JSON.toJSONString(callback);
        }
    }

    /**
     * 用户登录成功后选择 公司并进入系统
     *
     * @param request
     * @param comKey
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "tomain", produces = "application/json;charset=UTF-8")
    public ModelAndView toMain(HttpServletRequest request, String comKey, String type) throws Exception {
        UserVo userVo = this.getSessionUservo();
        
    	//判断版本有效期，过期跳转 1未到期 0到期
    	String maturity = this.getSessionUservo().getIsMaturity();
    	if (StringUtil.isEmpty(userVo.getIsMaturity())) {
			maturity = tradeService.validateRentalPeriod(this.getSessionUservo().getComKey());
			userVo.setIsMaturity(maturity);
    	}
    	if (CompanyEnum.COM_TYPE_ENTERPRISE.getCode()
    			.equalsIgnoreCase(userVo.getComType())) {
			userVo.setComAttr(CompanyEnum.COM_ATTR_LIMITED.getCode());
		}
    	if(RentalTradeEnum.OUT_DATE_YES.getCode().equals(maturity)){
    		return new ModelAndView("/jsp/company/service-maturity");
    	}
//    	if(true){
//    		return new ModelAndView("/jsp/company/service-maturity");
//    	}
    	
    	// 2017年08月25日18:10:50 修改逻辑。根据用户注册的情况判断是否需要强制跳转场景选择页面 choose-scene.jsp
    	/**
    	 * 1. 没有创建公司企业的。
    	 * 	1）创建个人企业后没选择对账大使的，跳转choose-scene.jsp,返回type=await
    	 * 	2）创建个人企业后选择对账大使的。跳转对账大使页面/promoter/coming-soon.jsp
    	 * 2. 创建公司企业的。
    	 * 	1）新创建的企业要求选择行业，如果行业为00，跳转choose-scene.jsp,返回type=choose-industry
    	 * 	2）老用户没选择行业的，跳转choose-scene.jsp,返回type=choose-industry
    	 * 3. 如果默认公司是个人的，且comAttr=3的，跳转对账大使页面/promoter/coming-soon.jsp
    	 * 4. 如果默认公司是企业的，且行业不是00的，跳转到main.jsp
    	 */
    	ModelAndView forwordView = new ModelAndView("/jsp/main");
    	//如果公司类型是企业的
    	if (CompanyEnum.COM_TYPE_ENTERPRISE.getCode()
    			.equalsIgnoreCase(userVo.getComType())){
    		if (!Const.INDUSTRY_GENERAL.equalsIgnoreCase(userVo.getDetailIndustryId())) {
    			forwordView.setViewName("/jsp/main");//行业不是通用版的，跳转到main页面
			}else if (Const.INDUSTRY_GENERAL.equalsIgnoreCase(userVo.getDetailIndustryId())) {
				forwordView.setViewName("/jsp/choose-scene");//行业是通用的，跳转到choose-scene页面并传递type=choose-industry
				forwordView.addObject("type", "choose-industry");
			}
    	}else if (CompanyEnum.COM_TYPE_PERSONAL.getCode()
    			.equalsIgnoreCase(userVo.getComType())) { //如果公司类型是个人的
			if (CompanyEnum.COM_ATTR_PROMOTER.getCode()
					.equalsIgnoreCase(userVo.getComAttr())) {
				forwordView.setViewName("/jsp/main"); //个人类型是对账大使的直接跳转到main页面并打开对账大使页面
				forwordView.addObject("type","promoter");
			}else if (!CompanyEnum.COM_ATTR_PROMOTER.getCode()
					.equalsIgnoreCase(userVo.getComAttr())) {
				forwordView.setViewName("/jsp/choose-scene");//个人类型不是对账大使的跳转到choose-scene并传递type=await
				forwordView.addObject("type", "await");
			}
		}
    	
    	
        return forwordView;
    }

    /**
     * 用户注销
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request,HttpServletResponse response) {

        //shiro管理的session
        Session session = getShiroSession();

        session.removeAttribute(Const.SESSION_USER);
        session.removeAttribute(Const.SESSION_QX);
        session.removeAttribute(Const.SESSION_userpds);
        session.removeAttribute(Const.SESSION_USERNAME);

        //shiro销毁登录
        request.getSession().invalidate();
        SecurityUtils.getSubject().logout();
    }


    private void ensureUserIsLoggedOut(){
        try
        {
            // Get the user if one is logged in.
            Subject currentUser = SecurityUtils.getSubject();
            if (currentUser == null)
                return;

            // Log the user out and kill their session if possible.
            currentUser.logout();
            Session session = currentUser.getSession(false);
            if (session == null)
                return;

            session.stop();
        }
        catch (Exception e){
            // Ignore all errors, as we're trying to silently 
            // log the user out.
        }
    }
    

}
