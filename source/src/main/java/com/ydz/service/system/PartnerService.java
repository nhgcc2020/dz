/**
 * 
 */
package com.ydz.service.system;

import com.alibaba.fastjson.JSON;
import com.ydz.dao.advert.SalesCheckingOrderMapper;
import com.ydz.dao.advert.SalesOrderMapper;
import com.ydz.dao.common.MessageMapper;
import com.ydz.dao.common.SmsLogMapper;
import com.ydz.dao.system.ComPartnerConsumeLogMapper;
import com.ydz.dao.system.ComPartnerMapper;
import com.ydz.dao.system.ComPartnerRechargeLogMapper;
import com.ydz.dao.system.CompanyMapper;
import com.ydz.dao.system.PartnerContacterMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesCheckingOrder;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.common.Message;
import com.ydz.entity.common.SmsLog;
import com.ydz.entity.system.*;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.MessageEnum;
import com.ydz.util.*;
import com.ydz.util.Security.CipherUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.ComPartnerTotalPriceVO;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

/** 
 * @ClassName: PartnerService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年6月30日 下午4:43:19 
 * @Description: 合作伙伴处理
 *  
 */
@Service("partnerService")
public class PartnerService{

	private final Logger logger = Logger.getLogger(PartnerService.class);
	
	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private PartnerMapper partnerMapper;
	@Autowired
	private PartnerContacterMapper partnerContacterMapper;
	@Autowired
	private ComPartnerMapper comPartnerMapper;
	@Autowired
	private ComPartnerRechargeLogMapper comPartnerRechargeLogMapper;
	@Autowired
	private ComPartnerConsumeLogMapper comPartnerConsumeLogMapper;

	@Autowired
	private MessageMapper messageMapper;
	@Autowired
	private SmsLogMapper smsLogMapper;
	@Autowired
	private CompanyMapper companyMapper;
	@Autowired
	private SalesOrderMapper salesOrderMapper;
	@Autowired
	private SalesCheckingOrderMapper salesCheckingOrderMapper;
	@Autowired
	private CompanyService companyService;

	@Autowired
	private RedisUtil redisUtil;

	public List<Company> getInfoByKey(PageData pd){
		 return companyMapper.getInfoByKey(pd);
	}


	
	
	//查询单个合作伙伴联系人
	public PartnerContacter selectOnePartnerContacter(PageData pd){
		return partnerContacterMapper.selectOnePartnerContacter(pd);
	}
	//查询合作伙伴联系人列表
	public List<PartnerContacter> listPartnerContacter(PageData pd){
		return partnerContacterMapper.listPartnerContacter(pd);
	}
	//新增合作伙伴联系人
	public int insertOnePartnerContacter(PartnerContacter partnerContacter) throws Exception{
		return partnerContacterMapper.insertSelective(partnerContacter);
	}
	//修改合作伙伴联系人
	public int updateOnePartnerContacter(PartnerContacter partnerContacter) throws Exception{
		return partnerContacterMapper.updateByPrimaryKeySelective(partnerContacter);
	}
	public int deletePartnerContacter(PageData pd) throws Exception{
		return partnerContacterMapper.deleteByPrimaryKey(pd);
	}

