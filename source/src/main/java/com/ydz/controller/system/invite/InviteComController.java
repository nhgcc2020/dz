package com.ydz.controller.system.invite;

import com.alibaba.fastjson.JSONObject;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.PartnerService;
import com.ydz.service.system.UserService;
import com.ydz.util.*;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 邀请合作伙伴注册公司控制器
 * Created by ydz on 2016/6/24.
 */
@Controller
@RequestMapping(value = "invite/com", produces = "application/json;charset=UTF-8")
public class InviteComController extends BaseController {

    //用户业务层
    @Resource
    private UserService userService;

    @Resource
    private CompanyService companyService;

    @Resource(name = "tradeService")
    TradeService tradeService;

    @Resource(name = "menuService")
    MenuService menuService;
    @Resource PartnerService partnerService;
    
    @Resource private CommonService commonService;
    
    @Resource private DZConfig dzConfig;


    //邀请合作伙伴注册时根据条件进行跳转
    @RequestMapping(value = "signUpPage")
    @ResponseBody
    public ModelAndView forwardRegisterPage(HttpServletRequest request) throws Exception {
        String key = request.getParameter("key");
        if(StringUtil.isEmpty(key)){
        	return new ModelAndView("404");
        }
        String inviteType = null;
        Map<String, Object> map = new HashMap<String, Object>();
        String json = CipherUtil.decrypt(key);
        JSONObject jsonObject = JSONObject.parseObject(json);
        
        PageData pd = new PageData();
        
        //判断是否已失效。判断依据：合作伙伴的联系人是否存在，则正常，否则是过期。
        pd.put("tel1", jsonObject.get("invitee"));
        pd.put("partnerKey", jsonObject.get("partnerKey"));
        PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
        if (contacter==null) {
        	pd.clear();
        	pd.put("comKey", jsonObject.get("comKey"));
        	Company company = companyService.getCompanyByKey(pd);
        	
        	pd.clear();
        	pd.put("userKey", jsonObject.get("userKey"));
        	User user = userService.getUserById(pd);
			return new ModelAndView("/jsp/invite/invalid").addObject("comShortname",company.getComShortname())
					.addObject("userName",user.getRealName())
					.addObject("tel",user.getUserId());
		}
        
        //判断是否已经注册
        pd.clear();
        pd.put("userId", jsonObject.get("invitee"));
        User user = userService.getUserById(pd);
        if (user != null) {
            return new ModelAndView("jsp/invite/company/share");
        }

        map.put("userKey", jsonObject.getString("userKey"));
        map.put("comKey", jsonObject.getString("comKey"));
        map.put("invitee", jsonObject.getString("invitee"));
        map.put("partnerKey", jsonObject.getString("partnerKey"));
        map.put("inviteType", jsonObject.getString("inviteType"));
        inviteType = jsonObject.getString("inviteType");
        request.getSession().setAttribute(Const.SESSION_INVITE, map);
        
        //判断邀请的类型
        if (CompanyEnum.INVITE_TYPE_COMPANY.getCode().equals(inviteType)) {
            return new ModelAndView("jsp/invite/company/sign-up-com");  //邀请合作伙伴是公司的，进入公司注册流程
//        } 
//        else if (CompanyEnum.INVITE_TYPE_PERSONAL.getCode().equals(inviteType)) {
//            PartnerVO partner = partnerService.getByPartnerKey((String) map.get("partnerKey"));
//            return new ModelAndView("jsp/invite/company/sign-up").addObject("company",partner);
        } else {
            return new ModelAndView("404");
        }
    }

