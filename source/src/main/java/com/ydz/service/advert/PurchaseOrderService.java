package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.ydz.dao.advert.*;
import com.ydz.dao.system.ComPartnerMapper;
import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.advert.*;
import com.ydz.entity.system.ComPartner;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Partner;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.entity.system.PartnerVO;
import com.ydz.vo.AllPurchaseCheckingOrderVO;
import com.ydz.vo.EmployeeVo;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.SalesOrderVO;
import com.ydz.vo.TaxPointVo;
import com.ydz.vo.TotalPurchaseCheckingOrderDetailVO;
import com.ydz.vo.TotalPurchaseOrderDetailVO;
import com.ydz.vo.UserVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.ydz.entity.Page;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.exception.OrderException;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.EmployeeService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.LoggerUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.PurchaseOrderVO;
import com.ydz.wechat.util.WechatUtil;
import com.ydz.util.Logger;

import javax.annotation.Resource;

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
 *    ┃　　　┃   神兽保佑
 *    ┃　　　┃   代码无BUG！
 *    ┃　　　┗━━━┓
 *    ┃　　　　　　　┣┓
 *    ┃　　　　　　　┏┛
 *    ┗┓┓┏━┳┓┏┛
 *    ┃┫┫　┃┫┫
 *    ┗┻┛　┗┻┛
 * @ClassName: PurchaseOrderService 
 * @Description: 采购订单和采购对账单Service处理
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月8日 下午5:03:58 
 * 
 */

@Service
public class PurchaseOrderService {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource
	WechatUtil wechatUtil;

	@Autowired
	private PartnerMapper partnerMapper;

	@Autowired
	private PurchaseOrderMapper purchaseOrderMapper;
	@Autowired
	private PurchaseOrderDetailMapper purchaseOrderDetailMapper;
	@Autowired
	private PurchaseCheckingOrderMapper purchaseCheckingOrderMapper;
	@Autowired
	private PurchaseCheckingOrderDetailMapper purchaseCheckingOrderDetailMapper;

	@Autowired
	private ReceiptPaymentMapper receiptPaymentMapper;
	@Autowired
	private ComPartnerMapper comPartnerMapper;
	
	@Resource
	@Lazy
	private SalesOrderService salesOrderService;
	@Resource
	private PartnerService partnerService;
	@Resource
	private OrderConfigService orderConfigService;
	@Resource
	private CompanyService companyService;
	@Resource
	private EmployeeService employeeService;
	

    //非协同
	public List<PurchaseOrder> listPageNomal(Page page){
		return purchaseOrderMapper.listPageNomal(page);
	}

    //协同
	public List<PurchaseOrder> listPageSynch(Page page){
		return purchaseOrderMapper.listPageSynch(page);
	}

    /**
     * 根据采购单号（集合）批量查询采购单详情
     * @param orderNos
     * @return
     */
	public List<PurchaseOrderDetail> selectBatchPurchaseOrderDetail(List<String> orderNos){
	    Map<String,Object> map = new HashMap<>();
        map.put("orderNos",orderNos);
        return purchaseOrderDetailMapper.batchSelectPurchaseOrderDetail(map);
    }

	/**
	 * 
	* @Title: saveOrderAndOrderDetail 
	* @param orderVO
	* @param pd
	* @return
	* @throws Exception
	* String
	* @throws 
	* @Description: 保存采购订单和采购订单明细
	 */
	public Map<String,Object> saveOrderAndOrderDetail(PurchaseOrderVO orderVO,PageData pd) throws Exception{
		
		PurchaseOrder order = orderVO.getPurchaseOrder();
		List<PurchaseOrderDetail> items = orderVO.getDetails();
		String orderStatus = OrderEnum.STATUS_DAIDUIZHANG.getCode(); //默认 待对账
		
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		
		//删除完全为空的记录
		/**
		 * 业务内容(文件名) 制作(配置)说明 长(米) 宽(米) 计价方式  数量 单位 单价 附加说明 行小计(¥) 
		 * businessDesc,requirements,length,width,priceWay,quantity,unit,unitPrice,additionalService,totalPrice
		 */
		Iterator<PurchaseOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			PurchaseOrderDetail item = it.next();
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
		
		//查询供应商信息
		PageData pd2 = new PageData();
		pd2.put("myComKey", pd.getString("comKey")); //当前公司key
		pd2.put("partnerKey",order.getPartnerKey()); //供应商partnerkey
		PartnerVO partnerVO = partnerService.findPartnerByCPKey(pd2); //获取供应商信息

        int relation = 0; //好友关系判断 0非好友 1好友
        if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()
        		.equalsIgnoreCase(partnerVO.getPartnerStatus())){ //互为好友
        	relation = 1;
        }
		
		Map<String,String> mapType = new HashMap<String, String>();
        Date nowDate = new Date();
        String purchaseNo = CodeBuilderUtil.getInstance().getPurchaseNo();
        order.setPurchaseNo(purchaseNo);
        order.setOrderStatus(orderStatus);
        order.setCreateTime(nowDate);
        order.setDetailNum((short)items.size());
        order.setCreator(pd.getString("userKey"));
        order.setChangedTime(nowDate);
        order.setIndustryId(pd.getString("industryId"));
        order.setComKey(pd.getString("comKey")); //当前公司comKey
        order.setIsValid("1");
        order.setIsDel("0");
//        if(StringUtil.isEmpty(order.getSalesId())){
//        	order.setSalesId(CodeBuilderUtil.getInstance().getAnyId(10)); //采购代表ID
//        	order.setSalesName(pd.getString("userName")); //采购代表姓名
//		}
        
        int item = 1;
        for(PurchaseOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(orderStatus);
			orderDetail.setPurchaseNo(purchaseNo);
			orderDetail.setCreator(order.getCreator());
			orderDetail.setCreateTime(order.getCreateTime());
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			orderDetail.setIsValid("1");
			orderDetail.setIsDel("0");
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		order.setBusinessType(businessTypeOrder);
		
		if(relation==1){ //好友合作伙伴的
			SalesOrder salesOrder = null;
			List<SalesOrderDetail> soDetails = null;
			PageData pdPartner = new PageData();
			pdPartner.put("partnerComKey",partnerVO.getPartnerComKey()); //好友供应商的comKey
			salesOrder = this.fillInsertSalesOrder(order, pdPartner);
			soDetails = this.fillInsertSalesOrderDetails(items, salesOrder);
			salesOrderService.insertOneSalesOrder(salesOrder);
			salesOrderService.insertListSalesOrderDetail(soDetails);
		}
		
		this.insertOnePurchaseOrder(order);
		this.insertListPurchaseOrderDetail(items);
		returnMap.put("status","1");
		returnMap.put("type",order.getOrderStatus());
		returnMap.put("msg","采购订单新建成功");
		return returnMap;
	}
	
	/**
	 * 
	 * @Title: fillInsertSalesOrder 
	 * @param purchaseOrder
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return SalesOrder
	 * @throws 
	 * @Description: 填充根据采购单填充销售单数据
	 */
		private SalesOrder fillInsertSalesOrder(PurchaseOrder purchaseOrder,PageData pd)
				throws Exception{
			//自动生成销售单
			SalesOrder salesOrder = new SalesOrder();
			String salesNo = null;
			//如果存在传入的销售单号，则使用该单号。如果没传入就重新生成一个
			if(StringUtil.isEmpty(pd.getString("salesNo"))){
				salesNo = CodeBuilderUtil.getInstance().getSalesNo();
			}else{
				salesNo = pd.getString("salesNo");
			}
			salesOrder.setSalesNo(salesNo);
			salesOrder.setComKey(pd.getString("partnerComKey")); //销售方的comKey
			
			//根据销售方的comKey和采购方的comKey在销售方的合作伙伴列表中查询记录得到采购方的partnerKey
			PageData pageData = new PageData();
			pageData.put("comKey",salesOrder.getComKey());
			pageData.put("partnerComKey",purchaseOrder.getComKey());
			ComPartner comPartner = comPartnerMapper.selectMyPartnerKey(pageData);
			if(comPartner!=null){
				salesOrder.setPartnerKey(comPartner.getPartnerKey());
			}
			Company resCompany = companyService.getCompanyByUserKey(purchaseOrder.getComKey()); //查询采购方的公司信息作为销售方的客户
			salesOrder.setPartnerName(resCompany.getComName());
			salesOrder.setPartnerShortname(resCompany.getComShortname());

			//协同销售方的销售代表默认为销售方的管理员employeeId
			EmployeeVo employeeVo = employeeService.getAdmin(salesOrder.getComKey());
			if(employeeVo!=null){
				salesOrder.setSalesId(employeeVo.getEmployeeId());
				salesOrder.setSalesName(employeeVo.getUserName());
			}
			//协同销售方的联系人为销售方的客户的联系人
			pd.put("partnerKey", salesOrder.getPartnerKey());
//			pd.put("comKey", pd.getString("partnerComKey"));
//			PartnerVO partnerVo1 = partnerService.selectOneComPartnerAndPartnerInfo(pd);
			PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
			if(contacter!=null){
				salesOrder.setContactId(contacter.getContacterId());
				salesOrder.setContactName(contacter.getContacterName());
			}
			
			salesOrder.setCaseDesc(purchaseOrder.getCaseDesc());
			salesOrder.setOrderDate(purchaseOrder.getOrderDate());
			salesOrder.setPrice(purchaseOrder.getPrice());
			salesOrder.setDiscountRate(purchaseOrder.getDiscountRate());
			salesOrder.setDiscount(purchaseOrder.getDiscount());
			salesOrder.setTaxRate(purchaseOrder.getTaxRate());
			salesOrder.setTaxPrice(purchaseOrder.getTaxPrice());
			salesOrder.setPreferential(purchaseOrder.getPreferential());
			salesOrder.setTotalPrice(purchaseOrder.getTotalPrice());
			salesOrder.setDepositRequested(purchaseOrder.getDepositRequested());
			salesOrder.setReceivablesMoney(purchaseOrder.getReceivablesMoney());
			salesOrder.setRemarks(purchaseOrder.getRemarks());
			salesOrder.setOrderStatus(purchaseOrder.getOrderStatus());
			salesOrder.setDetailNum(purchaseOrder.getDetailNum());
			salesOrder.setIsUrgent(purchaseOrder.getIsUrgent());
			salesOrder.setIsValid("1");
			salesOrder.setBusinessType(purchaseOrder.getBusinessType());
			salesOrder.setIndustryId(purchaseOrder.getIndustryId());


			salesOrder.setPurchaseNo(purchaseOrder.getPurchaseNo()); //销售单关联采购单
			purchaseOrder.setSalesNo(salesOrder.getSalesNo()); //采购单关联销售单

			salesOrder.setCreator("system");
			salesOrder.setCreateTime(purchaseOrder.getCreateTime());
			salesOrder.setChangedTime(purchaseOrder.getCreateTime());

			return salesOrder;
		}
		
