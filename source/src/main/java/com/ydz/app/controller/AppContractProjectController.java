package com.ydz.app.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.project.ContractProject;
import com.ydz.entity.project.OpportunityChat;
import com.ydz.entity.system.Employee;
import com.ydz.entity.system.PartnerContacter;
import com.ydz.enums.ProjectEnum;
import com.ydz.service.advert.ContractService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: AppContractProjectController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 3, 2018 3:37:07 PM 
 * @Description: 项目合同的App控制器
 * 
 */
@RestController
@RequestMapping(value = "app/contract", produces = "application/json;charset=UTF-8")
public class AppContractProjectController extends BaseController{
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired private ContractService contractService;
	@Autowired private PartnerService partnerService;
	
	//查询合同单列表
	@RequestMapping(value = "listContractAllInfo", method = RequestMethod.GET)
	public String listContract(){
		UserVo userVo = this.getAppCurrentUserVo();
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
		resultMap.setPageCount(page.getTotalPage());
		resultMap.put("bottomInfo", contractService.getSumContractMoney(pd));
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//合同明细查看
	@RequestMapping(value = "getOneContractProjectAllInfo", method = RequestMethod.GET)
	public String getOneContractProjectAllInfo(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("contractNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有查到合同单"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
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
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//查看联系记录
	@RequestMapping(value="getContractChatList", method = RequestMethod.GET)
	public String getOpportChatList(){
		UserVo userVo = this.getAppCurrentUserVo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("contractNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有查到合同单"));
		}
		pd.put("oppoNo", pd.getString("contractNo"));
		pd.put("comKey", userVo.getComKey());
		pd.put("chatType", ProjectEnum.CHAT_TYPE_CONTRACT.getCode());
		page.setPd(pd);
		List<OpportunityChat> chats = contractService.listPageContractChats(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(chats);
		resultMap.setPageCount(page.getTotalPage());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//新增联系记录
	@RequestMapping(value="addContractChat", method = RequestMethod.POST)
	public String addContractChat(@RequestBody OpportunityChat chat)
		throws Exception{
		if (chat==null
				||StringUtil.isEmpty(chat.getOppoNo())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getAppCurrentUserVo();
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
	
	@RequestMapping(value = "listParticipanEmployees", method = RequestMethod.GET)
	public String listParticipanEmployees(){
		PageData pd = this.getPageData();
		ContractProject contract = contractService.selectContractProject(pd);
		if (contract == null||StringUtil.isEmpty(contract.getParticipantEmployeeId())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有参与人"));
		}
		pd.clear();
		UserVo userVo = this.getAppCurrentUserVo();
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(Tools.strSqlIn(contract.getParticipantEmployeeId()))) {
			pd.put("employeeIdIns", "('')");
		}else{
			pd.put("employeeIdIns", Tools.strSqlIn(contract.getParticipantEmployeeId()));
		}
		List<Employee> employees = contractService.listParticipanEmployees(pd);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setData(employees);
		return JsonUtil.toJsonString(resultMap);
	}

}
