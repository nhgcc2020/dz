package com.ydz.app.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.ComPartner;
import com.ydz.entity.system.ComPartnerConsumeLog;
import com.ydz.entity.system.ComPartnerRechargeLog;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.service.system.UserService;
import com.ydz.util.ChangeCharset;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppPartnerController 
 * @Description: app的合作伙伴控制器，包括客户和供应商
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:53:45 
 * 
 */
@RestController
@RequestMapping(value = "app/partner", produces = "application/json;charset=UTF-8")
public class AppPartnerController extends BaseController{
	
    @Resource private CompanyService companyService;
    @Resource private PartnerService partnerService;
    @Resource private UserService userService;
    @Resource private RedisUtil redisUtil;
    @Resource private CommonService commonService;

	 /**
     * @return String
	 * @throws Exception 
     * @throws
     * @Title: customerList
     * @Description: 查询我的客户列表
     */
    @RequestMapping(value = "customerList",method = RequestMethod.POST)
    public String customerList(HttpServletRequest request) throws Exception {
    	UserVo userVo = this.getAppCurrentUserVo();
        PageData pageData = this.getPageData();
        String searchKey = pageData.getString("searchKey");
        if (StringUtil.isNotEmpty(searchKey)) {
			pageData.put("searchKey", java.net.URLDecoder.decode(searchKey,ChangeCharset.UTF_8));
		}
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode());
        String partnerStatus = pageData.getString("partnerStatus"); 
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(1000);
            page.setPd(pageData);
            if (StringUtil.isEmpty(partnerStatus)) {
            	pageData.put("partnerStatus", null);
			}
            if ("-1".equals(pageData)) {
                pageData.remove("partnerStatus");
                pageData.put("notFriend", "true");
            }
            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,true);
            return JsonUtil.toCompatibleJSONString(partnerVOs);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "查询失败"));
        }
    }

    /**
     * @return String
     * @throws Exception 
     * @throws
     * @Title: supplierList
     * @Description: 查询我的供应商列表
     */
    @RequestMapping(value = "supplierList",method = RequestMethod.POST)
    public String supplierList(HttpServletRequest request) throws Exception {
    	UserVo userVo = this.getAppCurrentUserVo();
        PageData pageData = this.getPageData();
        String searchKey = pageData.getString("searchKey");
        if (StringUtil.isNotEmpty(searchKey)) {
        	pageData.put("searchKey", java.net.URLDecoder.decode(searchKey,ChangeCharset.UTF_8));
		}
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode());
        String partnerStatus = pageData.getString("partnerStatus"); 
        try {
            Page page = new Page();
            page.setCurrentPage(1);
            page.setShowCount(1000);
            page.setPd(pageData);
            if (StringUtil.isEmpty(partnerStatus)) {
				pageData.put("partnerStatus", null);
			}
            if ("-1".equals(partnerStatus)) {
                pageData.remove("partnerStatus");
                pageData.put("notFriend", "true");
            }

            List<PartnerVO> partnerVOs = partnerService.parsePartnerVO(page,true);
            return JsonUtil.toCompatibleJSONString(partnerVOs);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "查询失败"));
        }
    }
    
    @RequestMapping(value = "updatePartner",method = RequestMethod.POST)
    public String updatePartner(@RequestBody PartnerVO partnerVO){
        UserVo userVo = this.getAppCurrentUserVo();
        partnerService.updateComPartnerAndContact(partnerVO, userVo.getComKey());
        return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
    }
    
    @RequestMapping(value = "sendInviteCompanyByApp",method = RequestMethod.POST)
    public String sendInviteCompany() throws Exception{
    	UserVo userVo = this.getAppCurrentUserVo();
    	PageData pd = this.getPageData();
    	String partnerKey = pd.getString("partnerKey");
    	String phone = pd.getString("phone");
        if (StringUtil.isEmpty(partnerKey)) {
            return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "参数错误"));
            
        }
        if(StringUtil.isEmpty(phone)){
            return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "请填写正确手机号"));
        }

        pd.put("myComKey", userVo.getComKey());
        pd.put("partnerKey", partnerKey);
        PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd);
        
        //1.判断有没有注册
        List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pd);
        PartnerContacter partnerContacter = partnerContacters.get(0);

        //判断手机号是否进行进行了修改
        if(!partnerContacter.getTel1().equals(phone.trim())){
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
        if (user != null) {
            return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "用户已注册"));
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
            String json = JsonUtil.toCompatibleJSONString(map);

            String key = CipherUtil.encrypt(json);

            String para = "/invite/com/signUpPage?key=" + key;
            String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
            String codeKey = "j_" + ranCode;
            redisUtil.setIntervalDay(codeKey, para, 30);
            
            Map<String, Object> mesResult = null;
            //判断合作伙伴是1公司/2个人
            if(CompanyEnum.PARTNER_ATTR_COMPANY.getCode().equals(partnerVO.getPartnerAttr())){
            	SMSUtil.sendInviteMsg4Com(company.getComName(), userVo.getRealName(), partnerVO.getPartnerName(), "jh/" + ranCode + " ", partnerContacter.getTel1());
            }else{
            	mesResult = SMSUtil.sendInviteMsg(company.getComName(), userVo.getRealName(), "jh/" + ranCode + " ", partnerContacter.getTel1());
            }
            
            SmsLog smsLog = new SmsLog();  //新建一条短信记录
            smsLog.setSmsType(MessageEnum.SMS_INVITE_PARTNER.getCode());  //邀请合作伙伴
            smsLog.setSmsFrom(userVo.getComKey());  //发送者 
            smsLog.setSmsTo(partnerContacter.getTel1()); //接收者
            smsLog.setSmsContent(codeKey); //短信内容 如果是邀请类型 存放redis中的短连接的KEY
            smsLog.setSmsResult(JsonUtil.toCompatibleJSONString(mesResult)); //短信返回值
            smsLog.setCreator(userVo.getUserKey());
            smsLog.setCreateTime(new Date());
            commonService.insertSmsLog(smsLog);

            //修改状态
            ComPartner comPartner = new ComPartner();
            comPartner.setPartnerKey(partnerVO.getPartnerKey());
            comPartner.setComKey(userVo.getComKey());
            comPartner.setStatus(CompanyEnum.PARTNER_STATUS_INVITING.getCode());
            partnerService.updateByPrimaryKeySelective(comPartner);
            
            return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("已发送邀请"));
        }
    	
    }
    
    //=====================================客户充值业务=====================================
    
    @RequestMapping(value = "recharge/customerList",method=RequestMethod.GET)
    public String customerListForRecharge(){
    	UserVo userVo = this.getAppCurrentUserVo();
    	Page page = this.getPageWithParameter();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	pd.put("isRecharge", "1");
    	page.setPd(pd);
    	List<PartnerVO> partnerVOs = partnerService.listPageComPartenrForRecharge(page);
    	return JsonUtil.toJsonString(partnerVOs);
    }
    
    @RequestMapping(value = "recharge/sumTotalVo",method=RequestMethod.GET)
    public String sumChargeTotalVo(){
    	UserVo userVo = this.getAppCurrentUserVo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	OrderTotalVO orderTotalVO = partnerService.selectSumComPartnerRechargeTotalVO(pd);
    	OrderTotalVO consumeOrderTotalVO = partnerService.getSumConsumeLogTotalVO(pd);
    	if(orderTotalVO!=null){
	    	orderTotalVO.setSumConsumeMoney(consumeOrderTotalVO==null?BigDecimal.ZERO:consumeOrderTotalVO.getSumConsumeMoney());
	    	orderTotalVO.setSumBalanceMoney(orderTotalVO.getSumRechargeMoney().add(orderTotalVO.getSumPresentMoney()).subtract(orderTotalVO.getSumConsumeMoney())
	    			.setScale(2, BigDecimal.ROUND_HALF_UP));
    	}
    	return JsonUtil.toJsonString(orderTotalVO);
    }
    
    @RequestMapping(value = "recharge/listrechargelog",method=RequestMethod.GET)
    public String listInRechargeLog(){
    	UserVo userVo = this.getAppCurrentUserVo();
    	Page page = this.getPageWithParameter();
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("partnerKey"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("查询失败"));
		}
    	pd.put("comKey", userVo.getComKey());
    	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
    	page.setPd(pd);
    	List<ComPartnerRechargeLog> rechargeLogs = partnerService.listPageComPartnerRechargeLogs(page);
    	OrderTotalVO orderTotalVO = partnerService.selectSumComPartnerRechargeTotalVO(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setRows(rechargeLogs);
    	resultMap.setPageCount(page.getTotalPage());
    	resultMap.put("bottomInfo", orderTotalVO);
    	return JsonUtil.toJsonString(resultMap);
    }
    
    @RequestMapping(value = "recharge/listconsumelog",method=RequestMethod.GET)
    public String listConsumeLog(){
    	UserVo userVo = this.getAppCurrentUserVo();
    	Page page = this.getPageWithParameter();
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("partnerKey"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("查询失败"));
		}
    	pd.put("comKey", userVo.getComKey());
    	pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
    	page.setPd(pd);
    	List<ComPartnerConsumeLog> consumeLogs = partnerService.listPageComPartnerConsumeLogs(page);
    	OrderTotalVO orderTotalVO = partnerService.getSumConsumeLogTotalVO(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setRows(consumeLogs);
    	resultMap.setPageCount(page.getTotalPage());
    	resultMap.put("bottomInfo", orderTotalVO);
    	return JsonUtil.toJsonString(resultMap);
    }
}
