package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.advert.PurchaseOrder;
import com.ydz.entity.system.ComEmployee;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.exception.WechatException;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;
import com.ydz.wechat.util.WechatUtil;

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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame LoginController.java
 * @createTime 2016-09-21 上午11:05
 *
 *
 * @decription 微信账号处理控制器
 **/

@Controller
@RequestMapping(value = "wx/acct",produces = "plain/text; charset=UTF-8")
public class WxAccountController extends BaseController {
	public Logger logger = Logger.getLogger(this.getClass());
    @Resource
    private UserService userService;
    @Resource
    private WechatUtil wechatUtil;
    @Resource(name = "companyService")
    private CompanyService companyService;
    @Resource
    private PurchaseOrderService purchaseOrderService;

    /**
     * 用户办绑定易对账账号
     * @param user
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "bindWechat")
    @ResponseBody
    public String bindWechat(User user,HttpServletRequest request)throws Exception{
        Map<String,Object> callback = new HashMap<>();
        UserVo preUserVo = (UserVo) request.getSession().getAttribute(Const.SESSION_WECHAT_SIGN);
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUserId(),user.getPassword());
        //进行验证
        try {
            subject.login(token);
            //验证成功，根据用户名找到对应用户 添加绑定wechat
            PageData pd = new PageData();
            pd.put("userId",user.getUserId());
            User userRes = userService.getUserById(pd);
            //判断原有用户是否有openId
            if(StringUtil.isNotEmpty(userRes.getBindWechat())){
               //登录操作
                UserVo userVo = new UserVo();
                userVo.setUid(userRes.getUid());
                userVo.setUserKey(userRes.getUserKey());
                userVo.setUserId(userRes.getUserId());
                userVo.setNickName(userRes.getNickName());
                userVo.setRealName(userRes.getRealName());
                userVo.setAvatarPath(userRes.getAvatarPath());
                userVo.setRegisterIp(userRes.getRegisterIp());

                //判断用户默认登录的公司
                if(userRes.getDefaultCom() == null || "".equals(userRes.getDefaultCom().trim())){
                    List<Company> companies = companyService.getByEmpUserKey(userVo);
                    if(companies.size() > 0){
                        userVo.setComKey(companies.get(0).getComKey());
                        userVo.setComName(companies.get(0).getComName());
                        userVo.setComShortname(companies.get(0).getComShortname());
                        //查询对应的小行业ID
                        userVo.setDetailIndustryId(companies.get(0).getIndustryId());
                    }
                    //todo 如果没有comkey 需要在user表 中修改comkey字段
                }else{
                    PageData pdEmp = new PageData();
                    String comKey = userRes.getDefaultCom();
                    pdEmp.put("userKey", userVo.getUserKey());
                    pdEmp.put("comKey", comKey);

                    //校验是否为该公司员工
                    List<ComEmployee> comEmployees = companyService.getComEmployee(pdEmp);
                    if(comEmployees.size() == 1){
                        userVo.setComKey(comEmployees.get(0).getComKey());
                        Company companyResult = companyService.getCompanyByUserKey(comKey);
                        userVo.setDetailIndustryId(companyResult.getIndustryId());
                        userVo.setComName(companyResult.getComName());
                        userVo.setComShortname(companyResult.getComShortname());
                    }

                }
                userVo.setDefaultCom(userVo.getComKey());

                request.getSession().setAttribute(Const.SESSION_WECHAT,userVo);
                callback.put("state", "1");
                callback.put("msg","登录成功");
                return JSON.toJSONString(callback);
            }else if(preUserVo == null){
                //

                UserVo userVo = new UserVo();
                userVo.setUid(userRes.getUid());
                userVo.setUserKey(userRes.getUserKey());
                userVo.setUserId(userRes.getUserId());
                userVo.setNickName(userRes.getNickName());
                userVo.setRealName(userRes.getRealName());
                userVo.setAvatarPath(userRes.getAvatarPath());
                userVo.setRegisterIp(userRes.getRegisterIp());
                //判断用户默认登录的公司
                if(StringUtil.isEmpty(userRes.getDefaultCom())){
                    List<Company> companies = companyService.getByEmpUserKey(userVo);
                    if(companies.size() > 0){
                        userVo.setComKey(companies.get(0).getComKey());
                        userVo.setComName(companies.get(0).getComName());
                        userVo.setComShortname(companies.get(0).getComShortname());
                        //查询对应的小行业ID
                        userVo.setDetailIndustryId(companies.get(0).getIndustryId());
                    }
                    //todo 如果没有comkey 需要在user表 中修改comkey字段
                }else{
                    PageData pdEmp = new PageData();
                    String comKey = userRes.getDefaultCom();
                    pdEmp.put("userKey", userVo.getUserKey());
                    pdEmp.put("comKey", comKey);

                    //校验是否为该公司员工
                    List<ComEmployee> comEmployees = companyService.getComEmployee(pdEmp);
                    if(comEmployees.size() == 1){
                        userVo.setComKey(comEmployees.get(0).getComKey());
                        Company companyResult = companyService.getCompanyByUserKey(comKey);
                        userVo.setDetailIndustryId(companyResult.getIndustryId());
                        userVo.setComName(companyResult.getComName());
                        userVo.setComShortname(companyResult.getComShortname());
                    }
                }
                userVo.setDefaultCom(userVo.getComKey());

                request.getSession().setAttribute(Const.SESSION_WECHAT,userVo);
                
                callback.put("state", "1");
                callback.put("msg","绑定成功");
                return JSON.toJSONString(callback);
            }else if(preUserVo.getBindWechat() != null){
                //如果没有openId 绑定操作
                User userPara = new User();
                userPara.setUserKey(userRes.getUserKey());
                userPara.setBindWechat(preUserVo.getBindWechat());
                userPara.setNickName(preUserVo.getNickName());
                userPara.setAvatarPath(preUserVo.getAvatarPath());
                userService.updateUser(userPara); //更新绑定
                
                UserVo userVo = new UserVo();
                userVo.setUid(userRes.getUid());
                userVo.setUserKey(userRes.getUserKey());
                userVo.setUserId(userRes.getUserId());
                userVo.setNickName(userRes.getNickName());
                userVo.setRealName(userRes.getRealName());
                userVo.setAvatarPath(userRes.getAvatarPath());
                userVo.setRegisterIp(userRes.getRegisterIp());
                //判断用户默认登录的公司
                if(userRes.getDefaultCom() == null || "".equals(userRes.getDefaultCom().trim())){
                    List<Company> companies = companyService.getByEmpUserKey(userVo);
                    if(companies.size() > 0){
                        userVo.setComKey(companies.get(0).getComKey());
                        userVo.setComName(companies.get(0).getComName());
                        userVo.setComShortname(companies.get(0).getComShortname());
                        //查询对应的小行业ID
                        userVo.setDetailIndustryId(companies.get(0).getIndustryId());
                    }
                    //todo 如果没有comkey 需要在user表 中修改comkey字段
                }else{
                    PageData pdEmp = new PageData();
                    String comKey = userRes.getDefaultCom();
                    pdEmp.put("userKey", userVo.getUserKey());
                    pdEmp.put("comKey", comKey);

                    //校验是否为该公司员工
                    List<ComEmployee> comEmployees = companyService.getComEmployee(pdEmp);
                    if(comEmployees.size() == 1){
                        userVo.setComKey(comEmployees.get(0).getComKey());
                        Company companyResult = companyService.getCompanyByUserKey(comKey);
                        userVo.setDetailIndustryId(companyResult.getIndustryId());
                        userVo.setComName(companyResult.getComName());
                        userVo.setComShortname(companyResult.getComShortname());
                    }
                }
                userVo.setDefaultCom(userVo.getComKey());

                request.getSession().setAttribute(Const.SESSION_WECHAT,userVo);
                
                String succsbindTest = "恭喜您成功绑定易对账账号！\n\n"
                		+ "如果您是广告行业用户，建议您下载“易对账”APP，帮助您更全面更便捷地管理公司业务，包括：\n"
                		+ "1.查看销售订单\n"
                		+ "2.一键转发对账单\n"
                		+ "3.设计师任务分派\n"
                		+ "4.制作工车间工序管理\n"
                		+ "5.安装工上传安装完毕的照片\n"
                		+ "6.费用工资管理\n"
                		+ "7.经营统计分析等\n\n"
                		+ "移动互联时代，管理不只是开个单记个账！";
                wechatUtil.sendMsg(preUserVo.getBindWechat(), succsbindTest);
                logger.info("===绑定服务号成功后推送通知");
                callback.put("state", "1");
                callback.put("msg","绑定成功");
                return JSON.toJSONString(callback);
            }else{
                callback.put("state", "0");
                callback.put("msg","未获取用户微信信息");
                return JSON.toJSONString(callback);
            }
        }catch (AuthenticationException e){
            callback.put("state", "0");
            callback.put("msg","用户名或密码错误");
            e.printStackTrace();
            return JSON.toJSONString(callback);
        }
    }


    @RequestMapping(value = "purData")
    public ModelAndView loginAndPurData(HttpServletRequest request){
        String purchaseNo = request.getParameter("purchaseNo");
        String purchasecheckingNo = request.getParameter("purchasecheckingNo");
        String code = request.getParameter("code");
        try {
            String tokenStr =  wechatUtil.getOauthToken(code);
            Map<String,Object> map = JsonUtil.jsonToMap(tokenStr);
            String realOpenId = (String) map.get("openid");
            if (StringUtil.isEmpty(realOpenId)) {
            	return new ModelAndView("404");
			}
            //判断是否为同一用户
            PageData pd2 = new PageData();
            pd2.put("bindWechat",realOpenId);
            User userRes2 = userService.getUserById(pd2);
            if(userRes2 != null){
                //todo 需要修改
                UserVo userVo = new UserVo();
                userVo.setUid(userRes2.getUid());
                userVo.setUserKey(userRes2.getUserKey());
                userVo.setUserId(userRes2.getUserId());
                userVo.setNickName(userRes2.getNickName());
                userVo.setRealName(userRes2.getRealName());
                userVo.setAvatarPath(userRes2.getAvatarPath());
                userVo.setRegisterIp(userRes2.getRegisterIp());
                //判断用户默认登录的公司
                if(userRes2.getDefaultCom() == null || "".equals(userRes2.getDefaultCom().trim())){
                    List<Company> companies = companyService.getByEmpUserKey(userVo);
                    if(companies.size() > 0){
                        userVo.setComKey(companies.get(0).getComKey());
                        userVo.setComName(companies.get(0).getComName());
                        userVo.setComShortname(companies.get(0).getComShortname());
                        //查询对应的小行业ID
                        userVo.setDetailIndustryId(companies.get(0).getIndustryId());
                    }
                    //todo 如果没有comkey 需要在user表 中修改comkey字段
                }else{
                    PageData pdEmp = new PageData();
                    String comKey = userRes2.getDefaultCom();
                    pdEmp.put("userKey", userVo.getUserKey());
                    pdEmp.put("comKey", comKey);

                    //校验是否为该公司员工
                    List<ComEmployee> comEmployees = companyService.getComEmployee(pdEmp);
                    if(comEmployees.size() == 1){
                        userVo.setComKey(comEmployees.get(0).getComKey());
                        Company companyResult = companyService.getCompanyByUserKey(comKey);
                        userVo.setDetailIndustryId(companyResult.getIndustryId());
                        userVo.setComName(companyResult.getComName());
                        userVo.setComShortname(companyResult.getComShortname());
                    }
                }
                userVo.setDefaultCom(userVo.getComKey());
                request.getSession().setAttribute(Const.SESSION_WECHAT,userVo);
                //getCurrentSession().setAttribute(Const.SESSION_WECHAT,userVo);
//                    logger.info("##############加入微信session后的userkey"+getWxCurrentUserVo().getUserKey());
                //根据采购订单 查询对应的协同订单号，传入前台 todo 建议后期改为收货操作时（通过采购单号查询出对应订单号)
                if (StringUtil.isNotEmpty(purchaseNo)) {
                	return new ModelAndView("jsp/wechat/order-detailForMsg").addObject("purchaseNo",purchaseNo);
				}else if (StringUtil.isNotEmpty(purchasecheckingNo)) {
					return new ModelAndView("jsp/wechat/purchasechecking-order-detail-wxmsg").addObject("purchasecheckingNo",purchasecheckingNo);
				}else{
            		return new ModelAndView("404");
            	}
            }
            return new ModelAndView("404");
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new WechatException("查看微信推送消息异常");
        }
    }

}