	/**
	 * 修改生意伙伴
	 * @param partnerVO
	 * @param userVo
	 * @return
	 */
	public Map modPartner(PartnerVO partnerVO,UserVo userVo){
		Map<String, Object> result = new HashMap<>();

		//查询该生意伙伴是否已经建了订单
		PageData pd = new PageData();
		pd.put("partnerKey",partnerVO.getPartnerKey());
		Partner partner = partnerMapper.selectByPrimaryKey(pd);

		Partner partnerMod = new Partner();
		PartnerContacter partnerContacter = new PartnerContacter();
		//3.修改
		partnerMod.setPartnerKey(partnerVO.getPartnerKey());
		//企业全称
		boolean partnerFlag = false;
		if(!partner.getPartnerName().equals(partnerVO.getPartnerName())){
			partnerMod.setPartnerName(partnerVO.getPartnerName() == null ? "" : partnerVO.getPartnerName());
			partnerFlag = true;
		}
		//企业简称
		boolean partnerShortNameFlag = false;
		if(!partner.getPartnerShortname().equals(partnerVO.getPartnerShortname())){
			partnerMod.setPartnerShortname(partnerVO.getPartnerShortname() == null ? "" : partnerVO.getPartnerShortname());
			partnerShortNameFlag = true;
		}
		//公司电话
		partnerMod.setPartnerTel(StringUtil.isEmpty(partnerVO.getPartnerTel()) ? "" : partnerVO.getPartnerTel());
		//公司QQ
		partnerMod.setPartnerQQ(StringUtil.isEmpty(partnerVO.getPartnerQQ()) ? "" : partnerVO.getPartnerQQ());
		//助记码
		partnerMod.setMnemonicCode(StringUtil.isEmpty(partnerVO.getMnemonicCode()) ? "" : partnerVO.getMnemonicCode());
		//省
		partnerMod.setPartnerProvince(StringUtil.isEmpty(partnerVO.getPartnerProvince()) ? "" : partnerVO.getPartnerProvince());
		//市
		partnerMod.setPartnerCity(StringUtil.isEmpty(partnerVO.getPartnerCity())? "" : partnerVO.getPartnerCity());
		//县
		partnerMod.setPartnerCountry(StringUtil.isEmpty(partnerVO.getPartnerCountry())?"":partnerVO.getPartnerCountry());
		//伙伴分类
		//partnerMod.setPartnerType(partnerVO.getPartnerType() == null ? "":partnerVO.getPartnerType());
		//合作级别
		partnerMod.setPartnerLevel(StringUtil.isEmpty(partnerVO.getPartnerLevel())?"":partnerVO.getPartnerLevel());
		//公司地址
		partnerMod.setPartnerAddress(StringUtil.isEmpty(partnerVO.getPartnerAddress())?"":partnerVO.getPartnerAddress());
		partnerMod.setChanger(userVo.getUserKey());
		partnerMod.setChangeTime(new Date());
		partnerMod.setPartnerType(StringUtil.isEmpty(partnerVO.getPartnerType())?CompanyEnum.PARTNER_TYPE_ALL.getCode():partnerVO.getPartnerType());
		partnerMod.setRemarks(partnerVO.getRemarks() == null ? "" : partnerVO.getRemarks());
		partnerMod.setTaxNo(StringUtil.isEmpty(partnerVO.getTaxNo())?"":partnerVO.getTaxNo());
		partnerMapper.updateByPrimaryKeySelective(partnerMod);
		partnerContacter.setUid(partnerVO.getPcUid());
		partnerContacter.setTel1(StringUtil.isEmpty(partnerVO.getTel1())?"":partnerVO.getTel1());
		//联系姓名
		partnerContacter.setContacterName(partnerVO.getContacterName() == null ? "" : partnerVO.getContacterName());
		partnerContacterMapper.updateByPrimaryKeySelective(partnerContacter);
		//伙伴名称是否修改
		if(partnerFlag || partnerShortNameFlag){
			//被修改 查看是否有关于
			PageData numPD = new PageData();
			numPD.put("comKey",userVo.getComKey());
			numPD.put("partnerKey",partnerVO.getPartnerKey());
			OrderTotalVO orderTotalVO = salesOrderMapper.selectSumSalesOrder(numPD);
			if(orderTotalVO.getOrderCount() > 0){
				//同步订单和对账单的partner_name和partner_shortname
				SalesOrder salesOrder = new SalesOrder();
				salesOrder.setComKey(userVo.getComKey());
				salesOrder.setPartnerKey(partnerVO.getPartnerKey());
				salesOrder.setPartnerName(partnerVO.getPartnerName());
				salesOrder.setPartnerShortname(partnerVO.getPartnerShortname());
				salesOrderMapper.updateByPartnerKey(salesOrder);
				//对账单
				SalesCheckingOrder salesCheckingOrder = new SalesCheckingOrder();
				salesCheckingOrder.setComKey(userVo.getComKey());
				salesCheckingOrder.setPartnerKey(partnerVO.getPartnerKey());
				salesCheckingOrder.setPartnerName(partnerVO.getPartnerName());
				salesCheckingOrder.setPartnerShortname(partnerVO.getPartnerShortname());
				salesCheckingOrderMapper.updateByPartnerKey(salesCheckingOrder);
			}
		}
		
		//同时修改公司的专有客户定价中的级别。如果有的话
		if ("1C".equalsIgnoreCase(userVo.getDetailIndustryId())
				||"1D".equalsIgnoreCase(userVo.getDetailIndustryId())) {
			ComPartnerProPrice comPartnerProPrice = new ComPartnerProPrice();
			comPartnerProPrice.setComKey(userVo.getComKey());
			comPartnerProPrice.setPartnerKey(partnerVO.getPartnerKey());
			comPartnerProPrice.setPartnerLevel(partnerVO.getPartnerLevel());
			companyService.updateComPartnerProPrice(comPartnerProPrice);
		}
        
		result.put("state", true);
		result.put("msg", "修改成功");
		return result;
	}

	/**
	 * 删除生意伙伴
	 * @param partnerKey
	 * @param userVo
	 * @return
	 */
	public Map delPartner(String partnerKey,UserVo userVo){
		Map<String,String> result = new HashMap<>();
		//查询是否已经对该生意伙伴建单
		PageData pageData =  new PageData();
		pageData.put("comKey",userVo.getComKey());
		pageData.put("partnerKey",partnerKey);
		OrderTotalVO orderTotalVO = salesOrderMapper.selectSumSalesOrder(pageData);
		if(orderTotalVO.getOrderCount() > 0){
			result.put("state","0");
			result.put("msg","已有订单，不可以删除");
			return result;
		}

		//都没问题的话 开删
		//1.删除YDZ_COM_PARTNER
		ComPartner comPartnerDel = new ComPartner();
		comPartnerDel.setPartnerKey(partnerKey);
		comPartnerDel.setComKey(userVo.getComKey());
		comPartnerDel.setIsValid("0");//没有isdel字段 只能改为失效
		int delNum1 = comPartnerMapper.updateByPrimaryKeySelective(comPartnerDel);
		//2.删除YDZ_PARTNER_CONTACTER
		PartnerContacter partnerContacterDel = new PartnerContacter();
		partnerContacterDel.setPartnerKey(partnerKey);
		partnerContacterDel.setIsValid("0");//同上
		int delNum2 = partnerContacterMapper.updateByPartnerKey(partnerContacterDel);
		//3.删除YDZ_PARTNER
		Partner partnerDel = new Partner();
		partnerDel.setPartnerKey(partnerKey);
		partnerDel.setIsValid("0");//同上
		int delNum3 = partnerMapper.updateByPrimaryKeySelective(partnerDel);
		result.put("state","1");
		result.put("msg","操作成功");
		return result;
	}


	/**
	 * 
	* @Title: findPartner 
	* @param pd
	* @return
	* @throws Exception
	* @return Partner
	* @throws 
	* @Description: 查询合作伙伴
	 */
	public  Partner findPartner(PageData pd) throws Exception{
		Partner partner = partnerMapper.selectByPrimaryKey(pd);
		return partner;
	}
	