		/**
		 * 
		 * @Title: fillInsertSalesOrderDetails 
		 * @param items
		 * @param order
		 * @return
		 * @throws Exception
		 * @return List<SalesOrderDetail>
		 * @throws 
		 * @Description: 根据销售订单填充销售单明细
		 */
		private List<SalesOrderDetail> fillInsertSalesOrderDetails(List<PurchaseOrderDetail> items,SalesOrder order) 
				throws Exception{
			SalesOrderDetail soDetail = null;
			List<SalesOrderDetail> soDetails = new ArrayList<SalesOrderDetail>();
			//自动生成销售单明细
			for(PurchaseOrderDetail orderDetail : items){
				soDetail = new SalesOrderDetail();
				soDetail.setSalesNo(order.getSalesNo());
				soDetail.setItemNo(orderDetail.getItemNo());
				soDetail.setBusinessType(orderDetail.getBusinessType());
				soDetail.setBusinessDesc(orderDetail.getBusinessDesc());
				soDetail.setRequirements(orderDetail.getRequirements());
				soDetail.setSpecification(orderDetail.getSpecification());
				soDetail.setPriceWay(orderDetail.getPriceWay());
				soDetail.setLength(orderDetail.getLength());
				soDetail.setWidth(orderDetail.getWidth());
				soDetail.setColorSize(orderDetail.getColorSize());
				soDetail.setPairsNum(orderDetail.getPairsNum());
				soDetail.setQuantity(orderDetail.getQuantity());
				soDetail.setUnit(orderDetail.getUnit());
				soDetail.setUnitPrice(orderDetail.getUnitPrice());
				soDetail.setAdditionalPrice(orderDetail.getAdditionalPrice());
				soDetail.setAdditionalService(orderDetail.getAdditionalService());
				soDetail.setPreferential(orderDetail.getPreferential());
				soDetail.setTotalPrice(orderDetail.getTotalPrice());
				soDetail.setRemarks(orderDetail.getRemarks());
				soDetail.setOrderStatus(orderDetail.getOrderStatus());
				soDetail.setIsUrgent(orderDetail.getIsUrgent());
				soDetail.setIsValid("1");
				soDetail.setIsDel("0");
				soDetail.setCreator(order.getCreator());
				soDetail.setCreateTime(order.getCreateTime());
				soDetails.add(soDetail);
			}
			return soDetails;
		}
		
