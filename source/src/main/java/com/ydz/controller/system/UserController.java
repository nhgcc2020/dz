package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.taobao.api.ApiException;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.ResultMap;
import com.ydz.entity.invite.InviteReward;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.User;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.UserService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.CypherUtil;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.UserPromoterVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.apache.commons.codec.binary.Base64;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 类名称：UserController
 * 创建人：yiduizhang
 * 创建时间：2014年6月28日
 */
@Controller
@RequestMapping(value = "ydz/user",produces = "plain/text; charset=UTF-8")
public class UserController extends BaseController {

    @Resource(name = "userService")
    UserService userService;
    @Resource(name = "companyService")
    CompanyService companyService;
    @Resource
    private CommonService commonService;
    
    @Resource(name = "employeeService")
    private EmployeeService employeeService;



    /**
     * 
     * @Title: rewardSituation 
     * @return
     * @return String
     * @throws 
     * @Description: 邀请奖励金额
     */
    @RequestMapping(value = "rewardSituation")
    @ResponseBody
    public String rewardSituation(){
        UserVo userVo = getSessionUservo();
        Map<String,Object> result = new HashMap<>();
        PageData pd= new PageData();
        pd.put("userKey",userVo.getUserKey());
        BigDecimal sumNum = commonService.getSumReward(pd);
        if(sumNum == null){
            sumNum= new BigDecimal(0);
        }
        List<InviteReward> rewards = commonService.getListByKey(pd);
        //查询邀请已注册的
        pd.put("refereeName",userVo.getUserKey());
        List<CompanyVO> companies = companyService.getByRefereeName(pd);
        Map<String,Object> baseData = new HashMap<>();
        baseData.put("sumNum",sumNum);
        baseData.put("withdraw","0");
        baseData.put("balance",sumNum);
        baseData.put("regNum",companies.size());
        baseData.put("payNum",rewards.size());
        result.put("baseData",baseData);
        result.put("rewardRed",rewards);
        result.put("regList",companies);
        return JSON.toJSONString(result);
    }
    
