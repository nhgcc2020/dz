package com.ydz.service.common;

import com.alibaba.fastjson.JSON;
import com.ydz.dao.common.MessageMapper;
import com.ydz.entity.common.Message;
import com.ydz.entity.system.*;
import com.ydz.util.PageData;
import com.ydz.util.UuidUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author pengxuyang@yiduizhang.com 彭旭阳
 * @classame MessageService.java
 * @createTime 2016-09-30 上午9:50
 * @decription 类描述说明
 **/

@Service
public class MessageService {

    @Resource
    private MessageMapper messageMapper;
    @Resource
    CommonService commonService;


    //发送好友邀请
    public String sendFriendApplication(UserVo userVo){
        return "";
    }

    /*public Map saveFriendAdd(UserVo userVo){
        Map<String,Object> map = new HashMap<>();
        Message message = commonService.updateMessageInfo(messageId);


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
                partnerAdd.setPartnerType(partnerType);
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
                    partnerService.insertPartnerContacter(contacter1);
                }
                //添加联系人二
                if(partnerAdd.getTel12() != null){
                    PartnerContacter contacter2 = partnerService.fillPartner(partnerAdd,userVo);
                    partnerService.insertPartnerContacter(contacter2);
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
    }*/
}