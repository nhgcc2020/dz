package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.service.advert.TradeService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.CypherUtil;
import com.ydz.util.PageData;
import com.ydz.util.UuidUtil;
import com.ydz.vo.UserVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 微信注册控制器
 * Created by pengxuyang on 16/10/28.
 */
@Controller
@RequestMapping(value = "wx/reg", produces = "application/json;charset=UTF-8")
public class WxRegisterController extends BaseController {

    @Resource
    private UserService userService;

    @Resource
    private CompanyService companyService;

    @Resource(name = "tradeService")
    TradeService tradeService;

    @Resource(name = "menuService")
    MenuService menuService;

    @RequestMapping(value = "signUp2")
    @ResponseBody
    public Map signUp2(User user, HttpServletRequest request, String code) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("state", false);
        map.put("msg", "请输入正确手机号");
        return map;
    }


    /**
     * 注册第一步
     */
    @RequestMapping(value = "signUp")
    @ResponseBody
    public Map signUp(User user, HttpServletRequest request, String code) throws Exception {
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
        UserVo userVoSign = (UserVo) request.getSession().getAttribute(Const.SESSION_WECHAT_SIGN);
        //创建个人信息
        String userId = user.getUserId();
        String userKey = UuidUtil.get32UUID();
        String password = user.getPassword();
        String salt = CypherUtil.getSalt(userKey.substring(0, 11));
        user.setSalt(salt);
        user.setPassword(CypherUtil.getEncryptedPassword(password, salt));
        user.setUserKey(userKey);
        user.setCreateTime(new Date());
        if(userVoSign != null){
            user.setBindWechat(userVoSign.getBindWechat());
            user.setAvatarPath(userVoSign.getAvatarPath());
        }

        //获取ip
        user.setRegisterIp(getIpAddr(request));
        //用户 是否有效字段 该为有效
        user.setIsValid("1");

        UserVo userVo = userService.saveNormalSignUp(user, "1"); //个人注册写入user表并生成个人类型公司写入company表，参数传1，默认启用个人企业

        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            try {
                subject.login(new UsernamePasswordToken(userId, password));
            } catch (AuthenticationException ex) {
                ex.printStackTrace();
            }
        }
        map.put("state", true);
        map.put("msg", "注册成功");
        //微信session
        request.getSession().setAttribute(Const.SESSION_WECHAT, userVo);
        //getShiroSession().setAttribute(Const.SESSION_USER, userVo);
        return map;
    }

    /**
     * 用户信息
     * @return
     */
    @RequestMapping(value = "userInfo")
    @ResponseBody
    public String getUserInfo() {
        UserVo userVo = (UserVo) getRequest().getSession().getAttribute(Const.SESSION_WECHAT);
        User userInfo = new User();
        userInfo.setRealName(userVo.getRealName());
        userInfo.setUserId(userVo.getUserId());
        return JSON.toJSONString(userInfo);
    }

    /**
     * 创建公司
     * @param request
     * @param company
     * @param bossOrAdmin
     * @return
     */
    @RequestMapping("createCom")
    @ResponseBody
    public String saveCom(HttpServletRequest request, Company company, String bossOrAdmin) {
        UserVo userVo = getWxCurrentUserVo();
        String res = "1";
        try {
            UserVo userVo1 = (UserVo) companyService.insertNewCompany(company, userVo, bossOrAdmin);
            request.getSession().setAttribute(Const.SESSION_WECHAT, userVo1);
            /*
            userVo.setComKey(company.getComKey());
            userVo.setDetailIndustryId(company.getIndustryId());
            userVo.setRentalVersion(Const.RENTAL_VERSION_03); //注册试用高级版
            request.getSession().setAttribute(Const.SESSION_WECHAT, userVo);*/

        } catch (Exception e) {
            e.printStackTrace();
            res = "0";
            System.out.println("创建公司失败");
        }
        return JSON.toJSONString(res);
    }


    //创建公司成功跳转
    @RequestMapping("create_succ")
    @ResponseBody
    public String createSucc() throws Exception {
        UserVo operator = getWxCurrentUserVo();
        Company companyView = companyService.getCompanyByUserKey(operator.getComKey());
        Map<String, Object> map = new HashMap<>();
        map.put("userId", operator.getUserId());
        map.put("realName", operator.getRealName());
        map.put("comName", companyView.getComName());
        map.put("comShortname", companyView.getComShortname());
        map.put("comId", companyView.getComId());
        map.put("withinComId", companyView.getWithinComId());
        return JSON.toJSONString(map);
    }

}
