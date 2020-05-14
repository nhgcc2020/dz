package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.ComEmployee;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.redis.RedisUtil;
import com.ydz.wechat.util.JsonUtil;
import com.ydz.wechat.util.SendRequestUtil;
import com.ydz.wechat.util.WechatConstants;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.WechatUtil;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame WechatController.java
 * @createTime 2016-08-24 下午4:19
 * @decription 微信控制器处理
 **/
@Controller
@RequestMapping(value = "wechat", produces = "application/json;charset=UTF-8")
public class WechatController extends BaseController {
	
	public Logger logger = Logger.getLogger(this.getClass());

    @Resource
    RedisUtil redisUtil;
    @Resource
    WechatConstants wechatConstants;
    @Resource
    WechatUtil wechatUtil;
    @Resource
    UserService userService;
    @Resource(name = "companyService")
    private CompanyService companyService;


    /**
     * 
     * @Title: receive 
     * @param request
     * @return
     * @return String
     * @throws 
     * @Description: 关注服务号之后触发
     */
    @RequestMapping(value = "receive", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String receive(HttpServletRequest request){

        Map<String,Object> map = new HashMap<>();
        SAXReader saxReader = new SAXReader();

        Document document = null;
        //String xml = "<xml><ToUserName><![CDATA[toUser]]></ToUserName><FromUserName><![CDATA[FromUser]]></FromUserName><CreateTime>123456789</CreateTime><MsgType><![CDATA[event]]></MsgType><Event><![CDATA[subscribe]]></Event></xml>";
        //DocumentHelper.parseText(xml);

        try {
            document = saxReader.read(request.getInputStream());
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String result=  null;
        if(document == null){
            String echostr = request.getParameter("echostr");
            return echostr;
        }else{
            List<Element> elementList = document.getRootElement().elements();
            for(Element element : elementList ){
                map.put(element.getName(),element.getData());
            }
            if(map.get("MsgType") !=null && map.get("MsgType").equals("event")){
               if(map.get("Event").equals("subscribe")){
                   //给用户发送消息
                   String fromUserName = (String) map.get("FromUserName");
                   try {
                     result=  wechatUtil.sendMsg(fromUserName,"您好，欢迎关注易对账软件！\n" +
	                             "\n" +
	                             "本公众号主要用于接收、查看从好友供应商发过来的订单和对账单，只需2步：\n" +
	                             "\n" +
	                             "1. 点击供应商的邀请短信链接，注册成为易对账用户，双方即为好友。" +
	                             "\n" +
	                             "2. 绑定易对账账号(手机号)。" +
	                             "\n\n" +
	                             "后续还支持用户进行收货/确认/在线支付等操作。" +
	                             "\n\n" +
	                             "<a style='color:#2e8ae6' href='" +
	                             "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wechatConstants.appId+"&redirect_uri="+wechatConstants.domainName +
	                             "/wechat/getWechatCode&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect" +
	                             "'>立即绑定易对账账号</a>\n" +
	                             "\n如需了解更多易对账软件的功能，请访问 www.yiduizhang.com"
                             );
                     logger.info("===关注后自动回复已发送");
                   } catch (IOException e) {
                       e.printStackTrace();
//                       "<a style='color:#2e8ae6' href='" +
//                       "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wechatConstants.appId+"&redirect_uri="+wechatConstants.domainName
//                       +"/wechat/getWechatCode&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect" +
//                       "'>立即绑定易对账账号</a>\n" +
//                       "\n" +
//                       "如果还没有账号，<a style='color:#2e8ae6' href='"+wechatConstants.domainName+"/wechat/member/sign-in.html'>请创建！</a>\n
                   }

               }
            }
            return "";
        }

    }

    /**
     * 解析微信发来的请求（XML）
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static Map<String, String> parseXml(HttpServletRequest request) throws Exception {
        // 将解析结果存储在HashMap中
        Map<String, String> map = new HashMap<String, String>();

        // 从request中取得输入流
        InputStream inputStream = request.getInputStream();
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        // 得到xml根元素
        Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<Element> elementList = root.elements();

        // 遍历所有子节点
        for (Element e : elementList)
            map.put(e.getName(), e.getText());

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }

    /**
     * 
     * @Title: getToken 
     * @return
     * @return String
     * @throws 
     * @Description: 获取微信的token
     */
    @RequestMapping(value = "getToken")
    @ResponseBody
    public String getToken(){
       return wechatUtil.getToken();
    }

    /**
     * 
     * @Title: getWechatCode 
     * @param request
     * @return
     * @return ModelAndView
     * @throws 
     * @Description: 跳转主入口
     */
    @RequestMapping(value = "getWechatCode")
    public ModelAndView getWechatCode(HttpServletRequest request){
        String code = request.getParameter("code");
        try {
            String tokenStr =  wechatUtil.getOauthToken(code);
            Map<String,Object> map = JsonUtil.jsonToMap(tokenStr);
            String openId = (String) map.get("openid");
            UserVo userVo = new UserVo();
            if(map.get("access_token") != null && map.get("openid") != null){
               //todo 有空优化代码
               //查询该openid是否为系统用户
               PageData pd2 = new PageData();
               pd2.put("bindWechat",openId);
               User userRes2 = userService.getUserById(pd2);
               if(userRes2 != null){
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
                   return new ModelAndView("redirect:/wechat/home/index.html");
               }

              String userStr =  getSnsUserInfo((String) map.get("access_token"),(String) map.get("openid"));
              JSONObject userObject = JSON.parseObject(userStr);
              String nickname = (String) userObject.get("nickname");
              String headimgurl = (String) userObject.get("headimgurl");
              userVo.setNickName(nickname);
              userVo.setAvatarPath(headimgurl);
              userVo.setBindWechat(openId);

              request.getSession().setAttribute(Const.SESSION_WECHAT_SIGN,userVo);
            }
            return new ModelAndView("jsp/wechat/join-login")
                    .addObject("user",userVo);
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping(value = "toWechatPage")
    public ModelAndView toWechatPage(HttpServletRequest request){
        String code = request.getParameter("code");
        String url = request.getParameter("key");
        Map<String,String[]> objectMap =  request.getParameterMap();

        try {
            String tokenStr =  wechatUtil.getOauthToken(code);
            Map<String,Object> map = JsonUtil.jsonToMap(tokenStr);
            String openId = (String) map.get("openid");
            if(openId == null){
                return new ModelAndView("404");
            }
            //查询该openid在系统中是否有用户
            PageData pd2 = new PageData();
            pd2.put("bindWechat",openId);
            User userRes2 = userService.getUserById(pd2);
            if(userRes2 != null ){
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
                if("wechat/member/shark".equals(url)){
                    long key = userVo.getUid();
                    String inviteUrl = wechatConstants.domainName+"/invite/normal/shareMid/"+key;
                    return new ModelAndView("jsp/invite/normal/share").addObject("url",inviteUrl).addObject("key",key);
                }else{

                }
                return new ModelAndView(url);
            }else{
                String userStr =  getSnsUserInfo((String) map.get("access_token"),(String) map.get("openid"));
                JSONObject userObject = JSON.parseObject(userStr);
                String nickname = (String) userObject.get("nickname");
                String headimgurl = (String) userObject.get("headimgurl");
                UserVo userVo = new UserVo();
                userVo.setNickName(nickname);
                userVo.setAvatarPath(headimgurl);
                userVo.setBindWechat(openId);
                request.getSession().setAttribute(Const.SESSION_WECHAT_SIGN,userVo);
               
                return new ModelAndView("wechat/member/redirect-login");
            }
            /*if(map.get("access_token") != null && map.get("openid") != null){
                String userStr =  getSnsUserInfo((String) map.get("access_token"),(String) map.get("openid"));
                JSONObject userObject = JSON.parseObject(userStr);
            }*/
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("404");
        }
    }


    public String getSnsUserInfo(String accessToken,String openId){
        //获取token
        String param =  "access_token="+ accessToken+"&" +
                "openid="+openId+"&"+
                "lang=zh_CN";
        return SendRequestUtil.sendGet(wechatConstants.snsUserInfoUrl,param);

    }
}