package com.ydz.service.advert;

import com.ydz.config.DZConfig;
import com.ydz.dao.advert.*;
import com.ydz.dao.assignment.AssignTaskMapper;
import com.ydz.dao.system.ComPartnerMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.advert.*;
import com.ydz.entity.assignment.AssignTask;
import com.ydz.entity.system.*;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.*;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.*;
import com.ydz.wechat.util.JsonUtil;
import com.ydz.wechat.util.WechatConstants;
import com.ydz.wechat.util.WechatUtil;
import com.ydz.wechat.vo.PurchaseMsgVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/** 
 *   ┏┓　　　┏┓
 * ┏┛┻━━━┛┻┓
 * ┃　　　　　　　┃
 * ┃　　　━　　　┃
 * ┃　┳┛　┗┳　┃
 * ┃　　　　　　　┃
 * ┃　　　┻　　　┃
 * ┃　　　　　　　┃
 * ┗━┓　　　┏━┛
 * ┃　　　┃   神兽保佑
 * ┃　　　┃   代码无BUG！
 * ┃　　　┗━━━┓
 * ┃　　　　　　　┣┓
 * ┃　　　　　　　┏┛
 * ┗┓┓┏━┳┓┏┛
 * ┃┫┫　┃┫┫
 * ┗┻┛　┗┻┛
 * @ClassName: SalesOrderService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月2日 下午1:50:54 
 * @Description: 销售订单和销售对账单Service处理类
 *  
 */

@Service("salesOrderService")
public class SalesOrderService {

	private Logger logger = Logger.getLogger(this.getClass());

	@Resource
	private WechatUtil wechatUtil;
	@Resource
	private WechatConstants wechatConstants;

	@Autowired
	private PartnerMapper partnerMapper;

	@Autowired
	private SalesOrderMapper salesOrderMapper;
	@Autowired
	private SalesOrderDetailMapper salesOrderDetailMapper;
	@Autowired
	private SalesCheckingOrderMapper salesCheckingOrderMapper;
	@Autowired
	private SalesCheckingOrderDetailMapper salesCheckingOrderDetailMapper;

	@Autowired
	private AssignTaskMapper assignTaskMapper;

	@Resource
	private CheckingInvoiceMapper checkingInvoiceMapper;
	@Resource
	private ReceiptPaymentMapper receiptPaymentMapper;
	@Resource
	private ComPartnerMapper comPartnerMapper;
	@Resource
	private OrderConfigService orderConfigService;

	@Resource
	private PurchaseOrderService purchaseOrderService;
	@Resource
	private PartnerService partnerService;
	@Resource
	private CompanyService companyService;
	@Resource
	private EmployeeService employeeService;
	
	@Resource
	@Lazy
	private WorkingAssignTaskService workingAssignTaskService;

	@Resource
	private CommonService commonService;

	@Resource
	private DZConfig dzConfig;
	@Resource
	private RedisUtil redisUtil;

	public List<AllSalesCheckingOrderVO> listPageAllSalesCheckingOrder(Page page){
	 	return salesCheckingOrderMapper.listPageAllSalesCheckingOrder(page);
	}
	public List<AllSalesCheckingOrderVO> listPageAllSalesCheckingOrderConCat(Page page){
		List<AllSalesCheckingOrderVO> allscovos = salesCheckingOrderMapper.listPageAllSalesCheckingOrderConCat(page);
		for (AllSalesCheckingOrderVO vo : allscovos) {
			vo.setOrderStatusDesc(orderConfigService.formatOrderStatus(vo.getOrderStatus()));
			vo.setPrice(vo.getPrice().subtract(vo.getDiscount()).subtract(vo.getPreferential()).setScale(2, BigDecimal.ROUND_HALF_UP));
		}
		return allscovos;
	}
	public List<TotalSalesOrderDetailVO> selectTotalDetailBySalesNo(PageData pd){
		return salesOrderDetailMapper.selectTotalDetailBySalesNo(pd);
	}
	
	/**
	 * 
	 * @Title: updateSalesOrderByMapPara 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 通过参数映射的方式对销售单进行更新操作
	 */
	public int updateSalesOrderByMapPara(PageData pd) throws Exception{
		return salesOrderMapper.updateSalesOrderByMapPara(pd);
	}
	