	/**
	 * 
	* @Title: findPartnerVO 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return PartnerVO
	* @throws 
	* @Description: 根据COM_KEY获取拼接后的合作伙伴数据
	*
	 */
	public List<PartnerVO> findListPartnerVO(Page page) throws Exception{
		List<PartnerVO> partnerVOs = partnerMapper.listPageRartnerByComKey(page);
		if(partnerVOs!=null
				||partnerVOs.size()>0){
			for (PartnerVO partnerVO : partnerVOs) {
				partnerVO.setStatusValue(this.formatPartnerValue(partnerVO.getPartnerStatus()));
			}
		}
		return partnerVOs;
	}
	
	public String formatPartnerValue(String partnerStatus){
		String statusValue = null;
		switch (partnerStatus) {
		case "0":
			statusValue = CompanyEnum.PARTNER_STATUS_FRIEND_NO.getDesc();
			break;
		case "1":
			statusValue = CompanyEnum.PARTNER_STATUS_FRIEND_YES.getDesc();
			break;
		case "2":
			statusValue = CompanyEnum.PARTNER_STATUS_APPLYING.getDesc();
			break;
		case "3":
			statusValue = CompanyEnum.PARTNER_STATUS_REFUSED.getDesc();
			break;
		case "4":
			statusValue = CompanyEnum.PARTNER_STATUS_PENDING_APPLY.getDesc();
			break;
		case "5":
			statusValue = CompanyEnum.PARTNER_STATUS_PENDING_INVITE.getDesc();
			break;
		case "6":
			statusValue = CompanyEnum.PARTNER_STATUS_INVITING.getDesc();
			break;

		default:
			break;
		}
		return statusValue;
	}
	
	/**
	 * 
	* @Title: findPartnerByCPKey 
	* @param pd comKey,partnerKey
	* @return
	* @return PartnerVO
	* @throws 
	* @Description: 根据comKey和partnerKey查询公司与合作伙伴合并信息
	 */
	public PartnerVO findPartnerByCPKey(PageData pd){
		return partnerMapper.findPartnerByCPKey(pd);
	}
	
	/**
	 * 
	* @Title: parsePartnerVO 
	* @param @param pd
	* @param @param isTotalPrice 是否执行按合作伙伴进行订单统计
	* @param @return
	* @param @throws Exception
	* @return List<PartnerVO>
	* @throws 
	* @Description: 获取格式化后的拼装PartnerVO
	*
	 */
	public List<PartnerVO> parsePartnerVO(Page page,boolean isTotalPrice) throws Exception{
		List<PartnerVO> pvos = this.findListPartnerVO(page);
//		String partnerType = page.getPd().getString("partnerType");
//		Map<String, ComPartnerTotalPriceVO> mapTotalPriceVO = null;
//		List<ComPartnerTotalPriceVO> cptpVos = null;
//		if(isTotalPrice){
//			mapTotalPriceVO = new HashMap<String, ComPartnerTotalPriceVO>();
//
//			if(CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode().equalsIgnoreCase(partnerType)){
//				cptpVos = this.getComPartnerTotalPriceCustomerVO(page.getPd().getString("comKey"));
//			}else if(CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode().equalsIgnoreCase(partnerType)){
//				cptpVos = this.getComPartnerTotalPriceSupplierVO(page.getPd().getString("comKey"), null);
//			}
//			for (ComPartnerTotalPriceVO cptpvo : cptpVos) {
//				mapTotalPriceVO.put(cptpvo.getPartnerKey(), cptpvo);
//			}
//		}
//		
//		for(PartnerVO pvo : pvos){
//			this.formatValuePartnerVO(pvo);
//			ComPartnerTotalPriceVO vo = mapTotalPriceVO.get(pvo.getPartnerKey());
//			if (vo == null) {
//				continue;
//			}
//			if(isTotalPrice){
//				pvo.setGt6OrderNum(vo.getGt6OrderNum());
//				pvo.setGt6TotalPrice(vo.getGt6TotalPrice());
//				pvo.setGt3OrderNum(vo.getGt3OrderNum());
//				pvo.setGt3TotalPrice(vo.getGt3TotalPrice());
//				pvo.setAllOrderNum04(vo.getAllOrderNum04());
//				pvo.setAllTotalPrice(vo.getAllTotalPrice());
//				pvo.setAllOrderNum07(vo.getAllOrderNum07());
//				pvo.setAllReceivablesMoney(vo.getAllReceivablesMoney());
//			}
//		}
		return pvos;
	}
	
	private PartnerVO formatValuePartnerVO(PartnerVO pvo){
		//合作伙伴级别 1vip 2普通 3零散
		switch (pvo.getPartnerLevel()) {
		case "1":
			pvo.setPartnerLevelValue(CompanyEnum.PARTNER_LEVEL_VIP.getDesc());
			break;
		case "2":
			pvo.setPartnerLevelValue(CompanyEnum.PARTNER_LEVEL_GENERAL.getDesc());
			break;
		case "3":
			pvo.setPartnerLevelValue(CompanyEnum.PARTNER_LEVELL_INDIVIDUAL.getDesc());
			break;
		default:
			break;
		}
		//合作伙伴公司性质 1公司 2个人
		switch (pvo.getPartnerAttr()) {
		case "1":
			pvo.setPartnerAttrValue(CompanyEnum.PARTNER_ATTR_COMPANY.getDesc());
			break;
		case "2":
			pvo.setPartnerAttrValue(CompanyEnum.PARTNER_ATTR_PERSONAL.getDesc());
			break;
		default:
			break;
		}
		//合作伙伴类别 1客户 2供应商 A客户&供应商
		switch (pvo.getPartnerType()) {
		case "1":
			pvo.setPartnerTypeValue(CompanyEnum.PARTNER_TYPE_CUSTOMER.getDesc());
			break;
		case "2":
			pvo.setPartnerTypeValue(CompanyEnum.PARTNER_TYPE_SUPPLIER.getDesc());
			break;
		case "A":
			pvo.setPartnerTypeValue(CompanyEnum.PARTNER_TYPE_ALL.getDesc());
			break;
		default:
			break;
		}
		//合作伙伴状态 0非好友 1互为好友
		switch (pvo.getPartnerStatus()) {
		case "0":
			pvo.setStatusValue(CompanyEnum.PARTNER_STATUS_FRIEND_NO.getDesc());
			break;
		case "1":
			pvo.setStatusValue(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getDesc());
			break;
		default:
			break;
		}
		
		return pvo;
	}
	
