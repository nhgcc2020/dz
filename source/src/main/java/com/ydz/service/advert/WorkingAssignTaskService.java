package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.advert.SalesOrderDetailMapper;
import com.ydz.dao.advert.SalesOrderMapper;
import com.ydz.dao.assignment.AssignWorkingProcedureMapper;
import com.ydz.dao.assignment.AssignWorkingTaskDetailMapper;
import com.ydz.dao.assignment.AssignWorkingTaskMapper;
import com.ydz.dao.assignment.AssignWorkshopServicePriceMapper;
import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.entity.assignment.AssignWorkingProcedure;
import com.ydz.entity.assignment.AssignWorkingTask;
import com.ydz.entity.assignment.AssignWorkingTaskDetail;
import com.ydz.entity.assignment.AssignWorkingTaskDetailVO;
import com.ydz.entity.assignment.AssignWorkshopServicePrice;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.system.ComProPrice;
import com.ydz.enums.AssignEnum;
import com.ydz.enums.OrderEnum;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.TotalSalesOrderDetailVO;

/** 
 * @ClassName: WorkingAssignTaskService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月18日 下午6:06:20 
 * @Description: 制作派工Service
 */
@Service
public class WorkingAssignTaskService {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private AssignWorkingProcedureMapper assignWorkingProcedureMapper;
	@Autowired
	private AssignWorkingTaskMapper assignWorkingTaskMapper;
	@Autowired
	private AssignWorkingTaskDetailMapper assignWorkingTaskDetailMapper;
	@Autowired
	private AssignWorkshopServicePriceMapper assignWorkshopServicePriceMapper;

	@Resource
	CompanyService companyService;
	
	@Resource
	private SalesOrderService salesOrderService;

	@Resource
	private PurchaseOrderService purchaseOrderService;
	
	@Resource
	private CommonService commonService;
	
	public List<AssignWorkingProcedure> listWorkshops(Page page){
		List<AssignWorkingProcedure> workshops = assignWorkingProcedureMapper.listPageAssignWorkingProcedure(page);
		return workshops;
	}
	
	public AssignWorkingProcedure selectOneWorkshop(PageData pd){
		return assignWorkingProcedureMapper.selectByPrimaryKey(pd);
	}
	
	//根据工序编码解析组合工序描述
	public String formatProcedureDesc(String procedure){
		String desc = "";
		List<String> pros = Tools.strArray2List(StringUtil.StrList(procedure));
		for (String keyString : pros) {
			
			switch (keyString) {
			case "01":
				desc += AssignEnum.ASSIGN_PROCEDURE_XIEZHENDAYIN.getDesc()+",";
				break;
			case "02":
				desc += AssignEnum.ASSIGN_PROCEDURE_XIEZHENHOUDAO.getDesc()+",";
				break;
			case "03":
				desc += AssignEnum.ASSIGN_PROCEDURE_PENHUIDAYIN.getDesc()+",";
				break;
			case "04":
				desc += AssignEnum.ASSIGN_PROCEDURE_PENHUIHOUDAO.getDesc()+",";
				break;
			case "05":
				desc += AssignEnum.ASSIGN_PROCEDURE_UVDAYIN.getDesc()+",";
				break;
			case "06":
				desc += AssignEnum.ASSIGN_PROCEDURE_TIAOFUDAYIN.getDesc()+",";
				break;
			case "07":
				desc += AssignEnum.ASSIGN_PROCEDURE_TIAOFUHOUDAO.getDesc()+",";
				break;
			case "08":
				desc += AssignEnum.ASSIGN_PROCEDURE_HOUDAOJIAGONG.getDesc()+",";
				break;
			case "09":
				desc += AssignEnum.ASSIGN_PROCEDURE_HUWAIDAYIN.getDesc()+",";
				break;

			default:
				desc += AssignEnum.ASSIGN_PROCEDURE_NONE.getDesc()+",";
				break;
			}
		}
		return desc.substring(0,desc.length()-1);
	}
	
