package com.ydz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.Message;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.UuidUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by pengxuyang on 16/12/1.
 */
@Controller
@RequestMapping(value = "wx/message",produces = "plain/text; charset=UTF-8")
public class WxMessageController extends BaseController {

    @Resource
    private CommonService commonService;
    @Resource
    private PartnerMapper partnerMapper;
    @Resource
    private PartnerService partnerService;
    @Resource
    private CompanyService companyService;
    @Resource
    private EmployeeService employeeService;
    
    
    @RequestMapping(value = "agree")
    @ResponseBody
    public String agree(String messageId,String partnerLevel) throws Exception {
        Map<String,Object> callBack = new HashMap<>();
        if(partnerLevel == null || "".equals(partnerLevel)){
            callBack.put("status","0");
            callBack.put("msg","请选择合作级别");
            return JSON.toJSONString(callBack);
        }
//        if(partnerType == null || "".equals(partnerType)){
//            callBack.put("status","0");
//            callBack.put("msg","请选择伙伴分类");
//            return JSON.toJSONString(callBack);
//        }
        if(messageId == null || "".equals(messageId)){
            callBack.put("status","0");
            callBack.put("msg","无操作消息");
            return JSON.toJSONString(callBack);
        }
        UserVo userVo = getWxCurrentUserVo();
        Message message = commonService.updateMessageInfoToMarkRead(messageId);
        if(message.getAcceptComKey().equals(userVo.getComKey())){
            //找到双方的合作伙伴关系并完成关联（com_key 和 status）
            //1.查询对方的合作伙伴关系
            PageData pd = new PageData();
            pd.put("myComKey",message.getComKey());
            pd.put("partnerComKey",message.getAcceptComKey());
            PartnerVO partnerFriend = partnerMapper.checkPartner(pd);
            if(partnerFriend == null){
                callBack.put("status","0");
                callBack.put("msg","对方不是您的合作伙伴");
                logger.warn(message.getMsgId()+"该条消息，存在异常，发送方并不是接收方的合作伙伴");
                return JSON.toJSONString(callBack);
            }
            //如果状态不为1
            if(!"1".equals(partnerFriend.getPartnerStatus())){
                ComPartner comPartnerFri = new ComPartner();
                comPartnerFri.setComKey(partnerFriend.getComKey());
                comPartnerFri.setPartnerKey(partnerFriend.getPartnerKey());
                comPartnerFri.setStatus("1");
                partnerService.updateByPrimaryKeySelective(comPartnerFri);
            }

            //2.查询我方的合作伙伴关系
            pd.put("myComKey",message.getAcceptComKey());
            pd.put("partnerComKey",message.getComKey());
            PartnerVO partnerMyself = partnerMapper.checkPartner(pd);

            if(partnerMyself == null){
                Partner partnerAdd = new Partner();
                partnerAdd.setPartnerComKey(message.getComKey());
                partnerAdd.setPartnerLevel(partnerLevel);
                partnerAdd.setPartnerType(CompanyEnum.PARTNER_TYPE_ALL.getCode());
                //查询该公司信息
                Company company = companyService.getCompanyByUserKey(message.getComKey());

                partnerAdd.setPartnerShortname(company.getComShortname());
                partnerAdd.setPartnerName(company.getComName());
                partnerAdd.setPartnerTel(company.getComTel());
                partnerAdd.setPartnerAddress(company.getComAddress());
                partnerAdd.setPartnerAttr(company.getComAttr());
                partnerAdd.setPartnerQQ(company.getComQQ());

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
                partnerService.insertPartner(partnerAdd);


                ComPartner comPartner = new ComPartner();
                comPartner.setComKey(userVo.getComKey());
                comPartner.setPartnerKey(partnerAdd.getPartnerKey());
                comPartner.setStatus("1");
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
                if(partnerAdd.getTel12() != null){
                    PartnerContacter contacter2 = partnerService.fillPartner(partnerAdd,userVo);
                    partnerService.insertOnePartnerContacter(contacter2);
                }

            }
            callBack.put("status","1");
            callBack.put("msg","操作成功");
            return JSON.toJSONString(callBack);
        }else{
            callBack.put("status","0");
            callBack.put("msg","操作错误");
            return JSON.toJSONString(callBack);
        }

    }

    @RequestMapping(value = "callFriend")
    @ResponseBody
    public String callFriend(HttpServletRequest request) throws Exception {
        UserVo userVo = getWxCurrentUserVo();
        PageData pdPara = this.getPageData();
        pdPara.put("userKey", userVo.getUserKey());
        pdPara.put("comKey", userVo.getComKey());
        Page page = new Page();
        page.setCurrentPage(1);
        page.setShowCount(12);
        page.setPd(pdPara);
       return JsonUtil.toCompatibleJSONString(commonService.listPageMsgComVo(page));
    }

}