	//新增合作伙伴
	public void insertPartner(Partner partner) throws Exception{
		partnerMapper.insertSelective(partner);
	}
	
	/**
	 *
	* @Title: findComPartner
	* @param pd
	* @return
	* @throws Exception
	* @return ComPartner
	* @throws
	* @Description: 查询单个的公司的合作伙伴
	 */
	public ComPartner findComPartner(PageData pd){
		ComPartner comPartner = null;
		List<ComPartner> comPartners = comPartnerMapper.selectByPrimaryKey(pd);
		if(comPartners!=null&&comPartners.size()==1){
			comPartner = comPartners.get(0);
		}
		return comPartner;
	}
	
	/**
	 *
	* @Title: findListComPartner
	* @param pd
	* @return
	* @throws Exception
	* @return List<ComPartner>
	* @throws
	* @Description: 查询公司的合作伙伴的列表
	 */
	public List<ComPartner> findListComPartner(PageData pd) throws Exception{
		return comPartnerMapper.selectByPrimaryKey(pd);
	}
	
	
	//新增用户合伙伙伴关系
	public int insertComPartner(ComPartner comPartner) throws Exception{
		return comPartnerMapper.insertSelective(comPartner);
	}
	
	//修改用户合伙伙伴关系
	public int updateByPrimaryKeySelective(ComPartner comPartner) throws Exception{
		return comPartnerMapper.updateByPrimaryKeySelective(comPartner);
	}


	/**
	 * 处理好友
	 * @param userVo
	 * @param partner
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> savePartner(UserVo userVo,Partner partner) throws Exception {
		Map<String,Object> callBack = new HashMap<>();
		//需要判断对方是否已经是我的合作伙伴
		PageData pd = new PageData();
		pd.put("myComKey",userVo.getComKey());
		pd.put("partnerComKey",partner.getPartnerComKey());
		PartnerVO partner1 = partnerMapper.checkPartner(pd);

		//我的公司
		Company myCompany = companyService.getCompanyByUserKey(userVo.getComKey());

		//如果没有合作伙伴 则可以直接添加
		if(partner1  == null){
			partner.setPartnerKey(UuidUtil.get32UUID());
			partner.setIsValid("1");
			//合作伙伴的类型 即使客户又是供应商
			partner.setPartnerType("A");
			//助记码
			partner.setMnemonicCode(GetPinyin.getPinYinHeadChar(partner.getPartnerShortname()));
			insertPartner(partner);

			ComPartner comPartner = new ComPartner();
			comPartner.setComKey(userVo.getComKey());
			comPartner.setPartnerKey(partner.getPartnerKey());
			//好友状态 申请中
			comPartner.setStatus(CompanyEnum.PARTNER_STATUS_APPLYING.getCode());
			comPartner.setIsValid("1");
			comPartner.setCreateTime(new Date());
			comPartner.setCreator(userVo.getUserKey());
			insertComPartner(comPartner);
			//添加联系人一
			if(partner.getTel11() != null){
				PartnerContacter contacter1 = fillPartner(partner,userVo);
				insertOnePartnerContacter(contacter1);
			}
			//添加联系人二
			if(partner.getTel12() != null){
				PartnerContacter contacter2 = fillPartner(partner,userVo);
				insertOnePartnerContacter(contacter2);
			}

			Date date = new Date();
			//发送消息模块
			Message message = new Message();
			message.setMsgId(UuidUtil.get32UUID());
			message.setMsgTitle("接受好友申请");
			message.setComKey(userVo.getComKey());
			message.setMsgContent(myCompany.getComName()+"申请加您("+partner.getPartnerName()+")为好友。");

			message.setSendKey(userVo.getUserKey());
			message.setSendName(myCompany.getComName());

			message.setSendTime(date);
			//message.setAcceptUserKey();
			message.setAcceptComKey(partner.getPartnerComKey());
			message.setStatus("0");
			//好友申请
			message.setType("08");
			message.setIsDel("0");
			//操作状态
			message.setFriendStatus("0");
			//消息类型
			message.setMsgAttr(partner.getPartnerAttr());
			message.setCreator(userVo.getUserKey());
			message.setCreateTime(date);
			//message.setRemarks(partnerType);
			messageMapper.insertSelective(message);
			callBack.put("status","1");
			callBack.put("msg","添加成功，已发送好友申请");
			callBack.put("sendsms", "1");
			return callBack;
		}
		//已为好友
		if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode().equals(partner1.getPartnerStatus())){
			callBack.put("status","0");
			callBack.put("msg","该公司已经是您的好友合作伙伴");
			return callBack;
		}
		//申请中
		if(CompanyEnum.PARTNER_STATUS_APPLYING.getCode().equals(partner1.getPartnerStatus())){
			callBack.put("status","0");
			callBack.put("msg","已经交申请，待对方确认中");
			return callBack;
		}
		//已拒绝
		if(CompanyEnum.PARTNER_STATUS_REFUSED.getCode().equals(partner1.getPartnerStatus())){
			callBack.put("status","0");
			callBack.put("msg","对方已拒绝");
			return callBack;
		}
		//待申请 todo
		//待邀请 todo
		//邀请中 todo
		callBack.put("status","0");
		callBack.put("msg","未知的错误");
		return callBack;

	}

	/**
	 * 根据传入数据，新建合作伙伴联系人
	 * @return 合作伙伴联系人
	 */
	public PartnerContacter fillPartner(Partner partner,UserVo userVo){
		PartnerContacter partnerContacter = new PartnerContacter();
		partnerContacter.setContacterName(partner.getContacterName11());
		partnerContacter.setTel1(partner.getTel11());
		partnerContacter.setIsValid("1");
		partnerContacter.setPartnerKey(partner.getPartnerKey());
		partnerContacter.setCreateTime(new Date());
		partnerContacter.setCreator(userVo.getUserKey());
		partnerContacter.setContacterId(CodeBuilderUtil.getInstance().getAnyId(10));
		return partnerContacter;
	}

