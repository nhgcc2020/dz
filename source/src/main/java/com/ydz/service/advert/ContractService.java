/**   
 * @Title: ContractService.java 
 * @Package com.ydz.service.advert 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 29, 2017 5:00:59 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.advert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ydz.dao.project.ContractInvoiceMapper;
import com.ydz.dao.project.ContractProjectMapper;
import com.ydz.dao.project.ContractReturnMoneyPlanMapper;
import com.ydz.dao.project.ContractReturnMoneyRecordMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.UploadFile;
import com.ydz.entity.project.ContractInvoice;
import com.ydz.entity.project.ContractProject;
import com.ydz.entity.project.ContractProjectParaVO;
import com.ydz.entity.project.ContractReturnMoneyPlan;
import com.ydz.entity.project.ContractReturnMoneyRecord;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Partner;
import com.ydz.enums.ProjectEnum;
import com.ydz.exception.ProjectException;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.FileUpload;
import com.ydz.util.FileUtil;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.UuidUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: ContractService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 29, 2017 5:00:59 PM 
 * @Description: 项目合同Service
 */
@Service
public class ContractService {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ContractProjectMapper contractProjectMapper;
	@Autowired
	private ContractReturnMoneyPlanMapper contractReturnMoneyPlanMapper;
	@Autowired
	private ContractInvoiceMapper contractInvoiceMapper;
	@Autowired
	private ContractReturnMoneyRecordMapper contractReturnMoneyRecordMapper;

	@Resource
	private OpportunityService opportunityService;
	@Resource
	private CommonService commonService;
	@Resource
	private PartnerService partnerService;
	
	
	//合同单处理
	private ContractProject selectOneContractProject(PageData pd){
		return contractProjectMapper.selectByPrimaryKey(pd);
	}
	private List<ContractProject> listPageContractProjects(Page page){
		return contractProjectMapper.listPageContractProjects(page);
	}
	private int insertOneContractProject(ContractProject contractProject) throws Exception{
		return contractProjectMapper.insertSelective(contractProject);
	}
	private int updateContractProject(ContractProject contractProject) throws Exception{
		return contractProjectMapper.updateByPrimaryKeySelective(contractProject);
	}
	public int updateContractByPara(PageData pd) throws Exception{
		return contractProjectMapper.updateContractByPara(pd);
	}
	public OrderTotalVO getSumContractMoney(PageData pd){
		return contractProjectMapper.getSumContractMoney(pd);
	}
	
	
	//回款计划处理
	private ContractReturnMoneyPlan selectOneContractReturnMoneyPlan(PageData pd){
		return contractReturnMoneyPlanMapper.selectByPrimaryKey(pd);
	}
	private List<ContractReturnMoneyPlan> listContractReturnMoneyPlans(PageData pd){
		return contractReturnMoneyPlanMapper.listContractReturnMoneyPlans(pd);
	}
	private int insertOneContractReturnMoneyPlan(ContractReturnMoneyPlan contractReturnMoneyPlan) throws Exception{
		return contractReturnMoneyPlanMapper.insertSelective(contractReturnMoneyPlan);
	}
	private int insertListContractReturnMoneyPlan(List<ContractReturnMoneyPlan> contractReturnMoneyPlans) throws Exception{
		return contractReturnMoneyPlanMapper.insertList(contractReturnMoneyPlans);
	}
	private int updateContractReturnMoneyPlan(ContractReturnMoneyPlan contractReturnMoneyPlan) throws Exception{
		return contractReturnMoneyPlanMapper.updateByPrimaryKeySelective(contractReturnMoneyPlan);
	}
	private int deleteContractReturnMoneyPlan(PageData pd) throws Exception{
		return contractReturnMoneyPlanMapper.deleteByPrimaryKey(pd);
	}
	//发票记录处理
	private ContractInvoice selectOneContractInvoice(PageData pd){
		return contractInvoiceMapper.selectByPrimaryKey(pd);
	}
	private List<ContractInvoice> listContractInvoices(PageData pd){
		return contractInvoiceMapper.listContractInvoices(pd);
	}
	private int insertOneContractInvoice(ContractInvoice contractInvoice) throws Exception{
		return contractInvoiceMapper.insertSelective(contractInvoice);
	}
	private int insertListContractInvoices(List<ContractInvoice> contractInvoices) throws Exception{
		return contractInvoiceMapper.insertList(contractInvoices);
	}
	private int deleteContractInvoice(PageData pd) throws Exception{
		return contractInvoiceMapper.deleteByPrimaryKey(pd);
	}
	
