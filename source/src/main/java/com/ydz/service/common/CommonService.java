package com.ydz.service.common;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import com.ydz.config.DZConfig;
import com.ydz.dao.advert.PurchaseCheckingOrderMapper;
import com.ydz.dao.advert.PurchaseOrderMapper;
import com.ydz.dao.advert.SalesCheckingOrderMapper;
import com.ydz.dao.advert.SalesOrderMapper;
import com.ydz.dao.assignment.AssignTaskMapper;
import com.ydz.dao.assignment.AssignWorkingTaskMapper;
import com.ydz.dao.common.*;
import com.ydz.dao.invite.InviteRewardMapper;
import com.ydz.dao.project.ContractProjectMapper;
import com.ydz.dao.project.OpportunityOrderMapper;
import com.ydz.dao.system.RefuseLoginMapper;
import com.ydz.entity.Page;
import com.ydz.service.system.EmployeeService;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.MessageCompanyVO;
import com.ydz.wechat.util.JsonUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ydz.entity.common.City;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.common.Country;
import com.ydz.entity.common.Dict;
import com.ydz.entity.common.GlobalConfig;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.common.MenuInitDict;
import com.ydz.entity.common.Message;
import com.ydz.entity.common.OperateLog;
import com.ydz.entity.common.Province;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.common.UploadFile;
import com.ydz.entity.invite.InviteReward;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.RefuseLogin;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.exception.MediaException;
import com.ydz.exception.ProjectException;
import com.ydz.exception.YdzBusinessException;
import com.ydz.exception.YdzSystemRuntimeException;
import com.ydz.util.EncryptUtils;
import com.ydz.util.FileUpload;
import com.ydz.util.FileUtil;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.UuidUtil;

/** 
 * @ClassName: CommonService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月19日 下午2:51:05 
 * @Description: 用于通用的Service处理
 *  
 */
@Service("commonService")
public class CommonService {
	
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Resource
	RedisUtil redisUtil;
	
	@Autowired private ComConfigMapper comConfigMapper;
	@Autowired private ComSettingClassMapper comSettingClassMapper;
	@Autowired private DictMapper dictMapper;
	@Autowired private GlobalConfigMapper globalConfigMapper;
	
	@Autowired private ProvinceMapper provinceMapper;
	@Autowired private CityMapper cityMapper;
	@Autowired private CountryMapper countryMapper;
	@Autowired private LoginLogMapper loginLogMapper;
	
	@Autowired private SalesOrderMapper salesOrderMapper;
	@Autowired private SalesCheckingOrderMapper salesCheckingOrderMapper;
	@Autowired private PurchaseOrderMapper purchaseOrderMapper;
	@Autowired private PurchaseCheckingOrderMapper purchaseCheckingOrderMapper;
	@Autowired private OperateLogMapper operateLogMapper;
	@Autowired private AssignTaskMapper assignTaskMapper;
	@Autowired private AssignWorkingTaskMapper assignWorkingTaskMapper;
	@Autowired private OpportunityOrderMapper opportunityOrderMapper;
	@Autowired private ContractProjectMapper contractProjectMapper;
	
	@Autowired private MessageMapper messageMapper;
	@Autowired private InviteRewardMapper inviteRewardMapper;
	@Autowired private SmsLogMapper smsLogMapper;
	
	@Autowired private MenuInitDictMapper menuInitDictMapper;
	
	@Autowired private RefuseLoginMapper refuseLoginMapper;
	
	@Autowired private UploadFilesMapper uploadFilesMapper;
	
	
	@Resource private DZConfig dzConfig;
	
	
	@Resource
	private EmployeeService employeeService;
	
	public Integer insertSelective(Message message){
		return messageMapper.insertSelective(message);
	}
	
	/**
	 * 
	* @Title: selectCountMessageUnRead 
	* @param pd acceptUserKey，acceptComKey，status，type
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 统计消息的状态计数
	 */
	public int getCountMessageUnRead(PageData pd) throws Exception{
		return messageMapper.selectCountReadStatus(pd);
	}
	
	public List<Message> getMessageList(Page page){
		return messageMapper.listPageMessages(page);
	}

	public Message selectOneByPrimaryKey(String messageId){
		PageData pd = new PageData();
		pd.put("msgId",messageId);
		Message message = messageMapper.selectOneByPrimaryKey(pd);
		return message;
	}