	/**
	 * 新增合作伙伴(非好友)
	 * @return 新增结果
     */
	public Map savePartnerCom(UserVo userVo,Partner partner)throws Exception{

		Map<String,Object> callBack = new HashMap<>();

		partner.setPartnerKey(UuidUtil.get32UUID());
		partner.setIsValid("1");
		//合作伙伴的类型 即使客户又是供应商
		if (StringUtil.isEmpty(partner.getPartnerType())) {
			partner.setPartnerType(CompanyEnum.PARTNER_TYPE_ALL.getCode());
		}
		if (StringUtil.isEmpty(partner.getPartnerLevel())) {
			partner.setPartnerLevel(CompanyEnum.PARTNER_LEVEL_GENERAL.getCode());
		}
		this.insertPartner(partner);
		ComPartner comPartner = new ComPartner();
		//
		comPartner.setComKey(userVo.getComKey());
		comPartner.setPartnerKey(partner.getPartnerKey());

		if(partner.isSendMsg()){
			//发送短信为邀请中
			comPartner.setStatus(CompanyEnum.PARTNER_STATUS_INVITING.getCode());
		}else{
			//不发送短信为待邀请
			comPartner.setStatus(CompanyEnum.PARTNER_STATUS_PENDING_INVITE.getCode());

		}

		comPartner.setIsValid("1");
		comPartner.setCreateTime(new Date());
		comPartner.setCreator(userVo.getUserKey());
		insertComPartner(comPartner);

		PartnerContacter contacter1 = new PartnerContacter();
		contacter1.setContacterName(partner.getContacterName11());
		contacter1.setTel1(partner.getTel11());
		contacter1.setIsValid("1");
		if(StringUtil.isNotEmpty(partner.getTel112())){
			contacter1.setTel2(partner.getTel112());
		}
		contacter1.setPartnerKey(partner.getPartnerKey());
		contacter1.setCreateTime(new Date());
		contacter1.setCreator(userVo.getUserKey());
		contacter1.setContacterId(CodeBuilderUtil.getInstance().getAnyId(10));
		insertOnePartnerContacter(contacter1);
		
		if(partner.isSendMsg()){
			if(partner.getTel11() == null || "".equals(partner.getTel11().trim())){
				callBack.put("status","0");
				callBack.put("msg","请输入手机号");
				return callBack;
			}

			PageData pd = new PageData();
			pd.put("comKey",userVo.getComKey());
			Company company = companyService.getCompanyByKey(pd);
			//生成參數
			Map<String,Object> map = new HashMap<>();
			map.put("userKey",userVo.getUserKey());
			map.put("comKey",userVo.getComKey());
			map.put("invitee",partner.getTel11());
			map.put("partnerKey",partner.getPartnerKey());
			map.put("inviteType",partner.getPartnerAttr());
			String json = JSON.toJSONString(map);

			String key = CipherUtil.encrypt(json);

			String para =  "/invite/com/signUpPage?key="+key;
			String ranCode = CodeBuilderUtil.getInstance().getVoucherCode(7);
			String codeKey = "j_"+ranCode;
			redisUtil.setIntervalDay(codeKey,para,30);
			Map mesResult = null;
			if("1".equals(partner.getPartnerAttr())){
				mesResult = SMSUtil.sendInviteMsg4Com(company.getComName(),userVo.getRealName(),partner.getPartnerName(),"jh/"+ranCode+" ",partner.getTel11());
			}else{
				mesResult = SMSUtil.sendInviteMsg(company.getComName(),userVo.getRealName(),"jh/"+ranCode+" ",partner.getTel11());
			}

            //新建一条短信记录
            SmsLog smsLog = new SmsLog();
            //邀请合作伙伴
            smsLog.setSmsType(MessageEnum.SMS_INVITE_PARTNER.getCode());
            //发送者
            smsLog.setSmsFrom(userVo.getComKey());
            //接收者
            smsLog.setSmsTo(partner.getTel11());
		    //短信内容 如果是邀请类型 存放redis中的短连接的KEY
            smsLog.setSmsContent(codeKey);
            //短信返回值
            smsLog.setSmsResult(JSON.toJSONString(mesResult));
            //创建人
            smsLog.setCreator(userVo.getUserKey());
            //创建时间
            smsLog.setCreateTime(new Date());
            smsLogMapper.insert(smsLog);
		}
		//sendInviteMsg
		callBack.put("status","1");
		callBack.put("msg","添加成功");
		return callBack;

	}
	
