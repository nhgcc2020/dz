package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.common.Message;
import com.ydz.entity.init.IndustryInit;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.IndustryComService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.UuidUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * Created by pxy on 2016/6/6.
 */
@Controller
@RequestMapping(value = "company", produces = "plain/text; charset=UTF-8")
public class CompanyController extends BaseController {

    @Resource(name="companyService")
    private CompanyService companyService;
    
    @Resource(name = "industryComService")
    private IndustryComService industryComService;
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    @Resource
    private EmployeeService employeeService;
    
    @Resource
    private PartnerService partnerService;
    
    @Resource
    private RedisUtil redisUtil;


    /**
     * 根据内部邀请码 搜索公司
     * 并且公司类型为"企业"
     * @param insideCode
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "findByCom")
    @ResponseBody
    public String findByCom(String insideCode) throws Exception {
        UserVo userVo = getSessionUservo();
        Company company = null;
        PageData pdPara = new PageData();
        pdPara.put("withinComId", insideCode);
        //类型:公司
        pdPara.put("comType",CompanyEnum.COM_TYPE_ENTERPRISE.getCode());
        //当前公司
        company = companyService.getCompanyByKey(pdPara);
        if (company == null){
            return "0";
        }
        //管理员
        EmployeeVo employeeVo = employeeService.getAdmin(company.getComKey());
        if(employeeVo != null){
            company.setAdminName(employeeVo.getUserName());
            company.setAdminPhone(employeeVo.getUserPhone());
        }
        //查看当前用户是否已经加入过该
        Employee employee =  employeeService.getEmployeeByDoubleKey(userVo.getUserKey(),company.getComKey(),null);
        if(employee == null){
            company.setEmpStatus("0");
        }else{
            company.setEmpStatus(employee.getStatus());
        }

        return JSON.toJSONString(company);

    }
    /**
     * 申请加入公司
     * @param comKey
     * @param comName
     * @return
     */
    @RequestMapping(value = "applyCom")
    @ResponseBody
    public String applyCom(String comKey,String comName) throws Exception {
        if(comKey == null || comName == null ){
            return "0";
        }
        UserVo user = getSessionUservo();
        //如果我已经成为该公司员工，不能进行申请操作
        Employee employee = employeeService.getEmployeeByDoubleKey(user.getUserKey(),comKey,null);
        if(employee != null){
            return "0";
        }
        Company company = companyService.getCompanyByUserKey(comKey);
        //创建该公司员工
        Employee employeeAdd = new Employee();
        employeeAdd.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10));
        employeeAdd.setComKey(comKey);
        employeeAdd.setUserId(user.getUserId());
        employeeAdd.setRealName(user.getRealName());
        employeeAdd.setUserKey(user.getUserKey());
        //待审核
        employeeAdd.setStatus(CompanyEnum.EMPLOYEE_STATUS_PENDING_CHECK.getCode());
        employeeAdd.setIsValid("1");
        employeeAdd.setCreator(user.getUserKey());
        employeeAdd.setCreateTime(new Date());
        