	public int updateByPrimaryKeySelective(Message message){
		return messageMapper.updateByPrimaryKeySelective(message);
	}

	/**
	 * 
	 * @Title: updateMessageInfoToMarkRead 
	 * @param messageId
	 * @return
	 * @return Message
	 * @throws 
	 * @Description: 修改为消息已读
	 */
	public Message updateMessageInfoToMarkRead(String messageId) {
		//1.获取该消息
		PageData pd = new PageData();
		pd.put("msgId",messageId);
		Message message = messageMapper.selectOneByPrimaryKey(pd);

		//2.如果消息不空 且状态是未读修改该消息的查看状态(已读)
		if(message != null && MessageEnum.UNREAD.getCode().equals(message.getStatus())){
				message.setStatus(MessageEnum.MARKREAD.getCode());
				messageMapper.updateByPrimaryKeySelective(message);
		}

		return message;
	}
	
	public List<MessageCompanyVO> listPageMsgComVo(Page page) throws Exception{
		List<MessageCompanyVO> companies = messageMapper.listPageFriendRequest(page);
		for(MessageCompanyVO messageCompanyVO : companies){
			EmployeeVo employeeVo1 = employeeService.getAdmin(messageCompanyVO.getComKey());
			if(employeeVo1 != null){
				messageCompanyVO.setAdminName(employeeVo1.getUserName());
				messageCompanyVO.setAdminPhone(employeeVo1.getUserPhone());
			}else{
				messageCompanyVO.setAdminName("无");
				messageCompanyVO.setAdminPhone("无");
			}

			EmployeeVo employeeVo2 = employeeService.getBoss(messageCompanyVO.getComKey());
			if(employeeVo2 != null){
				messageCompanyVO.setBossName(employeeVo2.getUserName());
				messageCompanyVO.setBossPhone(employeeVo2.getUserPhone());
			}else{
				messageCompanyVO.setBossName("无");
				messageCompanyVO.setBossPhone("无");
			}
		}
		return companies;
		
		
	}

	//根据provinceName获取Province对象
	public Province getProvinceByName(String provinceName) throws Exception{
		PageData pd = new PageData();
		pd.put("provinceName", provinceName);
		return provinceMapper.selectByProvice(pd);
	}
	
	//根据cityName检索City
	public City getOneCityByName(String cityName) {
		PageData pd = new PageData();
		pd.put("cityName", cityName);
		return cityMapper.selectByCity(pd);
	}