    /**
     * 第一步
     * 邀请合作伙伴为公司时，个人注册
     *
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "signUpCom")
    @ResponseBody
    public Map signUpPerson(User user, String code, HttpServletRequest request) throws Exception {
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
        PageData pdPara = new PageData();
        pdPara.put("userId", user.getUserId());
        User userRsl = userService.getUserById(pdPara);
        if (userRsl != null) {
            map.put("state", false);
            map.put("msg", "该手机号已被注册");
            return map;
        }

        Map sessionMap = (Map) getCurrentSession().getAttribute(Const.SESSION_INVITE);
        sessionMap.put("user", user);
        getCurrentSession().setAttribute(Const.SESSION_INVITE, sessionMap);
        map.put("state", true);
        map.put("msg", "成功");
        return map;
    }

    /**
     * 
     * @Title: createComPage 
     * @param mId
     * @param request
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 邀请公司类型的合作伙伴注册创建公司时跳转
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "createComPage")
    public ModelAndView createComPage(String mId, HttpServletRequest request) {
		Map map = (Map) getCurrentSession().getAttribute(Const.SESSION_INVITE);
        PageData pd = this.getPageData();
        pd.put("partnerKey", (String) map.get("partnerKey"));
        pd.put("tel1", (String) map.get("invitee"));
        PartnerVO partner = partnerService.selectOnePartnerAndContacterByPartnerKey(pd);
        return new ModelAndView("jsp/invite/company/create-company").addObject("company", partner);
    }

    /**
     * 邀请合作伙伴为公司类型时创建公司
     * 第二步
     * 公司注册
     *
     * @return
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping(value = "signUpCompany")
    @ResponseBody
    public String signUpCompanyForInvitePartnerTypeCompany(HttpServletRequest request, Company company, String bossOrAdmin, String realName) throws Exception {
        Map<String, Object> map = new HashMap<>();
        Map sessionMap = (Map) getCurrentSession().getAttribute(Const.SESSION_INVITE);
        User user = (User) sessionMap.get("user");

        user.setRefereeName((String) sessionMap.get("userKey"));
        user.setRealName(realName);
        //创建个人信息
        String userId = user.getUserId();
        String userKey = UuidUtil.get32UUID();
        String password = user.getPassword();
        String salt = CypherUtil.getSalt(userKey.substring(0, 11));
        user.setSalt(salt);
        user.setPassword(CypherUtil.getEncryptedPassword(password, salt));
        user.setUserKey(userKey);
        user.setCreateTime(new Date());
        //获取ip
        user.setRegisterIp(getIpAddr(request));
        //用户 是否有效字段 该为有效
        user.setIsValid("1");

        UserVo userVo = userService.saveNormalSignUp(user, "1"); //个人注册写入user表并生成个人类型公司写入company表

        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            try {
                subject.login(new UsernamePasswordToken(userId, password));
            } catch (AuthenticationException ex) {
                ex.printStackTrace();
            }
        }
        if(StringUtil.isNotEmpty(user.getRefereeName())){
            company.setRefereeName(user.getRefereeName());
        }
        companyService.insertNewCompanyForInvite(company, userVo, bossOrAdmin, sessionMap);
        
//        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), commonService.formatRegisterType(user.getRegType()), userVo.getUserId(), "个人账户",PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request)));
//        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), userVo.getUserId(), company.getComName());
        
        map.put("state", true);
        map.put("msg", "操作成功");
        return JsonUtil.toCompatibleJSONString(map);
    }

    /**
     * 邀请合作伙伴为个人客户时个人注册
     *
     * @param user
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping(value = "signUp")
    @ResponseBody
    public Map signUp(User user, String code, HttpServletRequest request) throws Exception {
        //邀请注册的相关参数
        Map sessionMap = (Map) getCurrentSession().getAttribute(Const.SESSION_INVITE);

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
        PageData pdPara = new PageData();
        pdPara.put("userId", user.getUserId());
        User userRsl = userService.getUserById(pdPara);
        if (userRsl != null) {
            map.put("state", false);
            map.put("msg", "该手机号已被注册");
            return map;
        }

        user.setRefereeName((String) sessionMap.get("userKey"));
        //创建个人信息
        String userId = user.getUserId();
        String userKey = UuidUtil.get32UUID();
        String password = user.getPassword();
        String salt = CypherUtil.getSalt(userKey.substring(0, 11));
        user.setSalt(salt);
        user.setPassword(CypherUtil.getEncryptedPassword(password, salt));
        user.setUserKey(userKey);
        user.setCreateTime(new Date());
        //获取ip
        user.setRegisterIp(getIpAddr(request));
        //用户 是否有效字段 该为有效
        user.setIsValid("1");

        UserVo userVo = companyService.saveNormalSignUpForInvite(user, "0", sessionMap); //个人注册写入user表并生成个人类型公司写入company表

        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            try {
                subject.login(new UsernamePasswordToken(userId, password));
            } catch (AuthenticationException ex) {
                ex.printStackTrace();
            }
        }
       //插入本次登陆日志信息
        commonService.insertLoginLog(new LoginLog(
        		userVo.getUserKey(), new Date(), this.getIpAddr(request), PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request))));
        map.put("state", true);
        map.put("msg", "操作成功");
        getShiroSession().setAttribute(Const.SESSION_USER, userVo);
        return map;
    }

    @RequestMapping(value = "success")
    @ResponseBody
    public ModelAndView success() {
        return new ModelAndView("jsp/invite/company/share");
    }
}