    /**
     * 
     * @Title: getMyPromotion 
     * @return
     * @return String
     * @throws 
     * @Description: 获取我推荐的公司
     * paid == 1 已付费的推荐公司
     * paid == 0 未付费的推荐公司
     */
    @RequestMapping(value = "my-promotion")
    @ResponseBody
    public String getMyPromotion(){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
    	pd.put("userKey", userVo.getUserKey());
    	List<UserPromoterVO> promoterVOs = userService.listMyPromotion(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setData(promoterVOs);
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }


    @RequestMapping(value = "user-avatar")
    public void getUserAvatar(HttpServletRequest request, HttpServletResponse response) {
        UserVo user = getSessionUservo();

        //todo
        PageData pdPara = new PageData();
        pdPara.put("userKey", user.getUserKey());
        User userRes = null;
        try {
            userRes = userService.getAvatarByUserKey(pdPara);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //todo
        String userAvatar = userRes.getAvatarPath();
        //有头像的则把头像转化为流输出
        if(null != userAvatar && !"".equals(userAvatar)){
            //先把字符串转为流
//            BASE64Decoder decoder = new BASE64Decoder();
            // Base64解码
            try {
//                byte[] b = decoder.decodeBuffer(userAvatar);
                byte[] b = new Base64().decode(userAvatar);
                for (int i = 0; i < b.length; ++i) {
                    if (b[i] < 0) {// 调整异常数据
                        b[i] += 256;
                    }
                }

                OutputStream outputStream = response.getOutputStream();

                outputStream.write(b);
                outputStream.flush();
                outputStream.close();

            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
        //没有则打印日志
//            logger.warn("该用户暂无头像");

        }
    }

    @RequestMapping(value = "other-user-avatar")
    public void getOtherUserAvatar(HttpServletRequest request,String userKey ,HttpServletResponse response) {
        UserVo user = getSessionUservo();

        PageData pdPara = new PageData();
        pdPara.put("userKey", userKey);
        User userRes = null;
        try {
            userRes = userService.getAvatarByUserKey(pdPara);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String userAvatar = userRes.getAvatarPath();
        //有头像的则把头像转化为流输出
        if(null != userAvatar && !"".equals(userAvatar)){
            //先把字符串转为流
//            BASE64Decoder decoder = new BASE64Decoder();
            // Base64解码
            try {
//                byte[] b = decoder.decodeBuffer(userAvatar);
                byte[] b = new Base64().decode(userAvatar);
                for (int i = 0; i < b.length; ++i) {
                    if (b[i] < 0) {// 调整异常数据
                        b[i] += 256;
                    }
                }

                OutputStream outputStream = response.getOutputStream();

                outputStream.write(b);
                outputStream.flush();
                outputStream.close();

            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            //没有则打印日志
//            logger.warn("该用户暂无头像");

        }
    }

    @RequestMapping(value = "detail")
    @ResponseBody
    public String getUserDetail(){
        UserVo userVo = getSessionUservo();
        //根据userkey查询其所属的公司
        if(userVo == null){
            return "0";
        }
        try {
            return JSON.toJSONString(userVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }


    @RequestMapping(value = "detailWithCom")
    @ResponseBody
    public String getUserDetailWithCom(){
        UserVo userVo = getSessionUservo();
        UserVo userVoNew = new UserVo();
        BeanutilsCopy.apacheCopyProperties(userVoNew,userVo);
        //根据userkey查询其所属的公司
        if(userVo == null){
            return "0";
        }
        try {
            List<Company> companies = companyService.getByEmpUserKey(userVo);
            for(Company com : companies){
                if(com.getComKey().equals(userVo.getComKey())){
                    userVoNew.setComName(com.getComName());
                    userVoNew.setComId(com.getComId());
                }
            }
            userVoNew.setCompanyList(companies);
            return JSON.toJSONString(userVoNew);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    /**
     * 跳转用户信息
     * @return 当前用户信息
     */
    @RequestMapping(value = "per-data" )
    @ResponseBody
    public String perInfo(){
        UserVo userVo = getSessionUservo();
        //根据userKey 查找用户的具体信息
        PageData pdPara = new PageData();
        pdPara.put("userKey", userVo.getUserKey());
        try {
            User user = userService.getUserById(pdPara);

            userVo.setNickName(user.getNickName()==null? "" : user.getNickName() );
            userVo.setRealName(user.getRealName()==null? "" : user.getRealName() );
            userVo.setUserId(user.getUserId()==null? "" : user.getUserId() );
            userVo.setTelBak(user.getTelBak()==null? "" : user.getTelBak() );
            userVo.setQq(user.getQq()==null? "" : user.getQq() );
            userVo.setEmail(user.getEmail()==null? "" : user.getEmail() );
            
            userVo.setNowProvince(user.getNowProvince());
            userVo.setNowCity(user.getNowCity());
            userVo.setNowCountry(user.getNowCountry());
            
            userVo.setLocalProvince(user.getLocalProvince());
            userVo.setLocalCity(user.getLocalCity());
            userVo.setLocalCountry(user.getLocalCountry());
            
//            long start1 = System.currentTimeMillis();
//            if( user.getNowProvince() != null ){
//                Province province = commonService.getOneProvince(user.getNowProvince());
//                userVo.setNowProvince(user.getNowProvince());
//                userVo.setNowProvinceView(province.getProvinceName());
//            }
//            if(user.getNowCity() != null ){
//                City city = commonService.getOneCity(user.getNowCity());
//                userVo.setNowCity(user.getNowCity());
//                userVo.setNowCityView(city.getCityName());
//
//            }
//            if(user.getNowCountry() != null ){
//                Country country = commonService.getOneCountry(user.getNowCountry());
//                userVo.setNowCountry(user.getNowCountry());
//                userVo.setNowCountryView(country.getCountryName());
//            }
//            System.out.println("======================================Now"+Long.toString(System.currentTimeMillis()-start1));
//            
//            long start2 = System.currentTimeMillis();
//            if( user.getLocalProvince() != null ){
//                Province province = commonService.getOneProvince(user.getLocalProvince());
//                userVo.setLocalProvince(user.getLocalProvince());
//                userVo.setLocalProvinceView(province.getProvinceName());
//            }
//            if(user.getLocalCity() != null ){
//                City city = commonService.getOneCity(user.getLocalCity());
//                userVo.setLocalCity(user.getLocalCity());
//                userVo.setLocalCityView(city.getCityName());
//
//            }
//            if(user.getLocalCountry() != null ){
//                Country country = commonService.getOneCountry(user.getLocalCountry());
//                userVo.setLocalCountry(user.getLocalCountry());
//                userVo.setLocalCountryView(country.getCountryName());
//            }
//            System.out.println("======================================Local"+Long.toString(System.currentTimeMillis()-start2));
            return JSON.toJSONString(userVo);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }


    /**
     * 修改用户信息
     * @param user 需要修改的用户信息
     * @return 返回操作结果
     */
    @RequestMapping(value = "modUser")
    @ResponseBody
    public String modUser(User user){
        UserVo userVo = getSessionUservo();
        user.setUserKey(userVo.getUserKey());
        try {
            user.setLastUpdateTime(new Date());
            int result = userService.updateUser(user);
            Employee employee = new Employee();
//            employee.setComKey(userVo.getComKey());
            employee.setUserKey(userVo.getUserKey());
            employee.setRealName(user.getRealName());
            employee.setUserId(userVo.getUserId());
            employeeService.updateEmployee(employee); //修改管理员用户自己所在公司的员工姓名
            
            
            //修改成功后 应同时修改session中的用户信息(后期确定session中的具体存放信息后 应及时修改)
            userVo.setRealName(user.getRealName());
            userVo.setNickName(user.getNickName());
            userVo.setLocalCity(user.getLocalCity());
            userVo.setLocalCountry(user.getLocalCountry());
            userVo.setLocalProvince(user.getLocalProvince());
            userVo.setNowCity(user.getNowCity());
            userVo.setNowCountry(user.getNowCountry());
            userVo.setNowProvince(user.getNowProvince());
            getShiroSession().setAttribute(Const.SESSION_USER, userVo); //信息写回session
            return Integer.toString(result);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * 修改密码
     * @return 修改密码页面
     */
    @RequestMapping(value = "toModPwd")
    public ModelAndView forwardModifyPwd(HttpServletRequest request){
        UserVo user = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        return new ModelAndView("jsp/personInfo/per-modify-pwd").addObject("user",user);
    }
    @RequestMapping(value = "modPwd" )
    @ResponseBody
    public String modPwd(HttpServletRequest request,String oldPwd,String newPwd,String code){
        //验证旧密码是否正确
        UserVo user = getSessionUservo();
        Map<String,Object> callback = new HashMap<>();
        boolean codeResult = checkVerificationCodeByUserVo(code);
        if(!codeResult){
            callback.put("state","0");
            callback.put("msg","请输入正确验证码");
            return JSON.toJSONString(callback);
        }
        //todo 密码应该是加密的  先根据用户
        User userRes = null;
        Boolean result = false;
        try {
            PageData pdPara = new PageData();
            pdPara.put("userId", user.getUserId());
            userRes =  userService.getAuthorByUserId(pdPara);
            if(userRes == null){
                callback.put("state","0");
                callback.put("msg","无此用户");
                return JSON.toJSONString(callback);
            }
            String salt = userRes.getSalt();
            String saltOldPwd = CypherUtil.getEncryptedPassword(oldPwd, salt);
            result = saltOldPwd.equals(userRes.getPassword());
        } catch (Exception e) {
            e.printStackTrace();
        }
        //正确则修改密码 不正确则返回失败
        if(result){
            User userParaMod = new User();
            userParaMod.setUserKey(user.getUserKey());
            userParaMod.setPassword(CypherUtil.getEncryptedPassword(newPwd,userRes.getSalt()));
            try {
                Integer modResult =  userService.updateUser(userParaMod);
                //注销session
                if(modResult == 1){
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
                callback.put("state","1");
                return JSON.toJSONString(callback);
            } catch (Exception e) {
                e.printStackTrace();
                callback.put("state","0");
                callback.put("msg","验证出错");
                return JSON.toJSONString(callback);
            }
        }else{
            callback.put("state","0");
            callback.put("msg","原密码错误");
            return JSON.toJSONString(callback);

        }
    }


    /**
     * 跳转修改手机号页面
     * @return 
     */
    @RequestMapping(value = "modPhone")
    public ModelAndView modPhone(){
        //UserVo userVo = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        return new ModelAndView("jsp/personInfo/per-modify-phone");
    }

    /**
     * 修改手机号
     * @return 啊啊
     */
    @RequestMapping(value = "updatePhone")
    @ResponseBody
    public String updatePhone(HttpServletRequest request,String code,String newPhone,String newCode){
         UserVo userVo  = getSessionUservo();
        Integer modResult = 0;
        boolean result = checkVerificationCodeByUserVo(code);
        if (!checkNewCodeByUserVo(newCode)) {
            return "0";
        }
        if(newPhone == null || "".equals(newPhone)){return "0";}

        if(result){
            //根据新手机号查询系统中是否已经有该用户
            User userPara = new User();
            userPara.setUserId(newPhone);

            PageData pdPara = new PageData();
            pdPara.put("userId", newPhone);
            try {
                User user = userService.getUserById(pdPara);
                if (user == null){
                    userPara.setUserKey(userVo.getUserKey());
                    modResult = userService.updateUser(userPara);
                    //session 注销
                    if(modResult == 1){
                        //request.getSession().removeAttribute(Const.SESSION_USER);
                        SecurityUtils.getSubject().logout();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return String.valueOf(modResult);
    }

    /**
     * 绑定帐号页面
     * @return 啊啊
     */
    @RequestMapping(value = "bindAct")
    public ModelAndView bindAct(){

        return new ModelAndView("jsp/personInfo/per-binding");
    }


    /**
     * 发送验证码
     * @return 啊啊
     */
    @RequestMapping(value = "sendVerCode-info")
    @ResponseBody
    public String sendVerificationCode(HttpServletRequest request,String phone){
        UserVo userVo  = getSessionUservo();
        if(phone == null || "".equals(phone) || !userVo.getUserId().equals(phone)){
            return "0";
        }

        long code = CodeBuilderUtil.getInstance().getSmsRandomCode(6);
        try {

            Map<String,Object> resMap =	SMSUtil.sendCode(String.valueOf(code),phone);
            Map<String,Object> map = new HashMap<>();
            map.put("code",code);
            map.put("time",new Date());
            map.put("phone",phone);
            getRequest().getSession().setAttribute(Const.SESSION_VERIFICATION_CODE,map);
            return "1";
        } catch (ApiException e) {
            e.printStackTrace();
            return "0";
        } catch (IOException e) {
            e.printStackTrace();
            return "0";
        }
    }


    @RequestMapping(value = "sendVerCode-info-modPwd")
    @ResponseBody
    public String sendModPwdCode(HttpServletRequest request,String phone){
        UserVo userVo  = getSessionUservo();
        if(phone == null || "".equals(phone) || !userVo.getUserId().equals(phone)){
            return "0";
        }

        long code = CodeBuilderUtil.getInstance().getSmsRandomCode(6);
        try {

            Map<String,Object> resMap =	SMSUtil.sendModPwdCode(String.valueOf(code),phone);
            Map<String,Object> map = new HashMap<>();
            map.put("code",code);
            map.put("time",new Date());
            map.put("phone",phone);
            getRequest().getSession().setAttribute(Const.SESSION_VERIFICATION_CODE,map);
            return "1";
        } catch (ApiException e) {
            e.printStackTrace();
            return "0";
        } catch (IOException e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    @RequestMapping(value="ownCompanies")
	@ResponseBody
	public String getOwnCompanies() throws Exception{
    	HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		UserVo userVo = this.getSessionUservo();
		
		List<Company> companies = companyService.getCompaniesByUserKey(userVo.getUserKey());
		jsonMap.put("companies", companies);
		jsonMap.put("defaultCom", userVo.getDefaultCom());
		jsonMap.put("currentCom", userVo.getComKey());
		jsonMap.put("comType", userVo.getComType());
		
		return JSONArray.toJSONString(jsonMap);
    }

}

