package com.ydz.controller.common;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.common.SmsLogMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.dao.system.RoleUserMapper;
import com.ydz.dao.system.UserMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.Message;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.*;
import com.ydz.util.sms.SMSUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;

import org.apache.commons.collections.map.HashedMap;
import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ydz on 2016/6/27.
 */
@Controller
@RequestMapping(value = "common/message", produces = "plain/text; charset=UTF-8")
public class MessageController extends BaseController {


    @Resource(name = "commonService")
    private CommonService commonService;
    @Resource private PartnerService partnerService;
    @Resource private PartnerMapper partnerMapper;
    @Resource private CompanyService companyService;
    @Resource private EmployeeService employeeService;
    @Resource private RoleUserMapper roleUserMapper;
    @Resource private UserMapper userMapper;
    @Resource private SmsLogMapper smsLogMapper;
    /**
     * 获取信息列表
     * @return
     */
    @RequestMapping(value ="messageList")
    @ResponseBody
    public String getMessageList(String parameter){
        UserVo userVo = getSessionUservo();
        Page page  = getPageWithParameter();
		PageData pd = new PageData();
		pd.put("type",parameter);
		pd.put("acceptComKey",userVo.getComKey());
        page.setPd(pd);
        try {
            List<Message> messages = commonService.getMessageList(page);
            if(messages!=null){
	            for(Message message : messages){
	                if(message.getStatus().equals(MessageEnum.MARKREAD.getCode())){
	                    message.setStatus("已读");
	                }else{
	                    message.setStatus("未读");
	                }
	                message.setCreateTimeStr(DateUtil.DateToString(message.getCreateTime(), DateStyle.YYYY_MM_DD_HH_MM_SS));
	            }
            }
            return JSON.toJSONString(messages);
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @RequestMapping(value = "messageListPage")
    public ModelAndView messageListPage(){

        return new ModelAndView("jsp/company/message-list");
    }

    @RequestMapping(value = "messageListPageApply")
    public ModelAndView messageListPageApply(){

        return new ModelAndView("jsp/company/message-detail-apply");
    }


    /**
     * 获取消息详情
     * @param messageId
     * @return
     */
    @RequestMapping(value ="detail")
    public ModelAndView getMessageDetail(String messageId){
        Message message = commonService.updateMessageInfoToMarkRead(messageId);
        ModelAndView mv = null;
        if(MessageEnum.MESSAGE_TYPE_PARTNER_ALERT.getCode().equals(message.getType())){
            mv = new ModelAndView("jsp/company/message-detail-friend");
        }else if(MessageEnum.MESSAGE_TYPE_APPLY_JOIN.getCode().equals(message.getType())){
            mv = new ModelAndView("jsp/company/message-detail-apply");
        }else{
            mv = new ModelAndView("jsp/company/message-detail");

        }
        return mv.addObject("message",JSON.toJSONString(message));
    }


    /**
     * 
     * @Title: agree 
     * @param messageId
     * @param partnerLevel
     * @param partnerType
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 在消息列表中同意申请好友申请操作
     */
    @RequestMapping(value = "agree")
    @ResponseBody
    public String agree(String messageId,String partnerLevel,String partnerType) throws Exception {
        Map<String,Object> callBack = new HashMap<>();
        if(StringUtil.isEmpty(partnerLevel)){
            callBack.put("status","0");
            callBack.put("msg","请选择合作级别");
            return JSON.toJSONString(callBack);
        }
        if(messageId == null || "".equals(messageId)){
            callBack.put("status","0");
            callBack.put("msg","无操作消息");
            return JSON.toJSONString(callBack);
        }
        UserVo userVo = getSessionUservo();
        Message message = commonService.updateMessageInfoToMarkRead(messageId); //改为已读
        if(message.getAcceptComKey().equals(userVo.getComKey())){
            //找到双方的合作伙伴关系并完成关联（com_key 和 status）
            //1.查询对方的合作伙伴关系。
            PageData pd = new PageData();
            pd.put("myComKey",message.getComKey()); //邀请方的comKey
            pd.put("partnerComKey",message.getAcceptComKey()); //被邀请方的comKey
            PartnerVO partnerFriend = partnerMapper.checkPartner(pd); //查询被邀请方是否已经接受邀请并注册公司了
            if(partnerFriend == null){
                callBack.put("status","0");
                callBack.put("msg","操作失败，您目前不是邀请方的合作伙伴");
//                logger.warn(message.getMsgId()+"该条消息，存在异常，目前不是邀请方的合作伙伴");
                return JSON.toJSONString(callBack);
            }
            //如果状态为好友则直接返回并提示
            if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode().equals(partnerFriend.getPartnerStatus())){
                callBack.put("status","0");
                callBack.put("msg","对方已经是您的好友");
                return JSON.toJSONString(callBack);
            }else{
                ComPartner comPartnerFri = new ComPartner();
                comPartnerFri.setComKey(partnerFriend.getComKey());
                comPartnerFri.setPartnerKey(partnerFriend.getPartnerKey());
                //互为好友
                comPartnerFri.setStatus(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode());
                partnerService.updateByPrimaryKeySelective(comPartnerFri);
            }

            //2.查询被邀请方的合作伙伴列表中是否存在邀请方
            pd.put("myComKey",message.getAcceptComKey()); //被邀请方，即消息接收方
            pd.put("partnerComKey",message.getComKey()); //邀请方，即消息发送方
            PartnerVO partnerMyself = partnerMapper.checkPartner(pd);

            if(partnerMyself == null){
                Partner partnerAdd = new Partner();
                partnerAdd.setPartnerComKey(message.getComKey());
                partnerAdd.setPartnerLevel(partnerLevel);

                //查询该公司信息
                Company company = companyService.getCompanyByUserKey(message.getComKey());

                partnerAdd.setPartnerShortname(company.getComShortname().trim());
                partnerAdd.setPartnerName(company.getComName().trim());
                //助记码
                partnerAdd.setMnemonicCode(GetPinyin.getPinYinHeadChar(partnerAdd.getPartnerShortname()));

                partnerAdd.setPartnerTel(company.getComTel());
                partnerAdd.setPartnerAddress(company.getComAddress());
                partnerAdd.setPartnerAttr(company.getComType());
                partnerAdd.setPartnerQQ(company.getComQQ());
                
                partnerAdd.setPartnerProvince(company.getComProvince());
                partnerAdd.setPartnerCity(company.getComCity());
                partnerAdd.setPartnerCountry(company.getComCountry());
                partnerAdd.setPartnerAddress(company.getComAddress());

                EmployeeVo employeeVo1 = employeeService.getAdmin(company.getComKey());
                if(employeeVo1 != null){
                    partnerAdd.setTel11(employeeVo1.getUserPhone());
                    partnerAdd.setContacterName11(employeeVo1.getUserName());
                }

                EmployeeVo employeeVo2 = employeeService.getBoss(company.getComKey());
                if(employeeVo2 != null && !employeeVo2.getUserPhone().equals(employeeVo1.getUserPhone())){
                    partnerAdd.setTel12(employeeVo2.getUserPhone());
                    partnerAdd.setContacterName12(employeeVo2.getUserName());
                }

                partnerAdd.setPartnerKey(UuidUtil.get32UUID());
                partnerAdd.setIsValid("1");
                //合作伙伴的类型 即使客户又是供应商
                partnerAdd.setPartnerType(CompanyEnum.PARTNER_TYPE_ALL.getCode());
                partnerService.insertPartner(partnerAdd);


                ComPartner comPartner = new ComPartner();
                comPartner.setComKey(userVo.getComKey());
                comPartner.setPartnerKey(partnerAdd.getPartnerKey());
                comPartner.setStatus(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode());
                comPartner.setIsValid("1");
                comPartner.setCreateTime(new Date());
                comPartner.setCreator(userVo.getUserKey());
                partnerService.insertComPartner(comPartner);

                //添加联系人一
                if(partnerAdd.getTel11() != null){
                    PartnerContacter contacter1 = partnerService.fillPartner(partnerAdd,userVo);
                    partnerService.insertOnePartnerContacter(contacter1);
                }
                //添加联系人二
//                if(partnerAdd.getTel12() != null){
//                    PartnerContacter contacter2 = partnerService.fillPartner(partnerAdd,userVo);
//                    partnerService.insertPartnerContacter(contacter2);
//                }

            }

            //修改消息
            Message messageMod = new Message();
            messageMod.setMsgId(messageId);
            messageMod.setFriendStatus(MessageEnum.FRIEND_YES.getCode());
            messageMod.setReason("已由\""+userVo.getRealName()+"\"同意");
            commonService.updateByPrimaryKeySelective(messageMod);

            callBack.put("status","1");
            callBack.put("msg","操作成功");
            return JSON.toJSONString(callBack);
        }else{
            callBack.put("status","0");
            callBack.put("msg","操作错误");
            return JSON.toJSONString(callBack);
        }

    }


    @RequestMapping(value = "ignore")
    @ResponseBody
    public String ignore(String messageId){
        UserVo userVo = getSessionUservo();
        Message message = commonService.updateMessageInfoToMarkRead(messageId);
        if(message.getAcceptComKey().equals(userVo.getComKey())){
            if("0".equals(message.getStatus())){
                Message messagePara = new Message();
                messagePara.setMsgId(message.getMsgId());
                messagePara.setStatus("1");
                commonService.updateByPrimaryKeySelective(message);
            }
        }
        return "1";
    }

    @RequestMapping(value = "agreeEmp")
    @ResponseBody
    public String agreeEmp(String deptId,String roleKey,String userKey,String msgId) throws Exception {
        Map<String,Object> callback = new HashMap<>();
        Message message = commonService.selectOneByPrimaryKey(msgId);
        if("1".equals(message.getFriendStatus())){
            callback.put("state","0");
            callback.put("msg","您已操作过该消息");
            return JSON.toJSONString(callback);
        }

        UserVo userVo = getSessionUservo();
        
        PageData pdUser = new PageData();
        pdUser.put("userKey", userKey);
        User userApply = userMapper.selectByKey(pdUser);
        if(userApply == null){
        	 callback.put("state","0");
             callback.put("msg","不存在该申请人用户，请联系管理员");
             return JSON.toJSONString(callback);
        }
        //根据userKey查询当前公司的的改员工
        Employee employee = employeeService.getEmployeeByDoubleKey(userKey,userVo.getComKey(),null);
        Employee employeeMod = new Employee();
        employeeMod.setComKey(employee.getComKey());
        employeeMod.setUserKey(employee.getUserKey());
        employeeMod.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
        employeeMod.setDeptId(deptId);
        employeeMod.setUserId(userApply.getUserId());
        employeeMod.setRealName(userApply.getRealName());
        employeeService.updateEmployee(employeeMod);

        RoleUser roleUser = new RoleUser();
        roleUser.setRoleKey(roleKey);
        roleUser.setUserKey(userKey);
        roleUser.setComKey(employee.getComKey());
        roleUser.setCreator(userVo.getUserKey());
        roleUser.setCreateTime(new Date());
        roleUserMapper.insertSelective(roleUser);

        //修改消息
        Message messageMod = new Message();
        messageMod.setMsgId(msgId);
        messageMod.setFriendStatus("1");
        messageMod.setReason("已由\""+userVo.getRealName()+"\"审批同意");

        //根据userKey查询 手机号。后期可以和员工查询合并
        PageData pageDataUser = new PageData();
        pageDataUser.put("userKey",employee.getUserKey());
        User user = userMapper.selectByKey(pageDataUser);

        Map mesResult = SMSUtil.sendSussessToEmp(userVo.getComName(),user.getUserId());

        //新建一条短信记录
        SmsLog smsLog = new SmsLog();
        
        smsLog.setSmsType(MessageEnum.SMS_INVITE_EMPLOYEE.getCode()); //邀请合作伙伴
        smsLog.setSmsFrom(userVo.getComKey()); //发送者
        smsLog.setSmsTo(employee.getUserId()); //接收者
        smsLog.setSmsContent("RS_SMS_INVITE_EMPLOYEE_SUCCESS"); //短信内容 如果是邀请类型 存放redis中的短连接的KEY
        smsLog.setSmsResult(JSON.toJSONString(mesResult)); //短信返回值
        smsLog.setCreator(userVo.getUserKey()); //创建人
        smsLog.setCreateTime(new Date()); //创建时间
        smsLogMapper.insert(smsLog);

        commonService.updateByPrimaryKeySelective(messageMod);
        callback.put("state","1");
        callback.put("msg","操作成功");
        return JSON.toJSONString(callback);
    }

    @RequestMapping(value = "refuseEmp")
    @ResponseBody
    public String refuseEmp(String userKey,String msgId,String reason) throws Exception {
        UserVo userVo = getSessionUservo();

        Map<String,Object> callback = new HashMap<>();
        Message message = commonService.selectOneByPrimaryKey(msgId);
        if("1".equals(message.getFriendStatus())){
            callback.put("state","0");
            callback.put("msg","您已操作过该消息");
            return JSON.toJSONString(callback);
        }

        //根据userKey查询当前公司的该员工
        Employee employee = employeeService.getEmployeeByDoubleKey(userKey,userVo.getComKey(),null);

        Employee employeeMod = new Employee();
        employeeMod.setComKey(employee.getComKey());
        employeeMod.setUserKey(employee.getUserKey());
        //拒绝
        employeeMod.setStatus(CompanyEnum.EMPLOYEE_STATUS_REFUSED.getCode());
        employeeService.updateEmployee(employeeMod);
        /*
        RoleUser roleUser = new RoleUser();
        roleUser.setRoleKey(roleKey);
        roleUser.setUserKey(userKey);
        roleUser.setComKey(employee.getComKey());
        roleUser.setCreator(userVo.getUserKey());
        roleUser.setCreateTime(new Date());
        roleUserMapper.insertSelective(roleUser);*/
        //修改消息
        Message messageMod = new Message();
        messageMod.setMsgId(msgId);
        messageMod.setFriendStatus("1");
        messageMod.setReason("已由\""+userVo.getRealName()+"\"审批拒绝，原由为:"+reason);
        commonService.updateByPrimaryKeySelective(messageMod);
        //根据userKey查询 手机号。后期可以和员工查询合并
        PageData pageDataUser = new PageData();
        pageDataUser.put("userKey",employee.getUserKey());
        User user = userMapper.selectByKey(pageDataUser);
        Map mesResult = SMSUtil.sendFailToEmp(userVo.getComName(),user.getUserId());

        //新建一条短信记录
        SmsLog smsLog = new SmsLog();
        //
        smsLog.setSmsType(MessageEnum.SMS_INVITE_EMPLOYEE.getCode());
        //发送者
        smsLog.setSmsFrom(userVo.getComKey());
        //接收者
        smsLog.setSmsTo(employee.getUserId());
        //短信内容 如果是邀请类型 存放redis中的短连接的KEY
        smsLog.setSmsContent("RS_SMS_INVITE_EMPLOYEE_FAIL");
        //短信返回值
        smsLog.setSmsResult(JSON.toJSONString(mesResult));
        //创建人
        smsLog.setCreator(userVo.getUserKey());
        //创建时间
        smsLog.setCreateTime(new Date());
        smsLogMapper.insert(smsLog);

        callback.put("state","1");
        callback.put("msg","操作成功");
        return JSON.toJSONString(callback);
    }
}