	/**
	 * 
	* @Title: listDropdownPartner 
	* @param pd comKey, partnerType 1 客户 2供应商 A客户&供应商
	* @return
	* @throws Exception
	* @return List<PartnerVO>
	* @throws 
	* @Description: 获取用于下拉框的客户/供应商列表
	 */
	public LinkedList<PartnerVO> listDropdownPartner(PageData pd) throws Exception{
		LinkedList<PartnerVO> vos = partnerVOList(pd);
		PartnerVO vo1 = new PartnerVO();
		if(StringUtil.isNotEmpty(pd.getString("partnerType"))){
			if(CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode().equals(pd.getString("partnerType"))){
				vo1.setPartnerShortname("全部供应商");
			}
			if(CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode().equals(pd.getString("partnerType"))){
				vo1.setPartnerShortname("全部客户");
			}
		}
    	vo1.setPartnerKey("ALL");
    	vos.addFirst(vo1);
		return vos;
	}

	public LinkedList<PartnerVO> partnerVOList(PageData pd){
		pd.put("partnerTypeIns", Tools.strSqlIn("A,"+pd.getString("partnerType")));
		LinkedList<PartnerVO> vos = comPartnerMapper.selectPartnerDropdown(pd);

		for (PartnerVO partnerVO : vos) {
			if(StringUtil.isEmpty(partnerVO.getPartnerShortname())
					&&StringUtil.isEmpty(partnerVO.getMnemonicCode())){
				continue;
			}else{
				String shortname = StringUtil.isEmpty(partnerVO.getPartnerShortname())?"":partnerVO.getPartnerShortname();
				String code = StringUtil.isEmpty(partnerVO.getMnemonicCode())?"":partnerVO.getMnemonicCode();
				partnerVO.setMyComShortname(shortname+"-"+code);
			}
		}
		return vos;
	}

	/**
	 * 
	 * @Title: selectOnePartnerAndContacterByPartnerKey 
	 * @param pd
	 * @return
	 * @return PartnerVO
	 * @throws 
	 * @Description: 通过partnerKey和contacterId参数获取客户及联系人信息包括电话等信息
	 */
	public PartnerVO selectOnePartnerAndContacterByPartnerKey(PageData pd){
		return partnerMapper.getPartnerAndContacterByPartnerKey(pd);
	}
	/**
	 * 
	 * @Title: selectOneComPartnerAndPartnerInfo 
	 * @param pd
	 * @return
	 * @return PartnerVO
	 * @throws 
	 * @Description: 通过comKey和partnerKey参数查询单条公司合作伙伴记录
	 */
	public PartnerVO selectOneComPartnerAndPartnerInfo(PageData pd){
		return partnerMapper.getComPartnerAndPartnerInfo(pd);
	}
	
	/**
	 * 修改合作伙伴的业务（好友）
	 * @param partnerVO 前台传入的客户/供应商信息
	 * @param userVo 当前操作用户信息
	 * @return 修改结果
	 */
	public Map updateFriend(PartnerVO partnerVO,UserVo userVo){
		//todo 是否需要在service 中做一次关于确认当前合作伙伴为好友的校验。
        @SuppressWarnings("unchecked")
		Map<String,Object> result;
		//用做修改的合作伙伴实体
		Partner partnerMod = new Partner();
        result = this.checkForUpdatePartner(partnerVO,userVo);
        //校验不通过
        if (!(boolean)result.get("state")) {
            return result;
        }
        partnerMod.setPartnerKey(partnerVO.getPartnerKey());
		//助记码
		partnerMod.setMnemonicCode(partnerVO.getMnemonicCode() == null ? "":partnerVO.getMnemonicCode() );
		//伙伴分类
		partnerMod.setPartnerType(partnerVO.getPartnerType() == null ? "":partnerVO.getPartnerType());
		//合作级别
		partnerMod.setPartnerLevel(partnerVO.getPartnerLevel() == null ? "":partnerVO.getPartnerLevel());

		partnerMod.setChanger(userVo.getUserKey());
		partnerMod.setChangeTime(new Date());
		partnerMapper.updateByPrimaryKeySelective(partnerMod);

		PartnerContacter partnerContacter  = new PartnerContacter();
		partnerContacter.setUid(partnerVO.getPcUid());
		partnerContacter.setTel2(partnerVO.getTel2() == null ? "":partnerVO.getTel2());
		partnerContacterMapper.updateByPrimaryKeySelective(partnerContacter);
		result.put("state",true);
        result.put("msg","修改成功");
		return result;
	}

