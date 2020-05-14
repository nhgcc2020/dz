package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.common.SmsLogMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.service.WxPartnerService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pengxuyang on 16/11/27.
 */
@Controller
@RequestMapping(value = "wx/partner")
public class WxPartnerController extends BaseController {

    @Resource
    private WxPartnerService wxPartnerService;
    @Resource
    private CompanyService companyService;
    @Resource
    private PartnerMapper partnerMapper;
    @Resource
    private PartnerService partnerService;
    @Resource
    private UserService userService;
    @Resource
    private SmsLogMapper smsLogMapper;
    @Resource
    private RedisUtil redisUtil;

    /**
     * 合作伙伴列表
     * @param type
     * @return
     */
    /*@RequestMapping(value = "customerList")
    @ResponseBody
    public String customerList(String type){
        UserVo userVo = getWxCurrentUserVo();
        PageData pageData = getPageData();
        if(userVo.getComKey() == null){
            return "0";
        }
        //todo
        pageData.put("comKey",userVo.getComKey());
        //
        pageData.put("partnerType",type);
        //pageData.put("",);
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(300);
            //getPageWithParameter();
            page.setPd(pageData);
            List<PartnerVO> partnerVOs =  wxPartnerService.parsePartnerVO(page);
            *//*Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("$entityCount", page.getTotalResult());
            mapPage.put("$data", partnerVOs);*//*
            return JSON.toJSONString(partnerVOs);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }*/

    @ResponseBody
    @RequestMapping(value = "partner",produces = "plain/text; charset=UTF-8")
    public String save(Partner partner){
        System.out.println(partner);
        return "1";
    }

