package com.ydz.app.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.ydz.app.service.SecurityService;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.system.Company;
import com.ydz.enums.SystemEnum;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.IndustryComService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppCompanyController 
 * @Description: app的公司控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月9日 下午4:54:05 
 * 
 */
@RestController
@RequestMapping(value = "app/company", produces = "application/json;charset=UTF-8")
public class AppCompanyController extends BaseController{
	
	@Resource
	private SecurityService securityService;
	
	@Resource(name="companyService")
	private CompanyService companyService;

    @Resource(name = "industryComService")
    private IndustryComService industryComService;
    
    @Resource(name="partnerService")
    private PartnerService partnerService;
    
    @Resource(name="employeeService")
    private EmployeeService employeeService;
	
    @RequestMapping(value = "detail",method = RequestMethod.GET)
    public String getCompanyInfo(HttpServletRequest request){
		UserVo userVo = this.getAppCurrentUserVo();
		if (userVo==null) {
			return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR_VERIFY.getCode()).intValue(), "验证失败"));
		}
		
    	try {
    		Company company = companyService.getCompanyByUserKey(userVo.getComKey());
    		if(company!=null){
    			String industryValue = industryComService.selectByIndId(company.getIndustryId())==null?"通用行业"
    					:industryComService.selectByIndId(company.getIndustryId()).getIndustryName();
	            company.setIndustryValue(industryValue);
	            if(StringUtil.isNotEmpty(company.getAreaCode())){
	            	company.setComTel(company.getAreaCode()+"-"+company.getComTel());
	            }
	            company.setCreateTime(null);
	            company.setCreator(null);
    		}
            return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(company));
		} catch (Exception e) {
			e.printStackTrace();
			return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "查询失败"));
		}
    }
    
    /**
     * 
    * @Title: getOwnerCompanys 
    * @return
    * @return String
    * @throws 
    * @Description: 查看多家公司信息
     */
    @RequestMapping(value = "companies",method = RequestMethod.GET)
    public String getMyCompanys(HttpServletRequest request){
    	UserVo userVo = this.getAppCurrentUserVo();
    	try {
    		List<Company> companies = companyService.getByEmpUserKey(userVo);
    		ResultMap resultMap = ResultUtil.getResultMap();
    		resultMap.setData(companies);
    		resultMap.put("defaultCom", userVo.getDefaultCom());
    		resultMap.put("currentCom", userVo.getComKey());
    		return JsonUtil.toCompatibleJSONString(resultMap);
    	}catch(Exception ex){
    		ex.printStackTrace();
    		return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "查询失败"));
    	}
    }
    
    /**
     * 
    * @Title: changeCurCompany 
    * @param request
    * @return void
     * @throws Exception 
    * @throws 
    * @Description: 切换当前公司
     */
    @RequestMapping(value = "changeCurrentCompany", method = RequestMethod.POST)
    public String changeCurCompany(HttpServletRequest request) throws Exception{
    	UserVo userVo = this.getAppCurrentUserVo();
    	PageData pdPara = this.getPageData();
		Company company = companyService.getCompanyByKey(pdPara);
		userVo.setComId(company.getComId());
		userVo.setComKey(pdPara.getString("comKey"));
		userVo.setComName(company.getComName());
		userVo.setDetailIndustryId(company.getIndustryId());
		userVo.setComLogoPath(company.getComLogoPath());
		userVo.setComShortname(company.getComShortname());
		String tokenString = securityService.setUserVoToToken(userVo);
		if (StringUtil.isEmpty(tokenString)) {
			return JSONArray.toJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "切换失败"));
		}
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setToken(tokenString);
		resultMap.setMsg("切换成功");
		return JsonUtil.toCompatibleJSONString(resultMap);
    }
}