	/**
	 * 修改合作伙伴的业务（非好友）
	 * @return 修改结果
	 */
//	@SuppressWarnings("unchecked")
	public Map<String,Object> updateNonFriend(PartnerVO partnerVO,UserVo userVo){
		//todo 是否需要 对当前合作伙伴状态进行确认(有可能在操作过程中，对方接受好友请求，完成好友操作)
		//todo 需要了解spring的两种事务是否都支持对数据库的行锁。(进入修改逻辑，完成状态确认后，最好对数据库加锁)
        Map<String,Object> result = null;
        result = this.checkForUpdatePartner(partnerVO,userVo);
        //校验不通过
        if (!(boolean)result.get("state")) {
            return result;
        }
        //1.首先确认该合作伙伴为非好友
        PageData pd = new PageData();
        pd.put("partnerKey", partnerVO.getPartnerKey());
        pd.put("contacterId", partnerVO.getContacterId());
        PartnerVO partnerVO4Check = this.selectOnePartnerAndContacterByPartnerKey(pd);
		if (CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode().equals(
				partnerVO4Check.getPartnerStatus())) { //互为好友
           result.put("state",false);
           result.put("msg","当前数据已过期，请重新操作");//状态已经为好友，提示用户从好友修改入口操作
           return result;
        }
        Partner partnerMod = new Partner();
        PartnerContacter partnerContacter  = new PartnerContacter();
        //2.查看是否修改了手机号
        if(!partnerVO.getTel1().trim()
        		.equals(partnerVO4Check.getTel1().trim())){
            //查看下那当前手机是否为系统中的有身份为管理员或者法人的公司
            //负责人手机号 查询公司信息
            pd.put("userId",partnerVO.getTel1());
            List<Company> companies = companyService.getByDirector(pd);
            if (companies.size() > 0){
               result.put("state",false);
               result.put("msg","该手机用户已使用易对账，通过申请好友去加他吧");
               return result;
            }
            //修改了手机号
            partnerContacter.setTel1(partnerVO.getTel1());
            //然后找到redis对应的那条邀请链接设为失效(删除)
            //1.先去短息发送日志表里查询一番
            PageData pageData = new PageData();
            pageData.put("smsFrom",userVo.getComKey());
            pageData.put("smsTo",partnerVO4Check.getTel1());
            List<SmsLog> smsLogs = smsLogMapper.selectByPrimaryKey(pageData);
            if(smsLogs.size() > 1){
                result.put("state",false);
                result.put("msg","操作失败，请联系管理员");
                return result;
            }
            if(smsLogs.size() ==1){
                String redisUrlKey = smsLogs.get(0).getSmsContent();
                redisUtil.del(redisUrlKey);
            }
        }
        //3.修改
        partnerMod.setPartnerKey(partnerVO.getPartnerKey());
        //企业全称
        partnerMod.setPartnerName(partnerVO.getPartnerName() == null ? "":partnerVO.getPartnerName());
        //公司电话
        partnerMod.setPartnerTel(partnerVO.getPartnerTel() == null ?"":partnerVO.getPartnerTel());
        //企业简称
        partnerMod.setPartnerShortname(partnerVO.getPartnerShortname() == null ? "":partnerVO.getPartnerShortname());
        //公司QQ
        partnerMod.setPartnerQQ(partnerVO.getPartnerQQ() == null ? "" : partnerVO.getPartnerQQ());
        //助记码
        partnerMod.setMnemonicCode(partnerVO.getMnemonicCode() == null ? "":partnerVO.getMnemonicCode());
        //省
        partnerMod.setPartnerProvince(partnerVO.getPartnerProvince() == null ? "":partnerVO.getPartnerProvince());
        //市
        partnerMod.setPartnerCity(partnerVO.getPartnerCity() == null ? "":partnerVO.getPartnerCity());
        //县
        partnerMod.setPartnerCountry(partnerVO.getPartnerCountry() == null ? "":partnerVO.getPartnerCountry());
        //伙伴分类
        partnerMod.setPartnerType(partnerVO.getPartnerType() == null ? "":partnerVO.getPartnerType());
        //合作级别
        partnerMod.setPartnerLevel(partnerVO.getPartnerLevel() == null ? "":partnerVO.getPartnerLevel());
        //公司地址
        partnerMod.setPartnerAddress(partnerVO.getPartnerAddress() == null ? "":partnerVO.getPartnerAddress());
        partnerMod.setChanger(userVo.getUserKey());
        partnerMod.setChangeTime(new Date());
        partnerMapper.updateByPrimaryKeySelective(partnerMod);
        partnerContacter.setUid(partnerVO.getPcUid());
        partnerContacter.setTel2(partnerVO.getTel2() == null ? "":partnerVO.getTel2());
        //联系姓名
        partnerContacter.setContacterName(partnerVO.getContacterName() == null ? "":partnerVO.getContacterName());
        partnerContacterMapper.updateByPrimaryKeySelective(partnerContacter);
        result.put("state",true);
        result.put("msg","修改成功");
        return result;
	}

    /**
     * 修改客户/供应商的校验
     * @param partnerVO 前台传入客户/供应商信息
     * @param userVo 当前操作的用户信息
     * @return 校验结果
     */
	private Map<String,Object> checkForUpdatePartner(PartnerVO partnerVO,UserVo userVo){
        @SuppressWarnings("unchecked")
        Map<String,Object> result = new HashMap();

        if(partnerVO.getPartnerKey() == null || "".equals(partnerVO.getPartnerKey())){
            result.put("state",false);
            result.put("msg","修改参数校验不通过");
            logger.warn("用户:"+userVo.getUserKey()+",在修改好友合作伙伴时，partnerVo中主键partnerKey为空");
            return result;
        }

        if(partnerVO.getPcUid() == null){
            result.put("state",false);
            result.put("msg","修改参数校验不通过");
            logger.warn("用户:"+userVo.getUserKey()+",在修改好友合作伙伴时，partnerVo中pcUid为空");
            return result;
        }
        result.put("state",true);
        return result;
    }
	
	/**
	 * 
	 * @Title: getComPartnerTotalPriceCustomerVO 
	 * @param comKey
	 * @param partnerKey
	 * @return
	 * @return ComPartnerTotalPriceVO
	 * @throws 
	 * @Description: 根据公司key和合作伙伴key获取销售订单/对账单的相关统计信息
	 */
	public List<ComPartnerTotalPriceVO> getComPartnerTotalPriceCustomerVO(String comKey){
		PageData pdData = new PageData();
		pdData.put("comKey", comKey);
//		pdData.put("partnerKey", partnerKey);
		return comPartnerMapper.selectComPartnerTotalPriceByCustomerKey(pdData);
	}
	
	/**
	 * 
	 * @Title: getComPartnerTotalPriceSupplierVO 
	 * @param comKey
	 * @param partnerKey
	 * @return
	 * @return ComPartnerTotalPriceVO
	 * @throws 
	 * @Description: 根据公司key和合作伙伴key获取销售订单/对账单的相关统计信息
	 */
	public List<ComPartnerTotalPriceVO> getComPartnerTotalPriceSupplierVO(String comKey,String partnerKey){
		PageData pdData = new PageData();
		pdData.put("comKey", comKey);
//		pdData.put("partnerKey", partnerKey);
		return comPartnerMapper.selectComPartnerTotalPriceBySupplierKey(pdData);
	}
	
