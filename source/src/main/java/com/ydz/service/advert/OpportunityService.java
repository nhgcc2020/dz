/**   
 * @Title: OpportunityService.java 
 * @Package com.ydz.service.advert 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 2:27:48 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
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

import com.ydz.config.DZConfig;
import com.ydz.dao.project.OpportunityChatMapper;
import com.ydz.dao.project.OpportunityOrderMapper;
import com.ydz.dao.project.OpportunityQuotationDetailMapper;
import com.ydz.dao.project.OpportunityQuotationMapper;
import com.ydz.entity.Page;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.project.OpportunityOrder;
import com.ydz.entity.project.OpportunityQuotation;
import com.ydz.entity.project.OpportunityQuotationDetail;
import com.ydz.entity.project.OpportunityQuotationParaVO;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.Partner;
import com.ydz.enums.ProjectEnum;
import com.ydz.exception.YdzBusinessException;
import com.ydz.exception.YdzSystemRuntimeException;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.OrderTotalVO;
import com.ydz.vo.UserVo;

/** 
 * @ClassName: OpportunityService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 14, 2017 2:27:48 PM 
 * @Description: 商机业务Service
 */
@Service
public class OpportunityService {
	
	public Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired private OpportunityOrderMapper opportunityOrderMapper;
	@Autowired private OpportunityQuotationMapper opportunityQuotationMapper;
	@Autowired private OpportunityQuotationDetailMapper opportunityQuotationDetailMapper;
	@Autowired private OpportunityChatMapper opportunityChatMapper;
	
	@Resource private PartnerService partnerService;
	
	@Resource private CommonService commonService;
	@Resource private DZConfig dzConfig;
	
