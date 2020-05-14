package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.init.IndustryInit;
import com.ydz.entity.system.CityLevel;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.*;
import com.ydz.util.Const;
import com.ydz.util.CypherUtil;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.UuidUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;
import com.ydz.wechat.util.WechatConstants;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @ClassName: RegisterController
 * @date 2016年5月22日 下午1:11:52
 * @Description: 注册控制器
 */
@Controller
@RequestMapping(value = "reg", produces = "application/json;charset=UTF-8")
public class RegisterController extends BaseController {
    @Resource
    private WechatConstants wechatConstants;
    //todo 获取用户信息时候没次 需要获取token
    private final static String OPEN_USER_URL = "https://api.weixin.qq.com/sns/userinfo";
    //用户业务层
    @Resource(name = "userService")
    private UserService userService;
    //企业业务层
    @Resource(name = "companyService")
    private CompanyService companyService;
    //企业类型业务层
    @Resource(name = "industryComService")
    private IndustryComService industryComService;

    @Resource(name = "commonService")
    CommonService commonService;

    @Resource(name = "tradeService")
    TradeService tradeService;

    @Resource(name = "employeeService")
    EmployeeService employeeService;

    @Resource(name = "departmentService")
    DepartmentService departmentService;

    @Resource(name = "menuService")
    MenuService menuService;
    
    @Resource
    private DZConfig dzConfig;

    /////////////////////////////////////////////////////////////////////注册新流程 start//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "test")
    @ResponseBody
    public String test(@RequestParam(value = "para") String[] para, String id, HttpServletRequest request) {
        return "1";
    }


    /**
     * 注册（创建个人公司）
     * @param user
     * @param code
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "signUp")
    @ResponseBody
    public Map<String, Object> signUp(User user, String code, HttpServletRequest request) throws Exception {
        Map<String, Object> map = new HashMap<>();
        if (user.getUserId() == null || "".equals(user.getUserId())) {
            map.put("state", false);
            map.put("msg", "请输入正确手机号");
            return map;
        }
        if (user.getPassword() == null || "".equals(user.getPassword())) {
            map.put("state", false);
            map.put("msg", "请输入密码");
            return map;
        }
        if (code == null || "".equals(code)) {
            map.put("state", false);
            map.put("msg", "请输入验证码");
            return map;
        }
        //验证码 验证
        if ("0".equals(checkVerificationCode(code))) {
            map.put("state", false);
            map.put("msg", "验证码不正确");
            return map;
        }
        //手机号重复校验
        PageData pdPara = this.getPageData();
        pdPara.put("userId", user.getUserId());
        pdPara.put("password", null);
        User userRsl = userService.getUserById(pdPara);
        if (userRsl != null) {
            map.put("state", false);
            map.put("msg", "该手机号已被注册");
            return map;
        }

        //创建个人信息
        String userId = user.getUserId();
        String userKey = UuidUtil.get32UUID();
        String password = user.getPassword();
        String salt = CypherUtil.getSalt(userKey.substring(0, 11));
        user.setSalt(salt);
        user.setPassword(CypherUtil.getEncryptedPassword(password, salt));
        user.setUserKey(userKey);
        user.setCreateTime(new Date());
        if (StringUtil.isEmpty(pdPara.getString("regType"))) {
        	user.setRegType(SystemEnum.REG_TYPE_PC.getCode());
		}else {
			user.setRegType(pdPara.getString("regType"));
		}
        //获取ip
        user.setRegisterIp(getIpAddr(request));
        //用户 是否有效字段 该为有效
        user.setIsValid("1");

        UserVo userVo = userService.saveNormalSignUp(user,"1"); //个人注册写入user表并生成个人类型公司写入company表。isValid设为0，等待生效
        
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            try {
                subject.login(new UsernamePasswordToken(userId, password));
            } catch (AuthenticationException ex) {
                ex.printStackTrace();
            }
        }
        
        //插入注册后的首次登陆日志信息
        LoginLog loginLog = new LoginLog(
        		userVo.getUserKey(), new Date(), this.getIpAddr(request), PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request)));
        commonService.insertLoginLog(loginLog);
        
        map.put("state", true);
        map.put("msg", "注册成功");
        getShiroSession().setAttribute(Const.SESSION_USER, userVo);
        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), commonService.formatRegisterType(user.getRegType()), userVo.getUserId(), "个人账户",PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request)));
        return map;
    }
    
    /**
     * 
     * @Title: toBePromoter 
     * @return
     * @throws Exception
     * @return ModelAndView
     * @throws 
     * @Description: 成为推广大使
     */
    @RequestMapping(value = "toBePromoter")
    public ModelAndView toBePromoter() throws Exception {
    	UserVo userVo = getSessionUservo();
    	ModelAndView forwardView = new ModelAndView();
    	forwardView.setViewName("/jsp/main");
    	forwardView.addObject("type", "promoter");
    	userVo.setComAttr(CompanyEnum.COM_ATTR_PROMOTER.getCode());
    	getCurrentSession().setAttribute(Const.SESSION_USER,userVo);
    	return forwardView;
    }

