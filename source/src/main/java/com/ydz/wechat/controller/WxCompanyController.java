/**
 * 
 */
package com.ydz.wechat.controller;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.ydz.entity.system.Employee;
import com.ydz.vo.EmployeeVo;

import org.apache.commons.codec.binary.Base64;
import org.apache.shiro.session.InvalidSessionException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.system.Company;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.IndustryComService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WxCompanyController 
 * @Description: 微信公司控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年11月16日 下午12:02:13 
 * 
 */

@Controller
@RequestMapping(value = "wx/company",produces = "plain/text; charset=UTF-8")
public class WxCompanyController extends BaseController {
	
	@Resource(name="companyService")
	private CompanyService companyService;

    @Resource(name = "industryComService")
    private IndustryComService industryComService;
    
    @Resource(name="partnerService")
    private PartnerService partnerService;
    @Resource(name="employeeService")
    private EmployeeService employeeService;
	
    @RequestMapping(value = "detail")
    @ResponseBody
    public String getCompanyInfo(){
    	UserVo userVo = this.getWxCurrentUserVo();
//    	userVo = new UserVo();
//    	userVo.setUserKey("d94528a4879e4bc282416e10ddd35d3f");
//    	userVo.setComKey("279e60bbbe1b4c9fa11df4d67dec4178");
    	try {
    		if(userVo == null){
                return "0";
            }
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
            return JsonUtil.toCompatibleJSONString(company);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
    }
    
    /**
     * 
    * @Title: getOwnerCompany 
    * @return
    * @return String
    * @throws 
    * @Description: 查看多家公司信息
     */
    @RequestMapping(value = "companies")
    @ResponseBody
    public String getOwnerCompany(){
    	UserVo userVo = this.getWxCurrentUserVo();
    	try {
    		if(userVo == null){
                return "0";
            }
    		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
    		List<Company> companies = companyService.getByEmpUserKey(userVo);
    		jsonMap.put("companies", companies);
    		jsonMap.put("defaultCom", userVo.getDefaultCom());
    		jsonMap.put("currentCom", userVo.getComKey());
    		return JSONArray.toJSONString(jsonMap);
    	}catch(Exception ex){
    		ex.printStackTrace();
    		return "0";
    	}
    }
    
    /**
     * 
    * @Title: changeCurCompany 
    * @param request
    * @return void
    * @throws 
    * @Description: 切换当前公司
     */
    @RequestMapping(value = "changeCurrentCompany")
    @ResponseBody
    public void changeCurCompany(HttpServletRequest request){
    	try {
			PageData pdPara = this.getPageData();
			UserVo userVo = this.getWxCurrentUserVo();
			Company company = companyService.getCompanyByKey(pdPara);
			userVo.setComId(company.getComId());
			userVo.setComKey(pdPara.getString("comKey"));
			userVo.setComName(company.getComName());
			userVo.setDetailIndustryId(company.getIndustryId());
			userVo.setComLogoPath(company.getComLogoPath());
			userVo.setComShortname(company.getComShortname());
			this.getCurrentSession().setAttribute(Const.SESSION_WECHAT,userVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    
    /**
     * 
    * @Title: getPartnerInfo 
    * @param request partnerType
    * @return
    * @return String
    * @throws 
    * @Description: 获取公司的合作伙伴 1 客户 2供应商 A客户&供应商
    * 
     */
    @RequestMapping(value = "partnerList")
    public String getPartnerList(HttpServletRequest request){
    	PageData pdData = this.getPageData();
    	UserVo userVo = this.getWxCurrentUserVo();
    	if(userVo==null){
    		return "0";
    	}
    	try {
			pdData.put("comKey", userVo.getComKey());
			Page page = this.getPage();
			page.setPd(pdData);
			return JsonUtil.toCompatibleJSONString(partnerService.findListPartnerVO(page));
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
    	
    }

    @RequestMapping(value = "myEmpList")
	@ResponseBody
    public String employeeList()throws Exception{
		UserVo userVo = getWxCurrentUserVo();
		PageData pd = new PageData();
		pd.put("comKey",userVo.getComKey());
		pd.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
		List<EmployeeVo> employeeVos = employeeService.getAllEmployee(pd);
		return JsonUtil.toCompatibleJSONString(employeeVos);
	}

}
