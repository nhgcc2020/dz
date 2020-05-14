package com.ydz.service.advert;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

import javax.annotation.Resource;

import com.ydz.entity.system.*;
import com.ydz.service.system.RoleService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.ydz.config.DZConfig;
import com.ydz.dao.assignment.AssignWorkingProcedureMapper;
import com.ydz.dao.system.BusiPriceComMapper;
import com.ydz.dao.system.BusinessPriceInitMapper;
import com.ydz.dao.system.CityLevelMapper;
import com.ydz.dao.system.ComEmployeeMapper;
import com.ydz.dao.system.RentalPeriodMapper;
import com.ydz.dao.system.RentalTradeDiscountMapper;
import com.ydz.dao.system.RentalTradeMapper;
import com.ydz.dao.system.RentalVersionLimitMapper;
import com.ydz.dao.system.VoucherMapper;
import com.ydz.dao.system.VoucherUseMapper;
import com.ydz.entity.Page;
import com.ydz.entity.assignment.AssignWorkingProcedure;
import com.ydz.entity.init.BusinessPriceInit;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.MenuService;
import com.ydz.util.Const;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.RentalTradeVO;
import com.ydz.vo.SelectVo;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: TradeService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月11日 下午8:06:07 
 * @Description: 处理交易类业务
 *  
 */
