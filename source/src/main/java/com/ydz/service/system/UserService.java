package com.ydz.service.system;

import com.ydz.dao.system.CompanyMapper;
import com.ydz.dao.system.EmployeeMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.dao.system.UserMapper;
import com.ydz.entity.common.City;
import com.ydz.entity.common.Province;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.User;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.common.CommonService;
import com.ydz.util.*;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserCompanyVO;
import com.ydz.vo.UserPromoterVO;
import com.ydz.vo.UserVo;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;
import java.util.Map;


@Service("userService")
public class UserService{
	private static final Logger logger = Logger.getLogger(UserService.class);
	@Resource private UserMapper userMapper;
	@Resource private CompanyMapper companyMapper;
	@Resource private EmployeeMapper employeeMapper;
	@Resource private PartnerMapper partnerMapper;
	@Resource private CompanyService companyService;
	@Resource private CommonService commonService;
	
	@Resource private RedisUtil redisUtil;


	/**
	 * 
	 * @Title: saveNormalSignUp 
	 * @param user
	 * @return
	 * @throws Exception
	 * @return UserVo
	 * @throws 
	 * @Description: 个人注册后新建个人类型的公司记录，公司名与个人名一致
	 */
	public UserVo saveNormalSignUp(User user,String comIsValid) throws Exception {
		//创建一个类型是个体商户的公司
		Date nowDate = new Date();
		
		Map<String,Object> location = commonService.getLocationMap(user.getRegisterIp(), user.getUserId());
		String provinceId = null;
		String cityId = null;
		if (location!=null) {
			provinceId = location.get("region_id")==null?"":(String)location.get("region_id");
			cityId = location.get("city_id")==null?"":(String)location.get("city_id");
		}
		
		String registerLocation = "";
        Object objProvinceId = redisUtil.get(Const.PROVINCE_REDIS+provinceId);
        Object objCityId = redisUtil.get(Const.CITY_REDIS+cityId);
        if (objProvinceId!=null) {
        	Province province = (Province)objProvinceId;
        	registerLocation += province.getProvinceName()+" ";
		}
        if (objCityId!=null) {
        	City city = (City)objCityId;
        	registerLocation += city.getCityName();
		}
        user.setRegisterCity(registerLocation);

		Company company = new Company();
		if(StringUtil.isNotEmpty(user.getRefereeName())){
			company.setRefereeName(user.getRefereeName());
		}
		company.setComKey(UuidUtil.get32UUID());
		company.setComId(CodeBuilderUtil.getInstance().getCompanyCode());
		company.setWithinComId(CodeBuilderUtil.getInstance().getCompanyInvitationCode());
		company.setComName(user.getRealName());
		company.setComShortname(company.getComName());
		if(StringUtil.isNotEmpty(company.getComShortname())){
			company.setMnemonicCode(GetPinyin.getPinYinHeadChar(company.getComShortname()).toUpperCase()); //公司简称的首字母大写作为助记码
		}
		//公司类型 个人
		company.setComType(CompanyEnum.COM_TYPE_PERSONAL.getCode());
		company.setComAttr(CompanyEnum.COM_ATTR_PROMOTER.getCode());
		company.setCreator(user.getUserKey());
		//新建个人类型的公司时，该字段应为 0 ，当用户在第一次选择身份后，该字段值更新为"1"
		company.setIsValid(comIsValid);
		company.setCreateTime(nowDate);
		company.setIndustryId(Const.INDUSTRY_GENERAL);
		
		company.setComProvince(provinceId);
		company.setComCity(cityId);
		company.setProvince(provinceId);
		company.setCity(cityId);
		companyMapper.insertSelective(company);
        
        user.setDefaultCom(company.getComKey());
        user.setLocalProvince(provinceId);
        user.setLocalCity(cityId);
        user.setNowProvince(provinceId);
        user.setNowCity(cityId);
//        user.setRegType(SystemEnum.REG_TYPE_PC.getCode());
        
        this.saveUser(user);//添加用户

		//员工
		Employee employee = new Employee();
		employee.setEmployeeId(CodeBuilderUtil.getInstance().getAnyId(10));
		employee.setComKey(company.getComKey());
		employee.setUserKey(user.getUserKey());
		employee.setUserId(user.getUserId());
        employee.setRealName(user.getRealName());
		employee.setIsBoss("1");
		employee.setIsAdmin("1");
		employee.setStatus(CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());//正常
		employee.setCreator(user.getUserKey());
		employee.setCreateTime(nowDate);
		employee.setIsValid("1");
		employee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+Const.INDUSTRY_GENERAL));
		employee.setPermissionCode("");
		employeeMapper.insertSelective(employee);
		
		//session中存放字段
		UserVo userVo = new UserVo();
		userVo.setUid(user.getUid());
		userVo.setUserKey(user.getUserKey());
		userVo.setUserId(user.getUserId());
		userVo.setNickName(user.getNickName());
		userVo.setRealName(user.getRealName());
		userVo.setAvatarPath(user.getAvatarPath());
		userVo.setRegisterIp(user.getRegisterIp());
		userVo.setRoleKeys("ADMIN");

		//公司相关
		userVo.setComKey(company.getComKey());
		userVo.setDefaultCom(company.getComKey());
		userVo.setComName(company.getComName());
		userVo.setComShortname(company.getComShortname());
		userVo.setDetailIndustryId(company.getIndustryId());
		userVo.setComType(company.getComType());
		userVo.setComIsvalid(comIsValid); //判断个人公司的有效性

		//查询是否有人加我为好友  合作伙伴操作
		PageData pageData = new PageData();
		pageData.put("phone",userVo.getUserId());

		return userVo;
	}



	public Integer saveUser(User user)throws Exception{
		return userMapper.insertUser(user);
	}

	public int updateUser(User user) throws Exception {
		return userMapper.updateByUserKey(user);
	}

	public User getUserById(PageData pdPara){
		return userMapper.selectByKey(pdPara);
	}
	
	public User getAuthorByUserId(PageData pd) throws Exception {
		return userMapper.selectAuthorByUserId(pd);
	}
	
	public User getAvatarByUserKey(PageData pd) throws Exception{
		return userMapper.selectAvatarByUserKey(pd);
	}
	
	public User selectAuthorByWechat(PageData pd) throws Exception{
		return userMapper.selectAuthorByWechat(pd);
	}

	public UserCompanyVO selectUserComByUserId(String userId) throws Exception{
		PageData pd = new PageData();
		pd.put("userId",userId);
		return userMapper.selectUserComByUserId(pd);
	}

	public UserCompanyVO selectUserComByIdandKey(PageData pd){
		return userMapper.selectUserComByIdandKey(pd);
	}
	
	public int deleteBind(String userKey,String bindType) throws Exception{
		PageData pd = new PageData();
		pd.put("userKey", userKey);
		int result = 0;
		if(Const.BIND_WECHAT.equalsIgnoreCase(bindType)){
			result = userMapper.removeBindWechat(pd);
		}else if (Const.BIND_QQ.equalsIgnoreCase(bindType)) {
			result = userMapper.removeBindQq(pd);
		}else if (Const.BIND_ALIPAY.equalsIgnoreCase(bindType)) {
			result = userMapper.removeBindAlipay(pd);
		}
		return result;
	}
	
	public List<UserPromoterVO> listMyPromotion(PageData pd){
		return userMapper.selectPromotion(pd);
	}



}
