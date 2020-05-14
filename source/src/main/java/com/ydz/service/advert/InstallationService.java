/**   
 * @Title: InstallationService.java 
 * @Package com.ydz.service.advert 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 上午10:38:12 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;
import com.ydz.config.DZConfig;
import com.ydz.dao.advert.ReceiptPaymentMapper;
import com.ydz.dao.advert.SalesOrderDetailMapper;
import com.ydz.dao.assignment.InstallStandingByMapper;
import com.ydz.dao.assignment.InstallationCheckingOrderDetailMapper;
import com.ydz.dao.assignment.InstallationCheckingOrderMapper;
import com.ydz.dao.assignment.InstallationOrderDetailMapper;
import com.ydz.dao.assignment.InstallationOrderMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.ReceiptPayment;
import com.ydz.entity.assignment.InstallStandingBy;
import com.ydz.entity.assignment.InstallationCheckingOrder;
import com.ydz.entity.assignment.InstallationCheckingOrderDetail;
import com.ydz.entity.assignment.InstallationCheckingOrderVO;
import com.ydz.entity.assignment.InstallationOrder;
import com.ydz.entity.assignment.InstallationOrderAndDetailVO;
import com.ydz.entity.assignment.InstallationOrderDetail;
import com.ydz.entity.assignment.InstallationOrderVO;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.service.system.PartnerService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.EncryptUtils;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sms.SMSUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.TotalSalesOrderDetailVO;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: InstallationService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年9月20日 上午10:38:12 
 * @Description: 安装业务Service
 */

@Service
public class InstallationService {

	@Autowired private InstallStandingByMapper installStandingByMapper;
	
	@Autowired private InstallationOrderMapper installationOrderMapper;
	@Autowired private InstallationOrderDetailMapper installationOrderDetailMapper;
	
	@Autowired private InstallationCheckingOrderMapper installationCheckingOrderMapper;
	@Autowired private InstallationCheckingOrderDetailMapper installationCheckingOrderDetailMapper;
	
	@Resource private SalesOrderService salesOrderService;
	@Resource private PartnerService partnerService;
	
	@Autowired private ReceiptPaymentMapper receiptPaymentMapper;
	
	@Resource private DZConfig dzConfig;
	@Resource private RedisUtil redisUtil;
	