	/**
	 * 创建采购单并付款同时生成对账单	
	 */
	public Map<String,Object> savePaymentOrder(PurchaseOrderVO orderVO,UserVo userVo) throws Exception {
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<String,Object>();
		//获取提交的采购订单
		PurchaseOrder purchaseOrder = orderVO.getPurchaseOrder();
		purchaseOrder.setCaseDesc(purchaseOrder.getCaseDesc() == null ? "" : purchaseOrder.getCaseDesc());
		//获取采购订单详情列表
		List<PurchaseOrderDetail> items = orderVO.getDetails();
			
		//删除空记录
		Iterator<PurchaseOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			PurchaseOrderDetail item = it.next();
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
		if(StringUtil.isEmpty(purchaseOrder.getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请先选择客户信息");
			return returnMap;
		}
		
		Date nowTime = new Date();
		
		String orderStatus = OrderEnum.STATUS_YIDUIZHANG.getCode(); //新建采购订单(已对账)
		String purchaseNo = CodeBuilderUtil.getInstance().getPurchaseNo();
		purchaseOrder.setPurchaseNo(purchaseNo);
		purchaseOrder.setOrderStatus(orderStatus);
//		if(StringUtil.isEmpty(purchaseOrder.getSalesId())){
//			purchaseOrder.setSalesId(CodeBuilderUtil.getInstance().getAnyId(10)); //销售代表ID
//		}
		purchaseOrder.setDetailNum((short)items.size());
		purchaseOrder.setComKey(userVo.getComKey());
		purchaseOrder.setCreateTime(nowTime);
		purchaseOrder.setChangedTime(nowTime);
		purchaseOrder.setCreator(userVo.getUserKey());
		purchaseOrder.setIndustryId(userVo.getDetailIndustryId());

		int item = 1;
		Map<String,String> mapType = new HashMap<String,String>();
		for(PurchaseOrderDetail orderDetail :items){
			mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
			orderDetail.setItemNo(item++);
			orderDetail.setOrderStatus(orderStatus);
			orderDetail.setPurchaseNo(purchaseNo);;
			orderDetail.setCreator(purchaseOrder.getCreator());
			orderDetail.setCreateTime(purchaseOrder.getCreateTime());
			orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
			orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
			orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
			orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
		}
		String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
		purchaseOrder.setBusinessType(businessTypeOrder);

		List<PurchaseOrder> purchaseOrdersList = new ArrayList<PurchaseOrder>();
		purchaseOrdersList.add(purchaseOrder);
		
		//税点处理
		TaxPointVo taxPointVo = new TaxPointVo();
		taxPointVo.setTaxRate(purchaseOrder.getTaxRate());
		List<String> purchaseNos = new ArrayList<String>();
		purchaseNos.add(purchaseOrdersList.get(0).getPurchaseNo());
		
		//根据采购单生成采购对账单
		PurchaseCheckingOrder purchaseCheckingOrder = this.nToOneCheckingOrder(userVo,purchaseOrdersList, taxPointVo,items,purchaseNos);
		//补收总金额
		purchaseCheckingOrder.setReceivablesMoney(purchaseCheckingOrder.getTotalPrice().subtract(purchaseCheckingOrder.getDepositRequested()).setScale(2, BigDecimal.ROUND_HALF_UP));
		//实收总金额
		purchaseCheckingOrder.setPaidUp(purchaseCheckingOrder.getDepositRequested().add(purchaseCheckingOrder.getReceivablesMoney()));
			
		//根据采购订单明细生成对账单明细集合
		List<PurchaseCheckingOrderDetail> purchaseCheckingOrderDetails = this.nToNPuchaseCheckingOrderDetail(purchaseCheckingOrder,items);
		//创建采购单并付款时状态改为已付款
		purchaseCheckingOrder.setOrderStatus(OrderEnum.STATUS_YIFUKUAN.getCode());
		//填入订单中的对账单号值
		purchaseOrder.setPurchasecheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
		
		//插入付款记录
		ReceiptPayment receiptPayment = new ReceiptPayment();
		receiptPayment.setCheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());
		receiptPayment.setCheckingType("2"); //采购对账单
		receiptPayment.setRecpayType("2"); //付款
		receiptPayment.setComKey(userVo.getComKey()); //付款单位
		receiptPayment.setRecpayMoney(purchaseCheckingOrder.getPaidUp()); //付款金额(实付金额)
		receiptPayment.setRecpayDate(nowTime);
		receiptPayment.setIsValid("1");
		receiptPayment.setRecpayName(userVo.getRealName());
		receiptPayment.setCreateTime(nowTime);
		receiptPaymentMapper.insertSelective(receiptPayment);
		
		this.insertOnePurchaseOrder(purchaseOrder);
		this.insertListPurchaseOrderDetail(items);
		this.insertOnePurchaseCheckingOrder(purchaseCheckingOrder);
		this.insertListPurchaseCheckingOrderDetail(purchaseCheckingOrderDetails);
		
		returnMap.put("status","1");
		returnMap.put("msg","保存成功");
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
	 * @Description: 修改采购订单及明细
	 */
	public Map<String,Object> updateOrderAndOrderDetail(PurchaseOrderVO orderVO,UserVo userVo,String newOrderStatus)
			throws Exception{
		Date nowDate = new Date();
		//用于返回的map
		Map<String,Object> returnMap = new HashMap<>();
		//获取订单
		PurchaseOrder purchaseOrder = orderVO.getPurchaseOrder();
		purchaseOrder.setCaseDesc(purchaseOrder.getCaseDesc() == null ? "" : purchaseOrder.getCaseDesc());
		//获取订单详情列表
		List<PurchaseOrderDetail> items = orderVO.getDetails();

		//根据传入的订单号查询最新的采购订单信息用于判断
		PageData pdData = new PageData();
		pdData.put("comKey",userVo.getComKey());
		pdData.put("purchaseNo",purchaseOrder.getPurchaseNo());
		PurchaseOrder purchaseOrderReal = this.selectOnePurchaseOrder(pdData);

		if(!purchaseOrder.getOrderStatus().equalsIgnoreCase(purchaseOrderReal.getOrderStatus())){
			returnMap.put("status","0");
			returnMap.put("msg","您提交的订单状态已过期，请确认当前订单的状态");
			return returnMap;
		}

		//删除空记录
		Iterator<PurchaseOrderDetail> it = items.iterator();
		while (it.hasNext()) {
			PurchaseOrderDetail item = it.next();
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
		
		if(StringUtil.isEmpty(purchaseOrder.getPartnerKey())){
			returnMap.put("status","0");
			returnMap.put("msg","请选择客户");
			return returnMap;
		}
		
		if(items.size() == 0){
			returnMap.put("status","0");
			returnMap.put("msg","请填写订单明细");
			return returnMap;
		}
		
		purchaseOrder.setOrderStatus(newOrderStatus);
		purchaseOrder.setCreateTime(purchaseOrderReal.getCreateTime());
		purchaseOrder.setChangedTime(nowDate);
		purchaseOrder.setDetailNum((short)items.size());
		
		//删除订单详情
		pdData.clear();
		pdData.put("purchaseNo", purchaseOrder.getPurchaseNo());
		this.deletePurchaseOrderDetail(pdData);
		
		//待对账订单的修改
		String orderStatus = purchaseOrder.getOrderStatus(); //判断订单状态
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equals(orderStatus)){
			//修改订单状态
			pdData.clear();
			pdData.put("myComKey",userVo.getComKey());
			pdData.put("partnerKey",purchaseOrder.getPartnerKey());
			PartnerVO partnerVO = partnerMapper.findPartnerByCPKey(pdData);
			
			//新建订单详情
			int item = 1;
			Map<String,String> mapType = new HashMap<String, String>();//订单类型
			for(PurchaseOrderDetail orderDetail :items){
				mapType.put(orderDetail.getBusinessType(), orderDetail.getBusinessType());
				orderDetail.setItemNo(item++);
				orderDetail.setOrderStatus(purchaseOrder.getOrderStatus());
				orderDetail.setPurchaseNo(purchaseOrder.getPurchaseNo());
				orderDetail.setCreator(purchaseOrder.getCreator());
				orderDetail.setCreateTime(nowDate);
				orderDetail.setBusinessDesc(orderDetail.getBusinessDesc() == null ? "" : orderDetail.getBusinessDesc());
				orderDetail.setRequirements(orderDetail.getRequirements() == null ? "" : orderDetail.getRequirements());
				orderDetail.setSpecification(orderDetail.getLength().setScale(2, BigDecimal.ROUND_HALF_UP)+" * "+orderDetail.getWidth().setScale(2, BigDecimal.ROUND_HALF_UP));
				orderDetail.setAdditionalService(orderDetail.getAdditionalService() == null ? "" : orderDetail.getAdditionalService());
			}
			String businessTypeOrder = Tools.list2InString(Tools.strMap2List(mapType));
			purchaseOrder.setBusinessType(businessTypeOrder==null?"00":businessTypeOrder);
			
			if(CompanyEnum.PARTNER_STATUS_FRIEND_YES.getCode()
					.equalsIgnoreCase(partnerVO.getPartnerStatus())){ //如果是好友的，则生成协同销售单
				pdData.clear();
				pdData.put("partnerComKey",partnerVO.getPartnerComKey());
				pdData.put("salesNo",purchaseOrderReal.getSalesNo());
				SalesOrder salesOrder = this.fillInsertSalesOrder(purchaseOrder, pdData);
				List<SalesOrderDetail> sodDetails = this.fillInsertSalesOrderDetails(items, salesOrder); 
				
				//首先删除原有的协同单
				pdData.clear();
				pdData.put("comKey", partnerVO.getPartnerComKey());
				pdData.put("salesNo", salesOrder.getSalesNo());
				salesOrderService.deleteSalesOrder(pdData);
				salesOrderService.deleteSalesOrderDetail(pdData);
				//生成新的协同单
				salesOrderService.insertOneSalesOrder(salesOrder);
				salesOrderService.insertListSalesOrderDetail(sodDetails);
			}
			this.updatePurchaseOrder(purchaseOrder);  //修改采购订单
			this.insertListPurchaseOrderDetail(items); //新插入采购订单明细
			
			returnMap.put("type",purchaseOrder.getOrderStatus());
			returnMap.put("status","1");
			returnMap.put("msg","添加成功");
			return returnMap;
		} else {
			returnMap.put("status","0");
			returnMap.put("msg","订单状态不合法");
			return returnMap;
		}

	}
	
	/**
	 * 
	 * @Title: saveManyCheckingOrder 
	 * @param taxPointVo
	 * @param userVo
	 * @param purchaseNos
	 * @return
	 * @throws Exception
	 * @return Map<String,Object>
	 * @throws 
	 * @Description: 生成采购对账单
	 * 1.正常生成采购对账单
	 * 2.协同的生成协同对账单
	 */
	public Map<String,Object> saveManyCheckingOrder(TaxPointVo taxPointVo, UserVo userVo,List purchaseNos) throws Exception {

		Map<String,Object> returnMap = new HashMap<>();
		//查询参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("comKey",userVo.getComKey());
		map.put("purchaseNos",purchaseNos);
		List<PurchaseOrder> purchaseOrders = purchaseOrderMapper.listPurchaseOrderByPurchaseNos(map);
		String partnerKey = "";
		int i = 1;
		for(PurchaseOrder order : purchaseOrders){
			if(i == 1){
				partnerKey = order.getPartnerKey();
			}else if (!partnerKey.equals(order.getPartnerKey())){
				returnMap.put("status","0");
				returnMap.put("msg","只可对同一客户生成对账单");
				return returnMap;
			}

			if(order.getPurchasecheckingNo() != null && !"".equals(order.getPurchasecheckingNo())){
				returnMap.put("status","0");
				returnMap.put("msg","订单已对账");
				return returnMap;
			}
			//判断订单状态是否为待对账状态
			if(!order.getOrderStatus().equals(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
				returnMap.put("status","0");
				returnMap.put("msg","订单状态不可用");
				return returnMap;
			}
			i++;
		}
		System.out.println();
		//批量查询订单详情
		List<PurchaseOrderDetail> purchaseOrderDetails = this.selectBatchPurchaseOrderDetail(purchaseNos);
		
		//根据采购订单生成采购对账单
		PurchaseCheckingOrder purchaseCheckingOrder = this.nToOneCheckingOrder(userVo,purchaseOrders, taxPointVo, purchaseOrderDetails,purchaseNos);
		//根据订单明细集合生成对账单明细集合
		List<PurchaseCheckingOrderDetail> purchaseCheckingOrderDetails = this.nToNPuchaseCheckingOrderDetail(purchaseCheckingOrder,purchaseOrderDetails);

        //校验是否是协同单
        if(StringUtil.isEmpty(purchaseOrders.get(0).getSalesNo())){ //非协同单
            //生成对账单
            this.insertOnePurchaseCheckingOrder(purchaseCheckingOrder);
            this.insertListPurchaseCheckingOrderDetail(purchaseCheckingOrderDetails);
            
            //修改订单状态,修改订单明细状态
            PageData pdPara = new PageData();
            pdPara.put("orderStatus", OrderEnum.STATUS_YIDUIZHANG.getCode()); //05 已对账
            pdPara.put("changedTime", new Date());
			pdPara.put("purchasecheckingNo",purchaseCheckingOrder.getPurchasecheckingNo());
            pdPara.put("purchaseOrderNoIn", Tools.strArray2List(Tools.StrList(purchaseCheckingOrder.getPurchaseNo())));
            this.updateBatchByPurchaseNoIn(pdPara);
            this.updateBatchDetailByPurchaseNoIn(pdPara);

            returnMap.put("status","1");
            returnMap.put("msg","对账成功");
            return returnMap;
        }else{
            /**
             * 查找对应协同单并且生成协同单的 对账单。
             * 几笔销售订单对应几笔协同采购单
             *
             */
            List<SalesOrder> salesOrders = salesOrderService.listSalesOrderByPurchaseOrderNos(map);
            
            if(purchaseOrders.size() != salesOrders.size()){
                //几笔销售订单对应几笔协同采购单
                returnMap.put("status","0");
                returnMap.put("msg","销售方对账单生成失败！");
//                logger.warn("单号:"+Tools.list2String(purchaseNos)+"的采购订单,对应的协同销售单数不一致。");
            }
            //协同的销售单集合
            List<String> salesOrderNos = new ArrayList<>();
            //校验
            for(SalesOrder salesOrder : salesOrders){
                if(StringUtil.isNotEmpty(salesOrder.getSalescheckingNo())){
                	returnMap.put("status","0");
                	returnMap.put("msg","协同销售订单已对账");
                    return returnMap;
                }
                //判断订单状态是否为待对账状态
                if(!salesOrder.getOrderStatus().equals(OrderEnum.STATUS_DAIDUIZHANG.getCode())){
                    returnMap.put("status","0");
                    returnMap.put("msg","协同销售订单状态不可用");
                    return returnMap;
                }
                salesOrderNos.add(salesOrder.getSalesNo());
            }

            //查询协同销售订单明细
            map.clear();
            map.put("salesNo",salesOrderNos);
            List<SalesOrderDetail> salesOrderDetails = salesOrderService.listBatchSalesOrderDetail(map);

            //生成销售对账单和销售对账单明细
            SalesCheckingOrder salesCheckingOrder = this.nToOneSCheckingOrder(userVo, salesOrders, taxPointVo, salesOrderDetails, salesOrderNos, purchaseCheckingOrder);
            List<SalesCheckingOrderDetail> salesCheckingOrderDetails = this.nToNSalesCheckingOrderDetail(salesCheckingOrder, salesOrderDetails);
            
            //关联两个对账单单号
            purchaseCheckingOrder.setSalescheckingNo(salesCheckingOrder.getSalescheckingNo());
            salesCheckingOrder.setPurchasecheckingNo(purchaseCheckingOrder.getPurchasecheckingNo());

            //保存创建采购对账单和明细
            this.insertOnePurchaseCheckingOrder(purchaseCheckingOrder);
            this.insertListPurchaseCheckingOrderDetail(purchaseCheckingOrderDetails);
            //保存创建协同销售对账单和明细
            salesOrderService.insertOneSalesCheckingOrder(salesCheckingOrder);
            salesOrderService.insertListSalesCheckingOrderDetail(salesCheckingOrderDetails);

            //更新采购订单中的状态并回写采购对账单号
            PageData pdPara = new PageData();
            pdPara.put("orderStatus", OrderEnum.STATUS_YIDUIZHANG.getCode()); //"05" 已对账
            pdPara.put("changedTime", new Date());
			pdPara.put("purchasecheckingNo",purchaseCheckingOrder.getPurchasecheckingNo());
            pdPara.put("purchaseOrderNoIn", Tools.strArray2List(Tools.StrList(purchaseCheckingOrder.getPurchaseNo())));
            this.updateBatchByPurchaseNoIn(pdPara);
            this.updateBatchDetailByPurchaseNoIn(pdPara);


            //批量更新销售订单和订单明细
			pdPara.put("salescheckingNo",salesCheckingOrder.getSalescheckingNo());
            pdPara.put("salesOrderNoIn", Tools.strArray2List(Tools.StrList(salesCheckingOrder.getSalesNo())));
            salesOrderService.updateBatchBySalesNoIn(pdPara);
            salesOrderService.updateBatchDetailBySalesNoIn(pdPara);
            
            returnMap.put("status","1");
            returnMap.put("msg","对账成功");
            return returnMap;
        }
	}
	
		/**
		 * 
		 * @Title: nToOneCheckingOrder 
		 * @param userVo
		 * @param purchaseOrders
		 * @param taxPointVo
		 * @param purchaseOrderDetails
		 * @param purchaseNos
		 * @return
		 * @return PurchaseCheckingOrder
		 * @throws 
		 * @Description: 多笔采购订单生成一笔对账单
		 */
		private PurchaseCheckingOrder nToOneCheckingOrder(UserVo userVo,List<PurchaseOrder> purchaseOrders,
				   TaxPointVo taxPointVo,
				   List<PurchaseOrderDetail> purchaseOrderDetails,
				   List<String> purchaseNos
				   ){
			PurchaseCheckingOrder purchaseCheckingOrder = new PurchaseCheckingOrder();
			purchaseCheckingOrder.setPurchasecheckingNo(CodeBuilderUtil.getInstance().getCheckingNo());
			purchaseCheckingOrder.setComKey(purchaseOrders.get(0).getComKey());
			 
			BigDecimal price = new BigDecimal(0);	//本单金额
			BigDecimal discount = new BigDecimal(0); //总折扣
			BigDecimal preferential = new BigDecimal(0); //总减免
			BigDecimal totalPrice = new BigDecimal(0); //总合计
			BigDecimal depositRequested = new BigDecimal(0); //总预收
			BigDecimal receivablesMoney = new BigDecimal(0); //总应收
			
			String partnerKey  = null;
			String partnerName = null;
			String partnerShortName = null;
			
			int j = 1; //第一次的获取的供应商的key进行后续订单的循环比对，只要有不同的，则不允许继续
			for(PurchaseOrder order : purchaseOrders){
				if(j == 1){
					partnerKey = order.getPartnerKey();
					partnerName = order.getPartnerName();
					partnerShortName = order.getPartnerShortname();
				}else if(!partnerKey.equals(order.getPartnerKey())){
					throw new RuntimeException("请选择相同供应商的订单");
				}
				price = price.add(order.getPrice());
				//关于折扣
				discount = discount.add(order.getDiscount());
				preferential = preferential.add(order.getPreferential());
				totalPrice = totalPrice.add(order.getTotalPrice());
				//预付金额
				depositRequested = depositRequested.add(order.getDepositRequested());
				j++;
			}
			purchaseCheckingOrder.setPartnerKey(partnerKey);
			purchaseCheckingOrder.setPartnerName(partnerName);
			purchaseCheckingOrder.setPartnerShortname(partnerShortName);
			
			purchaseCheckingOrder.setSalesId(purchaseOrders.get(0).getSalesId());
			purchaseCheckingOrder.setSalesName(purchaseOrders.get(0).getSalesName());
			purchaseCheckingOrder.setContactId(purchaseOrders.get(0).getContactId());
			purchaseCheckingOrder.setContactName(purchaseOrders.get(0).getContactName());
			
			if(purchaseOrders.size() == 1){
				purchaseCheckingOrder.setCaseDesc(purchaseOrders.get(0).getCaseDesc());
			}else{
				purchaseCheckingOrder.setCaseDesc("多笔");
			}
			
			Date nowDate = new Date();
			purchaseCheckingOrder.setOrderDate(nowDate);
			//税金比例
			purchaseCheckingOrder.setTaxRate(taxPointVo.getTaxRate());
			//税金为  多笔订单totalPrice的加和 乘以 税金比例
			purchaseCheckingOrder.setTaxPrice(totalPrice.multiply(purchaseCheckingOrder.getTaxRate()));
			purchaseCheckingOrder.setPrice(price);
			purchaseCheckingOrder.setDiscount(discount);
			purchaseCheckingOrder.setPreferential(preferential);
			//合计金额为总金额加税金
			purchaseCheckingOrder.setTotalPrice(totalPrice.add(purchaseCheckingOrder.getTaxPrice()));
			//预付
			purchaseCheckingOrder.setDepositRequested(depositRequested);
			//应付金额 总计减预付
			receivablesMoney = purchaseCheckingOrder.getTotalPrice().subtract(purchaseCheckingOrder.getDepositRequested());
			purchaseCheckingOrder.setReceivablesMoney(receivablesMoney);
			purchaseCheckingOrder.setInvoiceMoney(new BigDecimal(0));
			purchaseCheckingOrder.setPaidUp(new BigDecimal(0));
			
			purchaseCheckingOrder.setOrderStatus(OrderEnum.STATUS_DAIFUKUAN.getCode());//待付款09
			purchaseCheckingOrder.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
			purchaseCheckingOrder.setPurchaseOrderNum((short) purchaseOrders.size());
			purchaseCheckingOrder.setDetailNum((short) purchaseOrderDetails.size());
			purchaseCheckingOrder.setIsValid("1");
			purchaseCheckingOrder.setIsDel("0");
			purchaseCheckingOrder.setChangedTime(nowDate);
			
			purchaseCheckingOrder.setIndustryId(purchaseOrders.get(0).getIndustryId());
			purchaseCheckingOrder.setPurchaseNo(Tools.list2InString(purchaseNos));
			purchaseCheckingOrder.setOrderCycle(this.getOrderCycle(Tools.strSqlIn(purchaseCheckingOrder.getPurchaseNo())));
			purchaseCheckingOrder.setCreator(userVo.getUserKey());
			purchaseCheckingOrder.setCreateTime(nowDate);
			return purchaseCheckingOrder;
		}
		
		/**
		 * 
		 * @Title: nToNPuchaseCheckingOrderDetail 
		 * @param purchaseCheckingOrder
		 * @param purchaseOrderDetails
		 * @return
		 * @return List<PurchaseCheckingOrderDetail>
		 * @throws 
		 * @Description: 根据采购对账单抬头生成采购对账单明细
		 */
		 List<PurchaseCheckingOrderDetail> nToNPuchaseCheckingOrderDetail(PurchaseCheckingOrder purchaseCheckingOrder,
				  List<PurchaseOrderDetail> purchaseOrderDetails){
			PurchaseCheckingOrderDetail purchaseCheckingOrderDetail = null;
			int i = 1;
			List<PurchaseCheckingOrderDetail> purchaseCheckingOrderDetails = new ArrayList<PurchaseCheckingOrderDetail>();
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
	 * 
	 * @Title: nToOneSCheckingOrder 
	 * @param userVo
	 * @param salesOrders
	 * @param taxPointVo
	 * @param salesOrderDetails
	 * @param purchaseOrderNos
	 * @param purchaseCheckingOrder
	 * @return
	 * @return SalesCheckingOrder
	 * @throws 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	private SalesCheckingOrder nToOneSCheckingOrder(UserVo userVo,List<SalesOrder> salesOrders,
					   TaxPointVo taxPointVo,
					   List<SalesOrderDetail> salesOrderDetails,
					   List<String> salesOrderNos,
					   PurchaseCheckingOrder purchaseCheckingOrder){
		SalesCheckingOrder salesCheckingOrder = new SalesCheckingOrder();
		salesCheckingOrder.setSalescheckingNo(CodeBuilderUtil.getInstance().getCheckingNo());
		
		salesCheckingOrder.setComKey(salesOrders.get(0).getComKey());
		//本单金额
		BigDecimal price = new BigDecimal(0);
		//总折扣
		BigDecimal discount = new BigDecimal(0);
		
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
			}else if(!partnerKey.equalsIgnoreCase(order.getPartnerKey())){
				throw new RuntimeException("请选择相同客户的订单");
			}
			price = price.add(order.getPrice());
			//关于折扣
			discount = discount.add(order.getDiscount());
			preferential = preferential.add(order.getPreferential());
			totalPrice = totalPrice.add(order.getTotalPrice());
			//预付金额
			depositRequested = depositRequested.add(order.getDepositRequested());
			j++;
		}
		salesCheckingOrder.setPartnerKey(partnerKey);
		salesCheckingOrder.setPartnerName(partnerName);
		salesCheckingOrder.setPartnerShortname(partnerShortName);
		
		salesCheckingOrder.setSalesId(salesOrders.get(0).getSalesId());
		salesCheckingOrder.setSalesName(salesOrders.get(0).getSalesName());
		salesCheckingOrder.setContactId(salesOrders.get(0).getContactId());
		salesCheckingOrder.setContactName(salesOrders.get(0).getContactName());
		
		salesCheckingOrder.setCaseDesc(purchaseCheckingOrder.getCaseDesc());
		
		salesCheckingOrder.setOrderDate(purchaseCheckingOrder.getCreateTime());
		//税金比例
		salesCheckingOrder.setTaxRate(taxPointVo.getTaxRate());
		//税金 多笔订单totalPrice的加和 乘以 税金比例
		salesCheckingOrder.setTaxPrice(totalPrice.multiply(salesCheckingOrder.getTaxRate()));
	
		salesCheckingOrder.setPrice(price);
		salesCheckingOrder.setDiscount(discount);
		salesCheckingOrder.setPreferential(preferential);
		//合计金额为 税金+总金额
		salesCheckingOrder.setTotalPrice(totalPrice.add(salesCheckingOrder.getTaxPrice()));
		salesCheckingOrder.setDepositRequested(depositRequested);
		//应收金额 总计减预收
		receivablesMoney = purchaseCheckingOrder.getTotalPrice().subtract(salesCheckingOrder.getDepositRequested());
		salesCheckingOrder.setReceivablesMoney(receivablesMoney);
	
		salesCheckingOrder.setInvoiceMoney(new BigDecimal(0));
		salesCheckingOrder.setPaidUp(purchaseCheckingOrder.getPaidUp());
		
		salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_DAISHOUKUAN.getCode());/** 07待收款 **/
		salesCheckingOrder.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
		salesCheckingOrder.setSalesOrderNum((short) salesOrders.size());
		salesCheckingOrder.setDetailNum((short) salesOrderDetails.size());
		salesCheckingOrder.setIsValid("1");
		salesCheckingOrder.setIsDel("0");
		salesCheckingOrder.setChangedTime(salesCheckingOrder.getCreateTime());
		
		salesCheckingOrder.setIndustryId(salesOrders.get(0).getIndustryId());
		salesCheckingOrder.setSalesNo(Tools.list2InString(salesOrderNos));
		salesCheckingOrder.setOrderCycle(salesOrderService.getOrderCycle(Tools.strSqlIn(salesCheckingOrder.getSalesNo())));
		salesCheckingOrder.setCreator("system");
		salesCheckingOrder.setCreateTime(salesCheckingOrder.getCreateTime());
		return salesCheckingOrder;
	}
	