//        employeeAdd.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+company.getIndustryId()));
        employeeAdd.setMenuId("1-00");
        employeeAdd.setPermissionCode("");
        employeeService.saveEmpBySignIn(employeeAdd);

        Message message = new Message();
        message.setMsgId(UuidUtil.get32UUID());
        message.setMsgTitle("申请加入公司");
        //message.setComKey(comKey);
        message.setMsgContent(user.getRealName()+"申请加入公司:"+comName);
        message.setSendKey(user.getUserKey());
        message.setSendName(user.getRealName());
        message.setSendTime(new Date());

        message.setAcceptComKey(comKey);
        try {
            EmployeeVo employeeVo = employeeService.getAdmin(comKey);
            message.setAcceptUserKey(employeeVo.getUserKey());
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
        message.setStatus("0");
        //申请加入
        message.setType("07");
        message.setIsDel("0");
        message.setCreator(user.getUserKey());
        message.setCreateTime(new Date());
        //未操作 (当用户点击接受或拒绝时)
        message.setFriendStatus("0");
        //消息类型 为公司。1个人 2公司
        message.setMsgAttr("2");
        Integer result = commonService.insertSelective(message);
        return String.valueOf(result);
    }

    /**
     * 设置个人企业的 有效字段为"1"
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "openPerson")
    @ResponseBody
    public String openPerson(HttpServletRequest request) throws Exception {
        UserVo userVo = getSessionUservo();
        String comKey = this.getPageData().getString("userKey_person");
        String comType = this.getPageData().getString("comType");
        
        if(StringUtil.isNotEmpty(comType)){
        	if(StringUtil.isEmpty(comKey)){
        		return "0";
        	}
        }else{
        	comKey = userVo.getDefaultCom();
        }
        		
        PageData pageData = new PageData();
        pageData.put("comKey",comKey);
        Company company = companyService.getCompanyByKey(pageData);
        if ("1".equals(company.getIsValid())){
            return "0";
        }
        Company companyMod = new Company();
        companyMod.setComKey(comKey);
        companyMod.setIsValid("1");
        companyService.updateCompany(companyMod);

        userVo.setComIsvalid("1");
        getShiroSession().setAttribute(Const.SESSION_USER,userVo);
        return "1";
    }

    /**
     * 获取公司头像
     * @param request
     * @param response
     */
    @RequestMapping(value = "com-avatar")
    public void getCompanyAvatar(HttpServletRequest request, HttpServletResponse response) {
        UserVo userVo = getSessionUservo();

        Company company = null;
        try {
            //获取公司Logo信息
            company = companyService.getComLogoByKey(userVo.getComKey());
        } catch (Exception e) {
            e.printStackTrace();
        }

        String comLogo = company.getComLogoPath();

        //有头像的则把头像转化为流输出
        if(null != comLogo && !"".equals(comLogo)){
            //先把字符串转为流
            Base64 decoder = new Base64();
            // Base64解码
            try {
                byte[] b = decoder.decode(comLogo);
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
//            logger.warn("暂无公司Logo");
        }
    }

    /**
     * 获取公司头像
     * @param request
     * @param response
     */
    @RequestMapping(value = "other-com-avatar")
    public void getOtherUserAvatar(HttpServletRequest request,String comKey,HttpServletResponse response) {
        Company company = null;
        try {
            //获取公司Logo信息
            company = companyService.getComLogoByKey(comKey);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String comLogo = company.getComLogoPath();

        //有头像的则把头像转化为流输出
        if(null != comLogo && !"".equals(comLogo)){
            //先把字符串转为流
            Base64 decoder = new Base64();
            // Base64解码
            try {
                byte[] b = decoder.decode(comLogo);
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
//            logger.warn("暂无公司Logo");
        }
    }

    @RequestMapping("single-info")
    @ResponseBody
    public String getCompany(){
        UserVo userVo = getSessionUservo();
        
        Company company = null;
        try {
            company = companyService.getCompanyByUserKey(userVo.getComKey());
            company.setIndustryValue(CompanyEnum.codeOf(company.getIndustryId()).getDesc());
            company.setCreateTime(null);
            company.setCreator(null);
            company.setUid(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonUtil.toJsonString(company);
    }


    @RequestMapping(value = "modCompany")
    @ResponseBody
    public String modCompany(Company company){
        try {
            company.setComId(null);
            company.setWithinComId(null);
            int result = companyService.updateCompany(company);
            if (result>0) {
				UserVo userVo = this.getSessionUservo();
				userVo.setComName(company.getComName());
				userVo.setComShortname(company.getComShortname());
				userVo.setComType(company.getComType());
				getShiroSession().setAttribute(Const.SESSION_USER, userVo); //信息写回session
			}
            return  String.valueOf(result);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @RequestMapping("saveMIndus")
    @ResponseBody
    public String savelMndustry(HttpServletRequest request,String mId) {

        UserVo userVo = getSessionUservo();
        String comKey = userVo.getComKey();
        try {
            IndustryCom industryCom = industryComService.getByComKey(userVo.getComKey());
            if(mId == null || industryCom == null){

                return "fail";
            }
            if(industryCom.getIndustryId().equals(mId)){

                return "1";
            }else{
                //todo 删除原来的大行业

                IndustryInit init = industryComService.selectByIndId(mId);
                //然后把用户选择的大行业 插入到公司行业表中表中
                IndustryCom com  = new IndustryCom();
                //装填开始
                com.setIndustryId(init.getIndustryId());
                com.setIndustryName(init.getIndustryName());
                com.setIndustryDesc(init.getIndustryDesc());
                com.setpIndustryId(init.getpIndustryId());
                com.setSortItem(init.getSortItem());
                com.setIsValid(init.getIsValid());

                com.setCreateTime(new Date());
                //数据库有默认字段
                com.setIsCheck("1");
                com.setComId(userVo.getComKey());
                int res =  industryComService.saveIndustryCom(com);
                return String.valueOf(res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    //跳转选择小行业
    @RequestMapping("detail-industry")
    public ModelAndView sIndustry(HttpServletRequest request){
        //根据用户所选的大行业 获取父级是大行业的小行业类别 并且获取该类别下的具体小行业
        List<IndustryInit> industries = null;
        UserVo operator = getSessionUservo();
        try {

            //IndustryCom industryCom = industryComService.getByComKey(operator.getComKey());
            industries = industryComService.selectIndusByID("1");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("jsp/company/detail-industry").addObject("industrys",industries);
    }

    //保存小行业
    @RequestMapping(value = "saveSIndus")
    @ResponseBody
    public String saveSIndus(String ids,HttpServletRequest request){
        UserVo operator = getSessionUservo();
        String res = "0";
        try {
            industryComService.modSIndus(ids,operator);
            res = "1";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    @RequestMapping(value = "allCompany")
    @ResponseBody
    public String getAllCompany(HttpServletRequest request){
        UserVo userVo = getSessionUservo();
        try {
            List<Company> companies = companyService.getByEmpUserKey(userVo);
            return JSON.toJSONString(companies);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
//==============================================================新版服务定价接口==============================================================
//2017-07-13 17:33:44 修改服务定价改为2级
    /**
     * 
     * @Title: listComProductPrice 
     * @param tier
     * @return
     * @return String
     * @throws Exception 
     * @throws 
     * @Description: 查询服务定价，传递级别参数，2的时候表示检索第2级
     */
    @RequestMapping(value = "listComProPrice", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listComProductPrice(String pCode,String tier,String searchKey) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	List<ComProPrice> comProPriceList = null;
    	
    	String industryId = userVo.getDetailIndustryId();
    	String comKey = userVo.getComKey();
    	String pricingType = CompanyEnum.PRICING_TYPE_SERVICE.getCode();
    	if (StringUtil.isEmpty(pCode)) {
			pCode = "0";
		}
    	if(StringUtil.isEmpty(tier)){
    		comProPriceList = companyService.listComProPrice(industryId, comKey, pricingType, pCode,null,null);
    	}else if("2".equalsIgnoreCase(tier)){
    		comProPriceList = companyService.listComProPriceAndPriceLevel(industryId, comKey, pricingType, pCode, searchKey, "2",null);
    	}
    	
    	return JsonUtil.toCompatibleJSONString(comProPriceList);
    }
    
    /**
     * 
     * @Title: insertNewComProPrice 
     * @param comProPrice
     * @return
     * @return String
     * @throws 
     * @Description: 新建公司的服务定价
     */
    @RequestMapping(value = "insertNewComProPrice")
    @ResponseBody
    public String insertNewComProPrice(ComProPrice comProPrice){
    	UserVo userVo = this.getSessionUservo();
    	Map<String, Object> callback = new HashMap<String, Object>();
    	try {
			if(comProPrice==null){
				callback.put("status", "0");
				callback.put("msg", "保存失败");
				return JsonUtil.toCompatibleJSONString(callback);
			}
			int tier = comProPrice.getTier();
			comProPrice.setComKey(userVo.getComKey());
			comProPrice.setCreateTime(new Date());
			comProPrice.setCreateType("1");
			comProPrice.setIndustryId(userVo.getDetailIndustryId());
			comProPrice.setPricingType("1");
			if (StringUtil.isEmpty(comProPrice.getIsChecked())) {
				comProPrice.setIsChecked("1");
			}
//			comProPrice.setIsChecked("1");
			if(StringUtil.isEmpty(comProPrice.getpCode())){
				comProPrice.setpCode("0");
			}
			comProPrice.setCategoryId(companyService.getNewCategoryIdByMax(comProPrice.getComKey(), comProPrice.getpCode(),
					comProPrice.getIndustryId(), comProPrice.getPricingType(), null)); //新服务定价的categoryId
			int sortItem = new Integer(comProPrice.getCategoryId()
					.substring(comProPrice.getCategoryId().length()-2,comProPrice.getCategoryId().length()));
			comProPrice.setSortItem(new Integer(sortItem).byteValue());
			companyService.insertNewComProPrice(comProPrice, tier);
			
			callback.put("status", "1");
			callback.put("msg", "保存成功");
		} catch (Exception e) {
			callback.put("status", "0");
			callback.put("msg", "保存失败");
			e.printStackTrace();
		}
    	return JsonUtil.toCompatibleJSONString(callback);
    }
    
    /**
     * 
     * @Title: updateComProPrice 
     * @param comProPrice
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 修改公司服务定价
     */
    @RequestMapping(value = "updateComProPrice", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String updateComProPrice(ComProPrice comProPrice) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	comProPrice.setComKey(userVo.getComKey());
    	comProPrice.setIndustryId(userVo.getDetailIndustryId());
    	Map<String, Object> callback = new HashMap<String, Object>();
    	int result = companyService.updateComProPrice(comProPrice);
    	if(result>0){
    		callback.put("status", "1");
			callback.put("msg", "修改成功");
    	}else {
    		callback.put("status", "0");
			callback.put("msg", "保存失败");
		}
    	return JsonUtil.toCompatibleJSONString(callback);
    }
    
    /**
     * 
     * @Title: addListComPartnerProPrice 
     * @param partnerKey
     * @return
     * @return String
     * @throws 
     * @Description: 为公司的客户初始化创建专有价格
     */
    @RequestMapping(value = "addListComPartnerProPrice", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String addListComPartnerProPrice(){
    	Map<String, Object> callback = new HashMap<String, Object>();
    	PageData pd = this.getPageData();
    	if(StringUtil.isEmpty(pd.getString("partnerKey"))){
    		callback.put("status", "0");
			callback.put("msg", "保存失败");
			return JsonUtil.toCompatibleJSONString(callback);
    	}
    	UserVo userVo = this.getSessionUservo();
    	String industryId = userVo.getDetailIndustryId();
    	String comKey = userVo.getComKey();
    	
    	//查询该客户的合作级别用于获取默认配置的价格
    	pd.put("comKey", comKey);
    	PartnerVO partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
    	//初始化时，只进行第2级的处理，需要查询公司已经存在第2级服务定价
		List<ComProPrice> comProPriceList = companyService
				.listComProPriceAndPriceLevel(industryId, comKey,
						CompanyEnum.PRICING_TYPE_SERVICE.getCode(), null, null,
						"2", partnerVO.getPartnerLevel());
    	if (comProPriceList==null||comProPriceList.size()==0) {
    		callback.put("status", "0");
			callback.put("msg", "保存失败");
			return JsonUtil.toCompatibleJSONString(callback);
		}
    	
    	List<ComPartnerProPrice> comPartnerProPrices = new ArrayList<ComPartnerProPrice>();
    	ComPartnerProPrice cppp = null;
    	for (ComProPrice comProPrice : comProPriceList) {
			cppp = new ComPartnerProPrice();
			cppp.setComKey(comKey);
			cppp.setPartnerKey(pd.getString("partnerKey"));
			cppp.setCategoryId(comProPrice.getCategoryId());
			cppp.setPricingType(CompanyEnum.PRICING_TYPE_SERVICE.getCode());
			cppp.setIsChecked("1");
			cppp.setCreateTime(new Date());
			cppp.setPartnerLevel(partnerVO.getPartnerLevel());
			if(CompanyEnum.PARTNER_LEVEL_VIP.getCode().equalsIgnoreCase(partnerVO.getPartnerLevel())) {
	    		cppp.setUnitPrice(comProPrice.getPrice1());
			} else if (CompanyEnum.PARTNER_LEVEL_GENERAL.getCode().equalsIgnoreCase(partnerVO.getPartnerLevel())) {
				cppp.setUnitPrice(comProPrice.getPrice2());
			} else if (CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getCode().equalsIgnoreCase(partnerVO.getPartnerLevel())) {
				cppp.setUnitPrice(comProPrice.getPrice3());
			}
    		comPartnerProPrices.add(cppp);
		}
    	int result = companyService.insertComPartnerProPrice(comPartnerProPrices);
    	if(result>0){
    		callback.put("status", "1");
			callback.put("msg", "保存成功");
    	}else {
    		callback.put("status", "0");
			callback.put("msg", "保存失败");
		}
    	return JsonUtil.toCompatibleJSONString(callback);
    }
    
    /**
     * 
     * @Title: updateComPartnerProPrice 
     * @param comPartnerProPrice
     * @return
     * @return String
     * @throws 
     * @Description: 修改专有客户服务定价信息
     */
    @RequestMapping(value = "updateComPartnerProPrice", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String updateComPartnerProPrice(ComPartnerProPrice comPartnerProPrice){
    	Map<String, Object> callback = new HashMap<String, Object>();
    	if(comPartnerProPrice==null
    			||StringUtil.isEmpty(comPartnerProPrice.getCategoryId())){
    		callback.put("status", "0");
			callback.put("msg", "修改失败");
			return JsonUtil.toCompatibleJSONString(callback);
    	}
    	UserVo userVo = this.getSessionUservo();
    	comPartnerProPrice.setComKey(userVo.getComKey());
    	int result = companyService.updateComPartnerProPrice(comPartnerProPrice);
    	if(result>0){
    		callback.put("status", "1");
			callback.put("msg", "修改成功");
			companyService.clearRedisComProPrice(userVo.getComKey(), comPartnerProPrice.getPartnerKey());
    	}else {
    		callback.put("status", "0");
			callback.put("msg", "修改失败");
		}
    	return JsonUtil.toCompatibleJSONString(callback);
    	
    }
    
    /**
     * 
     * @Title: listComPartnerWithProPrice 
     * @return
     * @return String
     * @throws 
     * @Description: 获取公司的专有客户服务定价中的所有专有客户列表，结果去重，按新建顺序
     */
    @RequestMapping(value = "listComPartnerWithProPrice", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listComPartnerWithProPrice(){
    	UserVo userVo = this.getSessionUservo();
    	return JSONArray.toJSONString(companyService.selectComParnter(userVo.getComKey(),null));
    }
    
    /**
     * 
     * @Title: listComCustomers 
     * @return
     * @return String
     * @throws 
     * @Description: 获取公司的客户列表用于设置专有服务定价
     */
    @RequestMapping(value = "listComCustomers", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listComCustomers(){
    	UserVo userVo = getSessionUservo();
        PageData pageData = this.getPageData();
        pageData.put("comKey", userVo.getComKey());
        pageData.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode()); //客户
        pageData.put("notFriend",null);
        try {
            List<PartnerVO> partnerVOs = partnerService.partnerVOList(pageData);
            Iterator<PartnerVO> it = partnerVOs.iterator();
            while (it.hasNext()) {
				PartnerVO partnerVO = (PartnerVO) it.next();
				if ("temp-customer".equalsIgnoreCase(partnerVO.getPartnerKey())) {
					it.remove();
				}
			}
            return JSONArray.toJSONString(partnerVOs);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }
    
    /**
     * 
     * @Title: listComPartnerProPriceLevel 
     * @param pCode
     * @param partnerKey
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 根据上级代码和客户key查询对应的专有客户第三级服务定价列表，包括参考价
     */
    @RequestMapping(value = "listComPartnerProPriceLevel", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listComPartnerProPriceLevel(String pCode,String partnerKey,String searchKey) throws Exception{
    	if(StringUtil.isEmpty(pCode)||StringUtil.isEmpty(partnerKey)){
    		return null;
    	}
    	UserVo userVo = getSessionUservo();
        String industryId = userVo.getDetailIndustryId();
        String comKey = userVo.getComKey();
        String pricingType = CompanyEnum.PRICING_TYPE_SERVICE.getCode();
    	return JsonUtil.toCompatibleJSONString(companyService.listComPartnerProPriceAndPriceLevel(industryId, comKey, partnerKey, 
    			pCode, searchKey, pricingType));
    }
    
    @RequestMapping(value = "topDropdownComProPrices", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String topDropdownComProPrices(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	String partnerKey = pd.getString("partnerKey");
    	if(StringUtil.isEmpty(partnerKey)){
    		return null;
    	}
    	UserVo userVo = this.getSessionUservo();
    	return JsonUtil.toCompatibleJSONString(companyService.listComProPrice(userVo.getDetailIndustryId(), 
    			userVo.getComKey(), CompanyEnum.PRICING_TYPE_SERVICE.getCode(), "0","1",null));
    }
    
    @RequestMapping(value = "topDropdownComProPricesLevel", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String topDropdownComProPricesLevel(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	String partnerKey = pd.getString("partnerKey");
    	if(StringUtil.isEmpty(partnerKey)){
    		return null;
    	}
    	String searchKey = pd.getString("searchKey");
    	String pCode = pd.getString("pCode");
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
    	PartnerVO partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
    	String priceLevel = partnerVO.getPartnerLevel();
    	List<ComPartnerProPrice> cppps = companyService.selectComParnter(userVo.getComKey(),partnerKey);
    	if (cppps==null
			||cppps.size()==0){
    		partnerKey = null;
		}
    	return JsonUtil.toCompatibleJSONString(companyService.getDropdownComProPricesByDesc
    			(userVo.getComKey(), userVo.getDetailIndustryId(), partnerKey, pCode, priceLevel, searchKey));
    }
    
    
    /**
     * 
     * @Title: dropdownComProPriceByDesc 
     * @param request
     * @return
     * @throws Exception
     * @return String
     * @throws 
     * @Description: 新建及修改订单的快速输入检索下拉框
     */
    @RequestMapping(value = "dropdownComProPriceByDesc", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String dropdownComProPriceByDesc(HttpServletRequest request) throws Exception{
    	PageData pd = this.getPageData();
    	String partnerKey = pd.getString("partnerKey");
    	String searchKey = pd.getString("searchKey");
    	if (StringUtil.isNotEmpty(searchKey)) {
    		searchKey = new String(searchKey.getBytes("iso8859-1"),"utf-8"); 
		}
    	Map<String, Object> result = new HashMap<String, Object>();
    	if(StringUtil.isEmpty(partnerKey)){
    		result.put("suggestions","");
    		return JsonUtil.toCompatibleJSONString(result);
    	}
    	UserVo userVo = this.getSessionUservo();
    	pd.put("comKey", userVo.getComKey());
    	PartnerVO partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
    	if (partnerVO==null) {
    		result.put("suggestions","");
    		return JsonUtil.toCompatibleJSONString(result);
		}
    	String priceLevel = partnerVO.getPartnerLevel();
    	List<ComPartnerProPrice> cppps = companyService.selectComParnter(userVo.getComKey(),partnerKey);
    	if (cppps==null
			||cppps.size()==0){
    		partnerKey = null;
		}
    	result.put("suggestions", companyService.getDropdownComProPricesByDesc(userVo.getComKey(), userVo.getDetailIndustryId(), 
    			partnerKey, null, priceLevel, searchKey));
    	return JsonUtil.toCompatibleJSONString(result);
    }
    
    /**
     * 
     * @Title: deleteComProPrice 
     * @return
     * @return String
     * @throws 
     * @Description: 删除服务定价
     * 1. 删除二级服务定价时，只删除单条记录并删除三条定价级别
     * 2. 删除一级服务目录时，其下的所有二级服务定价及定价级别全删
     * 3. 对应的，删除二级服务定价中所有的客户专有定价
     */
    @RequestMapping(value = "deleteComProPrice")
    @ResponseBody
    public String deleteComProPrice(){
    	int result = 0;
    	PageData pd = this.getPageData();
    	UserVo userVo = this.getSessionUservo();
    	
    	String categoryId = pd.getString("categoryId");
    	String tier = pd.getString("tier");
    	
    	if (StringUtil.isEmpty(categoryId)
			||StringUtil.isEmpty(tier)){
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()), "请选择需要删除的服务定价"));
		}
    	pd.put("comKey", userVo.getComKey());
    	pd.put("industryId", userVo.getDetailIndustryId());
    	pd.put("pricingType", CompanyEnum.PRICING_TYPE_SERVICE.getCode());
    	
    	try {
			result = companyService.deleteComProPriceAndPartner(pd);
		} catch (Exception e) {
			result = 0;
			e.printStackTrace();
		}
    	
    	if (result <= 0) {
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()), "删除失败"));
		}
    	
    	return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除成功"));
    }
    
    @RequestMapping(value = "config/get")
    @ResponseBody
    public String configGet(){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
    	pd.put("comKey", userVo.getComKey());
    	List<ComConfig> comConfigs = commonService.getComConfigs(pd);
    	ResultMap resultMap = ResultUtil.getResultMap();
    	resultMap.setData(comConfigs);
    	return JsonUtil.toCompatibleJSONString(resultMap);
    }
    @RequestMapping(value = "config/update")
    @ResponseBody
    public String configUpdate(){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
    	if (StringUtil.isEmpty(pd.getString("key"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()), "修改失败"));
		}
    	ComConfig comConfig = new ComConfig();
    	comConfig.setComKey(userVo.getComKey());
    	comConfig.setConfigKey(pd.getString("key").toUpperCase());
    	comConfig.setConfigValue(pd.getString("value"));
    	int result = commonService.updateComConfig(comConfig);
    	if(result<1){
    		return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()), "修改失败"));
    	}
    	return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
    }
    
    
}