	public OpportunityOrder selectOneOpportunityOrder(PageData pd){
		return opportunityOrderMapper.selectByPrimaryKey(pd);
	}
	@SuppressWarnings("unused")
	public List<OpportunityOrder> listPageOpportunityOrders(Page page){
		PageData pd = page.getPd();
		List<OpportunityOrder> orders = opportunityOrderMapper.listPageOpportOrders(page);
		List<String> opportNoList = new ArrayList<>();
		for (OpportunityOrder opportunityOrder : orders) {
			if (StringUtil.isNotEmpty(opportunityOrder.getParticipantEmployeeId())) {
				pd.put("employeeIdIns", Tools.strSqlIn(opportunityOrder.getParticipantEmployeeId()));
				List<Employee> employees = this.listParticipanEmployees(pd);
				opportunityOrder.setParticipantEmployeeName(commonService.getConcatEmployeeName(employees));
			}
			opportNoList.add(opportunityOrder.getOppoNo());
		}
		
		if (opportNoList!=null&&opportNoList.size()>0) {
			
			//拼装最近联系记录
			Map<String, OpportunityChat> mapChat = new HashMap<>();
			pd.put("oppoNoIns", Tools.strSqlIn(Tools.list2InString(opportNoList)));
			List<OpportunityChat> chats = this.listLatestChat(pd);
			for (OpportunityChat chat : chats) {
				mapChat.put(chat.getOppoNo(), chat);
			}
			//拼装默认报价单的报价金额
			Map<String, OpportunityQuotation> mapQuot = new HashMap<>();
			pd.put("isDefault", "1");
			List<OpportunityQuotation> quotations = this.listQuotations(pd);
			for (OpportunityQuotation quot : quotations) {
				mapQuot.put(quot.getOppoNo(), quot);
			}
			
			//循环拼装赋值
			for (OpportunityOrder opportunityOrder : orders) {
				if (mapChat.size()>0) {
					OpportunityChat chat = mapChat.get(opportunityOrder.getOppoNo());
					opportunityOrder.setLatestChat(chat!=null?chat.getChatEmployeeName()+": "+chat.getChatContent():"");
				}
				if (mapQuot.size()>0) {
					OpportunityQuotation quotation = mapQuot.get(opportunityOrder.getOppoNo());
					opportunityOrder.setTotalPrice(quotation==null?BigDecimal.ZERO:quotation.getTotalPrice());
				}
				int upToNow = DateUtil.getIntervalDays(opportunityOrder.getStartDate(), new Date());
				opportunityOrder.setUpToNow(upToNow < 0 ? 0 : upToNow); //距今日期<0的，按0处理。
			}
			
		}
		return orders;
	}
	public int insertOpportunityOrder(OpportunityOrder opportunityOrder) throws YdzSystemRuntimeException{
		return opportunityOrderMapper.insertSelective(opportunityOrder);
	}
	public int updateOpportunityOrder(OpportunityOrder opportunityOrder) throws YdzSystemRuntimeException{
		return opportunityOrderMapper.updateByPrimaryKeySelective(opportunityOrder);
	}
	public int updateOpportunityOrderByParam(PageData pd) throws Exception{
		return opportunityOrderMapper.updateByPara(pd);
	}
	public int deleteOpportunityOrder(PageData pd) throws YdzSystemRuntimeException{
		return opportunityOrderMapper.deleteByPrimaryKey(pd);
	}
	public OrderTotalVO getSumOpportQuotMoney(PageData pd){
		return opportunityOrderMapper.getSumOpportQuotMoney(pd);
	}
//	===============
	public OpportunityQuotation selectOneOpportunityQuotation(PageData pd){
		return opportunityQuotationMapper.selectByPrimaryKey(pd);
	}
	public List<OpportunityQuotation> listQuotations(PageData pd){
		return opportunityQuotationMapper.listQuotations(pd);
	}
	public int insertOpportunityQuotation(OpportunityQuotation opportunityQuotation) throws YdzSystemRuntimeException{
		return opportunityQuotationMapper.insertSelective(opportunityQuotation);
	}
	public int updateOpportunityQuotation(OpportunityQuotation opportunityQuotation) throws YdzSystemRuntimeException{
		return opportunityQuotationMapper.updateByPrimaryKeySelective(opportunityQuotation);
	}
	public int deleteOpportunityQuotation(PageData pd) throws YdzSystemRuntimeException{
		return opportunityQuotationMapper.deleteByPrimaryKey(pd);
	}
//	===============
	public OpportunityQuotationDetail selectOneOpportunityQuotationDetail(PageData pd){
		return opportunityQuotationDetailMapper.selectByPrimaryKey(pd);
	}
	public List<OpportunityQuotationDetail> listPageOpportunityQuotationDetails(Page page){
		return opportunityQuotationDetailMapper.listPageOpportQuotDetails(page);
	}
	public int insertOpportunityQuotationDetail(OpportunityQuotationDetail opportunityQuotationDetail) throws YdzSystemRuntimeException{
		return opportunityQuotationDetailMapper.insertSelective(opportunityQuotationDetail);
	}
	public int insertListOpportunityQuotationDetail(List<OpportunityQuotationDetail> details) throws YdzSystemRuntimeException{
		return opportunityQuotationDetailMapper.insertList(details);
	}
	public int updateOpportunityQuotationDetail(OpportunityQuotationDetail opportunityQuotationDetail) throws YdzSystemRuntimeException{
		return opportunityQuotationDetailMapper.updateByPrimaryKeySelective(opportunityQuotationDetail);
	}
	public int deleteOpportunityQuotationDetail(PageData pd) throws YdzSystemRuntimeException{
		return opportunityQuotationDetailMapper.deleteByPrimaryKey(pd);
	}
//	===========
	public OpportunityChat selectOneOpportunityChat(PageData pd){
		return opportunityChatMapper.selectByPrimaryKey(pd);
	}
	public List<OpportunityChat> listPageOpportunityChats(Page page){
		return opportunityChatMapper.listPageOpportChats(page);
	}
	public List<OpportunityChat> listLatestChat(PageData pd){
		return opportunityChatMapper.listLatestChat(pd);
	}
	public int insertOpportunityChat(OpportunityChat opportunityChat) throws YdzSystemRuntimeException{
		return opportunityChatMapper.insertSelective(opportunityChat);
	}
	public int updateOpportunityChat(OpportunityChat opportunityChat) throws YdzSystemRuntimeException{
		return opportunityChatMapper.updateByPrimaryKeySelective(opportunityChat);
	}
	public int deleteOpportunityChat(PageData pd) throws Exception{
		return opportunityChatMapper.deleteByPrimaryKey(pd);
	}
	
	
	public List<Employee> listParticipanEmployees(PageData pd){
		return opportunityOrderMapper.listParticipanEmployees(pd);
	}
	