	/**
	 * 
	 * @Title: nToNPCheckingOrderDetail 
	 * @param purchaseCheckingOrder
	 * @param purchaseOrderDetails
	 * @return
	 * @return List<PurchaseCheckingOrderDetail>
	 * @throws 
	 * @Description: 多笔采购订单明细生成对应的销售对账单明细
	 */
	private List<SalesCheckingOrderDetail> nToNSalesCheckingOrderDetail(SalesCheckingOrder salesCheckingOrder,
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
			//协同单明细状态跟协同单一致
			salesCheckingOrderDetail.setOrderStatus(salesCheckingOrder.getOrderStatus()); 
			salesCheckingOrderDetail.setInvoiceStatus(OrderEnum.INVOICE_NO.getCode());//未开票 0
			salesCheckingOrderDetail.setIsValid("1");
			salesCheckingOrderDetail.setIsDel("0");
			salesCheckingOrderDetail.setSalesNo(salesOrderDetail.getSalesNo());
			salesCheckingOrderDetail.setSalesOrderItem(salesOrderDetail.getItemNo()); //写入销售订单行序号
			salesCheckingOrderDetail.setCreator(salesOrderDetail.getCreator());
			salesCheckingOrderDetail.setCreateTime(salesOrderDetail.getCreateTime());
			salesCheckingOrderDetails.add(salesCheckingOrderDetail);
			i++;
		}
		return salesCheckingOrderDetails;
	}
		
		
	/**
	 * 
	* @Title: selectOnePurchaseOrder 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return PurchaseOrder
	 * @throws Exception 
	* @throws 
	* @Description: 查询单条采购订单
	 */
	public PurchaseOrder selectOnePurchaseOrder(PageData pd) throws Exception{
		PurchaseOrder order = purchaseOrderMapper.selectByPrimaryKey(pd);
		if(order!=null){
			order.setOrderStatusDesc(orderConfigService.formatOrderStatus(order.getOrderStatus()));
			pd.put("comKey", order.getComKey());
			order.setComName(companyService.getCompanyByKey(pd).getComName());
			pd.put("partnerKey", order.getPartnerKey());
			pd.put("contacterId", order.getContactId());
			if (StringUtil.isEmpty(order.getSalesNo())) { //非协同
				PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
				if (contacter!=null) {
					order.setContactTel(contacter.getTel1());
				}
			}else {
				//协同的采购单显示联系人和手机号取销售方的管理员信息
				PartnerVO partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
				if (partnerVO!=null) {
					EmployeeVo employeeVo = employeeService.getAdmin(partnerVO.getPartnerComKey());
					if (employeeVo!=null) {
						order.setContactName(employeeVo.getUserName());
						order.setContactTel(employeeVo.getUserId());
					}
				}
			}
		}
		return order;
	}

	/**
	 * 根据销售订单号集合 批量查询对应的协同采购单
	 * @return 采购单集合
	 */
	public List<PurchaseOrder> listPurchaseOrderBySalesNos(List<String> salesNos){
		PageData pd = new PageData();
		pd.put("salesNo",salesNos);
		return purchaseOrderMapper.listPurchaseOrderBySalesNos(pd);
	}
	
	public List<PurchaseOrder> listPurchaseOrderBySalesNos(PageData pd){
		return purchaseOrderMapper.listPurchaseOrderBySalesNos(pd);
	}
	
	

	/**
	 * 
	* @Title: listPagePurchaseOrder 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<PurchaseOrder>
	* @throws 
	* @Description: 查询带分页的采购订单列表
	 */
	public List<PurchaseOrder> listPagePurchaseOrder(Page page) throws Exception{
		
		return purchaseOrderMapper.listPagePurchaseOrder(page);
	}
	
	public List<PurchaseOrder> getPurchaseOrderNoList(Page page){
		return purchaseOrderMapper.getPurchaseOrderNoList(page);
	}
	
	public List<PurchaseOrder> listPagePurchaseOrderConcat(Page page) throws Exception{
		List<PurchaseOrder> totals = purchaseOrderMapper.listPagePurchaseOrderConcat(page);
		for (PurchaseOrder order : totals) {
			String workingProcedure = order.getWorkingStatus();
			if (StringUtil.isNotEmpty(workingProcedure)) {
				order.setWorkingStatus(AssignEnum.codeOf(workingProcedure).getDesc());
			}
		}
		return totals;
	}
	
	/**
	 * 修改页面的相关数据
	 * 1.purchaseOrder  		订单
	 * 2.purchaseOrderDetail   订单详情
	 * 3.clients			供应商
	 * 4.salesMan			采购代表
	 * 5.contacters			联系人
	 * @return
	 */
	public Map<String,Object> getOrderDatasForUpdateOrder(PageData pd) throws Exception {
		Map<String,Object> returnMap  = this.getMapPurchaseOrderDetailForUpdate(pd);
		PurchaseOrder purchaseOrder = (PurchaseOrder) returnMap.get("purchaseOrder");
		PageData pd2 = new PageData();
		pd2.put("comKey",purchaseOrder.getComKey());
//		pd2.put("status",CompanyEnum.EMPLOYEE_STATUS_NORMAL.getCode()); 
//        List<SalesMan> salesMen = employeeService.getList4order(pd2); //采购代表
//        List<Employee> employees = employeeService.getAllEmployeesForDropdown(pd2); //采购代表
        
		//供应商
		pd2.put("partnerType", CompanyEnum.PARTNER_TYPE_SUPPLIER.getCode());
		//判断当前订单状态是否为待对账
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equals(purchaseOrder.getOrderStatus()) ){
//				pd2.put("notFriend","true");
			pd2.put("notFriend",null);
		}

		Page page = new Page();
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
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
		//待对账修改的，供应商列表中去掉过路客
		if(OrderEnum.STATUS_DAIDUIZHANG.getCode().equalsIgnoreCase(purchaseOrder.getOrderStatus())){
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
		pd3.put("partnerKey",purchaseOrder.getPartnerKey());
		List<PartnerContacter> partnerContacters = partnerService.listPartnerContacter(pd3);
//		returnMap.put("salesMen",employees);
		returnMap.put("clients",partnerVOs);
		returnMap.put("partnerContacters",partnerContacters);

		return returnMap;
	}
	
	/**
	 * 
	* @Title: getMapPurchaseOrderDetailForUpdate 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return HashMap<String,Object>
	* @throws 
	* @Description:查询采购订单和订单详情
	 */
	public HashMap<String, Object> getMapPurchaseOrderDetailForUpdate(PageData pd) throws Exception{
		HashMap<String, Object> returnMap = new HashMap<String,Object>();
		PurchaseOrder purchaseOrder = this.selectOnePurchaseOrder(pd);
		purchaseOrder.setChangedTime(null);
		purchaseOrder.setCreateTime(null);
		String businessTypes = purchaseOrder.getBusinessType();
		if (StringUtil.isNotEmpty(businessTypes)) {
			List<String> list = Tools.strArray2List(Tools.str2StrArray(businessTypes));
			for(int i=0;i<list.size();i++){
				returnMap.put(list.get(i).toString(),orderConfigService.getOneBusinessTypeVO(pd.getString("industryId"), list.get(i).toString()));
			}
		}
		Page page = new Page();
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		page.setPd(pd);
		List<PurchaseOrderDetail> purchaseOrderDetails = this.listPagePurchaseOrderDetail(page);
		for (PurchaseOrderDetail purchaseOrderDetail : purchaseOrderDetails) {
			purchaseOrderDetail.setCreateTime(null);
		}
		returnMap.put("purchaseOrder",purchaseOrder);
		returnMap.put("purchaseOrderDetail",purchaseOrderDetails);
		
		return returnMap;
	}
	
	/**
	 * 
	* @Title: insertOnePurchaseOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条采购订单
	 */
	public void insertOnePurchaseOrder(PurchaseOrder record) throws Exception{
		purchaseOrderMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListPurchaseOrder 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增采购订单
	 */
	public void insertListPurchaseOrder(List<PurchaseOrder> records) throws Exception{
		purchaseOrderMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updatePurchaseOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新采购订单
	 */
	public void updatePurchaseOrder(PurchaseOrder record) throws Exception{
		purchaseOrderMapper.updateByPrimaryKeySelective(record);
	}
	public void updatePurchaseOrderByMapPara(PageData pd) throws Exception{
		purchaseOrderMapper.updateByMapPara(pd);
	}
	
	/**
	 * 
	* @Title: deletePurchaseOrder 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除采购订单
	 */
	public int deletePurchaseOrder(PageData pd) throws Exception{
		return purchaseOrderMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: selectOnePurchaseOrderDetail 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return PurchaseOrderDetail
	* @throws 
	* @Description: 查询单条采购订单明细
	 */
	public PurchaseOrderDetail selectOnePurchaseOrderDetail(PageData pd) throws Exception{
		PurchaseOrderDetail pod = purchaseOrderDetailMapper.selectByPrimaryKey(pd);
		pod.setPriceWayDesc(orderConfigService.formatPriceWay(pod.getPriceWay()));
		return pod;
	}

	/**
	 * 
	* @Title: selectListByPrimaryKey 
	* @param pd
	* @return
	* @return List<PurchaseOrderDetail>
	* @throws 
	* @Description: 采购单详情数据
	 */
	public List<PurchaseOrderDetail> selectListByPrimaryKey(PageData pd){
		List<PurchaseOrderDetail> list = purchaseOrderDetailMapper.selectListByPrimaryKey(pd);
		for (PurchaseOrderDetail detail : list) {
			detail.setPriceWayDesc(orderConfigService.formatPriceWay(detail.getPriceWay()));	
			detail.setTotalArea(detail.getLength().multiply(detail.getWidth()).multiply(detail.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			if ("1".equalsIgnoreCase(detail.getIsUrgent())) {
				detail.setWorkingStatus(detail.getWorkingStatus()+"<span class='plistmarkSale'></span>");
			}
		}
		return list;
	}

	/**
	 * 
	* @Title: listPagePurchaseOrderDetail 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<PurchaseOrderDetail>
	* @throws 
	* @Description: 查询带分页的采购订单明细
	 */
	public List<PurchaseOrderDetail> listPagePurchaseOrderDetail(Page page) throws Exception{
		List<PurchaseOrderDetail> pods = purchaseOrderDetailMapper.listPagePurchaseOrderDetail(page);
		if(pods!=null&&pods.size()>0){
			for(PurchaseOrderDetail pod : pods){
//				if(Const.ORDER_PRICE_WAY_01.equalsIgnoreCase(sod.getPriceWay())){
					pod.setTotalArea(pod.getWidth().multiply(pod.getLength()).multiply(pod.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
					pod.setPriceWayDesc(orderConfigService.formatPriceWay(pod.getPriceWay()));
//				}
			}
		}
		
		return pods;
		
	}
	
	/**
	 * 
	* @Title: insertOnePurchaseOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	public void insertOnePurchaseOrderDetail(PurchaseOrderDetail record) throws Exception{
		purchaseOrderDetailMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListPurchaseOrderDetail 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增采购订单明细
	 */
	public void insertListPurchaseOrderDetail(List<PurchaseOrderDetail> records) throws Exception{
		purchaseOrderDetailMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updatePurchaseOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新采购订单明细
	 */
	public void updatePurchaseOrderDetail(PurchaseOrderDetail record) throws Exception{
		purchaseOrderDetailMapper.updateByPrimaryKeySelective(record);
	}
	
	public void updatePurchaseOrderDetailByMapPara(PageData pd){
		purchaseOrderDetailMapper.updateByMapPara(pd);
	}
	
	/**
	 * 
	* @Title: deletePurchaseOrderDetail 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除采购订单明细
	 */
	public void deletePurchaseOrderDetail(PageData pd) throws Exception{
		purchaseOrderDetailMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: selectOnePurchaseCheckingOrder 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return PurchaseCheckingOrder
	 * @throws Exception 
	* @throws 
	* @Description: 查询单条采购对账单
	 */
	public PurchaseCheckingOrder selectOnePurchaseCheckingOrder(PageData pd) throws Exception{
		PurchaseCheckingOrder purchasecheckingOrder = purchaseCheckingOrderMapper.selectByPrimaryKey(pd);
		if(purchasecheckingOrder!=null){
			purchasecheckingOrder.setOrderStatusDesc(orderConfigService.formatOrderStatus(purchasecheckingOrder.getOrderStatus()));
			pd.put("comKey", purchasecheckingOrder.getComKey());
			purchasecheckingOrder.setComName(companyService.getCompanyByKey(pd).getComName());
			
			pd.put("partnerKey", purchasecheckingOrder.getPartnerKey());
			pd.put("contacterId", purchasecheckingOrder.getContactId());
			if (StringUtil.isEmpty(purchasecheckingOrder.getSalescheckingNo())) { //非协同
				PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
				if (contacter!=null) {
					purchasecheckingOrder.setContactTel(contacter.getTel1());
				}
			}else {
				//协同的采购单显示联系人和手机号取销售方的管理员信息
				PartnerVO partnerVO = partnerService.selectOneComPartnerAndPartnerInfo(pd);
				if (partnerVO!=null) {
					EmployeeVo employeeVo = employeeService.getAdmin(partnerVO.getPartnerComKey());
					if (employeeVo!=null) {
						purchasecheckingOrder.setContactName(employeeVo.getUserName());
						purchasecheckingOrder.setContactTel(employeeVo.getUserId());
					}
				}
			}
		}
		return purchasecheckingOrder;
	}
	
	/**
	 * 
	* @Title: listPagePurchaseCheckingOrder 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<PurchaseCheckingOrder>
	* @throws 
	* @Description: 查询带分页的采购对账单
	 */
	public List<PurchaseCheckingOrder> listPagePurchaseCheckingOrder(Page page) throws Exception{
		return purchaseCheckingOrderMapper.listPagePurchaseCheckingOrder(page);
	}
	public List<PurchaseCheckingOrder> listPagePurchaseCheckingOrderConcat(Page page) throws Exception{
		return purchaseCheckingOrderMapper.listPagePurchaseCheckingOrderConcat(page);
	}
	
	public List<AllPurchaseCheckingOrderVO> listPageTotalPurchaseCheckingOrder(Page page) throws Exception{
		List<AllPurchaseCheckingOrderVO> allvos = purchaseCheckingOrderMapper.listPageTotalPurchaseCheckingOrder(page);
		for (AllPurchaseCheckingOrderVO vo : allvos) {
			vo.setOrderStatusDesc(orderConfigService.formatOrderStatus(vo.getOrderStatus()));
			vo.setPrice(vo.getPrice().subtract(vo.getDiscount()).subtract(vo.getPreferential()).setScale(2, BigDecimal.ROUND_HALF_UP));
		}
		return allvos;
	}
	
	/**
	 * 
	* @Title: insertOnePurchaseCheckingOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条采购对账单
	 */
	public void insertOnePurchaseCheckingOrder(PurchaseCheckingOrder record) throws Exception{
		purchaseCheckingOrderMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListPurchaseCheckingOrder 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增采购对账单
	 */
	public void insertListPurchaseCheckingOrder(List<PurchaseCheckingOrder> records) throws Exception{
		purchaseCheckingOrderMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updatePurchaseCheckingOrder 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新采购对账单
	 */
	public Integer updatePurchaseCheckingOrder(PurchaseCheckingOrder record){
		return purchaseCheckingOrderMapper.updateByPrimaryKeySelective(record);
	}
	
	/**
	 * 
	* @Title: deletePurchaseCheckingOrder 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除采购对账单
	 */
	public void deletePurchaseCheckingOrder(PageData pd) throws Exception{
		purchaseCheckingOrderMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: selectOnePurchaseCheckingOrderDetail 
	* @param @param pd
	* @param @return
	* @param @throws Exception
	* @return PurchaseCheckingOrderDetail
	* @throws 
	* @Description: 查询单条采购对账单明细
	 */
	public PurchaseCheckingOrderDetail selectOnePurchaseCheckingOrderDetail(PageData pd) throws Exception{
		PurchaseCheckingOrderDetail pcod = purchaseCheckingOrderDetailMapper.selectByPrimaryKey(pd);
		pcod.setPriceWayDesc(orderConfigService.formatPriceWay(pcod.getPriceWay()));
		return pcod;
	}

	/**
	 * 
	 * @Title: listPurchaseCheckingOrderDetailByPrimaryKeyPCO 
	 * @param pd
	 * @return
	 * @return List<TotalPurchaseCheckingOrderDetailVO>
	 * @throws 
	 * @Description: 根据参数查询采购对账单详情
	 */
	public List<TotalPurchaseCheckingOrderDetailVO> listPurchaseCheckingOrderDetailByPrimaryKeyPCO(PageData pd){
		List<TotalPurchaseCheckingOrderDetailVO> pcodetails = purchaseCheckingOrderDetailMapper.selectPurchasecheckingOrderDetailVO(pd);
		
		for (TotalPurchaseCheckingOrderDetailVO pcodetail : pcodetails) {
			pcodetail.setPriceWayDesc(orderConfigService.formatPriceWay(pcodetail.getPriceWay()));
			//计算面积
			pcodetail.setTotalArea(pcodetail.getWidth().multiply(pcodetail.getLength()).multiply(pcodetail.getQuantity())
					.setScale(2, BigDecimal.ROUND_HALF_UP));
			//拼装规格尺寸
			if (pcodetail.getLength().compareTo(BigDecimal.ZERO)==0
					&&pcodetail.getWidth().compareTo(BigDecimal.ZERO)==0) {
				pcodetail.setSpecification("");
			}else{
				pcodetail.setSpecification(pcodetail.getLength()+" * "+pcodetail.getWidth());
			}
		}
		return pcodetails;
	}

	/**
	 * 
	* @Title: listPurchaseCheckingOrderDetail 
	* @param @param page
	* @param @return
	* @param @throws Exception
	* @return List<PurchaseCheckingOrderDetail>
	* @throws 
	* @Description: 查询带分页的采购对账单明细
	 */
	public List<PurchaseCheckingOrderDetail> listPagePurchaseCheckingOrderDetail(Page page) throws Exception{
		List<PurchaseCheckingOrderDetail> pcods = purchaseCheckingOrderDetailMapper.listPagePurchaseCheckingOrderDetail(page);
		if(pcods!=null&&pcods.size()>0){
			for(PurchaseCheckingOrderDetail pcod : pcods){
//				if(Const.ORDER_PRICE_WAY_01.equalsIgnoreCase(sod.getPriceWay())){
//					pod.setTotalArea(pod.getWidth().multiply(pod.getLength()).multiply(pod.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
				pcod.setPriceWayDesc(orderConfigService.formatPriceWay(pcod.getPriceWay()));
//				}
			}
		}
		return pcods;
	}
	
	/**
	 * 
	* @Title: insertOnePurchaseCheckingOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 新增单条采购对账单明细
	 */
	public void insertOnePurchaseCheckingOrderDetail(PurchaseCheckingOrderDetail record) throws Exception{
		purchaseCheckingOrderDetailMapper.insertSelective(record);
	}
	
	/**
	 * 
	* @Title: insertListPurchaseCheckingOrderDetail 
	* @param @param records
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 批量新增采购对账单明细
	 */
	public void insertListPurchaseCheckingOrderDetail(List<PurchaseCheckingOrderDetail> records) throws Exception{
		purchaseCheckingOrderDetailMapper.insertList(records);
	}
	
	/**
	 * 
	* @Title: updatePurchaseCheckingOrderDetail 
	* @param @param record
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 更新采购对账单明细
	 */
	public void updatePurchaseCheckingOrderDetail(PurchaseCheckingOrderDetail record) throws Exception{
		purchaseCheckingOrderDetailMapper.updateByPrimaryKey(record);
	}
	
	/**
	 * 
	* @Title: deletePurchaseCheckingOrderDetail 
	* @param @param pd
	* @param @throws Exception
	* @return void
	* @throws 
	* @Description: 删除采购对账单明细
	 */
	public void deletePurchaseCheckingOrderDetail(PageData pd) throws Exception{
		purchaseCheckingOrderDetailMapper.deleteByPrimaryKey(pd);
	}


	/**
	 * 收货操作
	 * @return
	 */
	public Map<String,Object> updateReceivingOperation(String purchaseNo, UserVo userVo) throws Exception{
		Map<String,Object> objectMap = new HashMap<>();
		//1.查询该条协同采购订单
		PageData pdp = new PageData();
		pdp.put("comKey",userVo.getComKey());
		pdp.put("purchaseNo",purchaseNo);
		PurchaseOrder purchaseOrder = purchaseOrderMapper.selectByPrimaryKey(pdp);
		//2.查询对应的销售订单
		String saleNo = purchaseOrder.getSalesNo();
		if(saleNo == null || "".equals(saleNo)){
			objectMap.put("status","0");
			objectMap.put("msg","该采购单非协同");
		}

		String partnerKey =	purchaseOrder.getPartnerKey();
		PageData pd = new PageData();
		pd.put("partnerKey",partnerKey);
		Partner partner = partnerService.findPartner(pd);

		PageData pds = new PageData();
		pds.put("comKey",partner.getPartnerComKey());
		pds.put("salesNo",saleNo);
		SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pds);

		if(purchaseOrder != null && salesOrder != null ){
			purchaseOrder.setOrderStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
			purchaseOrder.setChangedTime(new Date());
			purchaseOrderMapper.updateByPrimaryKeySelective(purchaseOrder);
			salesOrder.setOrderStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
			salesOrder.setChangedTime(new Date());
			salesOrderService.updateSalesOrder(salesOrder);
		}
		objectMap.put("status","1");
		objectMap.put("msg","success");
		return objectMap;
	}
	
	/**
	 * 
	* @Title: updateBatchByPurchaseNoIn 
	* @param pd changeTime, orderStatus, List<String> purchaseNo
	* @return
	* @return int
	* @throws 
	* @Description: 批量更新采购单
	 */
	public int updateBatchByPurchaseNoIn(PageData pd){
		return purchaseOrderMapper.updateBatchByPurchaseNoIn(pd);
	}
	
	/**
	 * 
	* @Title: updateBatchDetailByPurchaseNoIn 
	* @param pd orderStatus, List<String> purchaseNo
	* @return
	* @return int
	* @throws 
	* @Description: 批量更新采购单明细
	 */
	public int updateBatchDetailByPurchaseNoIn(PageData pd) throws Exception{
		return purchaseOrderDetailMapper.updateBatchDetailByPurchaseNoIn(pd);
	}

	/**
	 * 
	* @Title: updateBatchByPurchaseCheckingNoIn 
	* @param pd orderStatus, List<String> purchasecheckingNo, invoiceStatus, changedTime
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 批量更新采购对账单
	 */
	public int updateBatchByPurchaseCheckingNoIn(PageData pd) throws Exception{
		return purchaseCheckingOrderMapper.updateBatchByPurchaseCheckingNoIn(pd);
	}
	/**
	 * 
	* @Title: updateBatchDetailByPurchaseCheckingNoIn 
	* @param pd orderStatus, List<String> purchasecheckingNo, invoiceStatus
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 批量更新采购对账单明细
	 */
	public int updateBatchDetailByPurchaseCheckingNoIn(PageData pd) throws Exception{
		return purchaseCheckingOrderDetailMapper.updateBatchDetailByPurchaseCheckingNoIn(pd);
	}
	
	// 获取采购订单列表的合计金额、订单数统计
	private OrderTotalVO getSumTotalPricePurchaseOrder(PageData pd) throws Exception{
		return purchaseOrderMapper.selectSumPurchaseOrder(pd);
	}
	// 获取采购订单明细的合计数
	private Integer getCountPurchaseOrderDetail(PageData pd) throws Exception{
		return purchaseOrderDetailMapper.getCountOrderDetail(pd);
	}
	
	// 获取采购对账单列表的合计金额、订单数统计
	private OrderTotalVO getSumTotalPricePurchaseCheckingOrder(PageData pd) throws Exception{
		return purchaseCheckingOrderMapper.selectSumPurchaseCheckingOrder(pd);
	}
	// 获取采购对账单明细的合计数
	private Integer getCountPurchaseCheckingOrderDetail(PageData pd) throws Exception{
		return purchaseCheckingOrderDetailMapper.getCountOrderDetail(pd);
	}
	
	/**
	 * 
	 * @Title: getSumTotalVO 
	 * @param pd
	 * @param type
	 * @return
	 * @throws Exception
	 * @return OrderTotalVO
	 * @throws 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 */
	public OrderTotalVO getSumTotalVO(PageData pd,String type) throws Exception{
		OrderTotalVO orderTotalVO = null;
		
		if(OrderEnum.TYPE_PURCHASEORDER.getCode().equalsIgnoreCase(type)){ //采购订单
			orderTotalVO = this.getSumTotalPricePurchaseOrder(pd);
		}else if(OrderEnum.TYPE_PURCHASECHECKINGORDER.getCode().equalsIgnoreCase(type)){ //采购对账单
			orderTotalVO = this.getSumTotalPricePurchaseCheckingOrder(pd);
		}
		orderTotalVO.setSumTotalPrice(orderTotalVO.getSumTotalPrice()==null?BigDecimal.ZERO:orderTotalVO.getSumTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP));
		
		return orderTotalVO;
	}
	
	
	/**
	 * 
	* @Title: getSumTotalVO 
	* @param pd type: 01 协同订单 02 协同对账单 
	* 				  05 外协采购订单 06 外协采购对账单
	* @param type
	* @return
	* @throws Exception
	* @return OrderTotalVO
	* @throws 
	* @Description: 统计订单合计数，包括订单记录数，合计金额，合计明细数
	 */
//	public OrderTotalVO getSumTotalVO(PageData pd,String type) throws Exception{
//		OrderTotalVO orderTotalVO = null;
//		
//		if(OrderEnum.TYPE_SYNCHRO_ORDER.getCode().equalsIgnoreCase(type)){ // 协同订单
//			pd.put("isSynchro", "1");
//			orderTotalVO = this.getSumTotalPricePurchaseOrder(pd);
//			orderTotalVO.setOrderDetailCount(this.getCountPurchaseOrderDetail(pd));
//		}else if(OrderEnum.TYPE_SYNCHRO_CHECKINGORDER.getCode().equalsIgnoreCase(type)){ //协同对账单
//			pd.put("isSynchro", "1");
//			orderTotalVO = this.getSumTotalPricePurchaseCheckingOrder(pd);
//			orderTotalVO.setOrderDetailCount(this.getCountPurchaseCheckingOrderDetail(pd));
//		}else if(OrderEnum.TYPE_PURCHASEORDER.getCode().equalsIgnoreCase(type)){ //外协采购订单
//			pd.put("isSynchro", null);
//			orderTotalVO = this.getSumTotalPricePurchaseOrder(pd);
//			orderTotalVO.setOrderDetailCount(this.getCountPurchaseOrderDetail(pd));
//		}else if(OrderEnum.TYPE_PURCHASECHECKINGORDER.getCode().equalsIgnoreCase(type)){ //外协采购对账单
//			pd.put("isSynchro", null);
//			orderTotalVO = this.getSumTotalPricePurchaseCheckingOrder(pd);
//			orderTotalVO.setOrderDetailCount(this.getCountPurchaseCheckingOrderDetail(pd));
//		}
//		orderTotalVO.setSumTotalPrice(orderTotalVO.getSumTotalPrice()==null?BigDecimal.ZERO:orderTotalVO.getSumTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP));
//		
//		return orderTotalVO;
//	}
	
	/**
	 * 
	* @Title: listPageTotalPurchaseDetail 
	* @param page
	* @return
	* @throws Exception
	* @return List<TotalPurchaseOrderDetailVO>
	* @throws 
	* @Description: 带分页的混合了订单的全部采购明细列表
	 */
	public List<TotalPurchaseOrderDetailVO> listPageTotalPurchaseDetail(Page page) throws Exception{
		List<TotalPurchaseOrderDetailVO> totals = purchaseOrderDetailMapper.listPageTotalPurchaseDetail(page);
		for (TotalPurchaseOrderDetailVO detail : totals) {
			detail.setTotalArea(detail.getWidth().multiply(detail.getLength()).multiply(detail.getQuantity())
					.setScale(2, BigDecimal.ROUND_HALF_UP));
			detail.setOrderStatusDesc(orderConfigService.formatOrderStatus(detail.getOrderStatus()));
//			if(StringUtil.isNotEmpty(detail.getCaseDesc())
//					&&detail.getCaseDesc().length()>Const.ORDER_CASE_DESC_LENGTH){
//				detail.setCaseDesc(detail.getCaseDesc().substring(0, Const.ORDER_CASE_DESC_LENGTH-3)+"...");
//			}
//			if(StringUtil.isNotEmpty(detail.getBusinessDesc())
//					&&detail.getBusinessDesc().length()>Const.ORDER_BUSINESS_DESC_LENGTH){
//				detail.setBusinessDesc(detail.getBusinessDesc().substring(0, Const.ORDER_BUSINESS_DESC_LENGTH-3)+"...");
//			}
//			if(StringUtil.isNotEmpty(detail.getRemarks())
//					&&detail.getRemarks().length()>Const.ORDER_REMARKS_LENGTH){
//				detail.setRemarks(detail.getRemarks().substring(0, Const.ORDER_REMARKS_LENGTH-3)+"...");
//			}
		}
		return totals;
	}
	
	/**
	 * 采购方付款操作
	 * 1.销售方： 新建收款记录 并 修改对账单状态(已收款)
	 * 2.采购方： 如果该笔对账单为协同单 则新建付款记录 并修改对账单状态(已付款）
	 * @param userVo 当前操作人信息
	 * @param receiptPayment 销售方收款信息
	 * @return
	 * @throws Exception 
	 */
	public Integer savePayments(UserVo userVo,ReceiptPayment receiptPayment) throws Exception{
		Date nowDate = new Date();
		receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_PURCHASE.getCode());
		receiptPayment.setRecpayType("2");
		receiptPayment.setComKey(userVo.getComKey());
		receiptPayment.setIsValid("1");
		receiptPayment.setCreateTime(nowDate);
		receiptPaymentMapper.insertSelective(receiptPayment);
		
		PageData pageData = new PageData();
		pageData.put("comKey",userVo.getComKey());
		pageData.put("purchasecheckingNo",receiptPayment.getCheckingNo());
		PurchaseCheckingOrder purchaseCheckingOrder = this.selectOnePurchaseCheckingOrder(pageData);
		purchaseCheckingOrder.setPaidUp(receiptPayment.getRecpayMoney()); //本次收款金额
		purchaseCheckingOrder.setChangedTime(nowDate);
		purchaseCheckingOrder.setOrderStatus(OrderEnum.STATUS_YIFUKUAN.getCode()); //10已付款
		Integer result = this.updatePurchaseCheckingOrder(purchaseCheckingOrder);
		
		//如有协同 处理协同销售对账单
		if(StringUtil.isNotEmpty(purchaseCheckingOrder.getSalescheckingNo())){
			//查询协同的销售对账单
			pageData.clear();
			pageData.put("salescheckingNo",purchaseCheckingOrder.getSalescheckingNo());
			SalesCheckingOrder salesCheckingOrder = salesOrderService.selectOneSalesCheckingOrder(pageData);
			//协同销售对账单部分自动生成收款记录信息
			ReceiptPayment receiptPaymentPur = new ReceiptPayment();
			receiptPaymentPur.setCheckingNo(salesCheckingOrder.getSalescheckingNo());
			receiptPaymentPur.setCheckingType(OrderEnum.CHECKING_TYPE_SALES.getCode());//1 销售对账
			receiptPaymentPur.setRecpayType("1");//收款 
			receiptPaymentPur.setComKey(salesCheckingOrder.getComKey());
			receiptPaymentPur.setRecpayDate(receiptPayment.getRecpayDate());
			receiptPaymentPur.setRecpayMoney(receiptPayment.getRecpayMoney());
			receiptPaymentPur.setIsValid("1");
			receiptPaymentPur.setRecpayName(Const.SYS_AUTO_MESSAGE); //系统自动生成
			receiptPaymentPur.setCreateTime(nowDate);
			receiptPaymentMapper.insertSelective(receiptPayment);
			
			salesCheckingOrder.setPaidUp(receiptPayment.getRecpayMoney()); //本次付款金额
			salesCheckingOrder.setOrderStatus(OrderEnum.STATUS_YISHOUKUAN.getCode()); //销售对账单 08已收款
			salesCheckingOrder.setChangedTime(nowDate);
			salesOrderService.updateSalesCheckingOrder(salesCheckingOrder);
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: deletePurchaseOrderAndDetails 
	 * @param comKey
	 * @param purchaseNo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 根据comKey和purchaseNo删除采购订单和明细
	 */
	public int deletePurchaseOrderAndDetails(String comKey,String purchaseNo) throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("purchaseNo", purchaseNo);
		this.deletePurchaseOrderDetail(pd);
		int result = this.deletePurchaseOrder(pd);
		return result;
	}
	
	public String getOrderCycle(String purchaseOrderNoIn){
		PageData pd = new PageData();
		pd.put("purchaseOrderNoIn", purchaseOrderNoIn);
		return purchaseOrderMapper.selectOrderCycle(pd);
	}
	
	/**
	 * 
	 * @Title: getPurchaseOrderDetailGroupBusinessDesc 
	 * @param purchaseNo
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 获取采购单明细中的合并业务内容
	 */
	public String getPurchaseOrderDetailGroupBusinessDesc(String purchaseNo){
		PageData pd = new PageData();
		pd.put("purchaseNo", purchaseNo);
		return purchaseOrderDetailMapper.getGroupBusinessDesc(pd);
	}
	public String getPurchasecheckingOrderDetailGroupBusinessDesc(String purchasecheckingNo){
		PageData pd = new PageData();
		pd.put("purchasecheckingNo", purchasecheckingNo);
		return purchaseCheckingOrderDetailMapper.getGroupBusinessDesc(pd);
	}
	
	/**
	 * 
	 * @Title: cancelPurchaseOrder 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 作废采购订单
	 */
	public int cancelPurchaseOrder(PageData pd) throws Exception{
		int result = 0;
		this.updateBatchDetailByPurchaseNoIn(pd);
		result = this.updateBatchByPurchaseNoIn(pd);
		return result;
	}
	
	/**
	 * 
	 * @Title: createPurchaseOrderFromSalesOrder 
	 * @param salesNo
	 * @return
	 * @return PurchaseOrderVO
	 * @throws 
	 * @Description: 根据销售单号构造采购单及明细对象
	 */
	public PurchaseOrderVO createPurchaseOrderFromSalesOrder(String salesNo){
		PurchaseOrderVO orderVO = null;
		PageData pd = new PageData();
		pd.put("salesNo", salesNo);
		SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
		
		if (salesOrder==null) {
			return null;
		}
		Page page = new Page();
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		page.setPd(pd);
		List<SalesOrderDetail> salesOrderDetails = null;
		try {
			salesOrderDetails = salesOrderService.listPageSalesOrderDetail(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		orderVO = new PurchaseOrderVO();
		orderVO.setPurchaseOrder(this.copyDataFromSalesOrder(salesOrder));
		orderVO.setDetails(this.copyDataFromSalesOrderDetails(salesOrderDetails));
		return orderVO;
	}
	
	/**
	 * 
	 * @Title: copyDataFromSalesOrder 
	 * @param salesOrder
	 * @return
	 * @return PurchaseOrder
	 * @throws 
	 * @Description: 通过销售单构造采购单
	 */
	private PurchaseOrder copyDataFromSalesOrder(SalesOrder salesOrder){
		PurchaseOrder purchase = new PurchaseOrder();
		purchase.setCaseDesc(salesOrder.getCaseDesc());
		purchase.setFromSalesNo(salesOrder.getSalesNo());
		purchase.setOrderDate(new Date());
		return purchase;
	}
	
	/**
	 * 
	 * @Title: copyDataFromSalesOrderDetails 
	 * @param details
	 * @return
	 * @return List<PurchaseOrderDetail>
	 * @throws 
	 * @Description: 通过销售单明细构造采购单明细
	 */
	private List<PurchaseOrderDetail> copyDataFromSalesOrderDetails(List<SalesOrderDetail> details){
		PurchaseOrderDetail podDetail = null;
		List<PurchaseOrderDetail> podDetails = new ArrayList<PurchaseOrderDetail>();
		for(SalesOrderDetail orderDetail : details){
			podDetail = new PurchaseOrderDetail();
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
			podDetail.setUnitPrice(BigDecimal.ZERO);
			podDetail.setAdditionalPrice(BigDecimal.ZERO);
			podDetail.setAdditionalService(null);
			podDetail.setPreferential(BigDecimal.ZERO);
			podDetail.setTotalPrice(BigDecimal.ZERO);
			podDetail.setRemarks(orderDetail.getRemarks());
			podDetails.add(podDetail);
		}
		return podDetails;
	}
	
	//协同采购单收货，记录协同采购单的收货状态和收货时间，同时更新销售单被收货及被收货日期
	public int updateDelivery(PageData pd) throws Exception{
		Date nowDate = new Date();
		PurchaseOrder purchaseOrder = this.selectOnePurchaseOrder(pd);
		if (purchaseOrder==null||StringUtil.isEmpty(purchaseOrder.getSalesNo())) {
			return 0;
		}
		try {
			pd.put("isReceived", "1");
			pd.put("receivedTime", nowDate);
			this.updatePurchaseOrderByMapPara(pd);
			
			pd.put("salesOrderNoIn", Tools.strArray2List(Tools.StrList(purchaseOrder.getSalesNo())));
			salesOrderService.updateBatchBySalesNoIn(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new OrderException("协同采购收货失败");
		}
		
		return 1;
	}
	
	/**
	 * 
	 * @Title: insertBatchPurchaseOrderBySuppliers 
	 * @param details
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 根据供应商拆单创建多笔采购单
	 */
	public int insertBatchPurchaseOrderBySuppliers(
			List<PurchaseOrderDetail> details, PageData pd) throws Exception {
		List<String> partnerKeyList = new ArrayList<>();
		Map<String,Partner> mapSupplier = new HashMap<>();
		List<PurchaseOrderDetail> newDetails = new ArrayList<>();
		try {
			for (PurchaseOrderDetail detail : details) {
				partnerKeyList.add(detail.getSupplierKey());
			}
			pd.put("partnerKeyIns", Tools.strSqlIn(Tools.list2InString(partnerKeyList)));
			List<Partner> partners = partnerService.listPartners(pd);
			for (Partner partner : partners) {
				mapSupplier.put(partner.getPartnerKey(), partner);
			}
			if (mapSupplier.size()<=0) {
				return 0;
			}
			PurchaseOrder order = null;
			Iterator it = mapSupplier.entrySet().iterator();
			Date nowDate = new Date();
			String salesNo = pd.getString("salesNo");
			while(it.hasNext()){
				Entry entry = (Entry) it.next();
				Partner partner = (Partner) entry.getValue();
				
				order = new PurchaseOrder();
				order.setPurchaseNo(CodeBuilderUtil.getInstance().getPurchaseNo());
				order.setOrderDate(nowDate);
				order.setComKey(pd.getString("comKey"));
				order.setIndustryId(pd.getString("industryId"));
				order.setPartnerKey(entry.getKey().toString());
				order.setPartnerName(partner.getPartnerName());
				order.setPartnerShortname(partner.getPartnerShortname());
				order.setCaseDesc(pd.getString("caseDesc"));
				pd.put("partnerKey", order.getPartnerKey());
				PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
				order.setContactId(contacter.getContacterId());
				order.setContactName(contacter.getContacterName());
				order.setContactTel(contacter.getTel1());
				order.setFromSalesNo(salesNo);
				order.setOrderStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
				order.setCreateTime(nowDate);
				order.setCreator(pd.getString("userKey"));
				order.setIsDel("0");
				order.setIsValid("1");
				
				newDetails.clear();
				int itemNo = 1;
				BigDecimal sumTotalPrice = BigDecimal.ZERO;
				for (PurchaseOrderDetail detail : details) {
					if (detail.getSupplierKey()
							.equals(partner.getPartnerKey())) {
						PurchaseOrderDetail newDetail = new PurchaseOrderDetail();
						newDetail.setItemNo(itemNo++);
						newDetail.setPurchaseNo(order.getPurchaseNo());
						newDetail.setOrderStatus(order.getOrderStatus());
						newDetail.setBusinessType("00");
						newDetail.setBusinessDesc(detail.getBusinessDesc());
						newDetail.setRequirements(detail.getRequirements());
						newDetail.setSpecification(detail.getSpecification());
						newDetail.setLength(detail.getLength());
						newDetail.setWidth(detail.getWidth());
						newDetail.setPriceWay(detail.getPriceWay());
						newDetail.setQuantity(detail.getQuantity());
						newDetail.setUnit(detail.getUnit());
						newDetail.setUnitPrice(detail.getUnitPrice());
						newDetail.setTotalPrice(detail.getTotalPrice());
						sumTotalPrice = sumTotalPrice.add(newDetail.getTotalPrice()).setScale(2,BigDecimal.ROUND_HALF_UP);
						newDetail.setRemarks(detail.getRemarks());
						
						newDetail.setCreator(order.getCreator());
						newDetail.setCreateTime(order.getCreateTime());
						newDetail.setIsValid("1");
						newDetail.setIsDel("0");
						
						newDetails.add(newDetail);
					}
				}
				order.setDetailNum((short)(itemNo-1));
				order.setTotalPrice(sumTotalPrice);
				order.setPrice(sumTotalPrice);
				if (StringUtil.isNotEmpty(partner.getPartnerComKey())) { // 好友合作伙伴的
					SalesOrder salesOrder = null;
					List<SalesOrderDetail> soDetails = null;
					pd.put("salesNo", null);
					pd.put("partnerComKey",partner.getPartnerComKey()); //好友供应商的comKey
					salesOrder = this.fillInsertSalesOrder(order, pd);
					soDetails = this.fillInsertSalesOrderDetails(newDetails, salesOrder);
					salesOrderService.insertListSalesOrderDetail(soDetails);
					salesOrderService.insertOneSalesOrder(salesOrder);
				}
				
				this.insertListPurchaseOrderDetail(newDetails);
				this.insertOnePurchaseOrder(order);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new OrderException("根据供应商批量创建采购单失败");
		} finally{
			partnerKeyList.clear();
			mapSupplier.clear();
			newDetails.clear();
		}
		return 1;
	}
	
	//查询来自相同销售单创建的采购单的数量统计
	public List<PurchaseOrder> listFromSalesNoToPurchaseNoNum(PageData pd){
		return purchaseOrderMapper.listFromSalesNoToPurchaseNoNum(pd);
	}
}
