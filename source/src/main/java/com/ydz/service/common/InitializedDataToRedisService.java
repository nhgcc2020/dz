package com.ydz.service.common;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.entity.common.City;
import com.ydz.entity.common.Country;
import com.ydz.entity.common.Province;
import com.ydz.entity.init.DepartmentInit;
import com.ydz.entity.init.RoleInit;
import com.ydz.entity.system.ComPartner;
import com.ydz.entity.system.ComPartnerProPrice;
import com.ydz.entity.system.ComProPriceVO;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Role;
import com.ydz.enums.CompanyEnum;
import com.ydz.job.InitDataJob;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.DepartmentService;
import com.ydz.service.system.MenuService;
import com.ydz.service.system.PartnerService;
import com.ydz.service.system.RoleService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.redis.RedisUtil;

/** 
 * @ClassName: InitializedDataService
 * @Description: 初始化新建公司的数据
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月26日 下午3:39:33 
 * 
 */
@Service("initializedDataToRedisService" )
public class InitializedDataToRedisService {
	
	//广告业
	private String[] industryId_1 = {"1A","1B","1C","1D"};
	
	Logger logger = Logger.getLogger(InitDataJob.class);
	
	@Resource(name = "redisUtil")
	RedisUtil redisUtil;
	
	@Resource(name = "commonService")
	CommonService commonService;
	
	@Resource(name = "companyService")
	CompanyService companyService;
	
	@Resource(name = "departmentService")
	DepartmentService departmentService;
	
	@Resource(name = "roleService")
	RoleService roleService;
	
	@Resource(name = "menuService")
	MenuService menuService;
	
	@Resource(name="partnerService")
	PartnerService partnerService;
	
	
	public void insertInitRoleToRedis() throws Exception{
//		logger.info("开始初始化角色......");
		for(int i=0;i<industryId_1.length;i++){
			PageData pd = new PageData();
			pd.put("industryId", industryId_1[i]);
			List<RoleInit> roleInits = roleService.listAllRoleInitByIndustryId(pd);
			redisUtil.set(Const.REDIS_INIT_ROLE+industryId_1[i], roleInits);
		}
		logger.info("完成初始化角色......");
	}
	
	public void insertInitDeptToRedis() throws Exception{
//		logger.info("开始初始化部门......");
		for(int i=0;i<industryId_1.length;i++){
			PageData pd = new PageData();
			pd.put("industryId", industryId_1[i]);
			List<DepartmentInit> deptInits = departmentService.getDepartmentInits(pd);
			redisUtil.set(Const.REDIS_INIT_DEPT+industryId_1[i], deptInits);
		}
		logger.info("完成初始化部门......");
	}
	
	
	public void clearAllRoleMenu() throws Exception{
//		logger.info("开始清除公司的角色菜单数据......");
		List<Company> companies = companyService.listAllCompanies();
		for (Company company : companies) {
			List<Role> roles = roleService.listRolesByCom(company.getComKey());
			if(roles!=null&&roles.size()>0){
				//清空管理员的角色菜单
				redisUtil.set(Const.REDIS_ROLE_MENU_V+"ADMIN_"+company.getComKey(), null);
				redisUtil.set(Const.REDIS_ROLE_MENU_P+"ADMIN_"+company.getComKey(), null);
				//清空法人的角色菜单
				redisUtil.set(Const.REDIS_ROLE_MENU_V+"001_"+company.getComKey(), null);
				redisUtil.set(Const.REDIS_ROLE_MENU_P+"001_"+company.getComKey(), null);
				for (Role role : roles) {
					redisUtil.set(Const.REDIS_ROLE_MENU_V+role.getRoleKey()+"_"+company.getComKey(), null);
					redisUtil.set(Const.REDIS_ROLE_MENU_P+role.getRoleKey()+"_"+company.getComKey(), null);
					
				}
			}
		}
		
		logger.info("完成清除公司的角色菜单数据......");
	}
	
	public void clearAllComProductPrice() throws Exception{
		List<Company> companies = companyService.listAllCompanies();
		PageData pd = new PageData();
		for (Company company : companies) {
			pd.put("comKey", company.getComKey());
			List<ComPartner> cps = partnerService.findListComPartner(pd);
			for (ComPartner cp : cps) {
				redisUtil.del(Const.REDIS_PRODUCTSERVICE_DROPDOWN+company.getComKey()+"_"+cp.getPartnerKey());
			}
		}
		logger.info("完成清除公司的服务定价数据......");
	}
	
	
	/**
	 * 
	* @Title: insertProductPriceToRedis 
	* @throws Exception
	* @return void
	* @throws 
	* @Description: 初始化服务定价并加入redis
	 */
//	public void insertProductPriceToRedis() throws Exception{
//		logger.info("开始初始化服务定价......");
//		PageData pd = new PageData();
//		for(int i=0;i<industryId_1.length;i++){
//			if("1C".equalsIgnoreCase(industryId_1[i])){
//				redisUtil.del(Const.REDIS_INIT_PRODUCTSERVICE_PRICING+industryId_1[i]);
//				pd.put("industryId", industryId_1[i]);
//				pd.put("pCodeTop", "0");
//				pd.put("pricingType",CompanyEnum.PRICING_TYPE_SERVICE.getCode());
//				List<ComProPriceVO> cppvos = companyService.list
//				redisUtil.set(Const.REDIS_INIT_PRODUCTSERVICE_PRICING+industryId_1[i], cppvos);
//			}
//		}
//		logger.info("完成初始化服务定价......");	
//	}
	
	/**
	 * 
	* @Title: insertPermissionToRedis 
	* @throws Exception
	* @return void
	* @throws 
	* @Description: 初始化行业权限值并加入redis
	 */
	public void insertPermissionToRedis() throws Exception{
		logger.info("开始初始化权限......");
		PageData pd = new PageData();
		for(int i=0;i<industryId_1.length;i++){
			pd.put("industryId", industryId_1[i]);
			//List<PermissionInit> permissionInits = roleService.listPermissionInitByIndustryId(pd);
			//redisUtil.set(Const.REDIS_INIT_PERMISSION+industryId_1[i], permissionInits);
		}
		logger.info("完成初始化权限......");	
	}
	
	public void insertGlobalConfigToRedis() throws Exception{
		logger.info("开始初始化全局参数......");
		PageData pd = new PageData();
		for(int i=0;i<industryId_1.length;i++){
			//计价方式
			Map priceWay = commonService.getMapGlobalConfig(industryId_1[i], "1", null);
			redisUtil.set(Const.REDIS_GLOBALCONFIG_PRICEWAY+industryId_1[i], priceWay);
			
			//计价单位
			Map priceUnit = commonService.getMapGlobalConfig(industryId_1[i], "2", null);
			redisUtil.set(Const.REDIS_GLOBALCONFIG_PRICEUNIT+industryId_1[i], priceUnit);
		}
		
		logger.info("完成初始化全局参数......");
	}
	
	public void insertProvinceCityCountryToRedis(){
		List<Province> provinces = commonService.listAllProvince();
		for (Province province : provinces) {
			redisUtil.set(Const.PROVINCE_REDIS+province.getProvinceId(), province);
		}
		List<City> cities = commonService.listAllCity();
		for (City city : cities) {
			redisUtil.set(Const.CITY_REDIS+city.getCityId(), city);
		}
		List<Country> countries = commonService.listAllCountry();
		for (Country country : countries) {
			redisUtil.set(Const.COUNTRY_REDIS+country.getCountryId(), country);
		}
		logger.info("完成初始化省市县......");
	}
	
	
}