	/**
	 * 
	 * @Title: saveOpportunityOrder 
	 * @param opportunityOrder
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 新建商机概要单
	 */
	public int saveOpportunityOrder(OpportunityOrder opportunityOrder,UserVo userVo)
		throws YdzBusinessException,Exception{
		opportunityOrder.setOppoNo(CodeBuilderUtil.getInstance().getOrderId("SJ", 8)); //商机单号
		opportunityOrder.setComKey(userVo.getComKey());
		opportunityOrder.setIndustryId(userVo.getDetailIndustryId());
		opportunityOrder.setCreator(userVo.getUserKey());
		opportunityOrder.setCreateTime(new Date());
		opportunityOrder.setIsValid("1");
		opportunityOrder.setIsDel("0");
		if (StringUtil.isEmpty(opportunityOrder.getOrderSection())) {
			opportunityOrder.setOrderSection(ProjectEnum.OPPORT_ORDER_SECTION_CHANCE.getCode()); //商机阶段为空时默认为01商机
		}
		
		opportunityOrder.setStartDate(DateUtil.StringToDate(opportunityOrder.getStartDateValue(), DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
		opportunityOrder.setEndDate(DateUtil.StringToDate(opportunityOrder.getEndDateValue(), DateStyle.YYYY_MM_DD_HH_MM_SS.getValue()));
		
		PageData pd = new PageData();
		pd.put("partnerKey", opportunityOrder.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		opportunityOrder.setPartnerName(partner.getPartnerName());
		opportunityOrder.setPartnerShortname(partner.getPartnerShortname());
		
		int result = insertOpportunityOrder(opportunityOrder);
		if (result<=0) {
			throw new YdzBusinessException("新建商机概要失败");
		}
		return result;
		
	}
	/**
	 * 
	 * @Title: saveOpportunityQuotation 
	 * @param paraVO
	 * @param userVo
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 新建报价单及明细
	 */
	public int saveOpportunityQuotation(OpportunityQuotationParaVO paraVO,UserVo userVo)
			throws Exception{
		OpportunityQuotation quotation = paraVO.getOpportunityQuotation();
		List<OpportunityQuotationDetail> details = paraVO.getDetails();
		
		quotation.setQuotationNo(CodeBuilderUtil.getInstance().getOrderId("Q", 9)); //报价单号
		
		PageData pd = new PageData();
		pd.put("oppoNo", quotation.getOppoNo());
		OpportunityOrder opportOrder = this.selectOneOpportunityOrder(pd);
		if (opportOrder==null) {
			return 0;
		}
		quotation.setComKey(opportOrder.getComKey());
		quotation.setPartnerKey(opportOrder.getPartnerKey());
		quotation.setVersion(this.getCurrentVersionNo(pd));
		quotation.setVersionName("版本 v"+quotation.getVersion());
		quotation.setIsDel("0");
		if (quotation.getVersion()==1) {
			quotation.setIsDefault("1");
		}else{
			quotation.setIsDefault("0");
		}
		quotation.setCreateTime(new Date());
		quotation.setCreator(userVo.getUserKey());
		
		int item = 1;
		for (OpportunityQuotationDetail detail : details) {
			detail.setItemNo(item++);
			detail.setOppoNo(opportOrder.getOppoNo());
			detail.setQuotationNo(quotation.getQuotationNo());
			detail.setIsValid("1");
			detail.setIsDel("0");
			detail.setCreateTime(quotation.getCreateTime());
			detail.setCreator(quotation.getCreator());
		}
		
		int result = this.insertListOpportunityQuotationDetail(details);
		result = this.insertOpportunityQuotation(quotation);
		
		if (result<=0) {
			
			throw new YdzBusinessException("添加报价失败");
		}
		
		return result;
				
	}
	/**
	 * 
	 * @Title: getVersionNo 
	 * @param pd
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 获取版本号
	 */
	private int getCurrentVersionNo(PageData pd){
		Integer maxVersion = opportunityQuotationMapper.selectMaxVersionByPrimaryKey(pd);
		return maxVersion==null?1:maxVersion.intValue()+1;
	}
	
	private int getMinVersion(PageData pd){
		Integer minVersion = opportunityQuotationMapper.selectMinVersionByPrimaryKey(pd);
		return minVersion==null?0:minVersion;
	}
	
	/**
	 * 
	 * @Title: updateOpportunityQuotation 
	 * @param paraVO
	 * @param userVo
	 * @return
	 * @throws YdzBusinessException
	 * @return int
	 * @throws 
	 * @Description: 修改报价单及明细
	 */
	public int updateOpportunityQuotation(OpportunityQuotationParaVO paraVO,UserVo userVo)
			throws YdzBusinessException{
		OpportunityQuotation quotation = paraVO.getOpportunityQuotation();
		List<OpportunityQuotationDetail> details = paraVO.getDetails();
		
		//删除原报价列表
		PageData pd = new PageData();
		pd.put("quotationNo", quotation.getQuotationNo());
		this.deleteOpportunityQuotationDetail(pd);
		
		Date nowDate = new Date();
		int item = 1;
		for (OpportunityQuotationDetail detail : details) {
			detail.setItemNo(item++);
			detail.setOppoNo(quotation.getOppoNo());
			detail.setQuotationNo(quotation.getQuotationNo());
			detail.setIsValid("1");
			detail.setIsDel("0");
			detail.setCreateTime(nowDate);
			detail.setCreator(quotation.getCreator());
		}
		
		int result = this.insertListOpportunityQuotationDetail(details);
		result = this.updateOpportunityQuotation(quotation);
		
		if (result<=0) {
			throw new YdzBusinessException("修改报价失败");
		}
		
		return result;
	}
	
	/**
	 * 
	 * @Title: updateOpportunityQuotationByPara 
	 * @param pd
	 * @return
	 * @throws YdzSystemRuntimeException
	 * @return int
	 * @throws 
	 * @Description: 通过参数方式修改报价单
	 */
	public int updateOpportunityQuotationByPara(PageData pd)
			throws YdzSystemRuntimeException {
		return opportunityQuotationMapper.updateByPara(pd);
	}
	
	/**
	 * 
	 * @Title: updateSetDefaultVersion 
	 * @param pd
	 * @return
	 * @throws YdzSystemRuntimeException
	 * @return int
	 * @throws 
	 * @Description: 设置默认版本
	 */
	public int updateSetDefaultVersion(PageData pd)
			throws YdzSystemRuntimeException {
		pd.put("tempquotationNo", pd.getString("quotationNo"));
		
		pd.put("quotationNo", null);
		pd.put("isDefault", "0");
		int result = this.updateOpportunityQuotationByPara(pd); //先设置报价单全部为非默认
		if (result<=0) {
			throw new YdzBusinessException("设置默认报价单失败");
		}
		pd.put("quotationNo", pd.getString("tempquotationNo"));
		pd.put("isDefault", "1");
		result = this.updateOpportunityQuotationByPara(pd); //设置为默认
		if (result<=0) {
			throw new YdzBusinessException("设置默认报价单失败");
		}
		return result;
	}
	
	/**
	 * 
	 * @Title: listOpportunityQuotations 
	 * @param page
	 * @return
	 * @return List<OpportunityQuotation>
	 * @throws 
	 * @Description: 获取多条报价单记录及明细
	 */
	public List<OpportunityQuotation> listOpportunityQuotations(Page page){
		List<OpportunityQuotation> oqs = this.listOpportunityQuotations(page);
		for (OpportunityQuotation oq : oqs) {
			List<OpportunityQuotationDetail> details = this.listPageOpportunityQuotationDetails(page);
			oq.setDetails(details);
		}
		return oqs;
	}
	/**
	 * 
	 * @Title: getOneOpportunityQuotation 
	 * @return
	 * @return OpportunityQuotation
	 * @throws 
	 * @Description: 查询单条报价单
	 */
	public OpportunityQuotation getOneOpportunityQuotation(PageData pd){
		OpportunityQuotation oq = this.selectOneOpportunityQuotation(pd);
		if (oq!=null) {
			Page page = new Page();
			page.setShowCount(500);
			page.setPd(pd);
			pd.put("quotationNo", oq.getQuotationNo());
			oq.setDetails(this.listPageOpportunityQuotationDetails(page));
		}
		return oq;
	}
	
	/**
	 * 
	 * @Title: deleteOpportunityQuotationAndDetail 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @return int
	 * @throws 
	 * @Description: 删除报价单
	 * 查询需要删除的报价单
	 * 如果要删除的报价单为默认报价单，则修改最小版本为默认
	 */
	public int deleteOpportunityQuotationAndDetail(PageData pd) throws Exception{
		OpportunityQuotation quotation = this.selectOneOpportunityQuotation(pd);
		if (quotation==null) {
			return 0;
		}
		
		int result = this.deleteOpportunityQuotationDetail(pd);
		result = this.deleteOpportunityQuotation(pd);
		if (quotation.getIsDefault().equals("1")) {
			int minVersion = this.getMinVersion(pd);
			if (minVersion>0) {
				pd.put("version", minVersion);
				pd.put("isDefault", "1");
				this.updateOpportunityQuotationByPara(pd);
			}
		}
		return result;
	}

}