    /**
     * 创建通用型公司
     * @param company
     * @param bossOrAdmin
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "saveCom")
    @ResponseBody
    public Map<String, Object> saveNewCom(Company company, String bossOrAdmin) throws Exception {
        UserVo userVo = getSessionUservo();
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("userKey_person", userVo.getComKey());
        //根据该公司名称 和 该用户
        Object userVo1 = companyService.insertNewCompany(company, userVo, bossOrAdmin);
        UserVo userVo2 = null;
        if(userVo1 == null){
            result.put("state", false);
            result.put("msg", "已创建过该企业，请重新修改企业名称");
        }else{
            userVo2 = (UserVo) userVo1;
            result.put("state", true);
            result.put("msg", "操作成功");
            result.put("comId",userVo2.getComId());
            getCurrentSession().setAttribute(Const.SESSION_USER,userVo1);
        }
        HttpServletRequest request = this.getRequest();
//        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), commonService.formatRegisterType(user.getRegType()), userVo.getUserId(), "个人账户",PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request)));
        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), commonService.formatRegisterType("0"), 
        		userVo.getUserId(), "企业账户"+company.getComName(),
        		PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request)));

        return result;
    }

    /**
     * 
     * @Title: getLocationInfo 
     * @param request
     * @return
     * @return String
     * @throws 
     * @Description: 获取省市县信息，通过ip或者手机号
     */
    @RequestMapping(value="getLocation")
    @ResponseBody
    public String getLocationInfo(HttpServletRequest request){
    	Map<String, Object> locationMap = null;
    	PageData pd = this.getPageData();
    	UserVo userVo = getSessionUservo();
    	String phone = pd.getString("phone");
    	
    	try {
    		if (StringUtil.isEmpty(phone)) {
				phone = userVo.getUserId();
			}
			locationMap = commonService.getLocationMap(this.getIpAddr(request), phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return JsonUtil.toCompatibleJSONString(locationMap);
    }
    /////////////////////////////////////////////////////////////////////注册新流程 end//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    /**
     * 微信注册
     * @param request
     * @return
     */
   /* @RequestMapping("getwechat")
    public ModelAndView login(HttpServletRequest request){
        return new ModelAndView("jsp/register/reg-user-info");
     String code = request.getParameter("code");
     if(code == null){
     return new ModelAndView("frame/404");
     }else{
     //需要的参数
     String appid = "wx3cf7f06eafb76a51";
     String secret = "31205501f6cf4830e4eea755f4eb638a";
     String grant_type = "authorization_code";
     String getTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token";
     //
     String access_token = "";
     String openid = "";

     String tokenInfo = SendRequestUtil.sendGet(getTokenUrl,"appid="+appid+
     "&secret="+secret+
     "&code="+code+
     "&grant_type="+grant_type);
     System.out.println(tokenInfo);
     Map<String,Object> userInfo = null;
     try {
     Map<String,Object> tokenInfoMap = JsonUtil.jsonToMap(tokenInfo);
     access_token = (String) tokenInfoMap.get("access_token");
     openid  = (String) tokenInfoMap.get("openid");
     String userJson  =  SendRequestUtil.sendGet(OPEN_USER_URL,"access_token="+access_token+"&openid="+openid);
     userInfo = JsonUtil.jsonToMap(userJson);

     //先查询该openId 是否为系统用户
     User userPara = new User();
     userPara.setLoginWechat(openid);
     User userRes = userService.getByModel(userPara);
     if(userRes != null){
     //把个人信息加入
     UserVo userVo = new UserVo();
     userVo.setUid(userRes.getUid());
     userVo.setUserKey(userRes.getUserKey());
     userVo.setUserId(userRes.getUserId());
     userVo.setNickName(userRes.getNickName());
     userVo.setRealName(userRes.getRealName());
     userVo.setAvatarPath(userRes.getAvatarPath());
     userVo.setRegisterIp(userRes.getRegisterIp());
     //查询该用户对应公司
     Company companyPara = new Company();
     companyPara.setCreator(userRes.getUserKey());
     List<Company> companies = companyService.getCompanyByUserKey(userVo);
     if(companies.size() > 0){
     //当前默认选择第一家公司 登录

     getCurrentSession().setAttribute(Const.SESSION_USER,userVo);
     }       userVo.setComKey(companies.get(0).getComKey());
     return new ModelAndView("../frame/main");
     }else{
     User user = new User();
     user.setLoginWechat(openid);
     user.setNickName((String) userInfo.get("nickname"));
     user.setAvatarPath((String) userInfo.get("headimgurl"));
     request.getSession().setAttribute(Const.SESSION_WECHAT,user);
     return new ModelAndView("jsp/register/reg-user-info");
     }
     } catch (IOException e) {
     e.printStackTrace();
     return new ModelAndView("");
     } catch (Exception e) {
     e.printStackTrace();
     return new ModelAndView("");
     }
     }
    }
    */



    //跳转选择小行业
    @RequestMapping("detail-industry")
    public ModelAndView sIndustry(String mId) {
        //根据用户所选的大行业 获取父级是大行业的小行业类别 并且获取该类别下的具体小行业
        List<IndustryInit> industries = null;
        try {
            industries = industryComService.selectIndusByID("1");
        } catch (Exception e) {
            e.printStackTrace();
        }
        //}
        return new ModelAndView("jsp/register/reg-detail-industry").addObject("industrys", industries);
    }

    //保存小行业
    @RequestMapping(value = "saveSIndus")
    @ResponseBody
    public String saveSIndus(String ids, HttpServletRequest request) {
        UserVo operator = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        String res = "0";
        try {
            res = industryComService.saveSIndus(ids, operator);
            if ("1".equals(res)) {
                //小行业选择成功后 进行如下操作 初始化产品///////////////////////////////////////////////////////////////////////////////////
                Company company = companyService.getCompanyByUserKey(operator.getComKey());
                PageData pageDataPara = new PageData();
                pageDataPara.put("cityId", company.getCity());
                CityLevel cityLevel = tradeService.getCityLevel(pageDataPara);
                PageData pageData = new PageData();
                pageData.put("industryId", ids);

                pageData.put("cityLevel", cityLevel.getCityLevel());
                pageData.put("comKey", company.getComKey());
                pageData.put("comId", company.getComId());
                pageData.put("userKey", operator.getUserKey());
                //tradeService.insertTrialBusiPriceCom(pageData);
                //小行业选择成功后 进行如下操作 初始化产品///////////////////////////////////////////////////////////////////////////////////

                //小行业添加成功后把小行业放入 uservo中  start//////////////////////////////////////////////////////////////////////////////////////////////////////////////
                operator.setDetailIndustryId(ids);
                request.setAttribute(Const.SESSION_USER, operator);
                //小行业添加成功后把小行业放入 uservo中  end////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JSON.toJSONString(res);
    }
    

    //创建公司成功跳转
    @RequestMapping("create_succ")
    public ModelAndView createSucc(HttpServletRequest request) {
        UserVo operator = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        Company companyView = null;
        try {
            companyView = companyService.getCompanyByUserKey(operator.getComKey());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("jsp/register/reg-sucess").addObject("companyView", companyView).addObject("user", operator);
    }

    //
    @RequestMapping("qr_code")
    public ModelAndView qrCode(HttpServletRequest request) {
        UserVo operator = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        Company companyView = null;
        try {
            companyView = companyService.getCompanyByUserKey(operator.getComKey());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("jsp/register/reg-wechat-public").addObject("companyView", companyView);
    }

    @RequestMapping(value = "forget-password")
    public ModelAndView forgetPassword() {
        return new ModelAndView("jsp/register/forget-password");
    }

    @RequestMapping(value = "reset-password")
    @ResponseBody
    public String resetPassword(HttpServletRequest request, String code, String userId, String password1) {
        //1.首先判断短信验证是否通过
        String result = checkVerificationCode(code);
        //通过则重置密码
        if ("1".equals(result)) {
            PageData pdPara = new PageData();
            pdPara.put("userId", userId);
            User user = null;
            Integer operationState = 0;
            try {
                user = userService.getAuthorByUserId(pdPara);
                if (user != null) {
                    User passwordUser = new User();
                    passwordUser.setUserKey(user.getUserKey());
                    passwordUser.setPassword(CypherUtil.getEncryptedPassword(password1, user.getSalt()));
                    operationState = userService.updateUser(passwordUser);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return String.valueOf(operationState);
        } else {
            return "0";
        }
    }


    @RequestMapping(value = "transaction-record")
    public ModelAndView transactionRecord() {
        return new ModelAndView("jsp/company/transaction-record");
    }

    @RequestMapping(value = "voucher")
    public ModelAndView voucher() {
        return new ModelAndView("/jsp/company/voucher");
    }

    @RequestMapping(value = "invoice-center")
    public ModelAndView invoiceCenter() {
        return new ModelAndView("jsp/company/invoice-center");
    }

}