	public int insertWorkshop(AssignWorkingProcedure assignWorkingProcedure){
		return assignWorkingProcedureMapper.insertSelective(assignWorkingProcedure);
	}
	
	public int updateWorkshop(AssignWorkingProcedure assignWorkingProcedure){
		return assignWorkingProcedureMapper.updateByPrimaryKeySelective(assignWorkingProcedure);
	}
	
	public int deleteWorkshop(PageData pd){
		return assignWorkingProcedureMapper.deleteByPrimaryKey(pd);
	}
	
	public int updateByPrimaryKeySelective(AssignWorkingTaskDetail detail){
		return assignWorkingTaskDetailMapper.updateByPrimaryKeySelective(detail);
	}
	
	public int updateThrowUpByKey(PageData pd){
		return assignWorkingTaskDetailMapper.updateThrowUpByKey(pd);
	}
	
	public int updateReItemNoByKey(PageData pd){
		return assignWorkingTaskDetailMapper.updateReItemNoByKey(pd);
	}
	
	public int updateByPrimaryKeySelective(AssignWorkingTask assignWorkingTask){
		return assignWorkingTaskMapper.updateByPrimaryKeySelective(assignWorkingTask);
	}
	
	public int updateAssignWorkingTaskDetailByMapPara(PageData pd){
		return assignWorkingTaskDetailMapper.updateAssignWorkingTaskDetailByMapPara(pd);
	}
	
	public AssignWorkingTaskDetail selectOneAssignWorkingTaskDetail(PageData pd){
		List<AssignWorkingTaskDetail> details = this.selectListAssignWorkingTaskDetail(pd);
		AssignWorkingTaskDetail detail = null;
		if (details!=null&&details.size()>0) {
			detail = details.get(0);
		}
		return detail;
	}
	public List<AssignWorkingTaskDetail> selectListAssignWorkingTaskDetail(PageData pd){
		return assignWorkingTaskDetailMapper.selectByPrimaryKey(pd);
	}
	
	public List<AssignWorkingTask> selectListAssignWorkingTasks(Page page){
		return assignWorkingTaskMapper.listPageAssignWorkingTask(page);
	}
	
