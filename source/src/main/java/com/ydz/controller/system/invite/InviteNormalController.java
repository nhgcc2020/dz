package com.ydz.controller.system.invite;

import com.alibaba.fastjson.JSON;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.CypherUtil;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.UuidUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.WechatConstants;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 普通邀请
 * Created by pengxuyang on 16/11/2.
 */
@Controller
@RequestMapping(value = "invite/normal/",produces="application/json;charset=UTF-8")
public class InviteNormalController extends BaseController {
    @Resource
    private UserService userService;
    @Resource
    TradeService tradeService;
    @Resource
    private CompanyService companyService;
    @Resource
    private WechatConstants wechatConstants;
    
    @Resource private CommonService commonService;
    
    @Resource
    private DZConfig dzConfig;

    @RequestMapping(value ="getKey" )
    @ResponseBody
    public String getKey(){
        UserVo userVo = getSessionUservo();
        if(userVo == null || userVo.getUserId()==null){
            return "0";
        }else{
            String url = wechatConstants.domainName+"/invite/normal/shareMid/"+userVo.getUid();
            return JSON.toJSONString(url);
        }
    }

    @RequestMapping(value ="getKey2" )
    @ResponseBody
    public String getKey2(){
        UserVo userVo = getSessionUservo();
        if(userVo == null || userVo.getUserId()==null){
            return "0";
        }else{
            String url = wechatConstants.domainName+"/invite/normal/share/"+userVo.getUid();
            return JSON.toJSONString(url);
        }
    }


    @RequestMapping(value = "share/{key}")
    public ModelAndView share(@PathVariable(value = "key") String key){
        if(key == null || key.equals("")){
            return new ModelAndView("404");
        }
        String url = wechatConstants.domainName+"/invite/normal/shareMid/"+key;

        return new ModelAndView("jsp/invite/normal/share").addObject("url",url).addObject("key",key);
    }

    @RequestMapping(value = "shareMid/{key}")
    public ModelAndView shareMid(@PathVariable(value = "key") String key){
        String url = wechatConstants.domainName+"/invite/normal/signIn/"+key;
        return new ModelAndView("jsp/invite/normal/shareMid").addObject("url",url).addObject("key",key);
    }

    @RequestMapping(value = "signIn/{key}")
    public ModelAndView signIn(@PathVariable(value = "key") String key,HttpServletRequest request){
        PageData pd = new PageData();
        if(key == null || key.equals("")){
            return new ModelAndView("404");
        }
        pd.put("uid",key);
        User user = userService.getUserById(pd);
        if(user == null){
            return new ModelAndView("404");
        }
        UserVo userSession = new UserVo();
        userSession.setInviterKey(user.getUserKey());
        request.getSession().setAttribute(Const.SESSION_INVITE,userSession);
        return new ModelAndView("jsp/invite/normal/sign-in").addObject("inviterName",user.getRealName());
    }

    /**
     * 正常邀请注册第一步
     * @param user
     * @param request
     * @return
     */
    @RequestMapping(value = "signUp")
    @ResponseBody
    public String signUp(User user,HttpServletRequest request) throws Exception {

        Map<String,Object> map = new HashMap<>();

        if(user.getUserId() == null || "".equals(user.getUserId())){
            map.put("state","0");
            map.put("msg","请输入正确手机号");
            return JSON.toJSONString(map);
        }
        if(user.getPassword() == null || "".equals(user.getPassword())){
            map.put("state","0");
            map.put("msg","请输入密码");
            return JSON.toJSONString(map);
        }
        //手机号重复校验
        PageData pdPara = new PageData();
        pdPara.put("userId", user.getUserId());
        User userRsl = null;
        try {
            userRsl = userService.getUserById(pdPara);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(userRsl != null){
            map.put("state","0");
            map.put("msg","该手机号已被注册");
            return JSON.toJSONString(map);
        }
        UserVo userSession = (UserVo) request.getSession().getAttribute(Const.SESSION_INVITE);
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

        user.setRefereeName(userSession.getInviterKey());

        userService.saveNormalSignUp(user,"0");
        UserVo userVo = new UserVo();
        userVo.setUid(user.getUid());
        userVo.setUserKey(user.getUserKey());
        userVo.setUserId(user.getUserId());
        userVo.setRealName(user.getRealName());
        userVo.setAvatarPath(user.getAvatarPath());
        userVo.setRegisterIp(user.getRegisterIp());
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            try{
                subject.login(new UsernamePasswordToken(user.getUserId(),user.getPassword()));
            }catch(AuthenticationException ex){
                ex.printStackTrace();
            }
        }
        map.put("state","1");
        map.put("msg","注册成功");
      //插入本次登陆日志信息
        commonService.insertLoginLog(new LoginLog(
        		userVo.getUserKey(), new Date(), this.getIpAddr(request), PublicUtil.getInstance().getLoginIpLocation(this.getIpAddr(request))));
        getShiroSession().setAttribute(Const.SESSION_USER,userVo);
//        commonService.sendSmsToBoss(dzConfig.bossNum,userVo.getRealName(), userVo.getUserId(), userVo.getRealName());
        return JSON.toJSONString(map);
    }


    @RequestMapping(value = "detailIndustryPage")
    public ModelAndView detailIndustryPage(){
        return new ModelAndView("/jsp/invite/normal/select-detail-industry");
    }

    @RequestMapping(value = "toCreateCompay")
    public ModelAndView createCompay(String mId){
        return new ModelAndView("/jsp/invite/normal/create-company").addObject("mId",mId);
    }

    @RequestMapping("saveCom")
    @ResponseBody
    public String saveCom(HttpServletRequest request, Company company, String bossOrAdmin){
        UserVo userVo = getSessionUservo();
        String res = "1";
        try {
            //普通邀请注册 微信qq
            company.setInType("2");
            company.setRefereeName(((UserVo)request.getSession().getAttribute(Const.SESSION_INVITE)).getInviterKey());
            //tradeService.insertRegisterCompanyInfo(company, userVo, bossOrAdmin);
            userVo.setComKey(company.getComKey());
            userVo.setDetailIndustryId(company.getIndustryId());
            userVo.setRentalVersion(RentalTradeEnum.VERSION_ADVANCED_EDITION.getCode()); //注册试用高级版
            getShiroSession().setAttribute(Const.SESSION_USER,userVo);

        } catch (Exception e) {
            e.printStackTrace();
            res="0";
        }
        return JSON.toJSONString(res);
    }

    //创建公司成功跳转
    @RequestMapping("create_succ")
    public ModelAndView createSucc(){
        UserVo operator = getSessionUservo();
        Company companyView = null;
        try {
            //todo 回退空指针
            companyView =  companyService.getCompanyByUserKey(operator.getComKey());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("jsp/invite/normal/create-success").addObject("companyView",companyView).addObject("user",operator);
    }

}