	public List<TotalSalesOrderDetailVO> listPageSalesOrderAndDetails(Page page){
		 List<TotalSalesOrderDetailVO> detailVOs = installationOrderMapper.listPageSalesOrderAndDetails(page);
		 for (TotalSalesOrderDetailVO detailVO : detailVOs) {
			 if(OrderEnum.PRICE_WAY_AREA.getCode().equalsIgnoreCase(detailVO.getPriceWay())){
				 detailVO.setTotalArea(detailVO.getWidth().multiply(detailVO.getLength()).multiply(detailVO.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
				}
		}
		return detailVOs;
	}
	
	public List<InstallStandingBy> listPageInstallStandingBy(Page page){
		List<InstallStandingBy> installStandingBys = installStandingByMapper.listPageInstallStandingBys(page);
		for (InstallStandingBy installStandingBy : installStandingBys) {
			installStandingBy.setStatusDesc(this.formatStatus(installStandingBy.getStatus(), "1"));
			if(OrderEnum.PRICE_WAY_AREA.getCode().equalsIgnoreCase(installStandingBy.getPriceWay())){
				installStandingBy.setTotalArea(installStandingBy.getWidth().multiply(installStandingBy.getLength()).multiply(installStandingBy.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
		}
		return installStandingBys;
	}
	
	public InstallationOrder selectOneInstallationOrder(PageData pd){
		InstallationOrder order = installationOrderMapper.selectByPrimaryKey(pd);
		pd.put("partnerKey", order.getPartnerKey());
		pd.put("contacterId", order.getContactId());
        PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
        if (contacter!=null) {
			order.setContactTel(contacter.getTel1());
		}
        return order;
	}
	
	public List<InstallationOrder> listPageInstallationOrders(Page page){
		return installationOrderMapper.listPageByPrimaryKey(page);
	}
	
	public List<InstallationOrder> listInstallationOrders(PageData pd){
		return installationOrderMapper.listOrderByPrimaryKey(pd);
	}
	
	public InstallationOrderDetail selectOneInstallationOrderDetail(PageData pd){
		return installationOrderDetailMapper.selectByPrimaryKey(pd);
	}
	
	public List<InstallationOrderDetail> listPageInstallationOrderDetails(Page page){
		List<InstallationOrderDetail> details = installationOrderDetailMapper.listPageByPrimaryKey(page);
		for (InstallationOrderDetail detail : details) {
			if(OrderEnum.PRICE_WAY_AREA.getCode().equalsIgnoreCase(detail.getPriceWay())){
				detail.setTotalArea(detail.getWidth().multiply(detail.getLength()).multiply(detail.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
		}
		return details;
	}
	public List<InstallationOrderDetail> listInstallationOrderDetails(PageData pd){
		List<InstallationOrderDetail> details = installationOrderDetailMapper.listDetailsByPrimaryKey(pd);
		return details;
	}
	
	public List<InstallationOrderVO> listPageInstallationOrderVOs(Page page){
		List<InstallationOrderVO> installationOrderVOs= installationOrderDetailMapper.listPageInstallationOrderDetailConcat(page);
		for (InstallationOrderVO orderVO : installationOrderVOs) {
			orderVO.setStatusDesc(this.formatStatus(orderVO.getStatus(), "1"));
			if(OrderEnum.PRICE_WAY_AREA.getCode().equalsIgnoreCase(orderVO.getPriceWay())){
				orderVO.setTotalArea(orderVO.getWidth().multiply(orderVO.getLength()).multiply(orderVO.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
		}
		return installationOrderVOs;
	}
	
	public OrderTotalVO getOrderTotalVO(Page page){
		return installationOrderDetailMapper.selectOrderTotalVO(page);
	}
	
	public InstallationCheckingOrder selectOneCheckingOrder(PageData pd){
		InstallationCheckingOrder order = installationCheckingOrderMapper.selectByPrimaryKey(pd);
		pd.put("partnerKey", order.getPartnerKey());
		pd.put("contacterId", order.getContactId());
        PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
        if (contacter!=null) {
			order.setContactTel(contacter.getTel1());
		}
        return order;
	}
	
	public List<InstallationCheckingOrderVO> listPageCheckingOrders(Page page){
		return installationCheckingOrderMapper.listPageCheckingOrdersConcat(page);
	}
	
	public List<InstallationCheckingOrderDetail> listPageCheckingOrderDetails(Page page){
		List<InstallationCheckingOrderDetail> details = installationCheckingOrderDetailMapper.listPageByPrimaryKey(page);
		for (InstallationCheckingOrderDetail detail : details) {
			if(OrderEnum.PRICE_WAY_AREA.getCode().equalsIgnoreCase(detail.getPriceWay())){
				detail.setTotalArea(detail.getWidth().multiply(detail.getLength()).multiply(detail.getQuantity()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
		}
		return details;
	}
	
	public ReceiptPayment selectOneReceiptPayment(PageData pd){
		return receiptPaymentMapper.selectByPrimaryKey(pd);
	}
	
	
	public int insertOneInstallStandingBy(InstallStandingBy installStandingBy){
		return installStandingByMapper.insertSelective(installStandingBy);
	}
	
	public int insertListInstallStandingBys(List<InstallStandingBy> installStandingBys){
		return installStandingByMapper.insertList(installStandingBys);
	}
	
	public int insertOneInstallationOrder(InstallationOrder installationOrder){
		return installationOrderMapper.insertSelective(installationOrder);
	}
	
	public int insertOneInstallationOrderDetail(InstallationOrderDetail installationOrderDetail){
		return installationOrderDetailMapper.insertSelective(installationOrderDetail);
	}
	
	public int insertListInstallationOrderDetails(List<InstallationOrderDetail> installationOrderDetails){
		return installationOrderDetailMapper.insertList(installationOrderDetails);
	}
	
	public int updateInstallationOrder(InstallationOrder installationOrder){
		return installationOrderMapper.updateByPrimaryKeySelective(installationOrder);
	}
	
	public int updateInstallationOrderDetail(InstallationOrderDetail installationOrderDetail){
		return installationOrderDetailMapper.updateByPrimaryKeySelective(installationOrderDetail);
	}
	
	public int deleteInstallationOrder(PageData pd){
		return installationOrderMapper.deleteByPrimaryKey(pd);
	}
	
	public int deleteInstallationOrderDetail(PageData pd){
		return installationOrderDetailMapper.deleteByPrimaryKey(pd);
	}
	
	public int updateStatusInstallStandingBy(PageData pd){
		return installStandingByMapper.updateStatusByPrimaryKey(pd);
	}
	
	public int insertOneInstallationCheckingOrder(InstallationCheckingOrder checkingOrder){
		return installationCheckingOrderMapper.insertSelective(checkingOrder);
	}
	
	public int insertListInstallationCheckingOrderDetail(List<InstallationCheckingOrderDetail> checkingOrderDetails){
		return installationCheckingOrderDetailMapper.insertList(checkingOrderDetails);
	}
	
	public int updateInstallationCheckingOrder(InstallationCheckingOrder checkingOrder){
		return installationCheckingOrderMapper.updateByPrimaryKey(checkingOrder);
	}
	
	/**
	 * 
	 * @Title: getOrderAndDetailSimple 
	 * @param pd
	 * @return
	 * @return InstallationOrderAndDetailVO
	 * @throws 
	 * @Description: 简洁的安装单及安装单明细查询，用于修改页面
	 */
	public InstallationOrderAndDetailVO getOrderAndDetailSimple(PageData pd){
		InstallationOrderAndDetailVO orderVo = null;
		InstallationOrder order = this.selectOneInstallationOrder(pd);
		if (order==null) {
			return null;
		}
		orderVo = new InstallationOrderAndDetailVO();
		Page page = new Page();
		page.setShowCount(Const.PAGE_SIZE_DETAIL);
		page.setPd(pd);
		List<InstallationOrderDetail> details = this.listPageInstallationOrderDetails(page);
		orderVo.setOrder(order);
		orderVo.setDetails(details);
		return orderVo;
	}
	
	/**
	 * 
	 * @Title: insertFromSalesOrderDetailToInstallStandingBy 
	 * @param userVo
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 将勾选的单号选择的记录插入待安装列表
	 */
	public int insertFromSalesOrderDetailToInstallStandingBy(UserVo userVo,PageData pd) 
			throws Exception{
		String comKey = userVo.getComKey();
		String detailUid = pd.getString("detailUid");
		pd.put("comKey", comKey);
		pd.put("detailUid", Tools.strSqlIn(detailUid));
		Page page = new Page();
		page.setCurrentPage(0);
		page.setShowCount(1000);
		page.setPd(pd);
		List<TotalSalesOrderDetailVO> detailVOs = this.listPageSalesOrderAndDetails(page);
		if (detailVOs.size()<=0) {
			return 0;
		}
		List<InstallStandingBy> installStandingByList = new ArrayList<>();
		InstallStandingBy installStandingBy = null;
		Date nowDate = new Date();
		for (TotalSalesOrderDetailVO totalSalesOrderDetailVO : detailVOs) {
			installStandingBy = new InstallStandingBy();
			BeanutilsCopy.apacheCopyProperties(installStandingBy, totalSalesOrderDetailVO);
			
			installStandingBy.setIsValid("1");
			installStandingBy.setIsDel("0");
			installStandingBy.setSalesCreateTime(totalSalesOrderDetailVO.getCreateTime());
			installStandingBy.setStatus(AssignEnum.INSTALLATION_STATUS_NO.getCode());
			installStandingBy.setCreator(userVo.getUserKey());
			installStandingBy.setCreateTime(nowDate);
			installStandingByList.add(installStandingBy);
		}
		
		return installStandingByMapper.insertList(installStandingByList);
	}
	
	/**
	 * 
	 * @Title: insertNewInstallationOrder 
	 * @param orderVO
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 新建安装工单
	 */
	public int insertNewInstallationOrder(InstallationOrderAndDetailVO orderVO,UserVo userVo) 
			throws Exception{
		Date nowDate = new Date();
		InstallationOrder order = orderVO.getOrder();
		List<InstallationOrderDetail> details = orderVO.getDetails();
		
		order.setInstallationNo(CodeBuilderUtil.getInstance().getOrderId("AZ", 8));
		order.setComKey(userVo.getComKey());
		order.setIndustryId(userVo.getDetailIndustryId());
		order.setCreator(userVo.getUserKey());
		order.setCreateTime(nowDate);
		order.setStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
		order.setIsValid("1");
		order.setIsDel("0");
		
		int item = 1;
		BigDecimal totalPriceDetail = BigDecimal.ZERO;
		List<String> detailUids = new ArrayList<>();
		for (InstallationOrderDetail detail : details) {
			detail.setSalesOrderItem(detail.getItemNo());
			detail.setInstallationNo(order.getInstallationNo());
			detail.setIsValid("1");
			detail.setIsDel("0");
			detail.setCreator(order.getCreator());
			detail.setCreateTime(order.getCreateTime());
			detail.setBusinessDesc(detail.getBusinessDesc() == null ? "" : detail.getBusinessDesc());
			detail.setRequirements(detail.getRequirements() == null ? "" : detail.getRequirements());
			detail.setSpecification(detail.getLength()+" * "+detail.getWidth());
			totalPriceDetail = totalPriceDetail.add(detail.getTotalPrice()); //累加行项目合计金额
			detailUids.add(detail.getUid().toString());
			detail.setItemNo(item++);
		}
		
		BigDecimal totalPrice = order.getTotalPrice().setScale(2, BigDecimal.ROUND_HALF_UP);
		if (totalPrice.compareTo(totalPriceDetail.setScale(2, BigDecimal.ROUND_HALF_UP))!=0) {
			return 0;
		}
		//安装金额 = 行项目合计-行项目合计*折扣比例-减免
		BigDecimal installationPrice = totalPriceDetail.subtract(order.getDiscount().setScale(2, BigDecimal.ROUND_HALF_UP))
				.subtract(order.getPreferential().setScale(2, BigDecimal.ROUND_HALF_UP)).setScale(2, BigDecimal.ROUND_HALF_UP);
		if (installationPrice.compareTo(order.getInstallationPrice().setScale(2, BigDecimal.ROUND_HALF_UP))!=0) { //判断金额计算是否与页面一致
			return 0;
		}
		
		this.insertListInstallationOrderDetails(details);
		int result = this.insertOneInstallationOrder(order);
		if (result>0) {
			//短信提醒安装工查看安装单
			PageData pd = new PageData();
			pd.put("partnerKey", order.getPartnerKey());
			pd.put("contactId", order.getContactId());
			PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
			if (contacter!=null) {
				String shortCode = CodeBuilderUtil.getInstance().getShortUrlCode(6);
				String shareUrl = dzConfig.webPath+"/ordershare/installation-list-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
                		order.getIndustryId()+"-"+order.getInstallationNo()+"-"+order.getComKey());
                redisUtil.setIntervalDay(shortCode, shareUrl, 90);
				SMSUtil.notifyInstallationOrderForInstaller(contacter.getTel1(), order.getInstallationNo(), shortCode);
			}
		}
		PageData pd = new PageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("status", AssignEnum.INSTALLATION_STATUS_YES.getCode());
		pd.put("detailUids", Tools.strSqlIn(Tools.list2InString(detailUids)));
		this.updateStatusInstallStandingBy(pd);
		return result;
	}
	
	public int updateInstallationOrderAndDetail(InstallationOrderAndDetailVO orderVO,UserVo userVo)
			throws Exception{
		Date nowDate = new Date();
		InstallationOrder order = orderVO.getOrder();
		order.setComKey(userVo.getComKey());
		order.setIndustryId(userVo.getDetailIndustryId());
		order.setStatus(OrderEnum.STATUS_DAIDUIZHANG.getCode());
		order.setCreator(userVo.getUserKey());
		order.setCreateTime(nowDate);
		order.setIsValid("1");
		order.setIsDel("0");
		
		
		List<InstallationOrderDetail> details = orderVO.getDetails();
		int item = 1;
		for (InstallationOrderDetail detail : details) {
			detail.setItemNo(item++);
			detail.setInstallationNo(order.getInstallationNo());
			detail.setCreator(order.getCreator());
			detail.setCreateTime(order.getCreateTime());
			detail.setBusinessDesc(detail.getBusinessDesc() == null ? "" : detail.getBusinessDesc());
			detail.setRequirements(detail.getRequirements() == null ? "" : detail.getRequirements());
			detail.setSpecification(detail.getLength()+" * "+detail.getWidth());
			detail.setIsValid("1");
			detail.setIsDel("0");
		}
		PageData pd = new PageData();
		pd.put("installationNo", order.getInstallationNo());
		int result = this.deleteInstallationOrderDetail(pd);
		if (result<=0) {
			return 0;
		}
		this.insertListInstallationOrderDetails(details);
		result = this.updateInstallationOrder(order);
		if (result<=0) {
			throw new RuntimeException();
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: cancelInstallationOrder 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 作废安装工单
	 */
	public int cancelInstallationOrder(PageData pd) throws Exception{
		return  installationOrderMapper.updateStatusByPrimaryKey(pd);
	}
	
	private String formatStatus(String code,String type){
		String desc = null;
		if("1".equals(type)){ //安装状态
			switch (code) {
			case "0":
				desc = AssignEnum.INSTALLATION_STATUS_NO.getDesc();
				break;
			case "1":
				desc = AssignEnum.INSTALLATION_STATUS_YES.getDesc();
				break;
			default:
				desc = AssignEnum.INSTALLATION_STATUS_NO.getDesc();
				break;
			}
		}
		
		return desc;
	}
	
//===============================================================	安装对账单
	
	/**
	 * 
	 * @Title: createInstallationChecking 
	 * @param pd
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 生成安装对账单
	 * 1.构造对账单
	 * 2.构造对账单明细
	 * 3.修改安装单状态为已对账
	 */
	public int createInstallationChecking(PageData pd) throws Exception{
		List<InstallationOrder> orders = this.listInstallationOrders(pd);
		if (orders==null||orders.size()<=0) {
			return 0;
		}
		//构造安装对账单
		InstallationOrderVO orderVO = installationOrderMapper.getSumMoneyByPrimaryKey(pd);
		//应付金额 = 安装总金额-预付总金额
		BigDecimal payablePrice = BigDecimal.ZERO;
		if (StringUtil.isEmpty(pd.getString("payablePrice"))) {
			payablePrice = BigDecimal.ZERO;
		}else{
			payablePrice = new BigDecimal(pd.getString("payablePrice")).setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		BigDecimal payablePriceCalc = orderVO.getSumInstallationPrice().subtract(orderVO.getSumPrepayPrice()==null?BigDecimal.ZERO:orderVO.getSumPrepayPrice()).setScale(2, BigDecimal.ROUND_HALF_UP);
		if (payablePrice.compareTo(payablePriceCalc)!=0) {
			return 0;
		}
		InstallationCheckingOrder checkingOrder = this.fillDataForCheckingOrder(orders,orderVO,pd);
		
		//构造安装对账单明细
		List<InstallationOrderDetail> details = this.listInstallationOrderDetails(pd);
		List<InstallationCheckingOrderDetail> checkingOrderDetails = this.fillDataCheckingOrderDetails(details,checkingOrder);
		
		checkingOrder.setPayablePrice(payablePrice);
		checkingOrder.setDetailNum(details.size());
		
		this.insertListInstallationCheckingOrderDetail(checkingOrderDetails);
		int result = this.insertOneInstallationCheckingOrder(checkingOrder);
		
		pd.put("status", OrderEnum.STATUS_YIDUIZHANG.getCode());
		result = installationOrderMapper.updateStatusByPrimaryKey(pd);
		
		//判断是否需要发送短信给安装工查看安装结算单
		if ("1".equalsIgnoreCase(pd.getString("isSms"))) {
			pd.clear();
			pd.put("partnerKey", checkingOrder.getPartnerKey());
			pd.put("contactId", checkingOrder.getContactId());
			PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
			if (contacter!=null) {
				String shortCode = CodeBuilderUtil.getInstance().getShortUrlCode(6);
				String shareUrl = dzConfig.webPath+"/ordershare/installation-checking-list-detail-share.html?key1="+EncryptUtils.getInstance().encryptDESByKey(
						checkingOrder.getIndustryId()+"-"+checkingOrder.getInstallationcheckingNo()+"-"+checkingOrder.getComKey());
                redisUtil.setIntervalDay(shortCode, shareUrl, 90);
				SMSUtil.notifyInstallationCheckingOrderForInstaller(contacter.getTel1(), checkingOrder.getInstallationcheckingNo(), shortCode);
			}
		}
		
		if(result<=0){
			throw new RuntimeException("生成安装对账单失败");
		}
		return result;
	}
	
	private InstallationCheckingOrder fillDataForCheckingOrder(List<InstallationOrder> orders,InstallationOrderVO orderVO,PageData pd){
		List<String> installationNoList = new ArrayList<>();
		InstallationOrder order = orders.get(0);
		for (InstallationOrder installationOrder : orders) {
			installationNoList.add(installationOrder.getInstallationNo());
		}
		InstallationCheckingOrder checkingOrder = new InstallationCheckingOrder();
		BeanutilsCopy.apacheCopyProperties(checkingOrder, order);
		checkingOrder.setUid(null);
		checkingOrder.setComKey(pd.getString("comKey"));
		checkingOrder.setInstallationcheckingNo(CodeBuilderUtil.getInstance().getOrderId("AC", 8));
		checkingOrder.setStatus(OrderEnum.STATUS_DAIFUKUAN.getCode()); //待付款
		checkingOrder.setOrderDate(new Date());
		checkingOrder.setCaseDesc("多笔");
		checkingOrder.setCreateTime(new Date());
		checkingOrder.setCreator(pd.getString("userKey"));
		checkingOrder.setIsValid("1");
		checkingOrder.setIsDel("0");
		checkingOrder.setOrderCycle(orderVO.getOrderCycle());
		checkingOrder.setInstallationOrderNum(orders.size());
		checkingOrder.setInstallationNo(Tools.list2InString(installationNoList));
		
		checkingOrder.setDiscount(orderVO.getSumDiscount());
		checkingOrder.setPreferential(orderVO.getPreferential());
		checkingOrder.setPrepayPrice(orderVO.getSumPrepayPrice());
		checkingOrder.setTotalPrice(orderVO.getSumTotalPrice());
		checkingOrder.setInstallationPrice(orderVO.getSumInstallationPrice());
		
		return checkingOrder;
	}
	
	private List<InstallationCheckingOrderDetail> fillDataCheckingOrderDetails(List<InstallationOrderDetail> details, InstallationCheckingOrder checkingOrder){
		checkingOrder.setDetailNum(details.size());
		List<InstallationCheckingOrderDetail> checkingOrderDetails = new ArrayList<>();
		InstallationCheckingOrderDetail checkingOrderDetail = null;
		int item = 1;
		for (InstallationOrderDetail detail : details) {
			checkingOrderDetail = new InstallationCheckingOrderDetail();
			BeanutilsCopy.apacheCopyProperties(checkingOrderDetail, detail);
			checkingOrderDetail.setUid(null);
			checkingOrderDetail.setItemNo(item++);
			checkingOrderDetail.setInstallationcheckingNo(checkingOrder.getInstallationcheckingNo());
			checkingOrderDetail.setInstallationNo(detail.getInstallationNo());
			checkingOrderDetail.setInstallationOrderItem(detail.getItemNo());
			checkingOrderDetail.setInstallationOrderDate(detail.getInstallationOrderDate());
			checkingOrderDetail.setIsValid("1");
			checkingOrderDetail.setIsDel("0");
			checkingOrderDetail.setCreator(checkingOrder.getCreator());
			checkingOrderDetail.setCreateTime(checkingOrder.getCreateTime());
			checkingOrderDetails.add(checkingOrderDetail);
		}
		return checkingOrderDetails;
	}
	
	public int saveReceivables(String comKey,ReceiptPayment receiptPayment) throws Exception{
		Date nowDate = new Date();
		receiptPayment.setCheckingType(OrderEnum.CHECKING_TYPE_INSTALLATION.getCode());//3安装结算单
		receiptPayment.setComKey(comKey);
		receiptPayment.setIsValid("1");
		receiptPayment.setCreateTime(nowDate);
		int result = receiptPaymentMapper.insertSelective(receiptPayment);
		
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("installationcheckingNo", receiptPayment.getCheckingNo());
		InstallationCheckingOrder checkingOrder = this.selectOneCheckingOrder(pd);
		if(checkingOrder==null){
			throw new RuntimeException("安装结算单费用保存失败");
		}
		
		checkingOrder.setStatus(OrderEnum.STATUS_YIFUKUAN.getCode()); //已付款
		checkingOrder.setPaidUp(receiptPayment.getRecpayMoney());
		checkingOrder.setBalanceMoney(checkingOrder.getPaidUp()
				.subtract(checkingOrder.getPayablePrice()).setScale(2, BigDecimal.ROUND_HALF_UP));
		result = this.updateInstallationCheckingOrder(checkingOrder);
		
		return result;
	}
	
	public int updateReceivables(String comKey,ReceiptPayment receiptPayment) throws Exception{
		int result = receiptPaymentMapper.updateByPrimaryKeySelective(receiptPayment);
		
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("installationcheckingNo", receiptPayment.getCheckingNo());
		InstallationCheckingOrder checkingOrder = this.selectOneCheckingOrder(pd);
		if(checkingOrder==null){
			throw new RuntimeException("安装结算单费用保存失败");
		}
		checkingOrder.setPaidUp(receiptPayment.getRecpayMoney());
		checkingOrder.setBalanceMoney(checkingOrder.getPaidUp()
				.subtract(checkingOrder.getPayablePrice()).setScale(2, BigDecimal.ROUND_HALF_UP));
		result = this.updateInstallationCheckingOrder(checkingOrder);
		
		return result;
		
	}
	
}
