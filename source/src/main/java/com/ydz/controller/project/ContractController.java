/**   
 * @Title: ContractController.java 
 * @Package com.ydz.controller.project 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 29, 2017 4:38:48 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.project;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.UploadFile;
import com.ydz.entity.project.ContractProject;
import com.ydz.entity.project.ContractProjectParaVO;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.ProjectEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.exception.ProjectException;
import com.ydz.service.advert.ContractService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.FileDownload;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: ContractController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 29, 2017 4:38:48 PM 
 * @Description: 项目合同控制器
 * 
 */
@Controller
@RequestMapping(value = "ydz/contract", produces = "application/json;charset=UTF-8")
public class ContractController extends BaseController{
	private Logger logger = Logger.getLogger(this.getClass());
	private final String projectFilePath="project/contract/";
	
	@Resource
	private ContractService contractService;
	@Resource
	private CommonService commonService;
	@Resource
	private DZConfig dzConfig;
	@Resource
	private PartnerService partnerService;
	
	@RequestMapping(value = "getContractNo")
	@ResponseBody
	public String getContractNo(){
		return JsonUtil.toCompatibleJSONString(CodeBuilderUtil.getInstance().getOrderId("HT", 8));
	}
	
	//新建合同单
	@RequestMapping(value = "addContract")
	@ResponseBody
	public String addContract(@RequestBody ContractProjectParaVO contractProjectParaVO)
		throws Exception{
		UserVo userVo = this.getSessionUservo();
		if (contractProjectParaVO == null
				|| contractProjectParaVO.getContractProject() == null
				|| StringUtil.isEmpty(contractProjectParaVO
						.getContractProject().getContractNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建合同失败"));
		}
		int result = 0;
		try {
			result = contractService.insertContractAll(contractProjectParaVO, userVo);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("新建合同失败");
		}
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建合同失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("新建合同成功"));
		}
	}
	
	//查询合同单列表
	@RequestMapping(value = "listContractAllInfo")
	@ResponseBody
	public String listContract(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
        pd.put("startDate", pd.getStartDate(pd.getString("startTime")));
        pd.put("endDate", pd.getEndDate(pd.getString("endTime")));
        if("ALL".equalsIgnoreCase(pd.getString("partnerKey"))){
        	pd.put("partnerKey", null);
        }
        if (StringUtil.isEmpty(pd.getString("salesId"))) {
        	pd.put("salesId", null);
		}
		page.setPd(pd);
		List<ContractProject> contractProjects = contractService.listPageContractProjectsAllInfo(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(contractProjects);
		resultMap.setTotalCount(page.getTotalResult());
		resultMap.put("bottomInfo", contractService.getSumContractMoney(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "forward-contract-update")
	public ModelAndView forwardUpdateContract(){
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/project/project-contract-add-update").addObject(
				"contractNo", pd.getString("contractNo"));
	}
	
	/**
	 * 
	 * @Title: updateContract 
	 * @param contractProjectParaVO
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改合同单
	 * 修改合同单页面为综合页面，其中包括
	 * 1.修改合同单
	 * 2.修改回款计划——新建，删除，修改
	 * 3.修改发票记录——新建，删除，修改
	 * 4.修改回款记录——新建，删除，修改
	 */
	@RequestMapping(value = "updateContract")
	@ResponseBody
	public String updateContract(@RequestBody ContractProjectParaVO contractProjectParaVO)
		throws Exception{
		if (contractProjectParaVO == null
				|| contractProjectParaVO.getContractProject() == null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改合同失败"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = contractService.updateContractAll(contractProjectParaVO, pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("修改合同失败");
		}
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改合同失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改合同成功"));
		}
		
	}
	
	/**
	 * 
	 * @Title: changeContractStatus 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 修改合同单状态
	 */
	@RequestMapping(value = "changeContractStatus")
	@ResponseBody
	public String changeContractStatus() throws Exception{
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(pd.getString("contractNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("操作失败"));
		}
		try {
			int result = contractService.updateContractByPara(pd);
			if (result > 0 ) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("操作成功"));
			}else{
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("操作失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("修改合同单状态失败");
		}
	}
	
	@RequestMapping(value = "forward-contract-detail")
	public ModelAndView forwardContractDetail(){
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/project/project-contract-list-detail").addObject(
				"contractNo", pd.getString("contractNo"));
	}
	
	//查询单条合同单及详情
	@RequestMapping(value = "getOneContractProjectAllInfo")
	@ResponseBody
	public String getOneContractProjectAllInfo(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("contractNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有查到合同单"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		ResultMap resultMap = ResultUtil.getResultMap();
		
		ContractProject contract = contractService.selectContractProject(pd);
		pd.put("partnerKey", contract.getPartnerKey());
		pd.put("contacterId", contract.getContactId());
		PartnerContacter contacter = partnerService.selectOnePartnerContacter(pd);
		if (contacter!=null) {
			contract.setContactTel(contacter.getTel1());
		}
		resultMap.put("contract",contract);
		resultMap.put("plans", contractService.listPlans(pd));
		resultMap.put("invioces", contractService.listInvoices(pd));
		resultMap.put("returnMoneys", contractService.listReturnRecord(pd));
		pd.put("orderNo", pd.getString("contractNo"));
		resultMap.put("attachments", contractService.listAttachmentFiles(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//查询回款计划

	//查询发票记录
	
	//查询回款记录
	
	//	添加联系记录
	@RequestMapping(value="addContractChat")
	@ResponseBody
	public String addContractChat(@RequestBody OpportunityChat chat)
		throws Exception{
		if (chat==null
				||StringUtil.isEmpty(chat.getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		chat.setChatEmployeeId(userVo.getEmployeeId());
		chat.setChatEmployeeName(userVo.getRealName());
		chat.setComKey(userVo.getComKey());
		chat.setCreator(userVo.getUserKey());
		chat.setCreateTime(new Date());
		chat.setChatType(ProjectEnum.CHAT_TYPE_CONTRACT.getCode());
		chat.setIsValid("1");
		chat.setIsDel("0");
		int result = contractService.insertContractChat(chat);
		if (result<=0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
		}
	}
//	
//	查看联系记录
	@RequestMapping(value="getContractChatList")
	@ResponseBody
	public String getOpportChatList(){
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("chatType", ProjectEnum.CHAT_TYPE_CONTRACT.getCode());
		page.setPd(pd);
		List<OpportunityChat> chats = contractService.listPageContractChats(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(chats);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: listParticipanEmployees 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 获取参与人
	 */
	@RequestMapping(value = "listParticipanEmployees")
	@ResponseBody
	public String listParticipanEmployees(){
		PageData pd = this.getPageData();
		ContractProject contract = contractService.selectContractProject(pd);
		if (contract == null||StringUtil.isEmpty(contract.getParticipantEmployeeId())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有参与人"));
		}
		pd.clear();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("employeeIdIns", Tools.strSqlIn(contract.getParticipantEmployeeId()));
		List<Employee> employees = contractService.listParticipanEmployees(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}
	
	
	//分享转发短地址
	@SuppressWarnings("unchecked")
	@RequestMapping("shareUrl")
	@ResponseBody
	public String getShareUrl(String orderNo){
		if (StringUtil.isEmpty(orderNo)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), "无法查询此单，请重试"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("contractNo", orderNo);
		ContractProject contract = contractService.selectContractProject(pd);
		if (contract==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无此订单数据"));
		}
		ResultMap resultMap =ResultUtil.getResultMap();
        String orderUrl = "/ordershare/contract-project-share.html";
        resultMap.put("shareUrl",commonService.getShareUrlForOrder(orderUrl, contract.getIndustryId(), orderNo, userVo.getComKey()));
        return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	/**
	 * 
	 * @Title: fileUpload 
	 * @param multipartRequest
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 上传附件。支持多文件上传
	 */
	@RequestMapping(value = "fileUpload", method = RequestMethod.POST)  
	@ResponseBody  
	public String fileUpload(MultipartHttpServletRequest multipartRequest) 
		throws Exception{  
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("userKey", userVo.getUserKey());
		String filePath = dzConfig.attachmentFilePath+this.projectFilePath+userVo.getComKey()+"/"+multipartRequest.getParameter("contractNo")+"/";
		pd.put("filePath", filePath);
		pd.put("contractNo", multipartRequest.getParameter("contractNo"));
		String result = "";
        try {  
        	result = contractService.insertMultiFileUpload(multipartRequest.getFileMap(), pd);
        } catch (IllegalStateException e) {  
            logger.error(e);
            throw new ProjectException("上传附件失败");
        } catch (Exception e) {  
            logger.error(e);  
            throw new ProjectException("上传附件失败");
        }  
        return result;  
    }  
	
	/**
	 * 
	 * @Title: deleteFile 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 删除合同的附件
	 */
	@RequestMapping(value = "deletefile")  
	@ResponseBody  
	public String deleteFile() throws Exception {
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = contractService.deleteAttachmentFile(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("删除附件失败");
		}
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除附件成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除附件失败"));
		}
	}
	
	/**
	 * 
	 * @Title: downloadAndroidApp 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @return ModelAndView
	 * @throws 
	 * @Description: 下载附件
	 */
	@RequestMapping(value="download-attachment")
	public ModelAndView downloadProjectAttachment(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("fileId"))) {
			return null;
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());

		try {
			UploadFile file = commonService.selectOneUploadFile(pd);
			if (file != null) {
				FileDownload.fileDownload(response, file.getFilePath()+file.getFileName(),
						file.getFileName());
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("下载附件失败");
		}

		return null;
	}
	/**
	 * 
	 * @Title: updateContractByPara 
	 * @return
	 * @throws Exception
	 * @return String
	 * @throws 
	 * @Description: 参数式修改合同单信息
	 */
	@RequestMapping(value="updateContractByPara")
	@ResponseBody
	public String updateContractByPara()
		throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("contractNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有合同单号，修改失败"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		try {
			int result = contractService.updateContractByPara(pd);
			if (result>0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
			}else{
				return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("参数式修改合同单信息失败");
		}
	}
	
	
}