	/**
	 * 
	* @Title: getDictValue 
	* @param @param dictKey
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据传入的dictKey获取dictValue
	*
	 */
	public String getDictValue(String dictKey){
		String dictValue = null;
		try{
			Dict dict = dictMapper.selectByPrimaryKey(dictKey);
			dictValue = dict!=null?dict.getDictValue():"";
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dictValue;
	}
	
	/**
	 * 
	* @Title: selectListDictValue 
	* @param @param pd 包括dictKey，dictKeyIn，dictKeyLike，pKey
	* @param @return
	* @return List<Dict>
	* @throws
	* @Description: 根据传入的参数获取字典表记录的List
	 */
	public List<Dict> selectListDictValue(PageData pd){
		return dictMapper.listDictValue(pd);
	}
	
	/**
	 * 
	* @Title: getComConfigValue
	* @param @param pd 参数包括comKey，configKey
	* @param @return
	* @return ComConfig
	* @throws 
	* @Description: 查询公司配置参数
	 */
	public ComConfig getOneComConfig(PageData pd){
		List<ComConfig> comConfigs = this.getComConfigs(pd);
		ComConfig comConfig = null;
		if (comConfigs!=null&&comConfigs.size()>0) {
			comConfig = comConfigs.get(0); 
		}
		return comConfig;
	}
	public List<ComConfig> getComConfigs(PageData pd){
		return comConfigMapper.selectByPrimaryKey(pd);
	}
	public int insertComConfig(ComConfig comConfig){
		return comConfigMapper.insertSelective(comConfig);
	}
	public int updateComConfig(ComConfig comConfig){
		return comConfigMapper.updateByPrimaryKeySelective(comConfig);
	}
	public int deleteComConfig(PageData pd){
		return comConfigMapper.deleteByPrimaryKey(pd);
	}
	
	public List<ComSettingClass> listComSettingClasses(PageData pd){
		return comSettingClassMapper.selectByPrimaryKey(pd);
	}
	
	public int selectMaxTypeCodeByPrimaryKey(PageData pd){
		Integer maxTypeCode = comSettingClassMapper.selectMaxTypeCodeByPrimaryKey(pd);
		if(maxTypeCode==null){
			return 0;
		}else{
			return maxTypeCode.intValue();
		}
	}
	public ComSettingClass getOneComSettingClass(PageData pd){
		List<ComSettingClass> comSettingClasses = this.listComSettingClasses(pd);
		if (comSettingClasses!=null&&comSettingClasses.size()>0) {
			return comSettingClasses.get(0);
		}else{
			return null;
		}
	}
	public int insertComSettingClass(ComSettingClass comSettingClass) throws YdzBusinessException{
		return comSettingClassMapper.insertSelective(comSettingClass);
	}
	public int insertListComSettingClass(List<ComSettingClass> comSettingClasses) throws YdzBusinessException{
		return comSettingClassMapper.insertList(comSettingClasses);
	}
	public int updateComSettingClass(ComSettingClass comSettingClass) throws YdzBusinessException{
		return comSettingClassMapper.updateByPrimaryKeySelective(comSettingClass);
	}
	public int deleteComSettingClass(PageData pd) throws YdzBusinessException{
		return comSettingClassMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: insertLoginLog 
	* @param log
	* void
	* @throws 
	* @Description: 插入本次登录日志
	 */
	public void insertLoginLog(LoginLog log){
		loginLogMapper.insert(log);
	}
	
	/**
	 * 
	* @Title: getLoginLog 
	* @param pd userKey
	* @return
	* @throws Exception
	* @return LoginLog
	* @throws 
	* @Description: 获取当前用户上一次登陆信息
	 */
	public LoginLog getLoginLog(PageData pd) throws Exception{
		PageData pdPara = new PageData();
		pdPara.put("userKey", pd.getString("userKey"));
		List<LoginLog> logs = loginLogMapper.selectByPrimaryKey(pdPara);
		if(logs!=null){
			if(logs.size()==2){
				return logs.get(1);
			}else if(logs.size()==1){
				return logs.get(0);
			}else{
				return null;
			}
		}
		return null;
	}
	
	public List<TodoCountVO> getTodoList(PageData pd){
		List<TodoCountVO> todoList = new ArrayList<TodoCountVO>();
		try{
			PageData pdPara = new PageData();
			pdPara.put("comKey", pd.getString("comKey"));
			
			//=====采购订单
			pdPara.put("orderStatus", OrderEnum.STATUS_DAIDUIZHANG.getCode()); //协同待对账
			pdPara.put("isSynchro", null);
			TodoCountVO synchroPurchaseTodo = purchaseOrderMapper.selectCountOrderStatus(pdPara);
			synchroPurchaseTodo.setOrderType("P");
			synchroPurchaseTodo.setOrderStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
			todoList.add(synchroPurchaseTodo);
			
			//=====采购对账单
			pdPara.put("orderStatus", OrderEnum.STATUS_DAIFUKUAN.getCode()); //协同待付款
			pdPara.put("isSynchro", null);
			TodoCountVO synchroPurchaseCheckingTodo = purchaseCheckingOrderMapper.selectCountOrderStatus(pdPara);
			synchroPurchaseCheckingTodo.setOrderType("P");
			synchroPurchaseCheckingTodo.setOrderStatus(OrderEnum.STATUS_DAIFUKUAN.getCode());
			todoList.add(synchroPurchaseCheckingTodo);

			//=====销售订单			
			pdPara.put("orderStatus", OrderEnum.STATUS_DAIJIJIA.getCode()); //销售待计价
			TodoCountVO salesTodo01 = salesOrderMapper.selectCountOrderStatus(pdPara);
			salesTodo01.setOrderType("S");
			salesTodo01.setOrderStatus(OrderEnum.STATUS_DAIJIJIA.getCode());
			todoList.add(salesTodo01);
			
			//=====销售对账单
			pdPara.put("orderStatus", OrderEnum.STATUS_DAIDUIZHANG.getCode()); //销售待对账
			TodoCountVO salesTodo04 = salesOrderMapper.selectCountOrderStatus(pdPara);
			salesTodo04.setOrderType("S");
			salesTodo04.setOrderStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
			todoList.add(salesTodo04);
			
			pdPara.put("orderStatus", OrderEnum.STATUS_DAISHOUKUAN.getCode()); //销售待收款
			TodoCountVO salesTodo07 = salesCheckingOrderMapper.selectCountOrderStatus(pdPara);
			salesTodo07.setOrderType("S");
			salesTodo07.setOrderStatus(OrderEnum.STATUS_DAISHOUKUAN.getCode());
			todoList.add(salesTodo07);
			
			//=======设计派工 进行中
			TodoCountVO assignTodo = assignTaskMapper.selectCountAssignStatus(pdPara);
			assignTodo.setOrderType("DESIGN");
			todoList.add(assignTodo);
			
			//制作派工 5制作中
			TodoCountVO workingTodo = assignWorkingTaskMapper.selectCountWorkingStatus(pdPara);
			workingTodo.setOrderType("WORKING");
			todoList.add(workingTodo);
			
			//=======商机报价 商机阶段：01商机、02需求报价、03谈判
			List<TodoCountVO> oppoTodos = opportunityOrderMapper.selectCountOppoSection(pdPara);
			if (oppoTodos!=null&&oppoTodos.size()>0) {
				for (TodoCountVO oppoTodo : oppoTodos) {
					oppoTodo.setOrderType("OPPO");
					todoList.add(oppoTodo);
				}
			}
			
			//=======项目合同 01执行中
			TodoCountVO contractTodo = contractProjectMapper.selectCountContract(pdPara);
			contractTodo.setOrderType("CONTRACT");
			todoList.add(contractTodo);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return todoList;
	}
	
//======= 邀请奖励
	
	/**
	 * 
	* @Title: listPageInviteRewards 
	* @param page
	* @return
	* @throws Exception
	* @return List<InviteReward>
	* @throws 
	* @Description: 查询带分页的邀请激励记录
	 */
	public List<InviteReward> listPageInviteRewards(Page page) throws Exception{
		return inviteRewardMapper.listPageInviteReward(page);
	}

	/**
	 *  查询奖励总金额
	 * @return
	 */
	public BigDecimal getSumReward(PageData pd){
		return inviteRewardMapper.getSumReward(pd);
	}

	public List<InviteReward> getListByKey(PageData pd){
		return inviteRewardMapper.getListByKey(pd);
	}

	/**
	 * 
	* @Title: insertInviteReward 
	* @param inviteReward
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 插入邀请奖励记录
	 */
	public int insertInviteReward(InviteReward inviteReward) throws Exception{
		return inviteRewardMapper.insertSelective(inviteReward);
	}
	
	/**
	 * 
	* @Title: insertOperateLog 
	* @param operLog
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 记录操作日志
	 */
	public int insertOperateLog(OperateLog operLog) throws Exception{
		return operateLogMapper.insertSelective(operLog);
	}
	
	/**
	 * 
	* @Title: listSmsLogs 
	* @param pd smsFrom, smsTo, startTime, endTime
	* @return List<SmsLog>
	* @throws 
	* @Description: 根据发送人，接收人，发送时间从某某到某某等条件查询短信发送日志
	 */
	public List<SmsLog> listSmsLogs(PageData pd){
		return smsLogMapper.selectByPrimaryKey(pd);
	}
	
	public int insertSmsLog(SmsLog smsLog){
		return smsLogMapper.insertSelective(smsLog);
	}
	
	/**
	 * 
	* @Title: getMenuInitDict 
	* @param pd menuId,resourceId
	* @return MenuInitDict
	* @throws 
	* @Description: 获取单条菜单字典记录表
	 */
	public MenuInitDict getMenuInitDict(PageData pd){
		return menuInitDictMapper.selectOneByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: listMenuInitDicts 
	* @param pd menuId,resourceId
	* @return List<MenuInitDict>
	* @throws 
	* @Description: 获取多条菜单字典记录表
	 */
	public List<MenuInitDict> listMenuInitDicts(PageData pd){
		return menuInitDictMapper.selectListByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: updateMenuInitDict 
	* @param menuInitDict
	* @return int
	* @throws 
	* @Description: 更新菜单字典表
	 */
	public int updateMenuInitDict(MenuInitDict menuInitDict){
		return menuInitDictMapper.updateByPrimaryKeySelective(menuInitDict);
	}
	
	/**
	 * 
	 * @Title: getLocationMap 
	 * @param ip
	 * @param phone
	 * @return
	 * @throws Exception
	 * @return Map<String,Object>
	 * @throws 
	 * @Description: 根据ip和电话号码获取省市县信息
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getLocationMap(String ip,String phone) throws Exception{
		String[] centrals = new String[]{"110000","310000","120000","500000"}; //判断直辖市
		List<String> central_list = Tools.strArray2List(centrals);
		//通过ip获取省市县
		Map<String,Object> map = PublicUtil.getInstance().getTaobaoIpLocation(ip);
        String region = map.get("region")!=null?map.get("region").toString():null;
        if(StringUtil.isEmpty(region)){
        	//通过ip获取失败后，就通过解析手机号获取
        	map = PublicUtil.getInstance().getPhoneLocation(phone);
        	region = map.get("region")!=null?map.get("region").toString():null;
        	String cityName = map.get("city")!=null?map.get("city").toString():null;

        	if(StringUtil.isNotEmpty(region)){
        		Province province = this.getProvinceByName(region);
        		if(province!=null){
        			map.put("state", "0");
        			map.put("region", province.getProvinceName());
        			map.put("region_id", province.getProvinceId());
        			if(central_list.contains(province.getProvinceId())==true){
        				map.put("city",province.getProvinceName());
            			map.put("city_id", province.getProvinceId().substring(0,3)+"100");
        			}else{
        				City city = this.getOneCityByName(cityName);
            			map.put("city", city.getCityName());
            			map.put("city_id", city.getCityId());
        			}
        		}else{
        			map.put("state", "1");
        		}
        	}else{
        		map.put("state", "1");
        	}
        }
        return map;
	}
	
	/**
	 * 
	 * @Title: getFormatProvinceId 
	 * @param originProvinceId
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 处理直辖市港澳台的省份代码
	 */
	public String getFormatProvinceId(String originProvinceId){
		String destProvinceId = null;
		String[] centrals = new String[]{"110000","310000","120000","500000","810000","820000","710000"}; //判断直辖市，港澳台
    	List<String> central_list = Tools.strArray2List(centrals);
    	if(central_list.contains(originProvinceId)){
    		if(originProvinceId.equals("110000")){ //北京
    			destProvinceId = "110100";
    		}else if(originProvinceId.equals("310000")){ //上海
    			destProvinceId = "310100";
    		}else if(originProvinceId.equals("120000")){ //天津
    			destProvinceId = "120100";
    		}else if(originProvinceId.equals("500000")){ //重庆
    			destProvinceId = "500100";
    		}else if(originProvinceId.equals("810000")){ //香港
    			destProvinceId = "810000";
    		}else if(originProvinceId.equals("820000")){ //澳门
    			destProvinceId = "820000";
    		}else if(originProvinceId.equals("710000")){ //台湾
    			destProvinceId = "710000";
    		}
    	}
    	return destProvinceId;
	}
	
	/**
	 * 
	 * @Title: getListGlobalConfigs 
	 * @param industryId
	 * @param type
	 * @param code
	 * @return
	 * @return List<GlobalConfig>
	 * @throws 
	 * @Description: 根据行业ID，配置类型，配置编码等，获取对应的全局参数集和
	 */
	public List<GlobalConfig> getListGlobalConfigs(String industryId,String type,String code){
		PageData pd = new PageData();
		pd.put("industryId", industryId);
		pd.put("cfgType", type);
		pd.put("cfgCode", code);
		return globalConfigMapper.selectListByPrimaryKey(pd);
	}
	/**
	 * 
	 * @Title: getGlobalConfigs 
	 * @param industryId
	 * @param type
	 * @param code
	 * @return
	 * @return GlobalConfig
	 * @throws 
	 * @Description: 根据行业ID，配置类型，配置编码等，获取对应的全局参数对象
	 */
	public GlobalConfig getGlobalConfigs(String industryId,String type,String code){
		List<GlobalConfig> globalConfigs = this.getListGlobalConfigs(industryId, type, code);
		return globalConfigs.get(0);
	}
	
	/**
	 * 
	 * @Title: getMapGlobalConfig 
	 * @param industryId
	 * @param type
	 * @param code
	 * @return
	 * @return Map<String,Object>
	 * @throws 
	 * @Description: 将查询的全局配置结果集转为Map对象返回。
	 */
	public Map<String, Object> getMapGlobalConfig(String industryId,String type,String code){
		Map<String,Object> resMap = new HashMap<String,Object>();
		List<GlobalConfig> globalConfigs = this.getListGlobalConfigs(industryId, type, code);
		for (GlobalConfig globalConfig : globalConfigs) {
			resMap.put(globalConfig.getCfgCode(), globalConfig.getCfgDesc());
		}
		return resMap;
	}
	
	public List<Province> listAllProvince(){
		return provinceMapper.listAllProvince(null);
	}
	
	public List<City> listAllCity(){
		return cityMapper.listAllCityByProvince(null);
	}
	
	public List<Country> listAllCountry(){
		return countryMapper.listAllCountryByCity(null);
	}
	
	/**
	 * 
	 * @Title: sendSmsToBoss 
	 * @param bossNum 老板手机号
	 * @param realName 注册人姓名
	 * @param regTypeDesc 注册方式说明
	 * @param userId 注册人手机号
	 * @param comName 注册公司名
	 * @param location 注册位置 IP或手机号获取省市县
	 * @throws Exception
	 * @return void
	 * @throws 
	 * @Description: 发送注册信息给老板用于跟踪
	 */
	public void sendSmsToBoss(String bossNum,String realName,String regTypeDesc,String userId,
			String comName,String location) 
			throws Exception{
		if (StringUtil.isNotEmpty(bossNum)) {
			List<String> mobiles = Tools.strArray2List(Tools.str2StrArray(bossNum));
			for (String mobile : mobiles) {
				SMSUtil.sendNewCompanyToBoss(mobile,realName, regTypeDesc, userId, comName,location);
			}
		}
	}
	
	public boolean validateRefuseLogin(PageData pd){
		RefuseLogin refuseLogin = refuseLoginMapper.selectByPrimaryKey(pd);
		if(refuseLogin!=null&&StringUtil.isNotEmpty(refuseLogin.getUserId())){
			return true;
		}else{
			return false;
		}
	}
	
	public String formatVoucherStatus(String voucherStatus){
		String desc = "";
		if (StringUtil.isNotEmpty(voucherStatus)) {
			switch (voucherStatus) {
			case "0":
				desc = RentalTradeEnum.VOUCHER_STATUS_UNUSED.getDesc();
				break;
			case "1":
				desc = RentalTradeEnum.VOUCHER_STATUS_USED.getDesc();
				break;
			case "2":
				desc = RentalTradeEnum.VOUCHER_STATUS_OUTDATE.getDesc();
				break;

			default:
				break;
			}
		}
		return desc;
	}
	
//	public String formatRentalVersion(String rentalVersion){
//		String desc = "";
//		if (StringUtil.isNotEmpty(rentalVersion)) {
//			switch (rentalVersion) {
//			case "0T":
//				desc = RentalTradeEnum.VERSION_FREE_EDITION.getDesc();
//				break;
//			case "01":
//				desc = RentalTradeEnum.VERSION_BASIC_EDITION.getDesc();
//				break;
//			case "02":
//				desc = RentalTradeEnum.VERSION_PROFESSIONAL_EDITION.getDesc();
//				break;
//			case "03":
//				desc = RentalTradeEnum.VERSION_ADVANCED_EDITION.getDesc();
//				break;
//
//			default:
//				break;
//			}
//		}
//		return desc;
//	}
	
	public String formatRentalPeriod(String rentalPeriod){
		String desc = "";
		switch (rentalPeriod) {
		case "T":
			desc = RentalTradeEnum.PERIOD_TRIAL.getDesc();
			break;
		case "1":
			desc = RentalTradeEnum.PERIOD_USING.getDesc();
			break;
		case "0":
			desc = RentalTradeEnum.PERIOD_OUTDATE.getDesc();
			break;

		default:
			break;
		}
		return desc;
	}
	
	public String formatPaymentType(String paymentType){
		String desc = "";
		switch (paymentType) {
		case "0":
			desc = RentalTradeEnum.PAYMENT_FREE.getDesc();
			break;
		case "T":
			desc = RentalTradeEnum.PAYMENT_TRIAL.getDesc();
			break;
		case "1":
			desc = RentalTradeEnum.PAYMENT_ALIPAY.getDesc();
			break;
		case "2":
			desc = RentalTradeEnum.PAYMENT_WECHAT.getDesc();
			break;

		default:
			break;
		}
		return desc;
	}
	
	
//	public String formatIndustry(String industryId){
//		String desc = "";
//		switch (industryId) {
//		case "1A":
//			desc = CompanyEnum.INDUSTRY_CLASS_SHEJI.getDesc();
//			break;
//		case "1B":
//			desc = CompanyEnum.INDUSTRY_CLASS_CHUANMEI.getDesc();
//			break;
//		case "1C":
//			desc = CompanyEnum.INDUSTRY_CLASS_JIAGONGZHIZUO.getDesc();
//			break;
//		case "1D":
//			desc = CompanyEnum.INDUSTRY_CLASS_TUWENKUAIYIN.getDesc();
//			break;
//			
//		default:
//			break;
//		}
//		return desc;
//	}
	
	public String formatEmployeeStatus(String employeeStatus){
		String desc = "";
		switch (employeeStatus) {
		case "0":
			desc = CompanyEnum.EMPLOYEE_STATUS_PENDING_INVITE.getDesc();
			break;
		case "1":
			desc = CompanyEnum.EMPLOYEE_STATUS_INVITING.getDesc();
			break;
		case "2":
			desc = CompanyEnum.EMPLOYEE_STATUS_PENDING_CHECK.getDesc();
			break;
		case "3":
			desc = CompanyEnum.EMPLOYEE_STATUS_NORMAL.getDesc();
			break;
		case "4":
			desc = CompanyEnum.EMPLOYEE_STATUS_DISMISSION.getDesc();
			break;
		case "5":
			desc = CompanyEnum.EMPLOYEE_STATUS_REFUSED.getDesc();
			break;
		default:
			break;
		}
		return desc;
	}
	
	public String formatAccountPayee(String accountType){
		String desc = "";
		switch (accountType) {
		case "00":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_CASH.getDesc();
			break;
		case "01":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_WECHAT.getDesc();
			break;
		case "02":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_ALIPAY.getDesc();
			break;
		case "03":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_ICBC.getDesc();
			break;
		case "04":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_CCB.getDesc();
			break;
		case "05":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_BC.getDesc();
			break;
		case "06":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_ABC.getDesc();
			break;
		case "07":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_TRANSTER.getDesc();
			break;
		case "08":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_PREPAY.getDesc();
			break;
		case "09":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getDesc();
			break;
		case "10":
			desc = OrderEnum.ACCOUNT_PAYEE_TYPE_WECHATAPP.getDesc();
			break;
		default:
			break;
		}
		return desc;
	}
	
	public String formatRegisterType(String regType){
		String desc = "";
		switch (regType) {
		case "0":
			desc = SystemEnum.REG_TYPE_PC.getDesc();
			break;
		case "1":
			desc = SystemEnum.REG_TYPE_IOS.getDesc();
			break;
		case "2":
			desc = SystemEnum.REG_TYPE_ANDROID.getDesc();
			break;
		case "3":
			desc = SystemEnum.REG_TYPE_IOS_BROWSER.getDesc();
			break;
		case "4":
			desc = SystemEnum.REG_TYPE_ANDROID_BROWSER.getDesc();
			break;
		default:
			break;
		}
		return desc;
		
	}
	
	/**
	 * 
	 * @Title: getShareUrlForOrder 
	 * @param url 需要分享的页面
	 * @param industryId
	 * @param orderNo
	 * @param comKey
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 把需要分享的订单长地址加密后转为短地址返回
	 */
	public String getShareUrlForOrder(String url,String industryId,String orderNo,String comKey){
		if (StringUtil.isEmpty(industryId)
				||StringUtil.isEmpty(orderNo)
				||StringUtil.isEmpty(comKey)) {
			return null;
		}
		String shareUrl = dzConfig.webPath+url+"?key1="+EncryptUtils.getInstance().encryptDESByKey(
        		industryId+"-"+orderNo+"-"+comKey);
		return PublicUtil.getInstance().getShortUrl(shareUrl);
	}
	
	public void insertComSettingClassForException(
			ComSettingClass comSettingClass) throws YdzBusinessException {
		try {
			this.insertComSettingClass(comSettingClass);
			throw new YdzBusinessException("测试抛出业务异常");
		} catch (YdzBusinessException e1) {
			logger.info(e1.getMessage());
			throw new YdzSystemRuntimeException("需要回滚");
		} catch (Exception e) {
			logger.info("大异常啊");
			throw new YdzBusinessException();
		}
	}
	
	public int insertOneUploadFile(UploadFile uploadFile) throws Exception{
		return uploadFilesMapper.insertSelective(uploadFile);
	}
	public int deleteUploadFiles(PageData pd) throws Exception{
		return uploadFilesMapper.deleteByPrimaryKey(pd);
	}
	public List<UploadFile> listUploadFiles(PageData pd){
		return uploadFilesMapper.listUploadFiles(pd);
	}
	public UploadFile selectOneUploadFile(PageData pd){
		List<UploadFile> files = uploadFilesMapper.listUploadFiles(pd);
		if (files!=null&&files.size()>0) {
			return files.get(0);
		}else{
			return null;
		}
	}
	
	public int deleteAttachmentFile(PageData pd)
			throws Exception{
			int result = 0;
			try {
				UploadFile file = this.selectOneUploadFile(pd);
				if (file!=null) {
					result = this.deleteUploadFiles(pd);
					if (result>0) {
						FileUtil.delFile(file.getFilePath()+file.getFileName());
					}else{
						logger.info("删除附件记录失败");
					}
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
				throw new ProjectException("删除附件失败");
			}
			
			return result;
		}
	
	/**
	 * 
	 * @Title: getConcatEmployeeName 
	 * @param employees
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 高效拼接用户字符串
	 */
	public String getConcatEmployeeName(List<Employee> employees){
		StringBuilder sb = new StringBuilder(employees.size()*10);
		for (Employee employee : employees) {
			if (sb.length() > 0)
				sb.append("、");
			sb.append(employee.getRealName());
		}
		return sb.toString();
	}
	
	public String insertMultiFileUpload(
			Map<String, MultipartFile> multiPartFiles, PageData pd)
			throws Exception {
		List<String> fileIdList = new ArrayList<>();
		try {
			Iterator it = multiPartFiles.entrySet().iterator();
			while(it.hasNext()){
				Entry entry = (Entry) it.next();
				MultipartFile file = (MultipartFile) entry.getValue();
				pd.put("fileId", UuidUtil.get32UUID());
				pd.put("orderNo", pd.getString("orderNo"));
				pd.put("fileName", file.getOriginalFilename());
				int resultCount = this.insertUploadFile(pd); //插入数据库
				if (resultCount>0) {
					try {
						FileUpload.fileUpSimple(file, pd.getString("filePath"), file.getOriginalFilename()); //上传附件
					} catch (Exception e) {
						logger.error(e.getMessage());
						this.deleteUploadFiles(pd); //上传失败后删除插入的记录
						throw new YdzBusinessException("上传文件失败");
					}
					fileIdList.add(pd.getString("fileId"));
				}
				
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new YdzBusinessException("上传文件失败");
		}
		return JsonUtil.toCompatibleJSONString(fileIdList);
	}
	
	private int insertUploadFile(PageData pd)
		throws Exception{
		UploadFile uploadFile = new UploadFile();
		uploadFile.setFileId(pd.getString("fileId"));
		uploadFile.setOrderNo(pd.getString("orderNo"));
		uploadFile.setComKey(pd.getString("comKey"));
		uploadFile.setFileName(pd.getString("fileName"));
		uploadFile.setFilePath(pd.getString("filePath"));
		uploadFile.setFileType(pd.getString("fileType")); //文件类型
		uploadFile.setIsDel("0");
		uploadFile.setCreator(pd.getString("userKey"));
		uploadFile.setCreateTime(new Date());
		return this.insertOneUploadFile(uploadFile);
	}

}