	public AssignWorkingTask selectOneAssignWorkingTask(PageData pd){
		return assignWorkingTaskMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	 * @Title: listComProPriceAndWorkshop 
	 * @param industryId
	 * @param comKey
	 * @param pricingType
	 * @param pCode
	 * @param isChecked
	 * @param tier
	 * @return
	 * @throws Exception
	 * @return List<AssignWorkshopServicePrice>
	 * @throws 
	 * @Description: 查询构造工作车间及工序对应的服务定价列表
	 * 1. 查询已经未关闭的服务定价列表。
	 * 2. 第一层时直接构造服务定价的第一层结构转为工作车间对象返回
	 * 3. 第二层时不仅构造基础的信息，还需要获取已经配置好的工序及工作车间信息
	 * 4. 统一转为AssignWorkshopServicePrice对象返回
	 */
	public List<AssignWorkshopServicePrice> listComProPriceAndWorkshop(String industryId, String comKey, 
			String pricingType, String pCode, String isChecked, int tier,String searchKey) throws Exception{
		AssignWorkshopServicePrice servicePrice = null;
		List<AssignWorkshopServicePrice> servicePrices = new ArrayList<AssignWorkshopServicePrice>();
		
		List<String> categoryIdList = new ArrayList<>();
		List<ComProPrice> comProPrices = companyService.listComProPrice(industryId, comKey, pricingType, pCode, isChecked, searchKey);
		for (ComProPrice comProPrice : comProPrices) {
			servicePrice = new AssignWorkshopServicePrice();
			BeanutilsCopy.apacheCopyProperties(servicePrice, comProPrice);
			servicePrices.add(servicePrice);
			categoryIdList.add(comProPrice.getCategoryId());
		}
		
		if (2 == tier) {
			Map<String, AssignWorkshopServicePrice> map = new HashMap<>();
			PageData pd = new PageData();
			pd.put("comKey", comKey);
			pd.put("categoryIdIns", Tools.strSqlIn(Tools.list2InString(categoryIdList)));
			List<AssignWorkshopServicePrice> resultServicePrices = assignWorkshopServicePriceMapper.selectListByPrimaryKey(pd);
			if (resultServicePrices!=null) {
				for (AssignWorkshopServicePrice result : resultServicePrices) {
					map.put(result.getCategoryId(), result);
				}
				for (AssignWorkshopServicePrice servicePriceNew : servicePrices) {
					AssignWorkshopServicePrice result = map.get(servicePriceNew.getCategoryId());
					if (result!=null) {
						servicePriceNew.setIsChecked(result.getIsChecked());
						servicePriceNew.setWorkshop(result.getWorkshop());
						servicePriceNew.setWorkingProcedure(result.getWorkingProcedure());
					}
				}
			}
		}
		
		return servicePrices;
	}
	
	/**
	 * 
	 * @Title: insertAndUpdateServicePrice 
	 * @param servicePrice
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 修改或插入
	 */
	public int insertAndUpdateServicePrice(AssignWorkshopServicePrice servicePrice){
		int result = assignWorkshopServicePriceMapper.updateByPrimaryKeySelective(servicePrice);
		if (0 == result) {
			result = assignWorkshopServicePriceMapper.insertSelective(servicePrice);
		}
		return result;
	}
	
	public int insertAndUpdateBatchServicePrice(List<AssignWorkshopServicePrice> items,String comKey,String industryId){
		int result = 0;
		
		for (AssignWorkshopServicePrice item : items) {
			item.setComKey(comKey);
			item.setIndustryId(industryId);
			result = this.insertAndUpdateServicePrice(item);
		}
		return result;
	}
	
	
	/**
	 * 
	 * @Title: insertWorkingAssignTaskAndDetail 
	 * @param salesOrder
	 * @param details
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 根据销售单创建制作派工，派工任务项根据订单明细按工序拆分
	 */
	public int insertWorkingAssignTaskAndDetail(SalesOrder salesOrder,List<SalesOrderDetail> details){
		AssignWorkingTask workingTask = new AssignWorkingTask();
		List<AssignWorkingTaskDetail> workingTaskDetails = new ArrayList<>();
		AssignWorkingTaskDetail taskDetail = null;
		
		BeanutilsCopy.apacheCopyProperties(workingTask, salesOrder);
		workingTask.setTaskNo(CodeBuilderUtil.getInstance().getAnyId(10));
		workingTask.setTaskDate(new Date());
		workingTask.setStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
		workingTask.setIsDel("0");
		workingTask.setCreateTime(new Date());
		workingTask.setOrderDate(salesOrder.getOrderDate());
		
		int item = 1;
		for (SalesOrderDetail salesOrderDetail : details) {
			String workingProcedure = salesOrderDetail.getWorkingProcedure();
			List<String> procedures = Tools.strArray2List(Tools.StrList(workingProcedure));
			for (String procedureString : procedures) {
				taskDetail = new AssignWorkingTaskDetail();
				BeanutilsCopy.apacheCopyProperties(taskDetail, salesOrderDetail);
				taskDetail.setItemNo(item++);
				taskDetail.setTaskNo(workingTask.getTaskNo());
				taskDetail.setSalesOrderItem(salesOrderDetail.getItemNo());
				taskDetail.setStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
				taskDetail.setWorkingProcedure(procedureString);
				taskDetail.setCreateTime(workingTask.getCreateTime());
				taskDetail.setCreator(workingTask.getCreator());
				workingTaskDetails.add(taskDetail);
			}
		}
		assignWorkingTaskDetailMapper.insertList(workingTaskDetails);
		int result = assignWorkingTaskMapper.insertSelective(workingTask);
		
		return result;
	}
	
	
	public List<AssignWorkingTaskDetailVO> listAssignWorkingTaskDetailVOs(Page page){
		List<AssignWorkingTaskDetailVO> detailVOs = assignWorkingTaskDetailMapper.listPageAssignWorkingTaskDetailVO(page);
		for (AssignWorkingTaskDetailVO assignWorkingTaskDetailVO : detailVOs) {
			assignWorkingTaskDetailVO.setStatusDesc(this.formatStatusDesc(assignWorkingTaskDetailVO.getStatus()));
		}
		return detailVOs;
	}
	
	private String formatStatusDesc(String status){
		String desc = "";
		switch (status) {
		case "5":
			desc += AssignEnum.ASSIGN_STATUS_WORKING.getDesc();
			break;
		case "2":
			desc += AssignEnum.ASSIGN_STATUS_DONE.getDesc();
			break;
		case "C":
			desc += AssignEnum.ASSIGN_STATUS_CANCEL.getDesc();
			break;

		default:
			desc += AssignEnum.ASSIGN_STATUS_WORKING.getDesc();
			break;
		}
		return desc;
	}
	
	public List<TotalSalesOrderDetailVO> listAssignWorkingTaskDetailVOsByOrder(Page page){
		PageData pd = page.getPd();
		List<AssignWorkingTaskDetailVO> detailvos = assignWorkingTaskDetailMapper.listPageSalesNoIns(page);
		List<String> salesNoIns = new ArrayList<>();
		for (AssignWorkingTaskDetailVO assignWorkingTaskDetailVO : detailvos) {
			salesNoIns.add(assignWorkingTaskDetailVO.getSalesNo());
		}
		if (salesNoIns.size()<=0) {
			salesNoIns = null;
		}
		
		pd.put("salesNo", salesNoIns);
		 List<TotalSalesOrderDetailVO> totalSalesOrderDetailVOs = salesOrderService.selectTotalDetailBySalesNo(pd);
		 														 
		 for (TotalSalesOrderDetailVO tsodVO : totalSalesOrderDetailVOs) {
			//计算面积
			tsodVO.setTotalArea(tsodVO.getWidth().multiply(tsodVO.getLength()).multiply(tsodVO.getQuantity())
					.setScale(2, BigDecimal.ROUND_HALF_UP));
			
			System.out.println(tsodVO.getWorkingStatus());
			if (AssignEnum.ASSIGN_STATUS_DONE.getCode()
					.equalsIgnoreCase(tsodVO.getWorkingStatus())) {
				tsodVO.setWorkingStatus(AssignEnum.ASSIGN_STATUS_DONE.getDesc());
			}else{
				tsodVO.setWorkingStatus(AssignEnum.ASSIGN_STATUS_WORKING.getDesc());
			}
		}
		return totalSalesOrderDetailVOs;
	}
	
	/**
	 * 
	 * @Title: updateAssignTask 
	 * @param pd
	 * @return
	 * @return int
	 * @throws Exception 
	 * @throws 
	 * @Description: 完工操作。并同时将进度同步修改到派工，销售订单，协同订单中
	 */
	public synchronized int updateAssignTask(PageData pd) throws Exception{
		int result = 0;
		String taskNo = pd.getString("taskNo");
		String comKey = pd.getString("comKey");
		int salesOrderItem = new Integer(pd.getString("salesOrderItem")).intValue();
		String salesNo = pd.getString("salesNo");
		String procedure = pd.getString("workingProcedure");
		
//		1. 对派工任务进行完工处理
		PageData pdPara = new PageData();
		pdPara.put("taskNo", taskNo);
		pdPara.put("itemNo", new Integer(pd.getString("itemNo")));
		pdPara.put("uid", new Long(pd.getString("uid")));
		pdPara.put("status", AssignEnum.ASSIGN_STATUS_DONE.getCode());
		pdPara.put("finishDate", new Date());
		result = this.updateAssignWorkingTaskDetailByMapPara(pdPara);
		
//		2. 判断任务单是否所有任务完工，如果完工则任务单改为完工，不然就是制作中
		pd.clear();
		pd.put("taskNo", taskNo);
		pd.put("statusNo", "C");
		List<AssignWorkingTaskDetail> details = this.selectListAssignWorkingTaskDetail(pd);
		boolean doneAll = true;
		for (AssignWorkingTaskDetail detail : details) {
			if (!AssignEnum.ASSIGN_STATUS_DONE.getCode()
					.equalsIgnoreCase(detail.getStatus())) {
				doneAll = false;
			}
		}
		
		String workingStatus = AssignEnum.ASSIGN_STATUS_WORKING.getCode();
		String workingStatusDesc = AssignEnum.ASSIGN_STATUS_WORKING.getDesc();
		if(doneAll){
			workingStatus = AssignEnum.ASSIGN_STATUS_DONE.getCode();
			workingStatusDesc = AssignEnum.ASSIGN_STATUS_DONE.getDesc();
		}else{
			workingStatusDesc = AssignEnum.codeOf(procedure).getDesc()+"完工";
		}
		
//		3. 修改销售订单，协同采购单，派工单的进度值
		AssignWorkingTask task = new AssignWorkingTask();
		task.setComKey(comKey);
		task.setTaskNo(taskNo);
		task.setStatus(workingStatus);
		if (doneAll) {
			task.setFinishDate(new Date());
		}
		this.updateByPrimaryKeySelective(task);
		
		//判断是否有协同采购单，如果有需要更新协同采购单的制作派工进度
		pd.clear();
		pd.put("comKey", comKey);
		pd.put("salesNo", salesNo);
		SalesOrder salesOrder = salesOrderService.selectOneSalesOrder(pd);
		if (salesOrder!=null
				&&StringUtil.isNotEmpty(salesOrder.getPurchaseNo())) {
			pdPara.clear();
			pdPara.put("purchaseNo", salesOrder.getPurchaseNo());
			pdPara.put("workingStatus",workingStatus);
			purchaseOrderService.updatePurchaseOrderByMapPara(pdPara);
			
			pdPara.put("workingStatus",workingStatusDesc);
			if (!doneAll) {
				pdPara.put("itemNo", salesOrderItem);
			}
			purchaseOrderService.updatePurchaseOrderDetailByMapPara(pdPara);
		}
		
		pdPara.clear();
		pdPara.put("comKey", comKey);
		pdPara.put("salesNo", salesNo);
		pdPara.put("workingStatus", workingStatus);
		
		salesOrderService.updateSalesOrderByMapPara(pdPara);
		return result;
	}
	
	/**
	 * 
	 * @Title: updateReAssignTask 
	 * @param newItems
	 * @param deleteItems
	 * @param comKey
	 * @param salesNo
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 修改订单引起的重新派工处理
	 * 1. 删除的(包括修改了关键字段导致重新派工的)销售业务内容，在派工单中进行作废
	 * 2. 新建直接重新派工处理。
	 * 3. 考虑到派工任务中存在新派工及未被重新派工的任务，需要检索结果集重新进行itemNo编号处理。
	 */
	public int updateReAssignTask(List<SalesOrderDetail> newItems,List<String> deleteItems,String comKey,String salesNo){
		int result = 0;
		if (StringUtil.isEmpty(salesNo)||StringUtil.isEmpty(comKey)) {
			return 0;
		}
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("salesNo", salesNo);
		AssignWorkingTask assignWorkingTask = assignWorkingTaskMapper.selectByPrimaryKey(pd);
		if (assignWorkingTask == null) {
			return 0;
		}
		String taskNo = assignWorkingTask.getTaskNo();
		//作废被删除的业务内容记录
		if (deleteItems!=null&&deleteItems.size()>0) {
			pd.clear();
			for (String itemString : deleteItems) {
				pd.put("taskNo", taskNo);
				pd.put("salesOrderItem", new Integer(itemString));
				result = this.updateThrowUpByKey(pd);
			}
		}
		
		//新增或修改的导致需要重新派工的，插入新派工
		if (newItems!=null&&newItems.size()>0) {
			AssignWorkingTaskDetail taskDetail = null;
			List<AssignWorkingTaskDetail> workingTaskDetails = new ArrayList<>();
			int item = 1;
			for (SalesOrderDetail salesOrderDetail : newItems) {
				String workingProcedure = salesOrderDetail.getWorkingProcedure();
				List<String> procedures = Tools.strArray2List(Tools.StrList(workingProcedure));
				for (String procedureString : procedures) {
					taskDetail = new AssignWorkingTaskDetail();
					BeanutilsCopy.apacheCopyProperties(taskDetail, salesOrderDetail);
					taskDetail.setItemNo(item++);
					taskDetail.setTaskNo(taskNo);
					taskDetail.setSalesOrderItem(salesOrderDetail.getItemNo());
					taskDetail.setStatus(AssignEnum.ASSIGN_STATUS_WORKING.getCode());
					taskDetail.setWorkingProcedure(procedureString);
					taskDetail.setCreateTime(new Date());
					taskDetail.setCreator(assignWorkingTask.getCreator());
					workingTaskDetails.add(taskDetail);
				}
			}
			assignWorkingTaskDetailMapper.insertList(workingTaskDetails);
		}
		
		return result;
	}
	
	/**
	 * 
	 * @Title: updateReItemNo 
	 * @param newDetails
	 * @param comKey
	 * @param salesNo
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 用于更新因为修改销售订单导致的salesItemNo出现了变化。
	 * 定位判断依据：业务内容，制作要求，长，宽，数量
	 */
	public int updateReItemNo(List<SalesOrderDetail> newDetails,String comKey,String salesNo){
		int result = 0;
		if (StringUtil.isEmpty(salesNo)||StringUtil.isEmpty(comKey)) {
			return 0;
		}
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("salesNo", salesNo);
		AssignWorkingTask assignWorkingTask = assignWorkingTaskMapper.selectByPrimaryKey(pd);
		String taskNo = assignWorkingTask.getTaskNo();
		pd.clear();
		for (SalesOrderDetail orderDetail : newDetails) {
			pd.put("taskNo", taskNo);
			pd.put("businessDesc", orderDetail.getBusinessDesc());
			pd.put("requirements", orderDetail.getRequirements());
			pd.put("length", orderDetail.getLength());
			pd.put("width", orderDetail.getWidth());
			pd.put("quantity", orderDetail.getQuantity());
			pd.put("salesOrderItem", orderDetail.getItemNo());
			result = this.updateReItemNoByKey(pd);
		}
		
		//重新进行itemNo编号
		pd.clear();
		pd.put("taskNo", taskNo);
		List<AssignWorkingTaskDetail> assignWorkingTaskDetails = assignWorkingTaskDetailMapper.selectListByPrimaryKey(pd);
		int newitem = 1;
		PageData pdPara = new PageData();
		for (AssignWorkingTaskDetail assignWorkingTaskDetail : assignWorkingTaskDetails) {
			pdPara.put("itemNoNew", newitem++);
			pdPara.put("taskNo",taskNo);
			pdPara.put("uid", assignWorkingTaskDetail.getUid());
			result = this.updateAssignWorkingTaskDetailByMapPara(pdPara);
		}
		
		return result;
	}
	
	public int openOrCloseWorkingProcedure(PageData pd) throws Exception{
		int result = 0;
		if ("1".equals(pd.getString("configValue"))) {
			ComConfig comConfig = new ComConfig();
			comConfig.setComKey(pd.getString("comKey"));
			comConfig.setConfigKey(Const.COMPANY_CONFIG_WORKING_PROCEDURE);
			comConfig.setConfigValue("1");
			result = commonService.insertComConfig(comConfig);
		}else{
			pd.put("configKey",Const.COMPANY_CONFIG_WORKING_PROCEDURE);
			result = commonService.deleteComConfig(pd);
		}
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(Tools.strArray2List(Tools.StrList("00")));
	}
	

}