    @RequestMapping(value = "savePartnerWithout", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String savePartnerWithout(Partner partner) throws Exception {
//        logger.info("//@@@@@@@@@@@@@@@：" + partner.getPartnerName() + ":");
        UserVo userVo = getWxCurrentUserVo();
        //用于回调的map
        Map<String, Object> callBack = new HashMap<>();

        if (partner.getPartnerComKey() != null) {
            callBack.put("status", "0");
            callBack.put("msg", "该手机用户已使用易对账，通过申请好友去加他吧");
            return JSON.toJSONString(callBack);
        }

        String partnerAttr = partner.getPartnerAttr();
        //企业属性为个人时
        if ("2".equals(partnerAttr)) {
            //判断是否已经邀请过
            PageData pd = new PageData();
            pd.put("phone", partner.getTel11());
            pd.put("partnerAttr", "2");
            pd.put("comKey", userVo.getComKey());
            List<PartnerVO> partnerVOs = partnerMapper.listByPhone(pd);
            if (partnerVOs.size() > 0) {
                callBack.put("status", "0");
                callBack.put("msg", "该手机用户已在伙伴名单中，无法重复邀请");
                return JSON.toJSONString(callBack);
            }
            partner.setPartnerName(partner.getContacterName11());
            partner.setPartnerShortname(partner.getPartnerName());
        }else{
            //属性为企业时 1
            if(partner.getPartnerName() == null || "".equals(partner.getPartnerName().trim())){
                callBack.put("status", "0");
                callBack.put("msg", "请填写企业全称!");
                return JSON.toJSONString(callBack);
            }
            String partnerName = partner.getPartnerName().trim();
            PageData pd = new PageData();
            pd.put("phone", partner.getTel11());
            pd.put("partnerAttr", "1");
            pd.put("comKey", userVo.getComKey());
            pd.put("partnerName",partnerName);
            List<PartnerVO> partnerVOs = partnerMapper.listByPhone(pd);
            if (partnerVOs.size() > 0) {
                callBack.put("status", "0");
                callBack.put("msg", "该手机用户已在伙伴名单中，无法重复邀请");
                return JSON.toJSONString(callBack);
            }
            partner.setPartnerName(partnerName);
        }

        //查询联系人是否有公司
        String phone = partner.getTel11();
        //负责人手机号 查询公司信息
        PageData pageData = new PageData();
        pageData.put("userId", phone);
        try {
            List<Company> companies = companyService.getByDirector(pageData);
            if (companies.size() > 0) {
                callBack.put("status", "0");
                callBack.put("msg", "该手机用户已使用易对账，通过申请好友去加他吧");
                return JSON.toJSONString(callBack);

            }
        } catch (Exception e) {
            e.printStackTrace();
            callBack.put("status", "0");
            callBack.put("msg", "服务出错");
            return JSON.toJSONString(callBack);
        }

        callBack = partnerService.savePartnerCom(userVo, partner);

        return JSON.toJSONString(callBack);
    }

    /**
     * @return String
     * @throws
     * @Title: customerList
     * @Description: 查询我的客户列表
     */
    @RequestMapping(value = "customerList",produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String customerList() {
        UserVo userVo = getWxCurrentUserVo();
        PageData pageData = getPageData();
        if (userVo.getComKey() == null) {
            return "0";
        }
        //todo
        pageData.put("comKey", userVo.getComKey());
        //
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode());
        //pageData.put("",);
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(300);
            page.setPd(pageData);
            if ("0".equals(pageData.get("partnerStatus"))) {
                pageData.remove("partnerStatus");
                pageData.put("notFriend", "true");
            }
            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,false);
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("$entityCount", page.getTotalResult());
            mapPage.put("$data", partnerVOs);
            return JSON.toJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * @return String
     * @throws
     * @Title: supplierList
     * @Description: 查询我的供应商列表
     */
    @RequestMapping(value = "supplierList",produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String supplierList() {
        UserVo userVo = getWxCurrentUserVo();
        PageData pageData = getPageData();
        if (userVo.getComKey() == null) {
            return "0";
        }
        //todo
        pageData.put("comKey", userVo.getComKey());
        //
        pageData.put("partnerType", "2");
        //pageData.put("",);
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(300);
            //getPageWithParameter();
            page.setPd(pageData);

            if ("0".equals(pageData.get("partnerStatus"))) {
                pageData.remove("partnerStatus");
                pageData.put("notFriend", "true");
            }

            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,false);
            Map<String, Object> mapPage = new HashMap<>();
            mapPage.put("$entityCount", page.getTotalResult());
            mapPage.put("$data", partnerVOs);
            return JSON.toJSONString(mapPage);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    /**
     * @param phone
     * @return boolean
     * @throws
     * @Title: getCustListByPhone
     * @Description: 根据手机号 查询其身份为法人或者管理员的公司。
     * 用于新建合作伙伴时，是否是已经使用易对账的系统用户
     */
    @RequestMapping(value = "isRegistered")
    @ResponseBody
    public boolean getCustListByPhone(String phone) {
        //负责人手机号 查询公司信息
        PageData pageData = new PageData();
        pageData.put("userId", phone);
        List<Company> companies = companyService.getByDirector(pageData);
        boolean falg = false;
        if (companies.size() > 0) {
            falg = true;
        }
        return falg;
    }


    @RequestMapping(value = "sendInviteMsg")
    @ResponseBody
    public Map sendInviteMsg(String partnerKey,String phone) throws Exception {
        UserVo userVo = getWxCurrentUserVo();
        //返回值
        Map<String, Object> callback = new HashMap<>();
        if (partnerKey == null || "".equals(partnerKey)) {
            callback.put("state", false);
            callback.put("msg", "参数错误");
            return callback;
        }
        if(phone == null || "".equals(phone)){
            callback.put("state", false);
            callback.put("msg", "请填写正确手机号");
            return callback;
        }

        PageData pd = new PageData();
        pd.put("myComKey", userVo.getComKey());
        pd.put("partnerKey", partnerKey);
        PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd);

        //1.判断有没有注册
        List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pd);
        PartnerContacter partnerContacter = partnerContacters.get(0);

        //判断手机号是否进行进行了修改
        if(! partnerContacter.getTel1().equals(phone.trim())){
            PartnerContacter partnerContacterMod = new PartnerContacter();
            partnerContacterMod.setUid(partnerContacter.getUid());
            partnerContacterMod.setTel1(phone);
            partnerService.updateOnePartnerContacter(partnerContacterMod);

            partnerContacter.setTel1(partnerContacterMod.getTel1());
        }

        String userId = partnerContacter.getTel1();
        PageData pd2 = new PageData();
        pd2.put("userId", userId);
        User user = userService.getUserById(pd2);
        //2.如果已经注册
        //companyS
        if (user != null) {
            callback.put("state", false);
            callback.put("msg", "已经注册");
            return callback;
        } else {
            //3.如果没有注册 发送短信

            PageData pd3 = new PageData();
            pd3.put("comKey", userVo.getComKey());
            Company company = companyService.getCompanyByKey(pd3);
            //生成參數
            Map<String, Object> map = new HashMap<>();
            map.put("userKey", userVo.getUserKey());
            map.put("comKey", userVo.getComKey());
            map.put("invitee", partnerContacter.getTel1());
            map.put("partnerKey", partnerVO.getPartnerKey());
            map.put("inviteType", partnerVO.getPartnerAttr());
            String json = JSON.toJSONString(map);

            String key = CipherUtil.encrypt(json);

            String para = "/invite/com/signUpPage?key=" + key;
            String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
            String codeKey = "j_" + ranCode;
            redisUtil.setIntervalDay(codeKey, para, 30);
            Map mesResult = SMSUtil.sendInviteMsg(company.getComName(), userVo.getRealName(), "jh/" + ranCode + " ", partnerContacter.getTel1());
            //新建一条短信记录
            SmsLog smsLog = new SmsLog();
            //邀请合作伙伴
            smsLog.setSmsType(MessageEnum.SMS_INVITE_PARTNER.getCode());
            //发送者
            smsLog.setSmsFrom(userVo.getComKey());
            //接收者
            smsLog.setSmsTo(partnerContacter.getTel1());
            //短信内容 如果是邀请类型 存放redis中的短连接的KEY
            smsLog.setSmsContent(codeKey);
            //短信返回值
            smsLog.setSmsResult(JSON.toJSONString(mesResult));
            //创建人
            smsLog.setCreator(userVo.getUserKey());
            //创建时间
            smsLog.setCreateTime(new Date());
            smsLogMapper.insert(smsLog);

            //修改状态
            ComPartner comPartner = new ComPartner();
            comPartner.setPartnerKey(partnerVO.getPartnerKey());
            comPartner.setComKey(userVo.getComKey());
            comPartner.setStatus(CompanyEnum.PARTNER_STATUS_INVITING.getCode());
            partnerService.updateByPrimaryKeySelective(comPartner);
            callback.put("state", true);
            callback.put("msg", "操作成功");
            return callback;
        }


    }
}