	/**
	 *  保存现金订单。创建订单并收款
	 * 1. 税款=订单总金额*税率
     * 2. 对账总金额=订单总金额+税款
     * 3. 预收总金额=0
     * 4. 补收总金额=订单总金额+税金-预收总金额
     * 5. 实收总金额=预收总金额+补收总金额
	 * @param orderVO
	 * @param userVo
	 * @return
	 */
	public Map saveCashOrder(SalesOrderVO orderVO,UserVo userVo) throws Exception {
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();
		//删除空记录
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}

		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}
		//首先判断客户是否是合作伙伴
		if(StringUtil.isEmpty(orderVO.getSalesOrder().getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请先选择客户信息");
			return returnMap;
		}
		
		//制作派工的状态及制作进度
		if ("1C".equals(salesOrder.getIndustryId())) {
			salesOrder.setTaskStatus(StringUtil.isEmpty(salesOrder.getTaskStatus())?AssignEnum.ASSIGN_SALESORDER_NO.getCode():salesOrder.getTaskStatus());
			salesOrder.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
		}
		
		//新建销售订单(已对账)
		String orderStatus = OrderEnum.STATUS_YIDUIZHANG.getCode();
		String salesNo = CodeBuilderUtil.getInstance().getSalesNo();
		salesOrder.setSalesNo(salesNo);
		salesOrder.setOrderStatus(orderStatus);
		if(StringUtil.isEmpty(salesOrder.getSalesId())){ //默认销售代表salesId来自于employeeId
			salesOrder.setSalesId(CodeBuilderUtil.getInstance().getAnyId(10)); //销售代表ID
		}
		salesOrder.setDetailNum((short)items.size());
		salesOrder.setComKey(userVo.getComKey());
		Date nowTime = new Date();
		salesOrder.setCreateTime(nowTime);
		salesOrder.setChangedTime(nowTime);
		salesOrder.setCreator(userVo.getUserKey());
		salesOrder.setIndustryId(userVo.getDetailIndustryId());

		int item = 1;
		Map<String,String> mapType = new HashMap<>();
		for(SalesOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(orderStatus);
			orderDetail.setSalesNo(salesNo);
			orderDetail.setCreator(salesOrder.getCreator());
			orderDetail.setCreateTime(salesOrder.getCreateTime());
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			orderDetail.setIsUrgent(StringUtil.isEmpty(orderDetail.getIsUrgent())?"0":orderDetail.getIsUrgent());
			if("1C".equals(salesOrder.getIndustryId())
					&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())){
				if(StringUtil.isEmpty(orderDetail.getWorkingProcedure())){
					orderDetail.setWorkingProcedure(AssignEnum.ASSIGN_PROCEDURE_NONE.getCode()); //没有工序的，设置为未分配工序
				}
			}
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		salesOrder.setBusinessType("00");
		
		if("1C".equals(salesOrder.getIndustryId())
				&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())){
			//新建订单时进行制作任务派工
			workingAssignTaskService.insertWorkingAssignTaskAndDetail(salesOrder, items);
		}

		//新建对账单
		List<SalesOrder> salesOrders = new ArrayList<>();
		salesOrders.add(salesOrder);
		TaxPointVo taxPointVo = new TaxPointVo();
		taxPointVo.setTaxRate(salesOrder.getTaxRate());
		List<String> salesNos = new ArrayList<String>();
		salesNos.add(salesOrders.get(0).getSalesNo());
		SalesCheckingOrder salesCheckingOrder = nToOneCheckingOrder(userVo,salesOrders, taxPointVo,items,salesNos);
		//补收总金额
		salesCheckingOrder.setReceivablesMoney(salesCheckingOrder.getTotalPrice().subtract(salesCheckingOrder.getDepositRequested()).setScale(2, BigDecimal.ROUND_HALF_UP));
		//实收总金额
		salesCheckingOrder.setPaidUp(salesCheckingOrder.getDepositRequested().add(salesCheckingOrder.getReceivablesMoney()));
		
		//3.根据订单明细集合生成对账单明细集合
		List<SalesCheckingOrderDetail> salesCheckingOrderDetails = nToNCheckingOrderDetail(salesCheckingOrder,items);
		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_YISHOUKUAN.getCode());
		//填入订单的对账单号
		salesOrder.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
		
		//插入收款记录
		ReceiptPayment receiptPayment = new ReceiptPayment();
		receiptPayment.setCheckingNo(salesCheckingOrder.getSalescheckingNo());
		receiptPayment.setCheckingType("1"); //销售对账单
		receiptPayment.setRecpayType("1"); //收款
		receiptPayment.setComKey(userVo.getComKey()); //收款单位
		receiptPayment.setRecpayMoney(salesCheckingOrder.getPaidUp()); //收款金额(实收金额)
		receiptPayment.setAccountType(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getCode()); //其他账户类型
		receiptPayment.setAccountPayee(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getDesc());
		receiptPayment.setRecpayDate(nowTime);
		receiptPayment.setIsValid("1");
		receiptPayment.setRecpayName(userVo.getRealName());
		receiptPayment.setCreateTime(nowTime);
		receiptPaymentMapper.insertSelective(receiptPayment);
		
		this.insertOneSalesOrder(salesOrder); //新增销售订单
		this.insertListSalesOrderDetail(items); //新增销售订单明细
		this.insertOneSalesCheckingOrder(salesCheckingOrder);
		this.insertListSalesCheckingOrderDetail(salesCheckingOrderDetails);
		
		returnMap.put("status","1");
		returnMap.put("msg","保存成功");
		return returnMap;
	}


	/**
	 * 
	* @Title: saveOrderandOrderDetail 
	* @param @param orderVO
	* @param @return
	* @param @throws Exception
	* @return String
	* @throws 
	* @Description: 新建订单和订单明细
	 * 检查判断客户是否为好友合作伙伴,如果是好友合作伙伴的,自动生成好友合作伙伴的采购订单,此时进入协同订单流程,否则为单向流程处理
	 * 单向流程:
	 *   检查判断明细中的单行合计金额,为0的情况下,本单状态为待计价。否则为待对账
	 *
	 * 协同订单流程:
	 * 	1) 检查判断明细中的单行合计金额,为0的情况下,本单状态为待计价。否则为待收货
	 * 	2) 非待计价时,自动生成采购方(协同采购单)的采购订单,采购订单状态为待收货
	 *
	 *
	 */
	public Map<String,Object> saveOrderandOrderDetail(SalesOrderVO orderVO,PageData pd)
			throws Exception {
		//用于返回的map
 		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		salesOrder.setIndustryId((String) pd.get("industryId"));
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();
		
		
		//删除完全为空的记录
		/**
		 * 业务内容(文件名) 制作(配置)说明 长(米) 宽(米) 计价方式  数量 单位 单价 附加说明 行小计(¥) 
		 * businessDesc,requirements,length,width,priceWay,quantity,unit,unitPrice,additionalService,totalPrice
		 */
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}
		
		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}
		String orderStatus = OrderEnum.STATUS_DAIDUIZHANG.getCode(); //默认 待对账
        //首先判断客户是否是合作伙伴
        String comKey = pd.getString("comKey");
		if(StringUtil.isEmpty(orderVO.getSalesOrder().getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请先选择客户信息");
			return returnMap;
		}
		
		//查询合作伙伴
		PageData pd2 = new PageData();
		pd2.put("myComKey", comKey);
		pd2.put("partnerKey",orderVO.getSalesOrder().getPartnerKey());
		PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd2);

        int relation = 0; //好友关系判断 0非好友 1好友
        if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()
        		.equalsIgnoreCase(partnerVO.getPartnerStatus())){ //互为好友
        	relation = 1;
        }

        Map<String,String> mapType = new HashMap<String, String>();
		orderStatus = OrderEnum.STATUS_DAIDUIZHANG.getCode();
		
        String salesNo = CodeBuilderUtil.getInstance().getSalesNo();
        salesOrder.setSalesNo(salesNo);
		salesOrder.setOrderStatus(orderStatus);
		if(StringUtil.isEmpty(salesOrder.getSalesId())){ //默认销售代表salesId来自于employeeId
			salesOrder.setSalesId(CodeBuilderUtil.getInstance().getAnyId(10)); //销售代表ID
		}
		salesOrder.setDetailNum((short)items.size());
		salesOrder.setOrderStatus(orderStatus);
		salesOrder.setComKey(comKey);
		Date nowTime = new Date();
		salesOrder.setCreateTime(nowTime);
		salesOrder.setChangedTime(nowTime);
		salesOrder.setCreator(pd.getString("userKey"));
		salesOrder.setIndustryId(pd.getString("industryId"));
		
		//制作派工的状态及制作进度
		if ("1C".equals(salesOrder.getIndustryId())) {
			salesOrder.setTaskStatus(StringUtil.isEmpty(salesOrder
					.getTaskStatus()) ? AssignEnum.ASSIGN_SALESORDER_NO
					.getCode() : salesOrder.getTaskStatus());
			salesOrder.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING
					.getCode());
		}
		int item = 1;
		for(SalesOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(orderStatus);
			orderDetail.setSalesNo(salesNo);
			orderDetail.setCreator(salesOrder.getCreator());
			orderDetail.setCreateTime(salesOrder.getCreateTime());
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			orderDetail.setIsUrgent(StringUtil.isEmpty(orderDetail.getIsUrgent())?"0":orderDetail.getIsUrgent());
			if ("1C".equals(salesOrder.getIndustryId())
					&& AssignEnum.ASSIGN_SALESORDER_YES.getCode()
							.equalsIgnoreCase(salesOrder.getTaskStatus())) {
				if (StringUtil.isEmpty(orderDetail.getWorkingProcedure())) {
					orderDetail
							.setWorkingProcedure(AssignEnum.ASSIGN_PROCEDURE_NONE
									.getCode()); // 没有工序的，设置为未分配工序
				}
			}
			orderDetail.setBusinessType("00");
			orderDetail.setIsValid("1");
			orderDetail.setIsDel("0");
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		salesOrder.setBusinessType("00");
		
		if("1C".equals(salesOrder.getIndustryId())
				&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())){
			//新建订单时进行制作任务派工 2017-07-25 19:36:07
			workingAssignTaskService.insertWorkingAssignTaskAndDetail(salesOrder, items);
		}
		
		PurchaseOrder purchase = null;
		if(relation==1){ //好友合作伙伴的则生成协同单
			List<PurchaseOrderDetail> podDetails = null;
			PageData pdPartner = new PageData();
			pdPartner.put("partnerComKey",partnerVO.getPartnerComKey());
			purchase = this.fillInsertPurchaseOrder(salesOrder, pdPartner);
			podDetails = this.fillInsertPurchaseOrderDetails(items, purchase);
			salesOrder.setPurchaseNo(purchase.getPurchaseNo());  //协同采购单号写入销售订单
			
			purchaseOrderService.insertOnePurchaseOrder(purchase);
			purchaseOrderService.insertListPurchaseOrderDetail(podDetails);
		}
		
		this.insertOneSalesOrder(salesOrder); //新增销售订单
		this.insertListSalesOrderDetail(items); //新增销售订单明细
		
		

		//如果是协同单且为待对账状态时，查看采购方公司管理员 是否绑定微信号
		if (relation == 1
				&& orderStatus.equalsIgnoreCase(OrderEnum.STATUS_DAIDUIZHANG
						.getCode())) {
			PageData pdwechat = new PageData();
            pdwechat.put("type", "order");
            pdwechat.put("comKey", purchase.getComKey());
            pdwechat.put("partnerName", purchase.getPartnerName());
            pdwechat.put("caseDesc", purchase.getCaseDesc());
            pdwechat.put("purchaseNo", purchase.getPurchaseNo());
            pdwechat.put("orderDate", DateUtil.DateToString(purchase.getOrderDate(), DateStyle.YYYY_MM_DD.getValue()));
            pdwechat.put("totalPrice", purchase.getTotalPrice().toString());
            this.sendWechatMessage(pdwechat);
//			String comKeyPar = purchase.getComKey();
//			PageData pdPara = new PageData();
//			pdPara.put("comKey", comKeyPar);
//			 pdPara.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
//			List<EmployeeVo> employeeVos = employeeService
//					.getAllEmployee(pdPara);
//			for (EmployeeVo employeeVo : employeeVos) {
//				if (StringUtil.isNotEmpty(employeeVo.getBindWechat())) {
//					// 如果绑定 则发送待收货消息
//					PurchaseMsgVO purchaseMsgVO = new PurchaseMsgVO();
//					if (StringUtil.isNotEmpty(purchase.getCaseDesc())) {
//						purchaseMsgVO.setProjectName(purchase.getCaseDesc());
//					}else{
//						purchaseMsgVO.setProjectName(wechatConstants.defaultCaseDesc);
//					}
//					// 合作伙伴
//					purchaseMsgVO.setOrderSource(purchase.getPartnerName());
//					purchaseMsgVO.setOrderNo(purchase.getPurchaseNo());
//					purchaseMsgVO.setOrderMoney(String.valueOf(purchase
//							.getTotalPrice()));
//					purchaseMsgVO.setOrderDate(DateUtil.DateToString(
//							purchase.getOrderDate(), "yyyy-MM-dd"));
//					purchaseMsgVO.setOpenId(employeeVo.getBindWechat());
//					purchaseMsgVO.setFirst(wechatConstants.pOrderFirst);
//					purchaseMsgVO
//							.setTemplateId(wechatConstants.pOrderTemplateId);
//					purchaseMsgVO.setRemark(wechatConstants.pOrderRemark);
//					wechatUtil.sendTemMsg(purchaseMsgVO, "PO");
//					logger.info("===协同采购单微信推送\n  "+JsonUtil.toJsonString(purchase));
//				}
//			}
		}
		
		returnMap.put("status","1");
		returnMap.put("type",salesOrder.getOrderStatus());
		returnMap.put("msg","销售订单新建成功");
		return returnMap;
	}

	/**
	 * saveDraftOrder
	 * @param orderVO
	 * @param pd
	 * @return
	 * @throws Exception
	 * @Description:保存草稿
	 */
	public Map saveDraftOrder(SalesOrderVO orderVO,PageData pd)
			throws Exception {
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		salesOrder.setIndustryId(pd.getString("industryId"));
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();

		//删除空记录
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}

		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}
		String orderStatus = OrderEnum.STATUS_DAIJIJIA.getCode(); //默认 待计价
		//首先判断客户是否是合作伙伴
		String comKey = pd.getString("comKey");
		if(StringUtil.isEmpty(orderVO.getSalesOrder().getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请先选择客户信息");
			return returnMap;
		}

		//查询合作伙伴
		PageData pd2 = new PageData();
		pd2.put("myComKey", comKey);
		pd2.put("partnerKey",orderVO.getSalesOrder().getPartnerKey());
		//PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd2);

		//////////////////////////
		//如果是好友单 查看现在的订单列表中有没有关于这个好友的  非协同单
		Map<String,String> mapType = new HashMap<>();

		String salesNo = CodeBuilderUtil.getInstance().getSalesNo();
		salesOrder.setSalesNo(salesNo);
		salesOrder.setOrderStatus(orderStatus);
		if(StringUtil.isEmpty(salesOrder.getSalesId())){ //默认销售代表salesId来自于employeeId
			salesOrder.setSalesId(CodeBuilderUtil.getInstance().getAnyId(10)); //销售代表ID
		}
		salesOrder.setDetailNum((short)items.size());
		salesOrder.setOrderStatus(orderStatus);
		salesOrder.setComKey(comKey);
		Date nowTime = new Date();
		salesOrder.setCreateTime(nowTime);
		salesOrder.setChangedTime(nowTime);
		salesOrder.setCreator(pd.getString("userKey"));
		salesOrder.setIndustryId(pd.getString("industryId"));

		int item = 1;
		for(SalesOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(orderStatus);
			orderDetail.setSalesNo(salesNo);
			orderDetail.setCreator(salesOrder.getCreator());
			orderDetail.setCreateTime(salesOrder.getCreateTime());
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			orderDetail.setIsUrgent(StringUtil.isEmpty(orderDetail.getIsUrgent())?"0":orderDetail.getIsUrgent());
			orderDetail.setIsValid("1");
			orderDetail.setIsDel("0");
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		salesOrder.setBusinessType("00");

		this.insertOneSalesOrder(salesOrder); //新增销售订单
		this.insertListSalesOrderDetail(items); //新增销售订单明细



		returnMap.put("status","1");
		returnMap.put("type",salesOrder.getOrderStatus());
		returnMap.put("msg","销售订单新建成功");
		return returnMap;
	}

	/**
	 * 
	 * @Title: updateOrderAndOrderDetail 
	 * @param orderVO
	 * @param userVo
	 * @param newOrderStatus
	 * @return
	 * @throws Exception
	 * @return Map<String,Object>
	 * @throws 
	 * @Description: 销售订单的修改 1.待对账修改的 2.草稿箱提交的
	 * 2017-07-28 21:23:03 增加修改订单时对制作派工的处理。
	 * 修改派工的业务说明：
	 * 1. 如果从草稿箱改为已对账并且打开了派工的，则视为生成新派工单及工序任务。
	 * 2. 如果从待对账修改提交为待对账的。分为以下情况：
	 * 	2.1 如果是删除的，因为不知道删除的记录，需要先查询原销售单明细，获取旧记录。
	 * 		获取旧记录之后和本次提交的进行比对，提交数据的itemNo如果为空就认为是新增的
	 * 		如果itemNo有值就认为是修改的或者未修改的，比对出来旧记录比新记录多出来的就是删除的记录
	 * 		放入删除数据集中。如果itemNo有值的，因为不知道是否修改需要比对业务内容/制作要求/长/宽/数量，
	 * 		全部一致的认为没做修改，任何不相等的认为被修改了，本次新提交的记录放入派工任务删除列表中，
	 * 		同时新记录放入重新派工数据集中。
	 *  2.2 如果itemNo为空的，就认为是新增的，放入重新派工数据集中。
	 * 3. 判断重新派工数据集和删除派工数据集对象的状态，如果有值则认为需要重新派工，则调用重新派工方法。
	 * 4. 如果进行重新派工了。因为新派工的工序结果集中对应的销售订单明细的itemNo，即salesOrderItem出现了变化，
	 * 	  为避免与销售单/协同采购单出现itemNo不一致无法定位，就需要对新产生的派工工序记录进行重新分配itemNo，
	 * 	  此时需要调用重新派工更新itemNo的方法
	 * 		
	 *  
	 */
	public Map<String,Object> updateOrderAndOrderDetail(SalesOrderVO orderVO,UserVo userVo,String newOrderStatus)
			throws Exception{
		Date dateDetail = new Date();
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();

		//根据传入的订单号查询最新的销售订单信息用于判断
		PageData pdSale = new PageData();
		pdSale.put("comKey",userVo.getComKey());
		pdSale.put("salesNo",salesOrder.getSalesNo());
		SalesOrder salesOrderReal = salesOrderMapper.selectByPrimaryKey(pdSale); 

		if(!salesOrder.getOrderStatus().equals(salesOrderReal.getOrderStatus())){
			returnMap.put("status","0");
			returnMap.put("msg","您提交的订单状态已过期，请确认当前订单的状态");
			return returnMap;
		}
		
		//删除空记录
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}
		
		if(salesOrder.getPartnerKey() == null || "".equals(salesOrder.getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请选择客户");
			return returnMap;
		}
		
		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}
		
		PageData pdOldOrder = new PageData();
		pdOldOrder.put("salesNo", salesOrder.getSalesNo());
		SalesOrder oldSalesOrder = this.selectOneSalesOrder(pdOldOrder);
		String oldTaskStatus = oldSalesOrder.getTaskStatus()==null?"0":oldSalesOrder.getTaskStatus(); //原订单是否开启了派工
		String curStatus = salesOrder.getOrderStatus(); //判断当前提交的订单状态来自草稿提交还是待对账修改后提交
		
		salesOrder.setOrderStatus(newOrderStatus);
		Map<String,String> mapType = new HashMap<String, String>();//订单类型
		
		salesOrder.setChangedTime(new Date());
		salesOrder.setDetailNum((short)items.size());
		salesOrder.setIsUrgent(StringUtil.isEmpty(salesOrder.getIsUrgent())?"0":salesOrder.getIsUrgent());
		
		if ("1C".equals(salesOrder.getIndustryId())) {
			//制作派工的状态及制作进度
			salesOrder.setTaskStatus(StringUtil.isEmpty(salesOrder.getTaskStatus())?AssignEnum.ASSIGN_SALESORDER_NO.getCode():salesOrder.getTaskStatus());
			salesOrder.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
		}
		
		//如果是派工的，并且是待对账状态过来的，开始进行处理修改
		List<SalesOrderDetail> newDetail4Tasks = null; //需要新派工的数据集
		List<String> deleteItems = null; //需要作废的派工工序
		SalesOrderDetail detail4Task = null;
		boolean isReTask = false;
		if("1C".equals(salesOrder.getIndustryId())
				&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())
				&&OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(curStatus)){
			newDetail4Tasks = new ArrayList<SalesOrderDetail>();
			deleteItems = new ArrayList<String>();
			PageData pddetail = new PageData();
			pddetail.put("salesNo", salesOrder.getSalesNo());
			List<SalesOrderDetail> oldDetails = salesOrderDetailMapper.selectSalesOrderDetail(pddetail); //获取旧明细
			Map<String, SalesOrderDetail> mapDetail = new HashMap<String, SalesOrderDetail>();
			for (SalesOrderDetail item : items) { //循环提交过来的明细
				if (item.getItemNo()!=null&&item.getItemNo().intValue()>0) {  //如果提交过来的明细中itemNo不为空并且大于0，表示已存在的未删记录
					mapDetail.put(item.getSalesNo()+item.getItemNo().intValue(), item); 
				}else if(item.getItemNo()==null
						||item.getItemNo().intValue()==0){ //如果序号是空的或者0，表示新增的记录，记录放在新派工中
					newDetail4Tasks.add(item);
				}
			}
			for (SalesOrderDetail oldDetail : oldDetails) {
				detail4Task = mapDetail.get(oldDetail.getSalesNo()+oldDetail.getItemNo().intValue()); //从提交过来的记录集中获取明细对象
				if(detail4Task == null){
					deleteItems.add(oldDetail.getItemNo().toString()); //如果旧明细不存在于提交过来的明细中，说明被删除了，记录下来用于作废派工任务
				}else{
					//如果不为空，则判断 业务内容businessDesc，物料制作说明requirement，长length，宽width，数量quantity 是否发生改变，原有作废，重新派工
					
					if (!(oldDetail.getBusinessDesc().equalsIgnoreCase(detail4Task.getBusinessDesc())
							&&oldDetail.getRequirements().equalsIgnoreCase(detail4Task.getRequirements())
								&&oldDetail.getLength().compareTo(detail4Task.getLength())==0
								&&oldDetail.getWidth().compareTo(detail4Task.getWidth())==0
								&&oldDetail.getQuantity().compareTo(detail4Task.getQuantity())==0)){
						deleteItems.add(detail4Task.getItemNo().toString()); //加入删除准备作废
						newDetail4Tasks.add(detail4Task); //加入重新派工列表
					}
				}
			}
			if (deleteItems.size()>0||newDetail4Tasks.size()>0) {
				isReTask = true;
			}
		}
		
		//待对账订单的修改
		String orderStatus = salesOrder.getOrderStatus(); //判断订单状态
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equals(orderStatus)){
			
			//修改订单状态
			PageData pd1 = new PageData();
			pd1.put("myComKey",userVo.getComKey());
			pd1.put("partnerKey",salesOrder.getPartnerKey());
			PartnerVO partnerVO = partnerMapper.findPartnerByCPKey(pd1);
			
			//新建订单详情
			int item = 1;
			for(SalesOrderDetail orderDetail :items){
				mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
				orderDetail.setItemNo(item++);
				orderDetail.setOrderStatus(salesOrder.getOrderStatus());
				orderDetail.setSalesNo(salesOrder.getSalesNo());
				orderDetail.setCreator(salesOrder.getCreator());
				orderDetail.setCreateTime(dateDetail);
				orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
				orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
				orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
				orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
				orderDetail.setIsUrgent(StringUtil.isEmpty(orderDetail.getIsUrgent())?"0":orderDetail.getIsUrgent());
				if("1C".equals(salesOrder.getIndustryId())
						&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())
						&&StringUtil.isEmpty(orderDetail.getWorkingProcedure())){
						orderDetail.setWorkingProcedure(AssignEnum.ASSIGN_PROCEDURE_NONE.getCode()); //没有工序的，设置为未分配工序
				}
				orderDetail.setBusinessType("00");
				orderDetail.setIsValid("1");
				orderDetail.setIsDel("0");
			}
			String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
			salesOrder.setBusinessType("00");
			salesOrder.setDetailNum((short)(item-1));
			if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()
					.equalsIgnoreCase(partnerVO.getPartnerStatus())){ //如果是好友的，则生成协同采购单
				PageData pdPurchase = new PageData();
				pdPurchase.put("partnerComKey",partnerVO.getPartnerComKey());
				pdPurchase.put("purchaseNo",salesOrderReal.getPurchaseNo());
				PurchaseOrder purchase = this.fillInsertPurchaseOrder(salesOrder, pdPurchase);
				List<PurchaseOrderDetail> podDetails = this.fillInsertPurchaseOrderDetails(items, purchase);
				//首先删除原有的协同单
				pdPurchase.clear();
				pdPurchase.put("comKey", partnerVO.getPartnerComKey());
				pdPurchase.put("purchaseNo", purchase.getPurchaseNo());
				purchaseOrderService.deletePurchaseOrder(pdPurchase);
				purchaseOrderService.deletePurchaseOrderDetail(pdPurchase);
				//生成新的协同单
				purchaseOrderService.insertOnePurchaseOrder(purchase);
				purchaseOrderService.insertListPurchaseOrderDetail(podDetails);
				salesOrder.setPurchaseNo(purchase.getPurchaseNo());
			}
			
			//如果本次启用了派工，提交从待对账过来，并且上次没启用派工的，视为新启用派工处理
			//如果启用了派工，并且从草稿箱进来的，属于新派工单
			if("1C".equalsIgnoreCase(salesOrder.getIndustryId())
					&&AssignEnum.ASSIGN_SALESORDER_YES.getCode().equalsIgnoreCase(salesOrder.getTaskStatus())){
				if (OrderEnum.STATUS_DAIJIJIA.getCode().equalsIgnoreCase(curStatus)) {
					workingAssignTaskService.insertWorkingAssignTaskAndDetail(salesOrder, items);
					isReTask = false;
				}
				if (oldTaskStatus.equalsIgnoreCase("0")
						&&OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(curStatus)) {
					workingAssignTaskService.insertWorkingAssignTaskAndDetail(salesOrder, items);
					isReTask = false;
				}
			}
			
			if (isReTask) { //如果触发了重新派工，进行处理。
				workingAssignTaskService.updateReAssignTask(newDetail4Tasks, deleteItems, salesOrder.getComKey(), salesOrder.getSalesNo());
			}
			
			//删除订单详情
			PageData pdDel = new PageData();
			pdDel.put("comKey", salesOrder.getComKey());
			pdDel.put("salesNo", salesOrder.getSalesNo());
			this.deleteSalesOrderDetail(pdDel);//删除订单详情
			
			this.updateSalesOrder(salesOrder);//修改订单
			this.insertListSalesOrderDetail(items); //新增销售订单明细
			
			if (isReTask) { //如果触发了重新派工，进行处理。
				List<SalesOrderDetail> newDetails = this.selectSalesOrderDetailList(salesOrder.getSalesNo());
				if(newDetails!=null&&newDetails.size()>0){
					workingAssignTaskService.updateReItemNo(newDetails, salesOrder.getComKey(), salesOrder.getSalesNo());
				}
			}
			
			this.updateAssignTask(salesOrder, items); //修改设计派工
			
			if (newDetail4Tasks!=null) {
				newDetail4Tasks.clear();
			}
			if (deleteItems!=null) {
				deleteItems.clear();
			}
			
			returnMap.put("type",salesOrder.getOrderStatus());
			returnMap.put("status","1");
			returnMap.put("msg","添加成功");
			return returnMap;
		}
		else {
			returnMap.put("status","0");
			returnMap.put("msg","订单状态不合法");
			return returnMap;
		}

	}


	/**
	 * 销售订单的修改(保存为草稿箱)
	 * @param orderVO
	 * @param userVo
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> updateOrderAndOrderDetailAsDraft(SalesOrderVO orderVO,UserVo userVo)
			throws Exception{
		Date dateDetail = new Date();
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setComKey(userVo.getComKey());
		salesOrder.setCreator(userVo.getUserKey());
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();

		PageData pdSale = new PageData();
		pdSale.put("comKey",userVo.getComKey());
		pdSale.put("salesNo",salesOrder.getSalesNo());
		SalesOrder salesOrderReal = salesOrderMapper.selectByPrimaryKey(pdSale);

		if(!salesOrder.getOrderStatus().equals(salesOrderReal.getOrderStatus())){
			returnMap.put("status","0");
			returnMap.put("msg","您提交的订单状态已过期，请确认当前订单的状态");
			return returnMap;
		}

		//删除空记录
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}

		if(salesOrder.getPartnerKey() == null || "".equals(salesOrder.getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请选择客户");
			return returnMap;
		}
		
		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}

		//判断订单状态
		String orderStatus = salesOrder.getOrderStatus();
		//订单类型
		Map<String,String> mapType = new HashMap<>();

		//删除订单详情
		PageData pdDel = new PageData();
		pdDel.put("comKey", salesOrder.getComKey());
		pdDel.put("salesNo", salesOrder.getSalesNo());

		//待计价订单（草稿）
		if (OrderEnum.STATUS_DAIJIJIA.getCode().equals(orderStatus)
				|| OrderEnum.STATUS_DAIDUIZHANG.getCode().equals(orderStatus)) {
			if(StringUtil.isNotEmpty(salesOrder.getPurchaseNo())){
				returnMap.put("status","0");
				returnMap.put("msg","协同单无法修改");
				return returnMap;
			}
			//修改订单状态
			this.deleteSalesOrderDetail(pdDel);//删除订单详情
			
			//新建订单详情
			int item = 1;
			for(SalesOrderDetail orderDetail :items){
				mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
				orderDetail.setItemNo(item++);
				orderDetail.setOrderStatus(OrderEnum.STATUS_DAIJIJIA.getCode());
				orderDetail.setSalesNo(salesOrder.getSalesNo());
				orderDetail.setCreator(salesOrder.getCreator());
				orderDetail.setCreateTime(dateDetail);
				orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
				orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
				orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
				orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
				orderDetail.setBusinessType("00");
				orderDetail.setIsValid("1");
				orderDetail.setIsDel("0");
			}
			String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
			salesOrder.setBusinessType("00");
			salesOrder.setDetailNum((short)(item-1));
			//订单状态(带计价 草稿状态)
			salesOrder.setOrderStatus(OrderEnum.STATUS_DAIJIJIA.getCode());
			
			this.updateSalesOrder(salesOrder);//修改订单
			this.insertListSalesOrderDetail(items); //新增销售订单明细
			
			this.updateAssignTask(salesOrderReal, items); //修改派工
			
			returnMap.put("type", salesOrder.getOrderStatus());
			returnMap.put("status","1");
			returnMap.put("msg","添加成功");
			return returnMap;
		}else{
			returnMap.put("status","0");
			returnMap.put("msg","订单状态不合法");
			return returnMap;
		}

	}

	/**
	 * 销售订单的修改(保存为现金订单状态)
	 * @param orderVO
	 * @param userVo
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> updateOrderAndOrderDetailAsCash(SalesOrderVO orderVO,UserVo userVo)
			throws Exception{
		Date nowTime = new Date();
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		SalesOrder salesOrder = orderVO.getSalesOrder();
		salesOrder.setCaseDesc(salesOrder.getCaseDesc() == null ? "" : salesOrder.getCaseDesc());
		//获取订单详情列表
		List<SalesOrderDetail> items = orderVO.getDetails();


		PageData pdSale = new PageData();
		pdSale.put("comKey",userVo.getComKey());
		pdSale.put("salesNo",salesOrder.getSalesNo());
		SalesOrder salesOrderReal = salesOrderMapper.selectByPrimaryKey(pdSale);

		if(!salesOrder.getOrderStatus().equals(salesOrderReal.getOrderStatus())){
			returnMap.put("status","0");
			returnMap.put("msg","您提交的订单状态已过期，请确认当前订单的状态");
			return returnMap;
		}
		//判断订单状态
		String orderStatus = salesOrder.getOrderStatus();
		if(!OrderEnum.STATUS_DAIJIJIA.getCode().equals(orderStatus) ){
			returnMap.put("status","0");
			returnMap.put("msg","订单状态不合法");
			return returnMap;
		}

		//删除空记录
		Iterator<SalesOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			SalesOrderDetail item = it.next();
			if(StringUtil.isEmpty(item.getBusinessDesc())
					&&StringUtil.isEmpty(item.getRequirements())
					&&item.getLength().compareTo(BigDecimal.ZERO)==0
					&&item.getWidth().compareTo(BigDecimal.ZERO)==0
					&&item.getQuantity().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getUnit())
					&&item.getUnitPrice().compareTo(BigDecimal.ZERO)==0
					&&StringUtil.isEmpty(item.getAdditionalService())
					&&item.getTotalPrice().compareTo(BigDecimal.ZERO)==0){
				it.remove();
			}
		}
		
		if(salesOrder.getPartnerKey() == null || "".equals(salesOrder.getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请选择客户");
			return returnMap;
		}
		
		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}

		//订单类型
		Map<String,String> mapType = new HashMap<>();
		
		//删除订单详情
		PageData pdDel = new PageData();
		pdDel.put("comKey", salesOrder.getComKey());
		pdDel.put("salesNo", salesOrder.getSalesNo());
		
		//修改订单状态（已对账）
		salesOrder.setOrderStatus(OrderEnum.STATUS_YIDUIZHANG.getCode());
		this.deleteSalesOrderDetail(pdDel);//删除订单详情
		//新建订单详情
		int item = 1;
		for(SalesOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(salesOrder.getOrderStatus());
			orderDetail.setSalesNo(salesOrder.getSalesNo());
			orderDetail.setCreator(salesOrder.getCreator());
			orderDetail.setCreateTime(nowTime);
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			orderDetail.setBusinessType("00");
			orderDetail.setIsValid("1");
			orderDetail.setIsDel("0");
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		salesOrder.setBusinessType("00");
		salesOrder.setDetailNum((short)(item-1));
		//新建对账单
		List<SalesOrder> salesOrders = new ArrayList<>();
		salesOrders.add(salesOrder);
		TaxPointVo taxPointVo = new TaxPointVo();
		taxPointVo.setTaxRate(salesOrder.getTaxRate());
		List<String> salesNos = new ArrayList<String>();
		salesNos.add(salesOrders.get(0).getSalesNo());
		SalesCheckingOrder salesCheckingOrder = nToOneCheckingOrder(userVo,salesOrders, taxPointVo,items,salesNos);
		//3.根据订单明细集合生成对账单明细集合
		List<SalesCheckingOrderDetail> salesCheckingOrderDetails = nToNCheckingOrderDetail(salesCheckingOrder,items);
		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_YISHOUKUAN.getCode());
		//填入订单的对账单号
		salesOrder.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
		
		//补收总金额
		salesCheckingOrder.setReceivablesMoney(salesCheckingOrder.getTotalPrice().subtract(salesCheckingOrder.getDepositRequested()).setScale(2, BigDecimal.ROUND_HALF_UP));
		//实收总金额
		salesCheckingOrder.setPaidUp(salesCheckingOrder.getDepositRequested().add(salesCheckingOrder.getReceivablesMoney()));
		
		//插入收款记录
		ReceiptPayment receiptPayment = new ReceiptPayment();
		receiptPayment.setCheckingNo(salesCheckingOrder.getSalescheckingNo());
		receiptPayment.setCheckingType("1"); //销售对账单
		receiptPayment.setRecpayType("1"); //收款
		receiptPayment.setComKey(userVo.getComKey()); //收款单位
		receiptPayment.setRecpayMoney(salesCheckingOrder.getPaidUp()); //收款金额(实收金额)
		receiptPayment.setRecpayDate(nowTime);
		receiptPayment.setAccountType(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getCode()); //其他账户类型
		receiptPayment.setAccountPayee(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getDesc());
		receiptPayment.setIsValid("1");
		receiptPayment.setRecpayName(userVo.getRealName());
		receiptPayment.setCreateTime(nowTime);
		receiptPaymentMapper.insertSelective(receiptPayment);
		

		this.updateSalesOrder(salesOrder);//修改订单
		this.insertListSalesOrderDetail(items); //新增销售订单明细
		this.insertOneSalesCheckingOrder(salesCheckingOrder);
		this.insertListSalesCheckingOrderDetail(salesCheckingOrderDetails);

		this.updateAssignTask(salesOrder, items);
		
		returnMap.put("type",salesOrder.getOrderStatus());
		returnMap.put("status","1");
		returnMap.put("msg","添加成功");
		return returnMap;

	}
	/**
	 * 
	 * @Title: selectOneSalesOrder
	 * @param @param pd
	 * @param @return
	 * @param @throws Exception
	 * @return SalesOrder
	 * @throws 
	 * @Description: 查询单条销售订单
	 */
	public SalesOrder selectOneSalesOrder(PageData pd){
		SalesOrder order = salesOrderMapper.selectByPrimaryKey(pd);
		if(order!=null){
			order.setOrderStatusDesc(orderConfigService.formatOrderStatus(order.getOrderStatus()));
			pd.put("comKey", order.getComKey());
			order.setComName(companyService.getCompanyByKey(pd).getComName());
			pd.put("partnerKey", order.getPartnerKey());
			pd.put("contacterId", order.getContactId());
            PartnerVO partnerVO = partnerService.selectOnePartnerAndContacterByPartnerKey(pd);
            if (partnerVO!=null) {
				order.setContactTel(partnerVO.getTel1());
				order.setTaxNo(partnerVO.getTaxNo());
			}
		}
		return order;
	}
	
	/**
	 * 
	* @Title: listPageSalesOrder
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<SalesOrder>
	* @throws 
	* @Description: 查询带分页的销售订单列表
	 */
	public List<SalesOrder> listPageSalesOrder(Page page) throws Exception{
		return salesOrderMapper.listPageSalesOrder(page);
	}
	public List<SalesOrder> listPageSalesOrderConcat(Page page) throws Exception{
		List<SalesOrder> orders = salesOrderMapper.listPageSalesOrderConcat(page);
		return orders;
	}

	 /**
	 * 修改页面的相关数据
	 * 1.salesOrder  		订单
	 * 2.salesOrderDetail   订单详情
	 * 3.clients			客户
	 * 4.salesMan			销售代表
	 * 5.contacters			联系人
	 * @return
	 */
	public Map<String,Object> getOrderDatasForUpdateOrder(PageData pd) throws Exception {
		Map<String,Object> sales  = getMapVOSalesOrderDetail(pd);
		SalesOrder salesOrder = (SalesOrder) sales.get("salesOrder");
		PageData pd2 = new PageData();
		pd2.put("comKey",salesOrder.getComKey());
		//销售代表
//		pd2.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
//        List<SalesMan> salesMen = employeeService.getList4order(pd2);
        List<Employee> employees = employeeService.getAllEmployeesForDropdown(pd2); //采购代表
        
		//客户
		pd2.put("partnerType", CompanyEnum.PARTNER_TYPE_CUSTOMER.getCode()); //客户
		//判断当前订单状态是否为待对账
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equals(salesOrder.getOrderStatus()) ){
//			pd2.put("notFriend","true");
			pd2.put("notFriend",null);
		}

		Page page = new Page();
		page.setShowCount(300);
		page.setCurrentPage(1);
		page.setPd(pd2);
		List<PartnerVO> partnerVOs = partnerService.findListPartnerVO(page);
		for (PartnerVO partnerVO : partnerVOs) {
			if(StringUtil.isEmpty(partnerVO.getPartnerShortname())
					&&StringUtil.isEmpty(partnerVO.getMnemonicCode())){
				continue;
			}else{
				String shortname = StringUtil.isEmpty(partnerVO.getPartnerShortname())?"":partnerVO.getPartnerShortname();
				String code = StringUtil.isEmpty(partnerVO.getMnemonicCode())?"":partnerVO.getMnemonicCode();
				partnerVO.setMyComShortname(shortname+"-"+code);
			}
		}
		//待对账修改的，客户列表中去掉过路客
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(salesOrder.getOrderStatus())){
			Iterator<PartnerVO> it = partnerVOs.iterator();
			while(it.hasNext()){
				PartnerVO vo = it.next();
				if(vo.getPartnerKey().equalsIgnoreCase("temp-customer")){
					it.remove();
				}
			}
		}
		//联系人
		PageData pd3 = new PageData();
		pd3.put("partnerKey",salesOrder.getPartnerKey());
		pd3.put("contacterId", salesOrder.getContactId());
		List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pd3);
		sales.put("salesMen",employees);
		sales.put("clients",partnerVOs);
		sales.put("partnerContacters",partnerContacters);

		return sales;
	}


	/**
	 * 
	* @Title: getSalesOrderDetailMap 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return HashMap<String,Object>
	* @throws 
	* @Description: 查看销售订单的明细记录。包括业务类型、列内容，订单内容，订单明细内容
	 */
	public HashMap<String, Object> getMapVOSalesOrderDetail(PageData pd) throws Exception{
		HashMap<String, Object> mapVO = new HashMap<String,Object>();
		SalesOrder salesOrder = this.selectOneSalesOrder(pd);
		String businessTypes = salesOrder.getBusinessType();
		if (StringUtil.isEmpty(businessTypes)) {
			businessTypes = "00";
		}
		List<String> list = Tools.strArray2List(Tools.str2StrArray(businessTypes));
		for(int i=0;i<list.size();i++){
			mapVO.put(list.get(i).toString(),orderConfigService.getOneBusinessTypeVO(pd.getString("industryId"), list.get(i).toString()));
		}
		Page page = new Page();
		page.setShowCount(300);
		page.setPd(pd);
//		SalesOrder salesOrder = this.selectOneSalesOrder(pd);
		salesOrder.setChangedTime(null);
		salesOrder.setCreateTime(null);
		mapVO.put("salesOrder",salesOrder);
		List<SalesOrderDetail> salesOrderDetails = this.listPageSalesOrderDetail(page);
		for(SalesOrderDetail salesOrderDetail : salesOrderDetails){
			salesOrderDetail.setCreateTime(null);
		}
		mapVO.put("salesOrderDetail",salesOrderDetails);
		
		return mapVO;
	}
	
	// 获取销售订单列表的合计金额、订单数统计
	public OrderTotalVO getSumTotalPriceOrder(PageData pd) throws Exception{
		return salesOrderMapper.selectSumSalesOrder(pd);
	}
	// 获取销售订单明细的合计数
	private Integer getCountOrderDetail(PageData pd) throws Exception{
		return salesOrderDetailMapper.getCountOrderDetail(pd);
	}
	
	// 获取销售对账单列表的合计金额、订单数统计
	private OrderTotalVO getSumTotalPriceCheckingOrder(PageData pd) throws Exception{
		return salesCheckingOrderMapper.selectSumSalesCheckingOrder(pd);
	}
	// 获取销售对账单明细的合计数
	private Integer getCountCheckingOrderDetail(PageData pd) throws Exception{
		return salesCheckingOrderDetailMapper.getCountOrderDetail(pd);
	}
	
	
	/**
	 * 
	* @Title: getSumOrderTotalVO 
	* @param pd type: 01 协同订单 02 协同对账单 
	* 				  03 销售订单 04 销售对账单
	* 				  05 外协采购订单 06 外协采购对账单
	* @return
	* @throws Exception
	* @return OrderTotalVO
	* @throws 
	* @Description: 根据传入的条件获取订单/对账单统计值对象
	 */

	public OrderTotalVO getSumTotalVO(PageData pd,String type) throws Exception{
		OrderTotalVO orderTotalVO = null;
		
		if(OrderEnum.TYPE_SALESORDER.getCode().equalsIgnoreCase(type)){ //销售订单
			orderTotalVO = this.getSumTotalPriceOrder(pd);
			orderTotalVO.setOrderDetailCount(this.getCountOrderDetail(pd).intValue());
			orderTotalVO.setSumDetailTotalPrice(salesOrderDetailMapper.selectDetailTotalPriceBySalesNo(pd));
		}else if(OrderEnum.TYPE_SALESCHECKINGORDER.getCode().equalsIgnoreCase(type)){ //销售对账单
			orderTotalVO = this.getSumTotalPriceCheckingOrder(pd);
			orderTotalVO.setOrderDetailCount(this.getCountCheckingOrderDetail(pd).intValue());
		}
		orderTotalVO.setSumTotalPrice(orderTotalVO.getSumTotalPrice()==null?BigDecimal.ZERO:orderTotalVO.getSumTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP));
		
		return orderTotalVO;
	}
	
	
	
	/**
	 * 
	* @Title: updateSalesOrder
	* @param @param record
	* @return void
	* @throws 
	* @Description: 更新销售订单
	 */
	public int updateSalesOrder(SalesOrder record) throws Exception{
		return salesOrderMapper.updateByPrimaryKeySelective(record);
	}
	
	/**
	 * 
	* @Title: insertSalesOrder
	* @param @param record
	* @return void
	* @throws 
	* @Description: 创建销售订单
	 */
	public void insertOneSalesOrder(SalesOrder record) throws Exception{
		salesOrderMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListSalesOrder 
	* @param @param records
	* @return void
	* @throws 
	* @Description: 批量创建销售订单
	 */
	public void insertListSalesOrder(List<SalesOrder> records) throws Exception{
		salesOrderMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: deleteSalesOrder
	* @param @param pd
	* @return void
	* @throws 
	* @Description: 删除销售订单
	 */
	public int deleteSalesOrder(PageData pd){
		return salesOrderMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: selectOneSalesOrderDetail
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return SalesOrderDetail
	* @throws 
	* @Description: 查询单条销售订单明细
	 */
	public SalesOrderDetail selectOneSalesOrderDetail(PageData pd) throws Exception{
		SalesOrderDetail sodDetail = salesOrderDetailMapper.selectByPrimaryKey(pd);
			sodDetail.setTotalArea(sodDetail.getWidth().multiply(sodDetail.getLength()).multiply(sodDetail.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			sodDetail.setPriceWayDesc(orderConfigService.formatPriceWay(sodDetail.getPriceWay()));
		return sodDetail;
	}
	/**
	 * 
	* @Title: listSalesOrderDetail 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<SalesOrderDetail>
	* @throws 
	* @Description: 查询带分页的销售订单明细列表
	 */
	public List<SalesOrderDetail> listPageSalesOrderDetail(Page page) throws Exception{
		List<SalesOrderDetail> sods = salesOrderDetailMapper.listPageSalesOrderDetail(page);
		if(sods!=null&&sods.size()>0){
			for(SalesOrderDetail sod : sods){
				sod.setTotalArea(sod.getWidth().multiply(sod.getLength()).multiply(sod.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
				sod.setPriceWayDesc(orderConfigService.formatPriceWay(sod.getPriceWay()));
			}
		}
		return sods;
	}
	
	/**
	 * 
	 * @Title: listPageTotalDetailBySalesNo 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return List<TotalSalesOrderDetailVO>
	 * @throws 
	 * @Description: 带分页的混合了订单的全部明细列表
	 */
	public List<TotalSalesOrderDetailVO> listPageTotalDetailBySalesNo(PageData pd) throws Exception{
		List<TotalSalesOrderDetailVO> totalSalesOrderDetailVOs = salesOrderDetailMapper.selectTotalDetailBySalesNo(pd);
		if(totalSalesOrderDetailVOs!=null && totalSalesOrderDetailVOs.size()>0){
			for(TotalSalesOrderDetailVO tsodVO : totalSalesOrderDetailVOs){
				tsodVO.setTotalArea(tsodVO.getWidth().multiply(tsodVO.getLength()).multiply(tsodVO.getQuantity())
						.setScale(2, BigDecimal.ROUND_HALF_UP));
				tsodVO.setOrderStatusDesc(orderConfigService.formatOrderStatus(tsodVO.getOrderStatus()));
				//拼装规格尺寸
//				if (tsodVO.getLength().compareTo(BigDecimal.ZERO)==0
//						&&tsodVO.getWidth().compareTo(BigDecimal.ZERO)==0) {
//					tsodVO.setSpecification("");
//				}else{
//					tsodVO.setSpecification(tsodVO.getLength()+" * "+tsodVO.getWidth());
//				}
			}
		}
		return totalSalesOrderDetailVOs;
	}
	
	/**
	 * 
	 * @Title: listPageTotalDetailByOrder 
	 * @param page
	 * @return
	 * @throws Exception
	 * @return List<TotalSalesOrderDetailVO>
	 * @throws 
	 * @Description: 为订单型明细记录提供检索结果。
	 * 1.首先获取检索条件的订单结果，拿到订单号。
	 * 2.根据订单号获取对应的订单详情返回
	 */
	public List<TotalSalesOrderDetailVO> listPageTotalDetailByOrder(Page page) 
			throws Exception{
		
		List<SalesOrderDetail> detailNos = salesOrderDetailMapper.listPageTotalDetailByOrder(page);
		if(detailNos==null||detailNos.size()<=0){
			return null;
		}
		List<String> salesNoList = new ArrayList<String>();
		for (SalesOrderDetail salesOrderDetail : detailNos) {
			salesNoList.add(salesOrderDetail.getSalesNo());
		}
		PageData pd = new PageData();
		pd.put("salesNo", salesNoList);
		pd.put("comKey", page.getPd().get("comKey"));
		List<TotalSalesOrderDetailVO> totalSalesOrderDetailVOs = salesOrderDetailMapper.selectTotalDetailBySalesNo(pd);
		
		pd.put("fromSalesNo", Tools.strSqlIn(Tools.list2InString(salesNoList)));
		List<PurchaseOrder> numPurchaseOrders = purchaseOrderService.listFromSalesNoToPurchaseNoNum(pd);
		Map<String, PurchaseOrder> mapPurchase = new HashMap<>();
		for (PurchaseOrder purchaseOrder : numPurchaseOrders) {
			mapPurchase.put(purchaseOrder.getFromSalesNo(), purchaseOrder);
		}
		
		try {
			if(totalSalesOrderDetailVOs!=null && totalSalesOrderDetailVOs.size()>0){
				for(TotalSalesOrderDetailVO tsodVO : totalSalesOrderDetailVOs){
					tsodVO.setTotalArea(tsodVO.getWidth().multiply(tsodVO.getLength()).multiply(tsodVO.getQuantity())
							.setScale(2, BigDecimal.ROUND_HALF_UP)); //计算面积
					tsodVO.setOrderStatusDesc(orderConfigService.formatOrderStatus(tsodVO.getOrderStatus()));
					if (mapPurchase.get(tsodVO.getSalesNo())!=null) {
						tsodVO.setPurchaseNoNum(mapPurchase.get(tsodVO.getSalesNo()).getPurchaseNoNum());
					}
				}
			}
		} finally {
			mapPurchase.clear();
			if (numPurchaseOrders!=null) {
				numPurchaseOrders.clear();
			}
		}
		return totalSalesOrderDetailVOs;
	}
	
	/**
	 * 
	 * @Title: getSalesOrderNos 
	 * @param pd
	 * @return
	 * @return List<String>
	 * @throws 
	 * @Description: 根据检索条件查询销售订单号
	 */
	public List<String> getSalesOrderNos(PageData pd){
		List<SalesOrderDetail> details = salesOrderDetailMapper.getSalesOrderNos(pd);
		List<String> salesNoList = new ArrayList<>();
		for (SalesOrderDetail detail : details) {
			salesNoList.add(detail.getSalesNo());
		}
		return salesNoList;
	}

	/**
	 * 根据销售订单号 查询对应的所有销售订单详情
	 * @param salesNo 销售订单编号
	 * @return 销售订单详情集合
	 */
	public List<SalesOrderDetail> selectSalesOrderDetailList(String salesNo){
		PageData pd = new PageData();
		pd.put("salesNo",salesNo);
		return salesOrderDetailMapper.selectSalesOrderDetail(pd);
	}

	/**
	 *
	* @Title: listSalesMan
	* @param @param comKey
	* @param @return
	* @return List<SalesMan>
	* @throws
	* @Description: 从已经产生的销售订单中获取销售代表列表
	 */
	public List<SalesMan> listSalesMan(PageData pd){
		return salesOrderMapper.listSalesMan(pd);
	}

	/**
	 * 
	* @Title: insertSalesOrderDetail 
	* @param @param sod
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条销售订单明细
	 */
	public void insertOneSalesOrderDetail(SalesOrderDetail record) throws Exception{
		salesOrderDetailMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListSalesOrderDetail 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增销售订单明细
	 */
	public void insertListSalesOrderDetail(List<SalesOrderDetail> records) throws Exception{
		salesOrderDetailMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updateSalesOrderDetail 
	* @param @param record
	* @return void
	* @throws 
	* @Description: 更新销售订单明细
	 */
	public int updateSalesOrderDetail(SalesOrderDetail record) throws Exception{
		return salesOrderDetailMapper.updateByPrimaryKeySelective(record);
	}
	
	/**
	 * 
	* @Title: deleteSalesOrderDetail 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除销售订单明细
	 */
	public void deleteSalesOrderDetail(PageData pd) throws Exception{
		salesOrderDetailMapper.deleteByPrimaryKey(pd);
	}

	//////////////////////////	//////////////////////////对账单	//////////////////////////	//////////////////////////

	/**
	 * 
	* @Title: selectOneSalesCheckingOrder 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return SalesCheckingOrder
	* @throws 
	* @Description: 查询单条销售对账单
	 */
	public SalesCheckingOrder selectOneSalesCheckingOrder(PageData pd) throws Exception{
		SalesCheckingOrder checkingOrder = salesCheckingOrderMapper.selectByPrimaryKey(pd);
		if (checkingOrder!=null) {
			pd.put("comKey", checkingOrder.getComKey());
			checkingOrder.setComName(companyService.getCompanyByKey(pd).getComName());
			checkingOrder.setOrderStatusDesc(orderConfigService.formatOrderStatus(checkingOrder.getOrderStatus()));
			pd.put("partnerKey", checkingOrder.getPartnerKey());
			pd.put("contacterId", checkingOrder.getContactId());
			PartnerVO partnerVO = partnerService.selectOnePartnerAndContacterByPartnerKey(pd);
            if (partnerVO!=null) {
            	checkingOrder.setContactTel(partnerVO.getTel1());
            	checkingOrder.setTaxNo(partnerVO.getTaxNo());
			}
		}
		
		return checkingOrder;
	}
	
	public ReceiptPayment getReceiptPaymentInfo(PageData pd){
		return receiptPaymentMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: listSalesCheckingOrders 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<SalesCheckingOrder>
	* @throws 
	* @Description: 查询带分页的销售对账单列表
	 */
	public List<SalesCheckingOrder> listPageSalesCheckingOrders(Page page) throws Exception{
		return salesCheckingOrderMapper.listPageSalesCheckingOrder(page);
	}
//	public List<SalesCheckingOrder> listPageSalesCheckingOrderConcat(Page page) throws Exception{
//		return salesCheckingOrderMapper.listPageSalesCheckingOrderConcat(page);
//	}
	
	public String selectSalesNoInsBySalesCheckingOrder(PageData pd){
		return salesCheckingOrderMapper.selectSalesNoIns(pd);
	}
	
	/**
	 * 
	* @Title: insertOneSalesCheckingOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条销售对账单记录
	 */
	public void insertOneSalesCheckingOrder(SalesCheckingOrder record) throws Exception{
		salesCheckingOrderMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListSalesCheckingOrder 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增销售对账单记录
	 */
	public void insertListSalesCheckingOrder(List<SalesCheckingOrder> records) throws Exception{
		salesCheckingOrderMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updateSalesCheckingOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新销售对账单
	 */
	public void updateSalesCheckingOrder(SalesCheckingOrder record) throws Exception{
		salesCheckingOrderMapper.updateByPrimaryKeySelective(record);
	}
	
	public int updateBatchBySalesCheckingNoIn(PageData pd) throws Exception{
		return salesCheckingOrderMapper.updateBatchBySalesCheckingNoIn(pd);
	}
	
	/**
	 * 
	* @Title: deleteSalesCheckingOrder 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除销售对账单
	 */
	public void deleteSalesCheckingOrder(PageData pd) throws Exception{
		salesCheckingOrderMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: selectOneSalesCheckingOrderDetail 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return SalesCheckingOrderDetail
	* @throws 
	* @Description: 查询单条销售对账单明细
	 */
	public SalesCheckingOrderDetail selectOneSalesCheckingOrderDetail(PageData pd) throws Exception{
		return salesCheckingOrderDetailMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 *
	* @Title: listSalesCheckingOrderDetail
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<SalesCheckingOrderDetail>
	* @throws
	* @Description: 批量查询  查询带分页的销售销售对账单明细
	 */
	public List<SalesCheckingOrderDetail> listPageSalesCheckingOrderDetail(Page page) throws Exception{
		return salesCheckingOrderDetailMapper.listPageSalesCheckingOrderDetail(page);
	}

	/**
	 * @Title: listSalesCheckingOrderDetail
	 * @param @param pageData
	 * @param @return
	 * @param @throws Exception
	 * @return List<SalesCheckingOrderDetail>
	 * @throws
	 * @Description: 批量查询销售销售对账单明细
	 */
	public List<TotalSalesCheckingOrderDetailVO> listSalesCheckingOrderDetail(PageData pageData) throws Exception{
		List<TotalSalesCheckingOrderDetailVO> scods = salesCheckingOrderDetailMapper.selectSalesCheckingOrderDetailVO(pageData);
		if(scods!=null&&scods.size()>0){
			for(SalesCheckingOrderDetail scodetail : scods){
				scodetail.setPriceWayDesc(orderConfigService.formatPriceWay(scodetail.getPriceWay()));
				//计算面积
				scodetail.setTotalArea(scodetail.getWidth().multiply(scodetail.getLength()).multiply(scodetail.getQuantity())
						.setScale(2, BigDecimal.ROUND_HALF_UP));
				//拼装规格尺寸
				if (scodetail.getLength().compareTo(BigDecimal.ZERO)==0
						&&scodetail.getWidth().compareTo(BigDecimal.ZERO)==0) {
					scodetail.setSpecification("");
				}else{
					scodetail.setSpecification(scodetail.getLength()+" * "+scodetail.getWidth());
				}
			}
		}
		return scods;
	}
	/**
	 * 
	 * @Title: listPageSalesCheckingOrderDetailVO 
	 * @param page
	 * @return
	 * @throws Exception
	 * @return List<TotalSalesCheckingOrderDetailVO>
	 * @throws 
	 * @Description: 电脑端销售对账单详情分页查询
	 */
	public List<TotalSalesCheckingOrderDetailVO> listPageSalesCheckingOrderDetailVO(Page page) throws Exception{
		List<TotalSalesCheckingOrderDetailVO> scods = salesCheckingOrderDetailMapper.listPageSalesCheckingOrderDetailVO(page);
		if(scods!=null&&scods.size()>0){
			for(SalesCheckingOrderDetail scodetail : scods){
				scodetail.setPriceWayDesc(orderConfigService.formatPriceWay(scodetail.getPriceWay()));
				//计算面积
				scodetail.setTotalArea(scodetail.getWidth().multiply(scodetail.getLength()).multiply(scodetail.getQuantity())
						.setScale(2, BigDecimal.ROUND_HALF_UP));
				//拼装规格尺寸
				if (scodetail.getLength().compareTo(BigDecimal.ZERO)==0
						&&scodetail.getWidth().compareTo(BigDecimal.ZERO)==0) {
					scodetail.setSpecification("");
				}else{
					scodetail.setSpecification(scodetail.getLength()+" * "+scodetail.getWidth());
				}
			}
		}
		return scods;
	}
	
	/**
	 * @Title: listSalesCheckingOrderDetail
	 * @param @param pageData
	 * @param @return
	 * @param @throws Exception
	 * @return List<SalesCheckingOrderDetail>
	 * @throws
	 * @Description: 批量查询销售销售对账单明细
	 */
	public List<SalesCheckingOrderDetailVO> getCheckingDetailVO(PageData pageData) throws Exception{
		List<SalesCheckingOrderDetailVO> scods = salesCheckingOrderDetailMapper.selectSalesCheckingOrderVO(pageData);
		if(scods!=null&&scods.size()>0){
			for(SalesCheckingOrderDetailVO scod : scods){
				List<SalesCheckingOrderDetail> scodetails = scod.getDetails();
				for (SalesCheckingOrderDetail scodetail : scodetails) {
					scodetail.setPriceWayDesc(orderConfigService.formatPriceWay(scodetail.getPriceWay()));
					//计算面积
					scodetail.setTotalArea(scodetail.getWidth().multiply(scodetail.getLength()).multiply(scodetail.getQuantity())
							.setScale(2, BigDecimal.ROUND_HALF_UP));
					//拼装规格尺寸
					if (scodetail.getLength().compareTo(BigDecimal.ZERO)==0
							&&scodetail.getWidth().compareTo(BigDecimal.ZERO)==0) {
						scodetail.setSpecification("");
					}else{
						scodetail.setSpecification(scodetail.getLength()+" * "+scodetail.getWidth());
					}
				}
			}
		}
		return scods;
	}
	
	public List<String> getSalescheckingOrderNos(PageData pd){
		List<SalesCheckingOrder> orders = salesCheckingOrderMapper.getSalescheckingOrderNos(pd);
		List<String> salescheckingNoList = new ArrayList<>();
		for (SalesCheckingOrder order : orders) {
			salescheckingNoList.add(order.getSalesNo());
		}
		return salescheckingNoList;
	}
	/**
	 * 
	* @Title: insertOneSalesCheckingOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条销售对账单明细
	 */
	public void insertOneSalesCheckingOrderDetail(SalesCheckingOrderDetail record) throws Exception{
		salesCheckingOrderDetailMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListSalesCheckingOrderDetail 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	public void insertListSalesCheckingOrderDetail(List<SalesCheckingOrderDetail> records) throws Exception{
		salesCheckingOrderDetailMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updateSalesCheckingOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增销售对账单明细
	 */
	public void updateSalesCheckingOrderDetail(SalesCheckingOrderDetail record) throws Exception{
		salesCheckingOrderDetailMapper.updateByPrimaryKeySelective(record);
	}
	
	/**
	 * 
	* @Title: deleteSalesCheckingOrderDetail 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除销售对账单明细
	 */
	public void deleteSalesCheckingOrderDetail(PageData pd) throws Exception{
		salesCheckingOrderDetailMapper.deleteByPrimaryKey(pd);
	}
	
	public SalesOrder parseSalesOrder(SalesOrder order){
		return null;
	}
	
	public List<SalesOrderDetail> parseSalesOrderDetails(List<SalesOrderDetail> details){
		return null;
	}
	
	public SalesCheckingOrder parseSalesCheckingOrder(SalesCheckingOrder checkingOrder){
		return null;
	}

	public List<SalesCheckingOrderDetail> parseSalesCheckingOrderDetails(List<SalesCheckingOrderDetail> details){
		return null;
	}
	
	//填充采购单数据
	public PurchaseOrder fillInsertPurchaseOrder(SalesOrder salesOrder,PageData pd)
			throws Exception{
		//自动生成采购单 此时的合作伙伴为comKey
		PurchaseOrder purchase = new PurchaseOrder();
		String purchaseNo = null;
		//如果存在传入的采购单号，则使用该单号。如果没传入就重新生成一个
		if(StringUtil.isEmpty(pd.getString("purchaseNo"))){
			purchaseNo = CodeBuilderUtil.getInstance().getPurchaseNo();
		}else{
			purchaseNo = pd.getString("purchaseNo");
		}
		purchase.setPurchaseNo(purchaseNo);
		//协同中存放客户comKey
		purchase.setComKey(pd.getString("partnerComKey"));
		//查询来自销售订单的公司及合作伙伴是否与协同方的公司及合作伙伴相符合
		PageData pageData = new PageData();
		pageData.put("comKey",pd.getString("partnerComKey"));
		pageData.put("partnerComKey",salesOrder.getComKey());
		ComPartner comPartner = comPartnerMapper.selectMyPartnerKey(pageData);
		if(comPartner!=null){
			purchase.setPartnerKey(comPartner.getPartnerKey());
		}
		
		Company resCompany = companyService.getCompanyByUserKey(salesOrder.getComKey());
		purchase.setPartnerName(resCompany.getComName());
		purchase.setPartnerShortname(resCompany.getComShortname());

		purchase.setSalesId(salesOrder.getContactId());
		purchase.setSalesName(salesOrder.getContactName());
		purchase.setContactId(salesOrder.getSalesId());
		purchase.setContactName(salesOrder.getSalesName());
		purchase.setCaseDesc(salesOrder.getCaseDesc());
		purchase.setOrderDate(salesOrder.getOrderDate());
		purchase.setPrice(salesOrder.getPrice());
		purchase.setDiscountRate(salesOrder.getDiscountRate());
		purchase.setDiscount(salesOrder.getDiscount());
		purchase.setTaxRate(salesOrder.getTaxRate());
		purchase.setTaxPrice(salesOrder.getTaxPrice());
		purchase.setPreferential(salesOrder.getPreferential());
		purchase.setTotalPrice(salesOrder.getTotalPrice());
		purchase.setDepositRequested(salesOrder.getDepositRequested());
		purchase.setReceivablesMoney(salesOrder.getReceivablesMoney());
		purchase.setRemarks(salesOrder.getRemarks());
		purchase.setOrderStatus(salesOrder.getOrderStatus()); //待收货
		purchase.setDetailNum(salesOrder.getDetailNum());
		purchase.setIsUrgent(salesOrder.getIsUrgent());
		purchase.setIsValid("1");
		purchase.setBusinessType(salesOrder.getBusinessType());
		purchase.setIndustryId(salesOrder.getIndustryId());

		purchase.setSalesNo(salesOrder.getSalesNo()); //采购单关联销售单
		salesOrder.setPurchaseNo(purchaseNo);         //销售单关联采购单

		purchase.setCreator("system");
		purchase.setCreateTime(new Date());
		purchase.setChangedTime(salesOrder.getCreateTime());
		
		//如果勾选了派工则需要在协同采购单上增加进度说明
		if(AssignEnum.ASSIGN_SALESORDER_YES.getCode()
				.equalsIgnoreCase(salesOrder.getTaskStatus())){
			purchase.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
		}

		return purchase;
	}
	
	//填充采购单明细
	public List<PurchaseOrderDetail> fillInsertPurchaseOrderDetails(List<SalesOrderDetail> items,PurchaseOrder purchase) 
			throws Exception{
		PurchaseOrderDetail podDetail = null;
		List<PurchaseOrderDetail> podDetails = new ArrayList<PurchaseOrderDetail>();
		//自动生成采购单明细
		Date nowTime = new Date();
		for(SalesOrderDetail orderDetail : items){
			podDetail = new PurchaseOrderDetail();
			podDetail.setPurchaseNo(purchase.getPurchaseNo());
			podDetail.setItemNo(orderDetail.getItemNo());
			podDetail.setBusinessType(orderDetail.getBusinessType());
			podDetail.setBusinessDesc(orderDetail.getBusinessDesc());
			podDetail.setRequirements(orderDetail.getRequirements());
			podDetail.setSpecification(orderDetail.getSpecification());
			podDetail.setPriceWay(orderDetail.getPriceWay());
			podDetail.setLength(orderDetail.getLength());
			podDetail.setWidth(orderDetail.getWidth());
			podDetail.setColorSize(orderDetail.getColorSize());
			podDetail.setPairsNum(orderDetail.getPairsNum());
			podDetail.setQuantity(orderDetail.getQuantity());
			podDetail.setUnit(orderDetail.getUnit());
			podDetail.setUnitPrice(orderDetail.getUnitPrice());
			podDetail.setAdditionalPrice(orderDetail.getAdditionalPrice());
			podDetail.setAdditionalService(orderDetail.getAdditionalService());
			podDetail.setPreferential(orderDetail.getPreferential());
			podDetail.setTotalPrice(orderDetail.getTotalPrice());
			podDetail.setRemarks(orderDetail.getRemarks());
			podDetail.setOrderStatus(orderDetail.getOrderStatus());
			podDetail.setIsUrgent(orderDetail.getIsUrgent());
			podDetail.setIsValid("1");
			podDetail.setIsDel("0");
			podDetail.setCreator(purchase.getCreator());
			podDetail.setCreateTime(nowTime);
			//根据派工情况将派工进度写入协同采购单
			if (AssignEnum.ASSIGN_STATUS_WORKING.getCode()
					.equalsIgnoreCase(purchase.getWorkingStatus())) {
				podDetail.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getDesc());
				podDetail.setWorkingProcedure(orderDetail.getWorkingProcedure());
			}
			podDetails.add(podDetail);
		}
		return podDetails;
	}

	/**
	 * 销售订单对账操作(多笔)
	 * @return
	 */
	public Map<String,Object> saveManyReconciliation(TaxPointVo taxPointVo, UserVo userVo,List salesNos, String type, String isSms) 
			throws Exception {

		Map<String,Object> callBack = new HashMap<>();
		//查询参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("comKey",userVo.getComKey());
		map.put("salesNo",salesNos);
		List<SalesOrder> salesOrders = salesOrderMapper.listSalesOrderByOrderNos(map);
		String partnerKey = "";
		int index = 0;
		for(SalesOrder order : salesOrders){
			if(index == 0){
				partnerKey = order.getPartnerKey();
			}else if (!partnerKey.equals(order.getPartnerKey())){
				callBack.put("status","0");
				callBack.put("msg","只可对同一客户生成对账单");
				return callBack;
			}

			if(order.getSalescheckingNo() != null && !"".equals(order.getSalescheckingNo())){
				callBack.put("status","0");
				callBack.put("msg","订单已对账");
				return callBack;
			}
			//判断订单状态是否为待对账状态
			if(!order.getOrderStatus().equals(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
				callBack.put("status","0");
				callBack.put("msg","订单状态不可用");
				return callBack;
			}
			index++;
		}
		//批量查询订单详情
		List<SalesOrderDetail> salesOrderDetails = this.listBatchSalesOrderDetail(map);
		//2.根据订单生成对账单
		SalesCheckingOrder salesCheckingOrder = nToOneCheckingOrder(userVo,salesOrders, taxPointVo, salesOrderDetails,salesNos);
		//3.根据订单明细集合生成对账单明细集合
		List<SalesCheckingOrderDetail> salesCheckingOrderDetails = nToNCheckingOrderDetail(salesCheckingOrder,salesOrderDetails);
		
		 PurchaseCheckingOrder purchaseCheckingOrder = null;
		
        //一个大大的校验 看看是协同还是非协同
        if(StringUtil.isEmpty(salesOrders.get(0).getPurchaseNo())){ //非协同
            //生成对账单
            insertOneSalesCheckingOrder(salesCheckingOrder);
            insertListSalesCheckingOrderDetail(salesCheckingOrderDetails);
            //修改订单状态
            //修改订单明细状态
            PageData pdPara = new PageData();
            pdPara.put("orderStatus", OrderEnum.STATUS_YIDUIZHANG.getCode()); //orderStatus as "05" 已对账
            pdPara.put("changedTime", new Date());
			pdPara.put("salescheckingNo",salesCheckingOrder.getSalescheckingNo());
            pdPara.put("salesOrderNoIn", Tools.strArray2List(Tools.StrList(salesCheckingOrder.getSalesNo())));
            salesOrderMapper.updateBatchBySalesNoIn(pdPara);
            salesOrderDetailMapper.updateBatchDetailBySalesNoIn(pdPara);

        }else{
            /**
             * 查找对应协同单并且生成协同单的 对账单。
             * 1.几笔销售订单对应几笔协同采购单
             *
             */
            List<PurchaseOrder> purchaseOrders = purchaseOrderService.listPurchaseOrderBySalesNos(salesNos);
            if(purchaseOrders.size() != salesNos.size()){
                //几笔销售订单对应几笔协同采购单
                callBack.put("status","0");
                callBack.put("msg","采购方对账单生成失败！");
                logger.warn("单号:"+Tools.list2InString(salesNos)+"的销售订单,对应的协同采购单数不一致。");
            }
            //采购单集合
            List<String> purchaseOrderNos = new ArrayList<>();
            //校验
            for(PurchaseOrder purchaseOrder : purchaseOrders){
                if(purchaseOrder.getPurchasecheckingNo() != null && !"".equals(purchaseOrder.getPurchasecheckingNo())){
                    callBack.put("status","0");
                    callBack.put("msg","采购订单已对账");
                    return callBack;
                }
                //判断订单状态是否为待对账状态
                if(!purchaseOrder.getOrderStatus().equals(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
                    callBack.put("status","0");
                    callBack.put("msg","采购订单状态不可用");
                    return callBack;
                }
                purchaseOrderNos.add(purchaseOrder.getPurchaseNo());
            }

            //查询协同采购单明细
            List<PurchaseOrderDetail> purchaseOrderDetails = purchaseOrderService.selectBatchPurchaseOrderDetail(purchaseOrderNos);

            //生成采购对账单和 采购对账单明细
            purchaseCheckingOrder = nToOnePCheckingOrder(userVo, purchaseOrders, taxPointVo, purchaseOrderDetails, purchaseOrderNos,salesCheckingOrder);
            List<PurchaseCheckingOrderDetail> 	purchaseCheckingOrderDetails = nToNPCheckingOrderDetail(purchaseCheckingOrder, purchaseOrderDetails);

            //关联两个对账单单号
            purchaseCheckingOrder.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
            salesCheckingOrder.setPurchasecheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
            
            insertOneSalesCheckingOrder(salesCheckingOrder);
            insertListSalesCheckingOrderDetail(salesCheckingOrderDetails);

            purchaseOrderService.insertOnePurchaseCheckingOrder(purchaseCheckingOrder);
            purchaseOrderService.insertListPurchaseCheckingOrderDetail(purchaseCheckingOrderDetails);

            //update sales and purchase
            PageData pdPara = new PageData();
            pdPara.put("orderStatus", OrderEnum.STATUS_YIDUIZHANG.getCode()); //orderStatus as "05" 已对账
            pdPara.put("changedTime", new Date());
			pdPara.put("salescheckingNo",salesCheckingOrder.getSalescheckingNo());
            pdPara.put("salesOrderNoIn", Tools.strArray2List(Tools.StrList(salesCheckingOrder.getSalesNo())));

            salesOrderMapper.updateBatchBySalesNoIn(pdPara);
            salesOrderDetailMapper.updateBatchDetailBySalesNoIn(pdPara);

            //批量更新采购订单和订单明细
			pdPara.put("purchasecheckingNo",purchaseCheckingOrder.getPurchasecheckingNo());
            pdPara.put("purchaseOrderNoIn", Tools.strArray2List(Tools.StrList(purchaseCheckingOrder.getPurchaseNo())));
            purchaseOrderService.updateBatchByPurchaseNoIn(pdPara);
            purchaseOrderService.updateBatchDetailByPurchaseNoIn(pdPara);
            
            //微信推送协同采购对账单消息
            PageData pdwechat = new PageData();
            pdwechat.put("type", "checking");
            pdwechat.put("comKey", purchaseCheckingOrder.getComKey());
            pdwechat.put("partnerName", purchaseCheckingOrder.getPartnerName());
            pdwechat.put("caseDesc", purchaseCheckingOrder.getCaseDesc());
            pdwechat.put("purchasecheckingNo", purchaseCheckingOrder.getPurchasecheckingNo());
            pdwechat.put("orderDate", DateUtil.DateToString(purchaseCheckingOrder.getOrderDate(), DateStyle.YYYY_MM_DD.getValue()));
            pdwechat.put("totalPrice", purchaseCheckingOrder.getTotalPrice().toString());
            this.sendWechatMessage(pdwechat);
        }
        
        //如果生成对账时需要同时收款则执行收款操作
        if (StringUtil.isNotEmpty(type)
        		&&"1".equalsIgnoreCase(type)) {
        	ReceiptPayment receiptPayment = new ReceiptPayment();
        	receiptPayment.setCheckingNo(salesCheckingOrder.getSalescheckingNo());
        	//生成对账单并收款=应收金额
        	receiptPayment.setRecpayMoney(salesCheckingOrder.getReceivablesMoney());
        	receiptPayment.setAccountType(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getCode()); //其他账户类型
    		receiptPayment.setAccountPayee(OrderEnum.ACCOUNT_PAYEE_TYPE_OTHER.getDesc());
        	receiptPayment.setRecpayDate(new Date());
        	receiptPayment.setRecpayType("1"); //收款
        	this.saveReceivables(userVo,receiptPayment);
        }
        
        String receiveNum = null;
        PageData pdPara = new PageData();
        pdPara.put("partnerKey", salesCheckingOrder.getPartnerKey());
        pdPara.put("contacterId", salesCheckingOrder.getContactId());
        PartnerContacter partnerContacter = partnerService.selectOnePartnerContacter(pdPara);
        if(partnerContacter!=null){
        	receiveNum = partnerContacter.getTel1();
        }
        String comShortname = null;
        pdPara.put("comKey", salesCheckingOrder.getComKey());
        Company company = companyService.getCompanyByKey(pdPara);
        if (company!=null) {
			comShortname = company.getComShortname()==null?company.getComName():company.getComShortname();
		}
        String orderCycle = salesCheckingOrder.getOrderCycle();
        String totalPrice = salesCheckingOrder.getTotalPrice().toString();
        if(StringUtil.isNotEmpty(receiveNum)
        		&&"1".equalsIgnoreCase(isSms)){
        	String shortCode = CodeBuilderUtil.getInstance().getShortUrlCode(6);
        	if (StringUtil.isNotEmpty(salesCheckingOrder.getPurchasecheckingNo())) {
        		//发送好友短信
        		String shareUrl = dzConfig.webPath+"/ordershare/purchasechecking-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
                		purchaseCheckingOrder.getIndustryId()+"-"+purchaseCheckingOrder.getPurchasecheckingNo()+"-"+purchaseCheckingOrder.getComKey());
                redisUtil.setIntervalDay(shortCode, shareUrl, 90);
        		SMSUtil.notifyComPartnerOrderChecking(receiveNum, comShortname, orderCycle, totalPrice, shortCode);
        	}else {
        		//发送非好友短信
        		String shareUrl = dzConfig.webPath+"/ordershare/saleschecking-order-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
                 		salesCheckingOrder.getIndustryId()+"-"+salesCheckingOrder.getSalescheckingNo()+"-"+salesCheckingOrder.getComKey());
                redisUtil.setIntervalDay(shortCode, shareUrl, 90);
        		SMSUtil.notifyComPartnerOrderCheckingNoFriend(receiveNum, comShortname, orderCycle, totalPrice, shortCode);
        	}
        }
        
        
        callBack.put("status","1");
        callBack.put("msg","对账成功");
        return callBack;
	}

	/**
	 *（协同采购）多笔订单详情生成对账单详情
	 * @return
	 */
	public List<PurchaseCheckingOrderDetail> nToNPCheckingOrderDetail(PurchaseCheckingOrder purchaseCheckingOrder,
																	  List<PurchaseOrderDetail> purchaseOrderDetails){
		PurchaseCheckingOrderDetail purchaseCheckingOrderDetail = null;
		int i = 1;
		List<PurchaseCheckingOrderDetail> purchaseCheckingOrderDetails = new ArrayList<>();
		for(PurchaseOrderDetail purchaseOrderDetail: purchaseOrderDetails){
			purchaseCheckingOrderDetail = new PurchaseCheckingOrderDetail();
			purchaseCheckingOrderDetail.setPurchasecheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
			purchaseCheckingOrderDetail.setItemNo(i);
			purchaseCheckingOrderDetail.setBusinessType(purchaseOrderDetail.getBusinessType());
			purchaseCheckingOrderDetail.setBusinessDesc(purchaseOrderDetail.getBusinessDesc());
			purchaseCheckingOrderDetail.setRequirements(purchaseOrderDetail.getRequirements());
			purchaseCheckingOrderDetail.setSpecification(purchaseOrderDetail.getSpecification());
			purchaseCheckingOrderDetail.setPriceWay(purchaseOrderDetail.getPriceWay());
			purchaseCheckingOrderDetail.setLength(purchaseOrderDetail.getLength());
			purchaseCheckingOrderDetail.setWidth(purchaseOrderDetail.getWidth());
			purchaseCheckingOrderDetail.setColorSize(purchaseOrderDetail.getColorSize());
			purchaseCheckingOrderDetail.setPairsNum(purchaseOrderDetail.getPairsNum());
			purchaseCheckingOrderDetail.setQuantity(purchaseOrderDetail.getQuantity());
			purchaseCheckingOrderDetail.setUnit(purchaseOrderDetail.getUnit());
			purchaseCheckingOrderDetail.setUnitPrice(purchaseOrderDetail.getUnitPrice());
			purchaseCheckingOrderDetail.setAdditionalService(purchaseOrderDetail.getAdditionalService());
			purchaseCheckingOrderDetail.setAdditionalPrice(purchaseOrderDetail.getAdditionalPrice());
			purchaseCheckingOrderDetail.setPreferential(purchaseOrderDetail.getPreferential());
			purchaseCheckingOrderDetail.setTotalPrice(purchaseOrderDetail.getTotalPrice());
			purchaseCheckingOrderDetail.setRemarks(purchaseOrderDetail.getRemarks());
			//协同单详情状态跟协同单一致
			purchaseCheckingOrderDetail.setOrderStatus(purchaseCheckingOrder.getOrderStatus());
			purchaseCheckingOrderDetail.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
			purchaseCheckingOrderDetail.setIsValid("1");
			purchaseCheckingOrderDetail.setIsDel("0");
			purchaseCheckingOrderDetail.setPurchaseNo(purchaseOrderDetail.getPurchaseNo());
			purchaseCheckingOrderDetail.setPurchaseOrderItem(purchaseOrderDetail.getItemNo()); //写入采购订单行序号
			purchaseCheckingOrderDetail.setPurchaseOrderDate(purchaseOrderDetail.getPurchaseOrderDate());
			purchaseCheckingOrderDetail.setCreator(purchaseCheckingOrder.getCreator());
			purchaseCheckingOrderDetail.setCreateTime(purchaseOrderDetail.getCreateTime());
			purchaseCheckingOrderDetails.add(purchaseCheckingOrderDetail);
			i++;
		}
		return purchaseCheckingOrderDetails;
	}

	/**
	 * （协同采购）多笔订单生成协同采购对账单
	 */

	private PurchaseCheckingOrder nToOnePCheckingOrder(UserVo userVo,List<PurchaseOrder> purchaseOrders,
													   TaxPointVo taxPointVo,
													   List<PurchaseOrderDetail> purchaseOrderDetails,
													   List<String> purchaseOrderNos,
													   SalesCheckingOrder salesCheckingOrder
	){
		PurchaseCheckingOrder purchaseCheckingOrder = new PurchaseCheckingOrder();
		purchaseCheckingOrder.setPurchasecheckingNo(CodeBuilderUtil.getInstance().getCheckingNo());
		//获取对方的公司KEY
		//此时不应该为操作人所在公司

		purchaseCheckingOrder.setComKey(purchaseOrders.get(0).getComKey());
		//本单金额
		BigDecimal price = new BigDecimal(0);
		//总折扣
		BigDecimal discount = new BigDecimal(0);

		//税金比例
		//private BigDecimal taxRate;
		//private BigDecimal taxPrice;
		//总减免
		BigDecimal preferential = new BigDecimal(0);
		//总合计
		BigDecimal totalPrice = new BigDecimal(0);
		//总预收
		BigDecimal depositRequested = new BigDecimal(0);
		//总应收
		BigDecimal receivablesMoney = new BigDecimal(0);
		String partnerKey  = null;
		String partnerName = null;
		String partnerShortName = null;
		int j = 1;
		for(PurchaseOrder order : purchaseOrders){
			if(j == 1){
				partnerKey = order.getPartnerKey();
				partnerName = order.getPartnerName();
				partnerShortName = order.getPartnerShortname();
			}else if(! partnerKey.equals(order.getPartnerKey())){
				throw new RuntimeException("请选择相同客户的订单");
			}
			price = price.add(order.getPrice());
			//关于折扣
			discount = discount.add(order.getDiscount());
			preferential = preferential.add(order.getPreferential());
			totalPrice = totalPrice.add(order.getTotalPrice());
			//预售金额
			depositRequested = depositRequested.add(order.getDepositRequested());
			//receivablesMoney = receivablesMoney.add(order.getReceivablesMoney());
			j++;
		}
		purchaseCheckingOrder.setPartnerKey(partnerKey);
		purchaseCheckingOrder.setPartnerName(partnerName);
		purchaseCheckingOrder.setPartnerShortname(partnerShortName);


		purchaseCheckingOrder.setSalesId(purchaseOrders.get(0).getSalesId());
		purchaseCheckingOrder.setSalesName(purchaseOrders.get(0).getSalesName());
		purchaseCheckingOrder.setContactId(purchaseOrders.get(0).getContactId());
		purchaseCheckingOrder.setContactName(purchaseOrders.get(0).getContactName());
		purchaseCheckingOrder.setCaseDesc(salesCheckingOrder.getCaseDesc());

		//Date createTime = new Date();
		purchaseCheckingOrder.setOrderDate(salesCheckingOrder.getCreateTime());
		//税金比例
		purchaseCheckingOrder.setTaxRate(taxPointVo.getTaxRate());
		//税金 多笔订单totalPrice的加和 乘以 税金比例
		purchaseCheckingOrder.setTaxPrice(totalPrice.multiply(purchaseCheckingOrder.getTaxRate()));

		purchaseCheckingOrder.setPrice(price);
		purchaseCheckingOrder.setDiscount(discount);
		purchaseCheckingOrder.setPreferential(preferential);
		//合计金额为 税金+总金额
		purchaseCheckingOrder.setTotalPrice(totalPrice.add(purchaseCheckingOrder.getTaxPrice()));
		purchaseCheckingOrder.setDepositRequested(depositRequested);
		//应收金额 总计减预收
		receivablesMoney = purchaseCheckingOrder.getTotalPrice().subtract(purchaseCheckingOrder.getDepositRequested());
		purchaseCheckingOrder.setReceivablesMoney(receivablesMoney);

		purchaseCheckingOrder.setInvoiceMoney(new BigDecimal(0));
		purchaseCheckingOrder.setPaidUp(salesCheckingOrder.getPaidUp());
		
		purchaseCheckingOrder.setOrderStatus(OrderEnum.STATUS_DAIFUKUAN.getCode());/** 采购订单对账状态 09待付款 **/
		purchaseCheckingOrder.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
		purchaseCheckingOrder.setPurchaseOrderNum((short) purchaseOrders.size());
		purchaseCheckingOrder.setDetailNum((short) purchaseOrderDetails.size());
		purchaseCheckingOrder.setIsValid("1");
		purchaseCheckingOrder.setIsDel("0");
		purchaseCheckingOrder.setChangedTime(salesCheckingOrder.getCreateTime());

		purchaseCheckingOrder.setIndustryId(purchaseOrders.get(0).getIndustryId());
		purchaseCheckingOrder.setPurchaseNo(Tools.list2InString(purchaseOrderNos));
		purchaseCheckingOrder.setOrderCycle(purchaseOrderService.getOrderCycle(Tools.strSqlIn(purchaseCheckingOrder.getPurchaseNo())));
		purchaseCheckingOrder.setCreator("system");
		purchaseCheckingOrder.setCreateTime(salesCheckingOrder.getCreateTime());
		return purchaseCheckingOrder;
	}




	/**
	 *多笔订单详情生成对账单详情
	 * @param salesCheckingOrder
	 * @param salesOrderDetails
	 * @return
	 */
	public List<SalesCheckingOrderDetail> nToNCheckingOrderDetail(SalesCheckingOrder salesCheckingOrder,
																  List<SalesOrderDetail> salesOrderDetails){
		SalesCheckingOrderDetail salesCheckingOrderDetail = null;
		int i = 1;
		List<SalesCheckingOrderDetail> salesCheckingOrderDetails = new ArrayList<>();
		for(SalesOrderDetail salesOrderDetail: salesOrderDetails){
			salesCheckingOrderDetail = new SalesCheckingOrderDetail();
			salesCheckingOrderDetail.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
			salesCheckingOrderDetail.setItemNo(i);
			salesCheckingOrderDetail.setBusinessType(salesOrderDetail.getBusinessType());
			salesCheckingOrderDetail.setBusinessDesc(salesOrderDetail.getBusinessDesc());
			salesCheckingOrderDetail.setRequirements(salesOrderDetail.getRequirements());
			salesCheckingOrderDetail.setSpecification(salesOrderDetail.getSpecification());
			salesCheckingOrderDetail.setPriceWay(salesOrderDetail.getPriceWay());
			salesCheckingOrderDetail.setLength(salesOrderDetail.getLength());
			salesCheckingOrderDetail.setWidth(salesOrderDetail.getWidth());
			salesCheckingOrderDetail.setColorSize(salesOrderDetail.getColorSize());
			salesCheckingOrderDetail.setPairsNum(salesOrderDetail.getPairsNum());
			salesCheckingOrderDetail.setQuantity(salesOrderDetail.getQuantity());
			salesCheckingOrderDetail.setUnit(salesOrderDetail.getUnit());
			salesCheckingOrderDetail.setUnitPrice(salesOrderDetail.getUnitPrice());
			salesCheckingOrderDetail.setAdditionalService(salesOrderDetail.getAdditionalService());
			salesCheckingOrderDetail.setAdditionalPrice(salesOrderDetail.getAdditionalPrice());
			salesCheckingOrderDetail.setPreferential(salesOrderDetail.getPreferential());
			salesCheckingOrderDetail.setTotalPrice(salesOrderDetail.getTotalPrice());
			salesCheckingOrderDetail.setRemarks(salesOrderDetail.getRemarks());
			//
			salesCheckingOrderDetail.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
			salesCheckingOrderDetail.setIsValid("1");
			salesCheckingOrderDetail.setIsDel("0");
			salesCheckingOrderDetail.setSalesNo(salesOrderDetail.getSalesNo());
			salesCheckingOrderDetail.setSalesOrderItem(salesOrderDetail.getItemNo()); //将销售订单行序号写入对账单明细的订单行序号中用于定位
			salesCheckingOrderDetail.setCreator(salesCheckingOrder.getCreator());
			salesCheckingOrderDetail.setCreateTime(salesCheckingOrder.getCreateTime());
			//对应订单的下单时间
			salesCheckingOrderDetail.setSalesOrderDate(salesOrderDetail.getSalesOrderDate());
			
			salesCheckingOrderDetails.add(salesCheckingOrderDetail);
			i++;
		}
		return salesCheckingOrderDetails;
	}

	/**
	 * 多笔订单生成一张对账单
	 * @param userVo
	 * @param salesOrders
	 * @param taxPointVo
	 * @param salesOrderDetails
	 * @param salesNos
	 * @return
	 */
	private SalesCheckingOrder nToOneCheckingOrder(UserVo userVo,List<SalesOrder> salesOrders,
												   TaxPointVo taxPointVo,
												   List<SalesOrderDetail> salesOrderDetails,
												   List salesNos
												   ){
		SalesCheckingOrder salesCheckingOrder = new SalesCheckingOrder();
		salesCheckingOrder.setSalescheckingNo(CodeBuilderUtil.getInstance().getCheckingNo());
		salesCheckingOrder.setComKey(salesOrders.get(0).getComKey());
		//本单金额
		BigDecimal price = new BigDecimal(0);
		//总折扣
		BigDecimal discount = new BigDecimal(0);

		//税金比例
		//private BigDecimal taxRate;
		//private BigDecimal taxPrice;
		//总减免
		BigDecimal preferential = new BigDecimal(0);
		//总合计
		BigDecimal totalPrice = new BigDecimal(0);
		//总预收
		BigDecimal depositRequested = new BigDecimal(0);
		//总应收
		BigDecimal receivablesMoney = new BigDecimal(0);
		String partnerKey  = null;
		String partnerName = null;
		String partnerShortName = null;
		int j = 1;
		for(SalesOrder order : salesOrders){
			if(j == 1){
				partnerKey = order.getPartnerKey();
				partnerName = order.getPartnerName();
				partnerShortName = order.getPartnerShortname();
			}else if(! partnerKey.equals(order.getPartnerKey())){
				throw new RuntimeException("请选择相同客户的订单");
			}
			price = price.add(order.getPrice());
			//关于折扣
			discount = discount.add(order.getDiscount());
			preferential = preferential.add(order.getPreferential());
			totalPrice = totalPrice.add(order.getTotalPrice());
			//预收金额
			depositRequested = depositRequested.add(order.getDepositRequested());
			//应收金额
			//receivablesMoney = receivablesMoney.add(order.getReceivablesMoney());
		}
		salesCheckingOrder.setPartnerKey(partnerKey);
		salesCheckingOrder.setPartnerName(partnerName);
		salesCheckingOrder.setPartnerShortname(partnerShortName);

		salesCheckingOrder.setSalesId(salesOrders.get(0).getSalesId());
		salesCheckingOrder.setSalesName(salesOrders.get(0).getSalesName());
		salesCheckingOrder.setContactId(salesOrders.get(0).getContactId());
		salesCheckingOrder.setContactName(salesOrders.get(0).getContactName());
		if(salesOrders.size() == 1){
			salesCheckingOrder.setCaseDesc(salesOrders.get(0).getCaseDesc());
		}else{
			salesCheckingOrder.setCaseDesc("多笔");
		}

		Date createTime = new Date();
		salesCheckingOrder.setOrderDate(createTime);
		//税金比例
		salesCheckingOrder.setTaxRate(taxPointVo.getTaxRate());
		//税金为  多笔订单totalPrice的加和 乘以 税金比例
		salesCheckingOrder.setTaxPrice(totalPrice.multiply(salesCheckingOrder.getTaxRate()));
		salesCheckingOrder.setPrice(price);
		salesCheckingOrder.setDiscount(discount);
		salesCheckingOrder.setPreferential(preferential);
		//合计金额为  总金额加税金
		salesCheckingOrder.setTotalPrice(totalPrice.add(salesCheckingOrder.getTaxPrice()));
		//预收
		salesCheckingOrder.setDepositRequested(depositRequested);
		//应收金额 总计减预收
		receivablesMoney = salesCheckingOrder.getTotalPrice().subtract(salesCheckingOrder.getDepositRequested());
		salesCheckingOrder.setReceivablesMoney(receivablesMoney);
		salesCheckingOrder.setInvoiceMoney(new BigDecimal(0));
		salesCheckingOrder.setPaidUp(new BigDecimal(0));

		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_DAISHOUKUAN.getCode());//待收款 07
		salesCheckingOrder.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
		salesCheckingOrder.setSalesOrderNum((short) salesOrders.size());
		salesCheckingOrder.setDetailNum((short) salesOrderDetails.size());
		salesCheckingOrder.setIsValid("1");
		salesCheckingOrder.setIsDel("0");
		salesCheckingOrder.setChangedTime(createTime);

		salesCheckingOrder.setIndustryId(salesOrders.get(0).getIndustryId());
		salesCheckingOrder.setSalesNo(Tools.list2InString(salesNos));
		salesCheckingOrder.setOrderCycle(this.getOrderCycle(Tools.strSqlIn(salesCheckingOrder.getSalesNo())));
		salesCheckingOrder.setCreator(userVo.getUserKey());
		salesCheckingOrder.setCreateTime(createTime);
		return salesCheckingOrder;
	}

	/**
	 * 
	 * @Title: fillInsertCheckingOrder 
	 * @param salesOrder
	 * @param taxPointVo
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return SalesCheckingOrder
	 * @throws 
	 * @Description: 根据销售订单和税点生成 销售对账单
	 */
	private SalesCheckingOrder fillInsertCheckingOrder(SalesOrder salesOrder,TaxPointVo taxPointVo,UserVo userVo)
			throws Exception{

		SalesCheckingOrder salesCheckingOrder = new SalesCheckingOrder();
		String salesCheckingNo = CodeBuilderUtil.getInstance().getCheckingNo();
		salesCheckingOrder.setSalescheckingNo(salesCheckingNo);
		//协同中存放客户comKEY
		salesCheckingOrder.setComKey(salesOrder.getComKey());
		salesCheckingOrder.setPartnerKey(salesOrder.getPartnerKey());
		salesCheckingOrder.setPartnerName(salesOrder.getPartnerName());
		salesCheckingOrder.setSalesId(salesOrder.getContactId());
		salesCheckingOrder.setSalesName(salesOrder.getContactName());
		salesCheckingOrder.setContactId(salesOrder.getSalesId());
		salesCheckingOrder.setContactName(salesOrder.getSalesName());
		salesCheckingOrder.setCaseDesc(salesOrder.getCaseDesc());
		salesCheckingOrder.setOrderDate(salesOrder.getOrderDate());
		salesCheckingOrder.setPrice(salesOrder.getPrice());
		salesCheckingOrder.setDiscountRate(salesOrder.getDiscountRate());
		salesCheckingOrder.setDiscount(salesOrder.getDiscount());
		//税金比例为(taxPointVo中)
		salesCheckingOrder.setTaxRate(taxPointVo.getTaxRate());
		//税金为（订单的金额 * 税金比例）
		BigDecimal saleTaxPrice = (salesOrder.getTotalPrice()).subtract(taxPointVo.getTaxRate());
		salesCheckingOrder.setTaxPrice(saleTaxPrice);
		//减免
		salesCheckingOrder.setPreferential(salesOrder.getPreferential());
		//需重新计算税金
		salesCheckingOrder.setTotalPrice( salesOrder.getTotalPrice().add(saleTaxPrice) );
		//预收金额
		salesCheckingOrder.setDepositRequested(salesOrder.getDepositRequested());
		//需重新计算 应收金额
		salesCheckingOrder.setReceivablesMoney(salesOrder.getReceivablesMoney().add(saleTaxPrice));
		salesCheckingOrder.setRemarks(salesOrder.getRemarks());
		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_DAISHOUKUAN.getCode()); //07 未收款对账单
		salesCheckingOrder.setDetailNum(salesOrder.getDetailNum());
		salesCheckingOrder.setIsValid("1");
		salesCheckingOrder.setBusinessType(salesOrder.getBusinessType());
		salesCheckingOrder.setIndustryId(salesOrder.getIndustryId());
		salesCheckingOrder.setSalesNo(salesOrder.getSalesNo()); //对账单关联订单

		salesOrder.setSalescheckingNo(salesCheckingNo);         //销售单关联对账单

		salesCheckingOrder.setCreator(userVo.getUserKey());
		salesCheckingOrder.setCreateTime(new Date());
		salesCheckingOrder.setChangedTime(new Date());
		return salesCheckingOrder;
	}

	/**
	 * 
	 * @Title: fillInsertCheckingOrderDetails 
	 * @param items
	 * @param salesCheckingOrder
	 * @return
	 * @throws Exception
	 * @return List<SalesCheckingOrderDetail>
	 * @throws 
	 * @Description: 根据销售对账单抬头填充销售对账单明细
	 */
	private List<SalesCheckingOrderDetail> fillInsertCheckingOrderDetails(List<SalesOrderDetail> items,SalesCheckingOrder salesCheckingOrder)
			throws Exception{
		SalesCheckingOrderDetail detail = null;
		List<SalesCheckingOrderDetail> details = new ArrayList<>();
		//自动生成采购单明细
		for(SalesOrderDetail scDetail : items){
			detail = new SalesCheckingOrderDetail();
			detail.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
			detail.setSalesNo(salesCheckingOrder.getSalesNo());
			detail.setItemNo(scDetail.getItemNo());
			detail.setBusinessType(scDetail.getBusinessType());
			detail.setBusinessDesc(scDetail.getBusinessDesc());
			detail.setRequirements(scDetail.getRequirements());
			detail.setSpecification(scDetail.getSpecification());
			detail.setPriceWay(scDetail.getPriceWay());
			detail.setLength(scDetail.getLength());
			detail.setWidth(scDetail.getWidth());
			detail.setColorSize(scDetail.getColorSize());
			detail.setPairsNum(scDetail.getPairsNum());
			detail.setQuantity(scDetail.getQuantity());
			detail.setUnit(scDetail.getUnit());
			detail.setUnitPrice(scDetail.getUnitPrice());
			detail.setAdditionalPrice(scDetail.getAdditionalPrice());
			detail.setAdditionalService(scDetail.getAdditionalService());
			detail.setPreferential(scDetail.getPreferential());
			detail.setTotalPrice(scDetail.getTotalPrice());
			detail.setRemarks(scDetail.getRemarks());
			detail.setOrderStatus(scDetail.getOrderStatus());
			detail.setIsValid("1");
			detail.setIsDel("0");
			detail.setCreator(scDetail.getCreator());
			detail.setCreateTime(new Date());
			detail.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票
			details.add(detail);
		}
		return details;
	}

	/**
	 * 确认开票
	 * @param userVo
	 * @param checkingInvoice
	 * @return
	 */
	public Integer saveBill(UserVo userVo,CheckingInvoice checkingInvoice) throws Exception {

		String[] checkNos = checkingInvoice.getCheckingNo().split(",");
		Map<String,Object> map = new HashMap<>();
		map.put("comKey",userVo.getComKey());
		map.put("orderNo",checkNos);
		List<SalesCheckingOrder> salesCheckingOrders = salesCheckingOrderMapper.listCheckingOrderByOrderNos(map);
		//对应的协同单状态
		List<String> pocNos = new ArrayList<>();
		String partnerKey = "";
		int i = 0 ;
		if(salesCheckingOrders.size() == 0){
			return 0;
		}
		for(SalesCheckingOrder salesCheckingOrder : salesCheckingOrders){
			if(salesCheckingOrder.getInvoiceStatus().equals(OrderEnum.INVOICE_YES.getCode())){
				return 0;
			}

			//协同对账单号
			pocNos.add(salesCheckingOrder.getPurchasecheckingNo());

			/*if(i==0){
				partnerKey = salesCheckingOrder.getPartnerKey();
			}else{
				if(!partnerKey.equals(salesCheckingOrder.getPartnerKey())){
					return 0;
				}
			}
			i++;*/
		}

		checkingInvoice.setCheckingType(OrderEnum.CHECKING_TYPE_SALES.getCode());
		checkingInvoice.setComKey(userVo.getComKey());
		Company company = companyService.getCompanyByUserKey(checkingInvoice.getComKey());
		checkingInvoice.setComName(company.getComName());
		checkingInvoice.setComShortname(company.getComShortname());
		//checkingInvoice.setInvoiceDate(new Date());
		checkingInvoice.setIsValid("1");
		checkingInvoice.setCreateTime(new Date());
		Integer result = checkingInvoiceMapper.insertSelective(checkingInvoice);

		PageData pdPara = new PageData();
		pdPara.put("changedTime", new Date());
		pdPara.put("invoiceStatus", OrderEnum.INVOICE_YES.getCode());
		
		pdPara.put("salescheckingNoIn", Tools.strArray2List(Tools.StrList(checkingInvoice.getCheckingNo())));
		salesCheckingOrderMapper.updateBatchBySalesCheckingNoIn(pdPara);
		
		//todo 简单校验
		if(pocNos.size() > 0){
			pdPara.put("purchasecheckingNoIn", pocNos);
			purchaseOrderService.updateBatchByPurchaseCheckingNoIn(pdPara);
		}
		//

		//salesCheckingOrderMapper.updateByPrimaryKeySelective(salesCheckingOrder);
		return result;
	}
	
	public int insertReceiptPayment(ReceiptPayment receiptPayment) throws Exception{
		return receiptPaymentMapper.insertSelective(receiptPayment);
	}

	/**
	 * 收款操作
	 * 1.销售方： 新建收款记录 并 修改对账单状态(已收款)
	 * 2.采购方： 如果该笔对账单为协同单 则新建付款记录 并修改对账单状态(已付款）
	 * @param userVo 当前操作人信息
	 * @param receiptPayment 销售方收款信息
	 * @return
	 * @throws Exception 
	 */
	public Integer saveReceivables(UserVo userVo,ReceiptPayment receiptPayment) throws Exception{
		Date nowDate = new Date();
		receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_SALES.getCode());//1 销售对账单
		receiptPayment.setComKey(userVo.getComKey());
		receiptPayment.setIsValid("1");
		receiptPayment.setCreateTime(nowDate);
		receiptPaymentMapper.insertSelective(receiptPayment);
		PageData pageData = new PageData();

		pageData.put("comKey",userVo.getComKey());
		pageData.put("salescheckingNo",receiptPayment.getCheckingNo());
		SalesCheckingOrder salesCheckingOrder = salesCheckingOrderMapper.selectByPrimaryKey(pageData);
		salesCheckingOrder.setPaidUp(receiptPayment.getRecpayMoney()); //本次收款金额
		salesCheckingOrder.setBalanceMoney(salesCheckingOrder.getPaidUp().subtract(salesCheckingOrder.getReceivablesMoney()).setScale(2, BigDecimal.ROUND_HALF_UP)); //差额
		salesCheckingOrder.setChangedTime(nowDate);
		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_YISHOUKUAN.getCode()); //8 对账成功
		Integer result = salesCheckingOrderMapper.updateByPrimaryKeySelective(salesCheckingOrder);
		
		//预存款账户扣钱的，需要扣减预存余额
		if ("预存款账户".equalsIgnoreCase(receiptPayment.getAccountPayee())) {
			pageData.put("partnerKey", salesCheckingOrder.getPartnerKey());
			ComPartner comPartner = partnerService.findComPartner(pageData);
			if(comPartner!=null){
				comPartner.setBalanceMoney(comPartner.getBalanceMoney()
						.subtract(receiptPayment.getRecpayMoney()).setScale(2, BigDecimal.ROUND_HALF_UP));
				partnerService.updateByPrimaryKeySelective(comPartner);
				
				ComPartnerConsumeLog consumeLog = new ComPartnerConsumeLog();
				consumeLog.setComKey(salesCheckingOrder.getComKey());
				consumeLog.setCheckingNo(salesCheckingOrder.getSalescheckingNo());
				consumeLog.setIndustryId(salesCheckingOrder.getIndustryId());
				consumeLog.setPartnerKey(salesCheckingOrder.getPartnerKey());
				consumeLog.setConsumeDate(new Date());
				consumeLog.setConsumeMoney(receiptPayment.getRecpayMoney());
				consumeLog.setCreator(userVo.getUserKey());
				consumeLog.setCreateTime(new Date());
				partnerService.insertComPartnerConsumeLog(consumeLog);
				
		        if ("1".equals(receiptPayment.getIsSms())) {
		        	PageData pd = new PageData();
		        	pd.put("partnerKey",consumeLog.getPartnerKey());
		        	PartnerContacter partnerContacter = partnerService.selectOnePartnerContacter(pd);
		        	if (partnerContacter!=null) {
		        		SMSUtil.notifyConsumeComPartner(partnerContacter.getTel1(),DateUtil.DateToString(consumeLog.getConsumeDate(), DateStyle.YYYY_MM_DD_HH_MM_SS), 
		        				userVo.getComShortname(), consumeLog.getCheckingNo(), consumeLog.getConsumeMoney().toString(), comPartner.getBalanceMoney().toString());
		        	}
				}
			}
		}
		
		//如有协同 处理协同单
		if(StringUtil.isNotEmpty(salesCheckingOrder.getPurchasecheckingNo())){
			//查询协同的采购对账单
			PageData pdPur = new PageData();
			pdPur.put("purchasecheckingNo",salesCheckingOrder.getPurchasecheckingNo());
			PurchaseCheckingOrder purchaseCheckingOrder = purchaseOrderService.selectOnePurchaseCheckingOrder(pdPur);

			//协同对账单部分自动生成付款记录信息
			ReceiptPayment receiptPaymentPur = new ReceiptPayment();
			receiptPaymentPur.setCheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
			receiptPaymentPur.setCheckingType(OrderEnum.CHECKING_TYPE_PURCHASE.getCode());//2 采购对账
			receiptPaymentPur.setRecpayType("2");//付款 
			receiptPaymentPur.setComKey(purchaseCheckingOrder.getComKey());
			receiptPaymentPur.setRecpayDate(receiptPayment.getRecpayDate());
			receiptPaymentPur.setRecpayMoney(receiptPayment.getRecpayMoney());
			receiptPaymentPur.setIsValid("1");
			receiptPaymentPur.setRecpayName(Const.SYS_AUTO_MESSAGE); //系统自动生成
			receiptPaymentPur.setCreateTime(nowDate);
			receiptPaymentMapper.insertSelective(receiptPaymentPur);
			
			purchaseCheckingOrder.setPaidUp(receiptPayment.getRecpayMoney()); //本次付款金额
			purchaseCheckingOrder.setOrderStatus(OrderEnum.STATUS_YIFUKUAN.getCode());/** 采购订单对账状态 10已付款 **/
			purchaseCheckingOrder.setChangedTime(nowDate);
			purchaseOrderService.updatePurchaseCheckingOrder(purchaseCheckingOrder);
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: deleteReceivables 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 删除销售对账单的收款操作
	 */
	public int deleteReceivables(PageData pd) throws Exception{
		int result = 0;
//		根据单号公司查询对账单
		SalesCheckingOrder checkingOrder = this.selectOneSalesCheckingOrder(pd);
		if (checkingOrder==null) {
			return 0;
		}
		
//		删除收款记录
		pd.put("checkingNo", checkingOrder.getSalescheckingNo());
		result = receiptPaymentMapper.deleteByPrimaryKey(pd);
//		更改对账单明细状态
		PageData updatepd = new PageData();
		updatepd.put("salescheckingNoIn", Tools.strArray2List(Tools.StrList(checkingOrder.getSalescheckingNo())));
		updatepd.put("orderStatus", OrderEnum.STATUS_DAISHOUKUAN.getCode());
//		salesCheckingOrderDetailMapper.updateBatchDetailBySalesCheckingNoIn(updatepd);
		
//		更改对账单状态和金额
		updatepd.put("paidUp", BigDecimal.ZERO);
		updatepd.put("balanceMoney", BigDecimal.ZERO);
		result = salesCheckingOrderMapper.updateBatchBySalesCheckingNoIn(updatepd);
		if (result<=0) {
			throw new RuntimeException("撤销对账单收款失败");
		}
		
//		判断对账单是否有协同对账单
		if (StringUtil.isNotEmpty(checkingOrder.getPurchasecheckingNo())) {
//			删除付款记录
			pd.clear();
			pd.put("checkingNo", checkingOrder.getPurchasecheckingNo());
			result = receiptPaymentMapper.deleteByPrimaryKey(pd);
//			更改协同对账单明细状态
			updatepd.clear();
			updatepd.put("purchasecheckingNoIn", Tools.strArray2List(Tools.StrList(checkingOrder.getPurchasecheckingNo())));
			updatepd.put("orderStatus", OrderEnum.STATUS_DAIFUKUAN.getCode());
//			purchaseOrderService.updateBatchDetailByPurchaseCheckingNoIn(updatepd);
			
//			更改协同对账单状态和金额
			updatepd.put("paidUp", BigDecimal.ZERO);
			result = purchaseOrderService.updateBatchByPurchaseCheckingNoIn(updatepd);
		}
		
		return result;
	}
	
	public int updateBatchBySalesNoIn(PageData pd) throws Exception {
		return salesOrderMapper.updateBatchBySalesNoIn(pd);
	}
	
	public int updateBatchDetailBySalesNoIn(PageData pd) throws Exception{
		return salesOrderDetailMapper.updateBatchDetailBySalesNoIn(pd);
	}
	
	public List<SalesOrderDetail> getSalesNoOrderList(Page page) throws Exception{
		return salesOrderDetailMapper.listPageTotalDetailByOrder(page);
	}
	
	public List<TotalSalesCheckingOrderDetailVO> getCheckingDetail(PageData pd) throws Exception{
		return salesCheckingOrderDetailMapper.selectSalesCheckingOrderDetailVO(pd);
	}
	
	/**
	 * 
	 * @Title: cancelDelSalescheckingOrder 
	 * @param sco
	 * @param resMap
	 * @return
	 * @throws Exception
	 * @return Map<String,String>
	 * @throws 
	 * @Description: 撤销删除销售对账单。并处理对应的销售订单。如果有协同的，需要处理协同采购对账单和协同采购订单
	 */
	public Map<String,String> cancelDelSalescheckingOrder(SalesCheckingOrder sco,Map<String, String> resMap){
		
		//判断是单向对账单还是协同对账单
		PageData pd = new PageData();
		pd.put("myComKey", sco.getComKey());
		pd.put("partnerKey",sco.getPartnerKey());
		PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd);
		pd.clear();
		try {
			synchronized (this) {
				String purchasecheckingNo = sco.getPurchasecheckingNo();
				List<String> salesNoList = Tools.strArray2List(Tools.str2StrArray(sco.getSalesNo(), ","));
				pd.put("salesOrderNoIn", salesNoList);
				pd.put("orderStatus", OrderEnum.STATUS_DAIDUIZHANG.getCode());
				pd.put("changedTime", new Date());
				pd.put("salescheckingNo", "");
				this.updateBatchBySalesNoIn(pd);
				this.updateBatchDetailBySalesNoIn(pd);
				pd.clear();
				if(StringUtil.isEmpty(purchasecheckingNo)){  //非协同单
					pd.put("comKey", sco.getComKey());
					pd.put("salescheckingNo", sco.getSalescheckingNo());
					this.deleteSalesCheckingOrder(pd);
					this.deleteSalesCheckingOrderDetail(pd);
					pd.clear();
					resMap.put("state", "1");
					resMap.put("msg", "销售对账单已撤销删除");
				}else{ //协同单
					pd.put("comKey", partnerVO.getPartnerComKey());
					pd.put("purchasecheckingNo", purchasecheckingNo);
					PurchaseCheckingOrder pco = purchaseOrderService.selectOnePurchaseCheckingOrder(pd);
					List<String> purchaseNoList = Tools.strArray2List(Tools.str2StrArray(pco.getPurchaseNo(), ","));
					pd.put("purchaseOrderNoIn", purchaseNoList);
					pd.put("orderStatus", OrderEnum.STATUS_DAIDUIZHANG.getCode());
					pd.put("changedTime", new Date());
					pd.put("purchasecheckingNo", "");
					//先更改协同采购单
					purchaseOrderService.updateBatchByPurchaseNoIn(pd);
					purchaseOrderService.updateBatchDetailByPurchaseNoIn(pd);
					pd.clear();
					//删除协同对账单
					pd.put("comKey", partnerVO.getPartnerComKey());
					pd.put("purchasecheckingNo", purchasecheckingNo);
					purchaseOrderService.deletePurchaseCheckingOrder(pd);
					purchaseOrderService.deletePurchaseCheckingOrderDetail(pd);
					pd.clear();
					//删除销售对账单
					pd.put("comKey", sco.getComKey());
					pd.put("salescheckingNo", sco.getSalescheckingNo());
					this.deleteSalesCheckingOrder(pd);
					this.deleteSalesCheckingOrderDetail(pd);
					
					resMap.put("state", "1");
					resMap.put("msg", "已成功撤销删除");
				}
			}
		} catch (Exception e) {
			resMap.put("status", "0");
			resMap.put("msg", "撤销删除失败");
			e.printStackTrace();
		} finally {
			pd.clear();
		}
        
        return resMap;
	}
	
	/**
	 * 
	 * @Title: listSalesOrderByPurchaseOrderNos 
	 * @param purchaseNos
	 * @return
	 * @return List<SalesOrder>
	 * @throws 
	 * @Description: 根据采购订单号批量查询协同销售订单
	 */
	public List<SalesOrder> listSalesOrderByPurchaseOrderNos(Map<String, Object> map){
		return salesOrderMapper.listSalesOrderByPurchaseOrderNos(map);
	}
	
	/**
	 * 
	 * @Title: listBatchSalesOrderDetail 
	 * @param map
	 * @return
	 * @return List<SalesOrderDetail>
	 * @throws 
	 * @Description: 根据销售订单号批量查询销售订单明细
	 */
	public List<SalesOrderDetail> listBatchSalesOrderDetail(Map<String, Object> map){
		return salesOrderDetailMapper.selectBatchSalesOrderDetail(map);
	}
	
	/**
	 * 
	 * @Title: deleteSalesOrderAndDetails 
	 * @param comKey
	 * @param salesNo,purchaseNo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 根据comKey和salesNo删除销售订单和销售订单详情
	 */
	public int deleteSalesOrderAndDetails(String comKey,String salesNo,String purchaseNo) throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("salesNo", salesNo);
		this.deleteSalesOrderDetail(pd);
		int result = this.deleteSalesOrder(pd);
		//如果有协同的，删除协同采购订单
		if(StringUtil.isNotEmpty(purchaseNo)){
			pd.clear();
			pd.put("purchaseNo", purchaseNo);
			PurchaseOrder purchaseOrder = purchaseOrderService.selectOnePurchaseOrder(pd);
			purchaseOrderService.deletePurchaseOrderAndDetails(purchaseOrder.getComKey(), purchaseNo);
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: getOrderCycle 
	 * @param salesOrderNoIn
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 获取对账单的订单周期
	 */
	public String getOrderCycle(String salesOrderNoIn){
		PageData pd = new PageData();
		pd.put("salesOrderNoIn", salesOrderNoIn);
		return salesOrderMapper.selectOrderCycle(pd);
	}
	
	/**
	 * 
	 * @Title: getGroupBusinessDesc 
	 * @param salesNoIns
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 根据订单号查询经过合并的明细的业务内容
	 */
	public String getSalesOrderDetailGroupBusinessDesc(String salesNo){
		PageData pd = new PageData();
		pd.put("salesNo", salesNo);
		return salesOrderDetailMapper.getGroupBusinessDesc(pd);
	}
	public String getSalescheckingOrderDetailGroupBusinessDesc(String salescheckingNo){
		PageData pd = new PageData();
		pd.put("salescheckingNo", salescheckingNo);
		return salesCheckingOrderDetailMapper.getGroupBusinessDesc(pd);
	}
	
	
	
	//批量为好友前的单向销售订单生成协同采购订单
	public void insertBatchSynchroPurchaseOrderForSingleSalesOrder(String salesNoIns) throws Exception{
		PageData pd = new PageData();
		List<String> salesNoList = Tools.strArray2List(StringUtil.StrList(salesNoIns));
		for (String salesNo : salesNoList) {
			pd.put("salesNo", salesNo);
			SalesOrder order = this.selectOneSalesOrder(pd);
			if (order != null) {
				//查询合作伙伴
				PageData pd2 = new PageData();
				pd2.put("myComKey", order.getComKey());
				pd2.put("partnerKey",order.getPartnerKey());
				PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd2);

		        int relation = 0; //好友关系判断 0非好友 1好友
		        if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()
		        		.equalsIgnoreCase(partnerVO.getPartnerStatus())){ //互为好友
		        	relation = 1;
		        }
		        if(relation==1){ //好友合作伙伴的
		        	List<SalesOrderDetail> details = this.selectSalesOrderDetailList(salesNo);
					PurchaseOrder purchase = null;
					List<PurchaseOrderDetail> podDetails = null;
					PageData pdPartner = new PageData();
					pdPartner.put("partnerComKey",partnerVO.getPartnerComKey());
					purchase = this.fillInsertPurchaseOrder(order, pdPartner);
					podDetails = this.fillInsertPurchaseOrderDetails(details, purchase);
					order.setPurchaseNo(purchase.getPurchaseNo());  //协同采购单号写入销售订单
					purchaseOrderService.insertOnePurchaseOrder(purchase);
					purchaseOrderService.insertListPurchaseOrderDetail(podDetails);
					this.updateSalesOrder(order);
				}
			}
		}
	}
	
	
	//修改设计派工单（业务内容、订单日期、项目名称、客户）
	public int updateAssignTask(SalesOrder salesOrder,List<SalesOrderDetail> details){
		AssignTask assignTask = new AssignTask();
		assignTask.setSalesNo(salesOrder.getSalesNo());
		assignTask.setComKey(salesOrder.getComKey());
		assignTask.setOrderDate(salesOrder.getOrderDate());
		assignTask.setPartnerKey(salesOrder.getPartnerKey());
		assignTask.setPartnerName(salesOrder.getPartnerName());
		assignTask.setPartnerShortname(salesOrder.getPartnerShortname());
		String buinessDesc = "";
		for (SalesOrderDetail detail : details) {
			buinessDesc += detail.getBusinessDesc()+"  ("+detail.getRequirements()+")"+";";
		}
		assignTask.setCaseDesc(salesOrder.getCaseDesc());
		assignTask.setBusinessDesc(buinessDesc.substring(0, buinessDesc.length()-1));
		return assignTaskMapper.updateByPrimaryKeySelective(assignTask);
	}
	
	/**
	 * 
	 * @Title: insertWorkingAssignTask 
	 * @param salesOrder
	 * @param details
	 * @return
	 * @return int
	 * @throws Exception 
	 * @throws 
	 * @Description: 已对账的订单进行制作派工处理
	 */
	public int insertWorkingAssignTask(SalesOrder salesOrder,List<SalesOrderDetail> details) throws Exception{
		salesOrder.setTaskStatus(AssignEnum.ASSIGN_SALESORDER_YES.getCode());
		salesOrder.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
		for (SalesOrderDetail orderDetail : details) {
			if(StringUtil.isEmpty(orderDetail.getWorkingProcedure())){
				orderDetail.setWorkingProcedure(AssignEnum.ASSIGN_PROCEDURE_NONE.getCode()); //没有工序的，设置为未分配工序
			}
			this.updateSalesOrderDetail(orderDetail);
		}
		if (StringUtil.isNotEmpty(salesOrder.getPurchaseNo())) { //有协同单的需要更新协同采购单状态
			PageData pdPara = new PageData();
			pdPara.put("purchaseNo", salesOrder.getPurchaseNo());
			pdPara.put("workingStatus", AssignEnum.ASSIGN_STATUS_WORKING.getCode());
			
			purchaseOrderService.updatePurchaseOrderByMapPara(pdPara);
			pdPara.put("workingStatus", AssignEnum.ASSIGN_STATUS_WORKING.getDesc());
			purchaseOrderService.updatePurchaseOrderDetailByMapPara(pdPara);
		}
		workingAssignTaskService.insertWorkingAssignTaskAndDetail(salesOrder, details);
		return this.updateSalesOrder(salesOrder);
	}
	
	/**
	 * 
	 * @Title: cancelSalesOrder 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 作废销售单
	 */
	public int cancelSalesOrder(PageData pd) throws Exception{
		//作废销售单及明细。 isdel = 1
		int result = 0;
		this.updateBatchDetailBySalesNoIn(pd);
		result = this.updateBatchBySalesNoIn(pd);
		if (pd.get("purchaseOrderNoIn")!=null) {
			purchaseOrderService.updateBatchDetailByPurchaseNoIn(pd);
			result = purchaseOrderService.updateBatchByPurchaseNoIn(pd);
		}
		return result;
	}
	
	public ResultMap validOrderCount(PageData pd) throws Exception{
		ResultMap resultMap = ResultUtil.getResultMap();
		String orderStatus[] = {"01","04","05","CC"};
		pd.put("orderStatusIN", Tools.strArray2List(orderStatus));
		OrderTotalVO orderTotalVO = this.getSumTotalPriceOrder(pd);
		resultMap.put("userdOrderCount",orderTotalVO.getOrderCount());
		int freeOrderCount = StringUtil.isEmpty(commonService.getDictValue("FREE_ORDER_COUNT"))==true?0:Integer.parseInt(commonService.getDictValue("FREE_ORDER_COUNT"));
		resultMap.put("balanceOrderCount", freeOrderCount-orderTotalVO.getOrderCount());
		resultMap.put("freeOrderCount", freeOrderCount);
		return resultMap;
	}
	
	/**
	 * 
	 * @Title: sendWechatMessage 
	 * @param comKey
	 * @param pd
	 * @throws Exception
	 * @return void
	 * @throws 
	 * @Description: 发送微信推送消息
	 * 参数列表：
	 * comKey
	 * caseDesc
	 * partnerName
	 * purchaseNo/purchasecheckingNo
	 * type  order/checking
	 * totalPrice
	 * orderDate 格式：2017-12-13
	 * 
	 */
	private void sendWechatMessage(PageData pd) throws Exception{
		PurchaseMsgVO purchaseMsgVO = null;
		PageData pdPara = new PageData();
		pdPara.put("comKey", pd.getString("comKey"));
		pdPara.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode());
		List<EmployeeVo> employeeVos = employeeService.getAllEmployee(pdPara);
		for (EmployeeVo employeeVo : employeeVos) {
			if (StringUtil.isNotEmpty(employeeVo.getBindWechat())) { // 如果绑定 则发送微信消息
				purchaseMsgVO = new PurchaseMsgVO();
				if (StringUtil.isNotEmpty(pd.getString("caseDesc"))) {
					purchaseMsgVO.setProjectName(pd.getString("caseDesc"));
				}else{
					purchaseMsgVO.setProjectName(wechatConstants.defaultCaseDesc);
				}
				purchaseMsgVO.setOrderMoney(pd.getString("totalPrice"));
				purchaseMsgVO.setOrderDate(pd.getString("orderDate"));
				purchaseMsgVO.setOpenId(employeeVo.getBindWechat());
				
				// 合作伙伴
				purchaseMsgVO.setOrderSource(pd.getString("partnerName"));
				if ("order".equals(pd.getString("type"))) {
					purchaseMsgVO.setOrderNo(pd.getString("purchaseNo"));
					purchaseMsgVO.setTemplateId(wechatConstants.pOrderTemplateId);
					purchaseMsgVO.setFirst(wechatConstants.pOrderFirst);
					purchaseMsgVO.setRemark(wechatConstants.pOrderRemark);
					wechatUtil.sendTemMsg(purchaseMsgVO, "PO");
					logger.info("===协同采购单微信推送\n  "+JsonUtil.toJsonString(pd));
				}else if ("checking".equals(pd.getString("type"))) {
					purchaseMsgVO.setOrderNo(pd.getString("purchasecheckingNo"));
					purchaseMsgVO.setTemplateId(wechatConstants.pcheckingOrderTemplateId);
					purchaseMsgVO.setFirst(wechatConstants.pcheckingOrderFirst);
					purchaseMsgVO.setRemark(wechatConstants.pcheckingOrderRemark);
					wechatUtil.sendTemMsg(purchaseMsgVO, "PCO");
					logger.info("===协同采购对账单微信推送\n  "+JsonUtil.toJsonString(pd));
				}
			}
		}
	}
}