	public void updateComPartnerAndContact(PartnerVO partnerVO,String comKey){
		if(StringUtil.isEmpty(partnerVO.getPartnerKey())){
			throw new RuntimeException();
		}
		
		Partner partner = new Partner();
		BeanutilsCopy.apacheCopyProperties(partner, partnerVO);
		partner.setChangeTime(new Date());
		partnerMapper.updateByPrimaryKeySelective(partner);
		
		if (StringUtil.isNotEmpty(partnerVO.getTel1())
				||StringUtil.isNotEmpty(partnerVO.getContacterName())) {
			PartnerContacter contacter = new PartnerContacter();
			BeanutilsCopy.apacheCopyProperties(contacter, partnerVO);
			partnerContacterMapper.updateByPartnerKey(contacter);
		}
	}
	
//=====================================客户充值业务=====================================
	
	public ComPartnerRechargeLog selectOneComPartnerRechargeLog(PageData pd){
		return comPartnerRechargeLogMapper.selectByPrimaryKey(pd);
	}
	public List<ComPartnerRechargeLog> listPageComPartnerRechargeLogs(Page page){
		return comPartnerRechargeLogMapper.listPageByPrimaryKey(page);
	}
	public int insertComPartnerRechargeLog(ComPartnerRechargeLog comPartnerRechargeLog) throws Exception{
		return comPartnerRechargeLogMapper.insertSelective(comPartnerRechargeLog);
	}
	public int updateComPartnerRechargeLog(ComPartnerRechargeLog comPartnerRechargeLog) throws Exception{
		return comPartnerRechargeLogMapper.updateByPrimaryKeySelective(comPartnerRechargeLog);
	}
	public int deleteComPartnerRechargeLog(PageData pd) throws Exception{
		return comPartnerRechargeLogMapper.deleteByPrimaryKey(pd);
	}
	
	public List<PartnerVO> listPageComPartenrForRecharge(Page page){
		return comPartnerRechargeLogMapper.listPageComPartenr(page);
	}
	
	public OrderTotalVO selectSumComPartnerRechargeTotalVO(PageData pd){
		return comPartnerRechargeLogMapper.selectSumOrderTotalVO(pd);
	}
	
	public int insertRechargeAndUpdateBalanceForPartner(UserVo userVo,ComPartnerRechargeLog comPartnerRechargeLog) 
			throws Exception{
		comPartnerRechargeLog.setComKey(userVo.getComKey());
    	comPartnerRechargeLog.setIndustryId(userVo.getDetailIndustryId());
    	comPartnerRechargeLog.setIsValid("1");
    	comPartnerRechargeLog.setCreator(userVo.getUserKey());
    	comPartnerRechargeLog.setCreateTime(new Date());
		int result = this.insertComPartnerRechargeLog(comPartnerRechargeLog);
		PageData pd = new PageData();
		pd.put("comKey", comPartnerRechargeLog.getComKey());
		pd.put("partnerKey", comPartnerRechargeLog.getPartnerKey());
		ComPartner comPartner = this.findComPartner(pd);
		if (comPartner==null) {
			throw new RuntimeException("充值失败");
		}
		BigDecimal rechargeMoney = comPartnerRechargeLog.getRechargeMoney()==null?BigDecimal.ZERO:comPartnerRechargeLog.getRechargeMoney();
		BigDecimal balanceMoney = comPartner.getBalanceMoney()==null?BigDecimal.ZERO:comPartner.getBalanceMoney();
		BigDecimal presentMoney = comPartnerRechargeLog.getPresentMoney()==null?BigDecimal.ZERO:comPartnerRechargeLog.getPresentMoney();
		comPartner.setBalanceMoney(rechargeMoney.add(balanceMoney).add(presentMoney)
				.setScale(2, BigDecimal.ROUND_HALF_UP));
		comPartner.setIsRecharge("1");
		result = comPartnerMapper.updateByPrimaryKeySelective(comPartner);
		if (result>0) {
			if ("1".equalsIgnoreCase(comPartnerRechargeLog.getIsSms())) {
				Company company = companyService.getCompanyByUserKey(userVo.getComKey());
//				PartnerVO partnerVO = this.getByPartnerKey(comPartnerRechargeLog.getPartnerKey());
				if (StringUtil.isNotEmpty(comPartnerRechargeLog.getPaymentTel())
						&&company!=null) {
					SMSUtil.notifyRechargeComPartner(comPartnerRechargeLog.getPaymentTel(), DateUtil.getDate(comPartnerRechargeLog.getRechargeDate()), 
							company.getComShortname(), comPartnerRechargeLog.getRechargeMoney().setScale(2, BigDecimal.ROUND_HALF_UP).toString(), 
							comPartnerRechargeLog.getPaymentName(), comPartner.getBalanceMoney().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
				}
			}
		}
		return result;
	}
	
	public int insertComPartnerConsumeLog(ComPartnerConsumeLog comPartnerConsumeLog) throws Exception{
		return comPartnerConsumeLogMapper.insertSelective(comPartnerConsumeLog);
	}
	public List<ComPartnerConsumeLog> listPageComPartnerConsumeLogs(Page page){
		return comPartnerConsumeLogMapper.listPageByPrimaryKey(page);
	}
	public OrderTotalVO getSumConsumeLogTotalVO(PageData pd){
		return comPartnerConsumeLogMapper.getSumTotalVO(pd);
	}
	
	public List<Partner> listPartners(PageData pd){
		return partnerMapper.listPartners(pd);
	}
	
	
}