	//回款记录处理
	private ContractReturnMoneyRecord selectOneContractReturnMoneyRecord(PageData pd){
		return contractReturnMoneyRecordMapper.selectByPrimaryKey(pd);
	}
	private List<ContractReturnMoneyRecord> listContractReturnMoneyRecord(PageData pd){
		return contractReturnMoneyRecordMapper.listReturnMoneyRecords(pd);
	}
	private int insertOneContractReturnMoneyRecord(ContractReturnMoneyRecord contractReturnMoneyRecord) throws Exception{
		return contractReturnMoneyRecordMapper.insertSelective(contractReturnMoneyRecord);
	}
	private int insertListContractReturnMoneyRecord(List<ContractReturnMoneyRecord> contractReturnMoneyRecords) throws Exception{
		return contractReturnMoneyRecordMapper.insertList(contractReturnMoneyRecords);
	}
	private int deleteContractReturnMoneyRecord(PageData pd) throws Exception{
		return contractReturnMoneyRecordMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	 * @Title: insertContractAll 
	 * @param contractProjectParaVO
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 新建合同单
	 * 1.新建合同
	 * 2.新建回款计划
	 * 3.新建合同发票记录
	 * 4.新建回款记录
	 */
	public int insertContractAll(ContractProjectParaVO contractProjectParaVO,UserVo userVo) 
			throws Exception{
		int result = 0;
		ContractProject contract = contractProjectParaVO.getContractProject();
		List<ContractReturnMoneyPlan> plans = contractProjectParaVO.getPlans();
		List<ContractInvoice> invoices = contractProjectParaVO.getInvoices();
		List<ContractReturnMoneyRecord> returnRecords = contractProjectParaVO.getReturnRecords();
		
		contract.setComKey(userVo.getComKey());
		contract.setIndustryId(userVo.getDetailIndustryId());
		contract.setCreator(userVo.getUserKey());
		contract.setCreateTime(new Date());
		contract.setIsDel("0");
		contract.setIsValid("1");
		contract.setStatus(ProjectEnum.CONTRACT_STATUS_EXECUTINT.getCode());
		
		PageData pd = new PageData();
		pd.put("partnerKey", contract.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		if (partner!=null) {
			contract.setPartnerName(partner.getPartnerName());
			contract.setPartnerShortname(partner.getPartnerShortname());
		}
		result = this.insertOneContractProject(contract);
		if (result<=0) {
			logger.info("新建合同单失败");
			return result;
		}
		
		BigDecimal actualContractMoney = BigDecimal.ZERO; //合同实际金额=计划回款的总金额
		BigDecimal invoiceContractMoney = BigDecimal.ZERO; //已开票金额
		BigDecimal returnedContractMoney = BigDecimal.ZERO; //已回款金额
		BigDecimal baddebtMoney = BigDecimal.ZERO; //坏账=回款记录中回款类型为坏账的金额统计
		if (plans!=null&&plans.size()>0) {
			for (ContractReturnMoneyPlan plan : plans) {
				plan.setContractNo(contract.getContractNo());
				plan.setComKey(contract.getComKey());
				plan.setPlanRemindTime(DateUtil.StringToDate(plan.getPlanRemindTimeValue(), DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
				plan.setCreateTime(contract.getCreateTime());
				plan.setCreator(contract.getCreator());
				plan.setIsDel("0");
				actualContractMoney = actualContractMoney.add(plan.getPlanReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
				
			}
			int planCount = this.insertListContractReturnMoneyPlan(plans);
			if (planCount<=0) {
				throw new ProjectException("新建回款计划失败");
			}
		}
		if (invoices!=null&&invoices.size()>0) {
			for (ContractInvoice invoice : invoices) {
				invoice.setInvoiceNo(CodeBuilderUtil.getInstance().getAnyId(10));
				invoice.setContractNo(contract.getContractNo());
				invoice.setComKey(contract.getComKey());
				invoice.setCreateTime(contract.getCreateTime());
				invoice.setCreator(contract.getCreator());
				invoice.setIsDel("0");
				invoiceContractMoney = invoiceContractMoney.add(invoice.getInvoiceMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
			}
			int invoiceCount = this.insertListContractInvoices(invoices);
			if (invoiceCount<=0) {
				throw new ProjectException("新建合同发票记录失败");
			}
		}
		if (returnRecords!=null&&returnRecords.size()>0) {
			for (ContractReturnMoneyRecord returnRecord : returnRecords) {
				returnRecord.setContractNo(contract.getContractNo());
				returnRecord.setComKey(contract.getComKey());
				returnRecord.setCreateTime(contract.getCreateTime());
				returnRecord.setCreator(contract.getCreator());
				returnRecord.setIsDel("0");
				returnedContractMoney = returnedContractMoney.add(returnRecord.getReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
				if (ProjectEnum.CONTRACT_RETURN_TYPE_BAD_DEBT.getCode().equals(
						returnRecord.getReturnType())) {
					baddebtMoney = baddebtMoney.add(returnRecord.getReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
				}
			}
			int recordCount = this.insertListContractReturnMoneyRecord(returnRecords);
			if (recordCount<=0) {
				throw new ProjectException("新建回款记录失败");
			}
		}
		
		//更新合同单的金额字段
		PageData updatePara = new PageData();
		updatePara.put("contractNo", contract.getContractNo());
		updatePara.put("actualContractMoney", actualContractMoney);
		updatePara.put("invoiceContractMoney", invoiceContractMoney);
		updatePara.put("returnedContractMoney", returnedContractMoney);
		updatePara.put("waitforContractMoney", actualContractMoney.subtract(returnedContractMoney).setScale(2, BigDecimal.ROUND_HALF_UP)); //待回款金额=合同总金额-已回款金额
		updatePara.put("baddebtMoney", baddebtMoney);
		this.updateContractByPara(updatePara);
		
		return result;
	}
	
	/**
	 * 
	 * @Title: updateContractAll 
	 * @param contractProjectParaVO
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 修改合同单
	 * 1.修改合同单
	 * 2.先删除原回款计划再新插入回款计划
	 * 3.先删除原发票记录再新插入发票记录
	 * 4.先删除原回款记录再新插入回款记录
	 * 
	 */
	public int updateContractAll(ContractProjectParaVO contractProjectParaVO,PageData pd) 
			throws Exception{
		int result = 0;
		ContractProject newContract = contractProjectParaVO.getContractProject();
		List<ContractReturnMoneyPlan> plans = contractProjectParaVO.getPlans();
		List<ContractInvoice> invoices = contractProjectParaVO.getInvoices();
		List<ContractReturnMoneyRecord> returnRecords = contractProjectParaVO.getReturnRecords();
		
		pd.put("contractNo", newContract.getContractNo());
		ContractProject oldContract = this.selectOneContractProject(pd);
		if (oldContract==null) {
			logger.info("修改合同单失败");
			return result;
		}
		newContract.setComKey(oldContract.getComKey());
		newContract.setCreateTime(oldContract.getCreateTime());
		newContract.setCreator(oldContract.getCreator());
		
		pd.put("partnerKey", newContract.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		if (partner!=null) {
			newContract.setPartnerName(partner.getPartnerName());
			newContract.setPartnerShortname(partner.getPartnerShortname());
		}
		
		result = this.updateContractProject(newContract);
		if (result<=0) {
			logger.info("修改合同单失败");
			return result;
		}
		
	    BigDecimal actualContractMoney = BigDecimal.ZERO; //合同实际金额=计划回款的总金额
	    BigDecimal invoiceContractMoney = BigDecimal.ZERO; //已开票金额
	    BigDecimal returnedContractMoney = BigDecimal.ZERO; //已回款金额
	    BigDecimal baddebtMoney = BigDecimal.ZERO; //坏账=回款记录中回款类型为坏账的金额统计
	    
		if (plans != null && plans.size() > 0) {
			for (ContractReturnMoneyPlan plan : plans) {
				plan.setContractNo(newContract.getContractNo());
				plan.setComKey(newContract.getComKey());
				plan.setPlanRemindTime(DateUtil.StringToDate(
						plan.getPlanRemindTimeValue(),
						DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
				plan.setCreateTime(newContract.getCreateTime());
				plan.setCreator(newContract.getCreator());
				plan.setIsDel("0");
				actualContractMoney = actualContractMoney.add(plan.getPlanReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
			}
			// 先删除再插入
			int planCount = this.deleteContractReturnMoneyPlan(pd);
			planCount = this.insertListContractReturnMoneyPlan(plans);
			if (planCount <= 0) {
				throw new ProjectException("修改回款计划失败");
			}
		}
		if (invoices != null && invoices.size() > 0) {
			for (ContractInvoice invoice : invoices) {
				invoice.setInvoiceNo(CodeBuilderUtil.getInstance().getAnyId(10));
				invoice.setContractNo(newContract.getContractNo());
				invoice.setComKey(newContract.getComKey());
				invoice.setCreateTime(newContract.getCreateTime());
				invoice.setCreator(newContract.getCreator());
				invoiceContractMoney = invoiceContractMoney.add(invoice.getInvoiceMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
			}
			// 先删除再插入
			int invoiceCount = this.deleteContractInvoice(pd);
			invoiceCount = this.insertListContractInvoices(invoices);
			if (invoiceCount <= 0) {
				throw new ProjectException("修改合同发票记录失败");
			}
		}
		if (returnRecords != null && returnRecords.size() > 0) {
			for (ContractReturnMoneyRecord returnRecord : returnRecords) {
				returnRecord.setContractNo(newContract.getContractNo());
				returnRecord.setComKey(newContract.getComKey());
				returnRecord.setCreateTime(newContract.getCreateTime());
				returnRecord.setCreator(newContract.getCreator());
				returnedContractMoney = returnedContractMoney.add(returnRecord.getReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
				if (ProjectEnum.CONTRACT_RETURN_TYPE_BAD_DEBT.getCode().equals(
						returnRecord.getReturnType())) {
					baddebtMoney = baddebtMoney.add(returnRecord.getReturnMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
				}
			}
			// 先删除再插入
			int recordCount = this.deleteContractReturnMoneyRecord(pd);
			recordCount = this.insertListContractReturnMoneyRecord(returnRecords);
			if (recordCount <= 0) {
				throw new ProjectException("修改回款记录失败");
			}
		}
		
		//更新合同单的金额字段
		PageData updatePara = new PageData();
		updatePara.put("contractNo", newContract.getContractNo());
		updatePara.put("actualContractMoney", actualContractMoney);
		updatePara.put("invoiceContractMoney", invoiceContractMoney);
		updatePara.put("returnedContractMoney", returnedContractMoney);
		updatePara.put(
				"waitforContractMoney",
				actualContractMoney.subtract(returnedContractMoney).setScale(2,
						BigDecimal.ROUND_HALF_UP)); //待回款金额=合同总金额-已回款金额
		updatePara.put("baddebtMoney", baddebtMoney);
		this.updateContractByPara(updatePara);
		
		return result;
	}
	
	public ContractProject selectContractProject(PageData pd){
		ContractProject contractProject = this.selectOneContractProject(pd);
		if (StringUtil.isNotEmpty(contractProject.getParticipantEmployeeId())) {
			pd.put("employeeIdIns", Tools.strSqlIn(contractProject.getParticipantEmployeeId()));
			List<Employee> employees = this.listParticipanEmployees(pd);
			contractProject.setParticipantEmployeeName(commonService.getConcatEmployeeName(employees));
		}
		return contractProject;
	}
	
	/**
	 * 
	 * @Title: listPageContractProjectsAllInfo 
	 * @param page
	 * @return
	 * @return List<ContractProject>
	 * @throws 
	 * @Description: 查询合同单列表
	 * 1.包含最近跟进记录
	 * 2.包含参与人
	 */
	public List<ContractProject> listPageContractProjectsAllInfo(Page page){
		List<ContractProject> contractProjects = this.listPageContractProjects(page);
		PageData pd = page.getPd();
		List<String> contractNoList = new ArrayList<>();
		for (ContractProject contract : contractProjects) {
			if (StringUtil.isNotEmpty(contract.getParticipantEmployeeId())) {
				pd.put("employeeIdIns", Tools.strSqlIn(contract.getParticipantEmployeeId()));
				List<Employee> employees = this.listParticipanEmployees(pd);
				contract.setParticipantEmployeeName(commonService.getConcatEmployeeName(employees));
				contract.setWaitforInvoiceContractMoney(contract
						.getActualContractMoney()
						.subtract(contract.getInvoiceContractMoney())
						.setScale(2, BigDecimal.ROUND_HALF_UP));
			}
			contractNoList.add(contract.getContractNo());
		}
		
		if (contractNoList!=null&&contractNoList.size()>0) {
			
			//拼装最近联系记录
			Map<String, OpportunityChat> mapChat = new HashMap<>();
			pd.put("oppoNoIns", Tools.strSqlIn(Tools.list2InString(contractNoList)));
			List<OpportunityChat> chats = opportunityService.listLatestChat(pd);
			for (OpportunityChat chat : chats) {
				mapChat.put(chat.getOppoNo(), chat);
			}
			//循环拼装赋值
			for (ContractProject contract : contractProjects) {
				if (mapChat.size()>0) {
					OpportunityChat chat = mapChat.get(contract.getContractNo());
					contract.setLatestChat(chat!=null?chat.getChatEmployeeName()+": "+chat.getChatContent():"");
				}
			}
		}
		
		return contractProjects;
	}
	
	public List<ContractReturnMoneyPlan> listPlans(PageData pd){
		List<ContractReturnMoneyPlan> plans = this.listContractReturnMoneyPlans(pd);
		for (ContractReturnMoneyPlan plan : plans) {
			if (StringUtil.isNotEmpty(plan.getPlanRemindContactId())) {
				pd.put("employeeIdIns", Tools.strSqlIn(plan.getPlanRemindContactId()));
				List<Employee> employees = this.listParticipanEmployees(pd);
				plan.setPlanRemindContactName(commonService.getConcatEmployeeName(employees));
			}
		}
		return plans;
	}
	
	public List<ContractInvoice> listInvoices(PageData pd){
//		List<ContractInvoice> invoices = this.listContractInvoices(pd);
//		return invoices;
		return this.listContractInvoices(pd);
	}
	
	public List<ContractReturnMoneyRecord> listReturnRecord(PageData pd){
		List<ContractReturnMoneyRecord> records = this.listContractReturnMoneyRecord(pd);
		for (ContractReturnMoneyRecord record : records) {
			record.setPayTypeValue(commonService.formatAccountPayee(record.getPayType()));
			if (StringUtil.isEmpty(record.getReturnType())) {
				record.setReturnTypeValue(ProjectEnum.codeOf(record.getReturnType()).getDesc());
			}
		}
		return records;
	}
	
	public int insertContractChat(OpportunityChat chat) throws Exception{
		return opportunityService.insertOpportunityChat(chat);
	}
	
	public List<OpportunityChat> listPageContractChats(Page page){
		return opportunityService.listPageOpportunityChats(page);
	}
	
	public List<Employee> listParticipanEmployees(PageData pd){
		return opportunityService.listParticipanEmployees(pd);
	}
	
	/**
	 * 
	 * @Title: insertMultiFileUpload 
	 * @param multiPartFiles
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 多文件上传附件并将文件信息写入数据库
	 */
	@SuppressWarnings("rawtypes")
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
				pd.put("orderNo", pd.getString("contractNo"));
				pd.put("fileName", file.getOriginalFilename());
				int resultCount = this.insertUploadFile(pd); //插入数据库
				if (resultCount>0) {
					try {
						FileUpload.fileUpSimple(file, pd.getString("filePath"), file.getOriginalFilename()); //上传附件
					} catch (Exception e) {
						logger.error(e.getMessage());
						commonService.deleteUploadFiles(pd); //上传失败后删除插入的记录
						throw new ProjectException("上传合同附件失败");
					}
					fileIdList.add(pd.getString("fileId"));
				}
				
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("上传合同附件失败");
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
		uploadFile.setFileType("HT"); //合同附件
		uploadFile.setIsDel("0");
		uploadFile.setCreator(pd.getString("userKey"));
		uploadFile.setCreateTime(new Date());
		return commonService.insertOneUploadFile(uploadFile);
	}
	
	/**
	 * 
	 * @Title: deleteAttachmentFile 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 删除附件
	 */
	public int deleteAttachmentFile(PageData pd)
		throws Exception{
		int result = 0;
		try {
			UploadFile file = commonService.selectOneUploadFile(pd);
			if (file!=null) {
				result = commonService.deleteUploadFiles(pd);
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
	
	//查询附件列表
	public List<UploadFile> listAttachmentFiles(PageData pd){
		return commonService.listUploadFiles(pd);
	}
	
	
	public static void main(String[] args) {
//		ContractProjectParaVO paraVO = new ContractProjectParaVO();
//		ContractProject contractProject = new ContractProject();
//		paraVO.setContractProject(contractProject);
//		
//		List<ContractReturnMoneyPlan> plans = new ArrayList<ContractReturnMoneyPlan>();
//		for (int i = 0; i < 3; i++) {
//			ContractReturnMoneyPlan plan = new ContractReturnMoneyPlan();
//			plans.add(plan);
//		}
//		paraVO.setPlans(plans);
//		
//		List<ContractInvoice> invoices = new ArrayList<>();
//		for (int i = 0; i < 3; i++) {
//			ContractInvoice invoice = new ContractInvoice();
//			invoices.add(invoice);
//		}
//		paraVO.setInvoices(invoices);
//		
//		List<ContractReturnMoneyRecord> records = new ArrayList<>();
//		for (int i = 0; i < 3; i++) {
//			ContractReturnMoneyRecord record = new ContractReturnMoneyRecord();
//			records.add(record);
//		}
//		paraVO.setReturnRecords(records);
//		System.out.println(JsonUtil.toCompatibleJSONString(paraVO));
		List<Employee> employees = new ArrayList<>();
		for (int i = 0; i < 100000; i++) {
			Employee employee = new Employee();
			employee.setRealName("张孤独");
			employees.add(employee);
		}
		long start = System.currentTimeMillis();
		StringBuilder sb = new StringBuilder(employees.size()*10);
		for (Employee employee : employees) {
			if (sb.length() > 0)
				sb.append("、");
			sb.append(employee.getRealName());
		}
//		String employeeName = "";
//		for (Employee employee : employees) {
//			employeeName += employee.getRealName()+"、";
//		}
		System.out.println(System.currentTimeMillis()-start);
//		System.out.println(employeeName);
//		System.out.println(sb.toString());
	}
}