@Service("tradeService")
public class TradeService {
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "companyService")
	private CompanyService companyService;
	
	@Resource(name = "menuService")
	private MenuService menuService;
	@Resource private RoleService roleService;
	
	@Resource private RedisUtil redisUtil;
	
	@Resource private DZConfig dzConfig;
	
	@Autowired private BusinessPriceInitMapper businessPriceInitMapper;
	@Autowired private BusiPriceComMapper busiPriceComMapper;
	@Autowired private CityLevelMapper cityLevelMapper;
	
	@Autowired private ComEmployeeMapper comEmployeeMapper;
	
	@Autowired private RentalPeriodMapper rentalPeriodMapper;
	@Autowired private RentalTradeMapper rentalTradeMapper;
	@Autowired private RentalTradeDiscountMapper rentalTradeDiscountMapper;
	@Autowired private RentalVersionLimitMapper rentalVersionLimitMapper;
	
	@Autowired private VoucherMapper voucherMapper;
	@Autowired private VoucherUseMapper voucherUserMapper;
	
	@Autowired private AssignWorkingProcedureMapper assignWorkingProcedureMapper;
	
	/**
	 * 
	* @Title: listBusinessPriceInitAllByIndustry 
	* @param pd industryId，cityLevel
	* @return
	* @throws Exception
	* @return List<BusinessPriceInit>
	* @throws 
	* @Description: 获取初始化购买价格列表
	 */
	public List<BusinessPriceInit> listBusinessPriceInitAllByIndustry(PageData pd) throws Exception{
		return businessPriceInitMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: listVoucher 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return List<Voucher>
	* @throws 
	* @Description: 返回代金券列表数据
	*
	 */
	@SuppressWarnings("unchecked")
	public List<Voucher> listVoucher(PageData pd) throws Exception{
		return voucherMapper.selectByPrimaryKey(pd);
	}
	public Voucher getOneVoucher(PageData pd) throws Exception{
		List<Voucher> vouchers = voucherMapper.selectByPrimaryKey(pd);
		if(vouchers!=null&&vouchers.size()>0){
			return vouchers.get(0);
		}else{
			return null;
		}
	}
	
	
	/**
	 * 
	* @Title: voucherInfo 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return String
	* @throws 
	* @Description: 返回代金券的下拉框数据
	*
	 */
	@SuppressWarnings("unchecked")
	public String voucherInfo(PageData pd) throws Exception{
		List<Voucher> vouchers = this.listVoucher(pd);
		List<SelectVo> list = new ArrayList<SelectVo>();
		SelectVo vo = null;
//		SelectVo vo = new SelectVo();
//		vo.setText("不使用代金券");
//		vo.setValue("0.00");
//		list.add(vo);
		for(Voucher voucher:vouchers){
			vo = new SelectVo();
			vo.setText(voucher.getVoucherNo()+"，为您节省：￥"+voucher.getVoucherMoney().setScale(2, BigDecimal.ROUND_HALF_UP)+"元");
			vo.setValue(voucher.getVoucherMoney().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
			list.add(vo);
		}
		return JSONArray.toJSON(list).toString();
	}
	
	/**
	 * 
	* @Title: insertVoucher 
	* @param voucher
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 插入代金券
	 */
	public int insertVoucher(Voucher voucher) throws Exception{
		return voucherMapper.insertSelective(voucher);
	}
	
	/**
	 * 
	* @Title: getRentalTradeDiscount 
	* @param @param duration 传入购买的月数，为0时候取出全部折扣并返回json格式
	* @param @return
	* @param @throws Exception
	* @return String
	* @throws 
	* @Description: 获取产品业务购买的折扣率
	*
	 */
	public String getRentalTradeDiscount(int duration)
		throws Exception{
		PageData pd = new PageData();
		String result = null;
		if(duration==0){
			pd.put("duration", null);
			result = JSONArray.toJSONString(rentalTradeDiscountMapper.selectByPrimaryKey(pd));
		}else{
			pd.put("duration", Integer.toString(duration));
			RentalTradeDiscount discount = rentalTradeDiscountMapper.selectByPrimaryKey(pd);
			result = discount==null?"1":discount.getDiscount().toString();
		}
		return result;
	}
	
	/**
	 * 
	* @Title: parselistVoucher 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return List<Voucher>
	* @throws 
	* @Description: 返回格式化处理过的代金券列表数据
	*
	 */
	public List<Voucher> parselistVoucher(PageData pd) throws Exception{
		List<Voucher> vouchers = this.listVoucher(pd);
		for(Voucher v : vouchers){
			v.setStatusValue(commonService.formatVoucherStatus(v.getStatus()));
		}
		return vouchers;
	}
	
	/**
	 * 
	* @Title: getCityLevel 
	* @param @param pd cityId, provinceId
	* @param @return
	* @param @throws Exception
	* @return CityLevel
	* @throws 
	* @Description: 根据城市ID获取城市所属的区域级别
	*
	 */
	public CityLevel getCityLevel(PageData pd) throws Exception{
		return cityLevelMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: insertRentalPeriod 
	* @param @param period
	* @return void
	 * @throws Exception 
	* @throws 
	* @Description: 插入业务租赁周期
	*
	 */
	public int insertRentalPeriod(RentalPeriod rentalPeriod) throws Exception{
		return rentalPeriodMapper.insertSelective(rentalPeriod);
	}
	
	/**
	 * 
	* @Title: insertRentalTrade 
	* @param @param trade
	* @return void
	 * @throws Exception 
	* @throws 
	* @Description: 插入业务租赁交易记录
	*
	 */
	public int insertRentalTrade(RentalTrade rentalTrade) throws Exception{
		return rentalTradeMapper.insertSelective(rentalTrade);
	}
	
	
	/**
	 * 
	* @Title: updateVoucherStatus 
	* @param @param pd
	* @return void
	 * @throws Exception 
	* @throws 
	* @Description: 更新代金券记录 2已过期
	* 
	*
	 */
	public int updateVoucherStatus(Voucher voucher) throws Exception{
		return voucherMapper.updateByPrimaryKeySelective(voucher);
		
	}
	
	/**
	 * 
	* @Title: updateRentalPeriod 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新产品租用期限表
	*
	 */
	public int updateRentalPeriod(RentalPeriod rentalPeriod) throws Exception{
		return rentalPeriodMapper.updateByPrimaryKeySelective(rentalPeriod);
		
	}
	
	public int updateRentalTrade(RentalTrade rentalTrade) throws Exception{
		return rentalTradeMapper.updateByPrimaryKeySelective(rentalTrade);
	}
	
	public int updateStatusByTradeKey(PageData pd) throws Exception{
		return rentalTradeMapper.updateStatusByTradeKey(pd);
	}
	
	/**
	 * 
	* @Title: insertUpgradeTrial 
	* @param @param pd comKey, userKey, industryId
	* @return void
	* @throws 
	* @Description: 升级易对账默认试用版需要插入交易记录
	* 2017-08-30 17:01:40 修改
	* 1. 试用期改为2099年
	*
	 */
	private int insertUpgradeTrial(PageData pd) 
			throws Exception{
	
		Date nowDate = new Date();
		//1. 写入产品租用期限
		String rentalKey = CodeBuilderUtil.getInstance().getAnyId(14);
		
		RentalPeriod period = new RentalPeriod();
		period.setRentalKey(rentalKey);
		period.setComKey(pd.getString("comKey"));
		period.setStartDate(nowDate);
//		int trialDay = StringUtil.isNotEmpty(commonService.getDictValue("TRADE_TRIAL_DAY"))?Integer.parseInt(commonService.getDictValue("TRADE_TRIAL_DAY")):30;
//		period.setEndDate(DateUtil.addDay(nowDate, trialDay));
//		period.setEndDate(DateUtil.addDay(nowDate, trialDay));
//		period.setDuration(trialDay);
		//免费版有效期至2099-12-31
		Calendar calendar = Calendar.getInstance();
    	calendar.set(2099, 11, 31);
    	period.setEndDate(calendar.getTime());
		period.setDuration(DateUtil.getDayByMonth(DateUtil.getIntervalMonths(nowDate, calendar.getTime()))); //相隔天数
		period.setStatus(RentalTradeEnum.PERIOD_TRIAL.getCode()); //试用期
		period.setCreateTime(nowDate);
		period.setCreator(pd.getString("userKey"));
		period.setRentalVersion(pd.getString("trialRentalVersion")); //试用版
		this.insertRentalPeriod(period);
		
		//2. 写入交易记录
		String tradeKey = CodeBuilderUtil.getInstance().getPaySerial();
		RentalTrade trade = new RentalTrade();
		trade.setTradeKey(tradeKey);
		trade.setRentalKey(rentalKey);
		trade.setComKey(pd.getString("comKey"));
		trade.setTradeType(RentalTradeEnum.TRADE_TYPE_TRIAL.getCode());
		trade.setRentalMoney(new BigDecimal(0));
		trade.setPayedMoney(new BigDecimal(0));
		trade.setDeductionMoney(new BigDecimal(0));
		trade.setPaymentNum("");
		trade.setPaymentType(RentalTradeEnum.PAYMENT_TRIAL.getCode());
		trade.setIsInvoice(RentalTradeEnum.INVOICE_NO.getCode());
		trade.setBeforeChange(null);
		trade.setAfterChange(null);
		trade.setStatus(RentalTradeEnum.PAID_YES.getCode());
		trade.setCreateTime(nowDate);
		trade.setCreator(pd.getString("userKey"));
		trade.setRentalVersion(pd.getString("trialRentalVersion"));
		this.insertRentalTrade(trade);
		
		//3. 赠送代金券
		Voucher voucher = new Voucher();
		voucher.setComKey(pd.getString("comKey"));
		voucher.setVoucherNo(CodeBuilderUtil.getInstance().getVoucherCode(10));
		voucher.setStartDate(nowDate);
		String periodDay = commonService.getDictValue("VOUCHER_PERIOD_DAY");
		voucher.setEndDate(DateUtil.addDay(nowDate, StringUtil.isNotEmpty(periodDay)==true?Integer.parseInt(periodDay):10)); //代金券有效期默认10天
		voucher.setPeriodDay(StringUtil.isNotEmpty(periodDay)==true?Integer.parseInt(periodDay):10);
		voucher.setStatus(RentalTradeEnum.VOUCHER_STATUS_UNUSED.getCode());
		//根据不同的城市级别生成代金券金额
		Company company = companyService.getCompanyByUserKey(pd.getString("comKey"));
		PageData pdPara = new PageData();
		
        pdPara.put("cityId", company.getComCity());
        CityLevel cityLevel = this.getCityLevel(pdPara);
        String cityLevelString = cityLevel==null?"01":cityLevel.getCityLevel();
        
		voucher.setVoucherMoney(new BigDecimal(commonService.getDictValue("RENTAL_VOUCHER_MONEY_"+cityLevelString)));
		voucher.setVoucherName("注册赠送");
		voucher.setCreator("system");
		voucher.setCreateTime(nowDate);
//		this.insertVoucher(voucher);
		
		return 1;
	}
	
	/**
	 * 
	 * @Title: insertUpgradeTrialVersion 
	 * @param userVo
	 * @param newIndustryId
	 * @param bossOrAdmin
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 通用行业升级至专属行业的处理，默认给予试用期
	 * 1. 更新公司的行业，通用行业改为专属行业
	 * 2. 更新Menu菜单类型记录，用于获取不同行业不同版本的初始化菜单
	 * 3. 初始化升级后的部门，先删除通用行业的部门
	 * 4. 初始化升级后的角色，先删除通用行业的角色
	 */
	public int insertUpgradeTrialVersion(UserVo userVo,String newIndustryId){
		int result = 0;
		try {
			Company company = new Company();
			company.setComKey(userVo.getComKey());
			company.setIndustryId(newIndustryId);
			companyService.updateCompany(company);
			
			PageData pdPara = new PageData();
			pdPara.put("comKey", userVo.getComKey());
			pdPara.put("userKey", userVo.getUserKey());
			pdPara.put("industryId", newIndustryId);
			pdPara.put("trialRentalVersion", RentalTradeEnum.VERSION_BASIC_EDITION.getCode()); //试用基础版
			
			result = this.insertUpgradeTrial(pdPara);//初始化试用期记录
			
			//插入专有行业试用版菜单类型
			result = menuService.insertTrialMenu(userVo.getComKey(), newIndustryId, RentalTradeEnum.VERSION_BASIC_EDITION.getCode()); 
			//升级行业版本重新处理部门数据
			result = companyService.insertCompanyDept(newIndustryId, userVo.getComKey(), "upgrade"); 
			//为升级的公司添加过路客的客户
			result = companyService.insertTempComPartner(pdPara); 
			//删除通用行业用到的角色KEY
			result = roleService.deleteComRoles(userVo.getComKey(), "RS-01"); 
			//初始化公司角色
			roleService.insertComRolesRegisterInit(userVo.getComKey(), newIndustryId, userVo.getUserKey()); 
			//初始化插入管理员的权限
			roleService.insertComRoloPermission(userVo.getComKey(), newIndustryId, userVo.getRoleKeys());
			//初始化公司的服务定价列表,这样会默认打开
			companyService.insertInitComServicePrice(pdPara); 
			//初始化费用数据
			result = companyService.insertInitExpenseTypes(pdPara);
			
			//1B行业初始化媒体资源设置
			if (CompanyEnum.INDUSTRY_CLASS_CHUANMEI.getCode().equalsIgnoreCase(newIndustryId)) {
				result = companyService.insertInitMediaSetting(pdPara);
			}
			
			//从通用版升级到试用版时候出现了新行业，需要重新写入访问菜单
			ComEmployee comEmployee = new ComEmployee();
			comEmployee.setComKey(userVo.getComKey());
			comEmployee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+newIndustryId));
			comEmployeeMapper.updateByPrimaryKeySelective(comEmployee);
			
			//升级后，需要清除之前的菜单缓存数据
			redisUtil.set(Const.REDIS_ROLE_MENU_P+userVo.getRoleKeys()+"_"+userVo.getComKey(), null);
			redisUtil.set(Const.REDIS_ROLE_MENU_V+userVo.getRoleKeys()+"_"+userVo.getComKey(), null);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	
	/**
	 * 
	* @Title: insertFreeVersion 
	* @param pd comKey，userKey
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 创建使用免费版
	 */
	public String insertFreeVersion	(PageData pd) 
			throws Exception{
		
		//1. 写入产品租用期限
		String rentalKey = CodeBuilderUtil.getInstance().getAnyId(14);
		
		RentalPeriod period = new RentalPeriod();
		period.setRentalKey(rentalKey);
		period.setComKey(pd.getString("comKey"));
		period.setRentalVersion(RentalTradeEnum.VERSION_FREE_EDITION.getCode()); //免费版
		
		Date startDate = new Date();
		period.setStartDate(startDate);
		//免费版有效期至2099-12-31
		Calendar calendar = Calendar.getInstance();
    	calendar.set(2099, 11, 31);
    	period.setEndDate(calendar.getTime());
		period.setDuration(DateUtil.getDayByMonth(DateUtil.getIntervalMonths(startDate, calendar.getTime()))); //相隔天数
		
		period.setStatus(RentalTradeEnum.PERIOD_USING.getCode()); //使用中
		period.setCreateTime(startDate);
		period.setCreator(pd.getString("userKey"));
		this.insertRentalPeriod(period);
		
		//2. 写入交易记录
		String tradeKey = CodeBuilderUtil.getInstance().getPaySerial();
		RentalTrade trade = new RentalTrade();
		trade.setTradeKey(tradeKey);
		trade.setRentalKey(rentalKey);
		trade.setComKey(pd.getString("comKey"));
		trade.setTradeType(RentalTradeEnum.PERIOD_USING.getCode());
		trade.setRentalMoney(new BigDecimal(0));
		trade.setPayedMoney(new BigDecimal(0));
		trade.setDeductionMoney(new BigDecimal(0));
		trade.setPaymentNum("");
		trade.setPaymentType(RentalTradeEnum.PAYMENT_FREE.getCode());
		trade.setIsInvoice(RentalTradeEnum.INVOICE_NO.getCode());
		trade.setBeforeChange(null);
		trade.setAfterChange(null);
		trade.setStatus(RentalTradeEnum.PAID_YES.getCode());
		trade.setCreateTime(startDate);
		trade.setCreator(pd.getString("userKey"));
		trade.setRentalVersion(RentalTradeEnum.VERSION_FREE_EDITION.getCode());
		this.insertRentalTrade(trade);
		
		//3. 更新为免费版菜单
		Menu menu = new Menu();
		menu.setComKey(pd.getString("comKey"));
		menu.setRentalVersion(RentalTradeEnum.VERSION_FREE_EDITION.getCode());
		menu.setChangedTime(new Date());
		menuService.updateComMenu(menu);
		
		//员工权限改为免费版可访问
		ComEmployee comEmployee = new ComEmployee();
		comEmployee.setComKey(pd.getString("comKey"));
		comEmployee.setMenuId(commonService.getDictValue(Const.MENU_ID_INIT+RentalTradeEnum.VERSION_FREE_EDITION.getCode())); //写入免费版菜单
		comEmployeeMapper.updateByPrimaryKeySelective(comEmployee);
		
		String keys = null;
		if(StringUtil.isEmpty(pd.getString("roleKey"))){
			keys = pd.getString("comKey");
		}else{
			keys = pd.getString("roleKey")+"_"+pd.getString("comKey");
		}
		redisUtil.set(Const.REDIS_ROLE_MENU_V + keys, null);
		
		return "1";
	}
	
	/**
	 * 
	* @Title: insertPurchaseRental 
	* @param pd 公司KEY，用户KEY，使用时长，购买类型paymentType(1新购 2续费 3更改 T试用 0免费)
	* @throws Exception
	* @return void
	* @throws 
	* @Description: 插入功能购买/续费时的交易
	* 1.试用期购买的为新购
	* 2.使用中未到期的为续费
	* 3.过期的购买为新购
	* 	
	 */
	public HashMap<String, Object> insertPurchaseRental(PageData pd)
		throws Exception{
		String rentalKey = pd.getString("rentalKey");
		String rentalVersion = pd.getString("rentalVersion");
        BigDecimal durationMon = new BigDecimal(pd.getString("duration"));

        if(StringUtil.isEmpty(rentalVersion) || StringUtil.isEmpty(rentalKey)){
			return null;
		}

		Date startDate = null;
		Date nowDate = new Date();
		/**
		 * 1.未到期续费的，需要查询最后到期日作为起始日期
		 * 2.试用期未到期的作为新购处理
		 * 3.使用中未到期的作为续费处理
		 */
		PageData pdPara1 = new PageData();
		pdPara1.put("rentalKey", pd.getString("rentalKey"));
		pdPara1.put("comKey", pd.getString("comKey"));
		if (pd.getString("tradeType")
				.equalsIgnoreCase(RentalTradeEnum.TRADE_TYPE_NEWPAY.getCode())) { 	//试用期购买为新购
			if("1".equals(pd.getString("isMaturity"))){ //1未到期
				pdPara1.put("status", RentalTradeEnum.PERIOD_TRIAL.getCode());
				startDate = this.findRentalPeriod(pdPara1).getEndDate();
			}else{
				startDate = new Date();
			}
			startDate = new Date();
			if(pd.getString("oldRentalVersion")
					.equalsIgnoreCase(RentalTradeEnum.VERSION_FREE_EDITION.getCode())){
				startDate = new Date();
			}
			//插入新的产品租用记录
			RentalPeriod rentalPeriod = new RentalPeriod();
			rentalKey = CodeBuilderUtil.getInstance().getAnyId(14); //产品租用KEY
			rentalPeriod.setRentalKey(rentalKey);
			rentalPeriod.setComKey(pd.getString("comKey"));
			rentalPeriod.setDuration(DateUtil.getDayByMonth(Integer.parseInt(pd.getString("duration"))));
			rentalPeriod.setRentalVersion(rentalVersion);
			rentalPeriod.setStartDate(startDate);
			rentalPeriod.setEndDate(DateUtil.addDay(startDate, DateUtil.getDayByMonth( Integer.parseInt(pd.getString("duration")))));
			rentalPeriod.setStatus(RentalTradeEnum.PERIOD_USING.getCode());
			rentalPeriod.setCreator(pd.getString("userKey"));
			rentalPeriod.setCreateTime(nowDate);
			this.insertRentalPeriod(rentalPeriod);
		}else if (pd.getString("tradeType")
				.equalsIgnoreCase(RentalTradeEnum.TRADE_TYPE_RENEW.getCode())) { 	//续费
			pdPara1.put("status", RentalTradeEnum.PERIOD_USING.getCode());
			RentalPeriod hasPeriod = this.findRentalPeriod(pdPara1);
			
			RentalPeriod period_renew = new RentalPeriod();
			period_renew.setComKey(pd.getString("comKey"));
			period_renew.setRentalKey(pd.getString("rentalKey"));
			period_renew.setDuration(hasPeriod.getDuration()+DateUtil.getDayByMonth(Integer.parseInt(pd.getString("duration"))));
			period_renew.setEndDate(DateUtil.addDay(hasPeriod.getEndDate(), DateUtil.getDayByMonth(Integer.parseInt(pd.getString("duration")))));
			period_renew.setChanger(pd.getString("userKey"));
			period_renew.setChangeTime(nowDate);
			this.updateRentalPeriod(period_renew);
		}
		
		HashMap<String, Object> mapResult = new HashMap<String, Object>();
		mapResult.put("rentalVersionValue", RentalTradeEnum.codeOf(pd.getString("rentalVersion")).getDesc());

		//交易流水号
		String tradeKey =  CodeBuilderUtil.getInstance().getPaySerial();
		mapResult.put("tradeKey", tradeKey);
		//插入产品租用交易记录
		RentalTrade rentalTrade = new RentalTrade();
		rentalTrade.setTradeKey(tradeKey);
		rentalTrade.setRentalKey(rentalKey);
		rentalTrade.setComKey(pd.getString("comKey"));
		rentalTrade.setTradeType(pd.getString("tradeType"));
		rentalTrade.setPaymentType(pd.getString("paymentType"));
		
		BigDecimal payedMoney_client = new BigDecimal(pd.getString("payedMoney")); //用户提交的实际支付价格
		BigDecimal discount_client = new BigDecimal(pd.getString("discount")); //用户提交的折扣
 		BigDecimal discount = new BigDecimal(this.getRentalTradeDiscount(durationMon.intValue()))
 									.setScale(2, BigDecimal.ROUND_HALF_UP); //获取折扣率
		
		BigDecimal voucherPrice = new BigDecimal(0);
		if(StringUtil.isNotEmpty(pd.getString("voucherNo"))){
			Voucher voucher = this.getOneVoucher(pd);
			voucherPrice = voucher==null?new BigDecimal(0):voucher.getVoucherMoney(); //获取代金券金额
		}
		
		//根据行业、版本号、城市级别获取默认的产品价格
		PageData pdPrice = new PageData();
		pdPrice.put("industryId", pd.getString("industryId"));
		pdPrice.put("rentalVersion", pd.getString("rentalVersion"));
		pdPrice.put("cityLevel", pd.getString("cityLevel"));
		BigDecimal rentalMoney = this.listBusinessPriceInitAllByIndustry(pdPrice).get(0).getBusinessPrice(); 
		
		BigDecimal payedMoney = new BigDecimal(0);
		//半年的计算公式=版本金额/2+244
		if(durationMon.compareTo(new BigDecimal(6))==0){
			payedMoney = rentalMoney.divide(new BigDecimal(2)).setScale(2, BigDecimal.ROUND_HALF_UP).add(new BigDecimal(244))
					.subtract(voucherPrice).setScale(2, BigDecimal.ROUND_HALF_UP);
		}else{
			//计算公式：实际支付金额=软件年价格*(月份/12=年)*折扣率-代金券
			payedMoney = rentalMoney.multiply(durationMon.divide(new BigDecimal(12))).multiply(discount).setScale(2, BigDecimal.ROUND_HALF_UP).subtract(voucherPrice).setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		
		//如果比对产品金额、实际支付金额、折扣率与前台传过来的不一致，说明数据被破坏，终止执行。
		if(payedMoney.compareTo(payedMoney_client)!=0 
				|| discount.compareTo(discount_client)!=0){
			return null;
		}

		rentalTrade.setRentalMoney(rentalMoney); //产品功能总金额
		rentalTrade.setDiscount(discount); //折扣率
		rentalTrade.setVoucherNo(pd.getString("voucherNo")); //代金券号码
		rentalTrade.setDeductionMoney(voucherPrice); //优惠券抵扣金额
		rentalTrade.setPayedMoney(payedMoney); //实际支付金额
		rentalTrade.setRentalVersion(rentalVersion);
		rentalTrade.setCreator(pd.getString("userKey"));
		rentalTrade.setCreateTime(nowDate);
		rentalTrade.setStatus(RentalTradeEnum.PAID_NO.getCode()); //未支付
		
		if(StringUtil.isNotEmpty(pd.getString("voucherNo"))){
			//更新代金券
			Voucher voucherNew = new Voucher();
			voucherNew.setComKey(pd.getString("comKey"));
			voucherNew.setVoucherNo(pd.getString("voucherNo"));
			voucherNew.setUseDate(nowDate);
			voucherNew.setStatus(RentalTradeEnum.VOUCHER_STATUS_USED.getCode());
			this.updateVoucherStatus(voucherNew);
		}
		
		this.insertRentalTrade(rentalTrade);
		
		return mapResult;
	}
	
	/**
	 * 
	* @Title: findRentalPeriod 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return RentalPeriod
	* @throws 
	* @Description: 获取产品使用期限记录 
	*
	 */
	public RentalPeriod findRentalPeriod(PageData pd) throws Exception{
		return rentalPeriodMapper.selectOneByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: parseRentalPeriod 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return RentalPeriod
	* @throws 
	* @Description: 获取格式化处理过的产品使用期限记录
	*
	 */
	public RentalPeriod getParseRentalPeriod(PageData pd) throws Exception{
		RentalPeriod rp = this.findRentalPeriod(pd);
		rp.setStatusValue(commonService.formatRentalPeriod(rp.getStatus()));
		return rp;
	}
	
	public HashMap<String, Object> getMapPriceList(PageData pd) throws Exception{
		 HashMap<String, Object> mapResult = new HashMap<String, Object>();
		 PageData pdPara = new PageData();
		 
		 pdPara.put("comKey", pd.getString("comKey"));
		 
        //获取交易记录
        RentalPeriod period = this.getParseRentalPeriod(pdPara);
        mapResult.put("endDate", DateUtil.DateToString(period.getEndDate(), DateStyle.YYYY_MM_DD));
        mapResult.put("status", period.getStatus());
        mapResult.put("statusValue", period.getStatusValue());
        mapResult.put("rentalVersion", period.getRentalVersion());
        mapResult.put("rentalVersionValue", RentalTradeEnum.codeOf(period.getRentalVersion()).getDesc());
        mapResult.put("rentalKey", period.getRentalKey());
        Company company = companyService.getCompanyByUserKey(pd.getString("comKey"));
        pdPara.put("cityId", company.getComCity());
        CityLevel cityLevel = this.getCityLevel(pdPara);
        if (cityLevel==null) {
        	pdPara.put("cityLevel", "03");
		}else{
			pdPara.put("cityLevel", cityLevel.getCityLevel());
		}
        pdPara.put("industryId", company.getIndustryId());
        List<BusinessPriceInit> priceInits = this.listBusinessPriceInitAllByIndustry(pdPara); //根据行业城市级别获取初始化价格
        for (BusinessPriceInit priceInit : priceInits) {
			if(RentalTradeEnum.VERSION_BASIC_EDITION.getCode().equalsIgnoreCase(priceInit.getRentalVersion())){
				mapResult.put("version01", priceInit.getBusinessPrice());
			}
			if(RentalTradeEnum.VERSION_PROFESSIONAL_EDITION.getCode().equalsIgnoreCase(priceInit.getRentalVersion())){
				mapResult.put("version02", priceInit.getBusinessPrice());
			}
			if(RentalTradeEnum.VERSION_ADVANCED_EDITION.getCode().equalsIgnoreCase(priceInit.getRentalVersion())){
				mapResult.put("version03", priceInit.getBusinessPrice());
			}
		}
        mapResult.put("currentCom", company.getComName());
        mapResult.put("industryDesc", CompanyEnum.codeOf(company.getIndustryId()).getDesc());
        return mapResult;
	}
	
	/**
	 * 
	* @Title: selectRentalTradeVO
	* @return
	* @return List<RentalTradeVO>
	* @throws 
	* @Description: 查询交易记录
	 */
	public List<RentalTradeVO> listPageRentalTradeVO(Page page){
		List<RentalTradeVO> rtvos = rentalTradeMapper.listPageRentalTradeVO(page);
		for (RentalTradeVO rtvo : rtvos) {
			rtvo.setStatusPeriodValue(commonService.formatPaymentType(rtvo.getPaymentType()));
		}
		return rtvos;
	}
	
	/**
	 * 
	* @Title: validateRentalPeriod 
	* @param comKey
	* @return
	* @return boolean
	* @throws 
	* @Description: 判断用户所在的公司购买的软件使用期是否到期 1未到期 0到期
	 */
	public String validateRentalPeriod(String comKey){
		String valid = "0";
		try {
			//获取采购版本的有效期
			PageData pd = new PageData();
			pd.put("comKey", comKey);
			RentalPeriod period = this.findRentalPeriod(pd);
			if(period!=null
					&&new Date().after(period.getEndDate())){
				valid = "0";
			}else{
				valid = "1";
			}
		} catch (Exception e) {
			valid = "0";
			e.printStackTrace();
		}
    	return valid;
	}



	public Map saveChangeVersion(UserVo userVo,String newVersion) throws Exception {
		//返回信息
		Map<String,Object> map = new HashMap<>();
		String comKey = userVo.getComKey();
		//1.查看当前版本
		PageData pdPara = new PageData();
		pdPara.put("comKey", userVo.getComKey());

		//获取交易记录
		RentalPeriod period = this.getParseRentalPeriod(pdPara);
		//通过剩余时间计算余额
		//不允许减版本，只能加版本
		if(Integer.valueOf(period.getRentalVersion()) >= Integer.valueOf(newVersion)){
			map.put("state","0");
			map.put("msg","只可升级至高版本");
			return map;
		}
		Date startDatePara = period.getStartDate();
		//使用多少天
		int differ = DateUtil.getIntervalDays(startDatePara,new Date());
		int balanceDiffer = DateUtil.getIntervalDays(new Date(),period.getEndDate());
        //升级新版本余额可使用天数（新旧版本的价格标准）
		Company company = companyService.getCompanyByUserKey(comKey);
		pdPara.put("cityId", company.getComCity());
		pdPara.put("cityLevel", this.getCityLevel(pdPara).getCityLevel());
		pdPara.put("industryId", company.getIndustryId());
		List<BusinessPriceInit> priceInits = this.listBusinessPriceInitAllByIndustry(pdPara); //根据行业城市级别获取初始化价格
		//获取新版本新歌
		BusinessPriceInit newVersionInit = null;
		BusinessPriceInit currentVersionInit = null;

		for (BusinessPriceInit priceInit : priceInits) {
			if(newVersion.equalsIgnoreCase(priceInit.getRentalVersion())){
				newVersionInit = priceInit;
			}
			if(period.getRentalVersion().equalsIgnoreCase(priceInit.getRentalVersion())){
				currentVersionInit = priceInit;
			}
		}
		if(newVersionInit ==null || currentVersionInit == null){
			map.put("state","0");
			map.put("msg","升级失败");
			return map;
		}
		//当前余额  当前资费标准(？元/年)除以365（天）乘以 剩余天数
		BigDecimal balance = currentVersionInit.getBusinessPrice().divide(new BigDecimal(365),3, RoundingMode.HALF_UP).multiply(new BigDecimal(balanceDiffer)).setScale(0,BigDecimal.ROUND_HALF_UP);
		//新版本使用天数  当前余额 除以 新版本每天的资费标准（年费除以365）
		BigDecimal newVersionDay =balance.divide(newVersionInit.getBusinessPrice().divide(new BigDecimal(365),3,RoundingMode.HALF_UP),3,RoundingMode.HALF_UP).setScale(0,BigDecimal.ROUND_HALF_UP);

		//当前时间算出 newVersionDay 天后
		Date  newVerEndDate = DateUtil.addDay(new Date(),newVersionDay.intValue());
		//修改当前产品租用记录的 结束时间和状态
		RentalPeriod rentalPeriodMod = new RentalPeriod();
		rentalPeriodMod.setRentalKey(period.getRentalKey());
		rentalPeriodMod.setComKey(comKey);
		rentalPeriodMod.setEndDate(new Date());
		rentalPeriodMod.setStatus(RentalTradeEnum.PERIOD_OUTDATE.getCode());
		rentalPeriodMapper.updateByPrimaryKeySelective(rentalPeriodMod);
		//新增一条 产品租用记录
		RentalPeriod rentalPeriod = new RentalPeriod();
		String rentalKey = CodeBuilderUtil.getInstance().getAnyId(14); //产品租用KEY
		rentalPeriod.setRentalKey(rentalKey);
		rentalPeriod.setComKey(comKey);
		rentalPeriod.setStartDate(new Date());
		rentalPeriod.setEndDate(newVerEndDate);
		rentalPeriod.setDuration(newVersionDay.intValue());
		//使用中
		rentalPeriod.setStatus(RentalTradeEnum.PERIOD_USING.getCode());
		rentalPeriod.setRentalVersion(newVersion);
		rentalPeriod.setCreator(userVo.getUserKey());
		rentalPeriod.setCreateTime(new Date());
        rentalPeriodMapper.insertSelective(rentalPeriod);
		//新增一条 购买记录
		//插入产品租用交易记录
		RentalTrade rentalTrade = new RentalTrade();
		String tradeKey =  CodeBuilderUtil.getInstance().getPaySerial();
		rentalTrade.setTradeKey(tradeKey);
		rentalTrade.setRentalKey(rentalKey);
		rentalTrade.setComKey(comKey);
		//更改
		rentalTrade.setTradeType(RentalTradeEnum.TRADE_TYPE_CHNAGE.getCode());
		//钱相关
		rentalTrade.setRentalMoney(new BigDecimal(0));
		rentalTrade.setDiscount(new BigDecimal(0));
		rentalTrade.setPayedMoney(new BigDecimal(0));
		rentalTrade.setDeductionMoney(new BigDecimal(0));
		//免费
		rentalTrade.setPaymentType(RentalTradeEnum.PAYMENT_FREE.getCode());
		//未开票
		rentalTrade.setIsInvoice(RentalTradeEnum.INVOICE_NO.getCode());
        rentalTrade.setStatus(RentalTradeEnum.PAID_YES.getCode());
		rentalTrade.setRentalVersion(newVersion);
		rentalTrade.setCreator(userVo.getUserKey());
		rentalTrade.setCreateTime(new Date());
		rentalTradeMapper.insertSelective(rentalTrade);
		map.put("state","1");
		map.put("msg","修改成功");

		return map;
	}
	
	/**
	 * 
	* @Title: getRentalVersionLimit 
	* @param industryId
	* @param rentalVersion
	* @return
	* @return RentalVersionLimit
	* @throws 
	* @Description: 根据版本号和行业获取单条系统所限制的条件
	 */
	public RentalVersionLimit getRentalVersionLimit(String industryId, String rentalVersion){
		PageData pdPara = new PageData();
		pdPara.put("industryId",industryId);
		pdPara.put("rentalVersion", rentalVersion);
		return rentalVersionLimitMapper.selectOneByPrimaryKey(pdPara);
	}
	/**
	 * 
	* @Title: listRentalVersionLimits 
	* @param industryId
	* @return
	* @return List<RentalVersionLimit>
	* @throws 
	* @Description: 根据行业不同获取该行业的所有版本对应的限制条件
	 */
	public List<RentalVersionLimit> listRentalVersionLimits(String industryId){
		PageData pdPara = new PageData();
		pdPara.put("industryId",industryId);
		return rentalVersionLimitMapper.selectListByPrimaryKey(pdPara);
	}
}
