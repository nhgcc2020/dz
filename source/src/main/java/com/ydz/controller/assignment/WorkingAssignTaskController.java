package com.ydz.controller.assignment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.assignment.AssignWorkingProcedure;
import com.ydz.entity.assignment.AssignWorkingTaskDetail;
import com.ydz.entity.assignment.AssignWorkingTaskDetailVO;
import com.ydz.entity.assignment.AssignWorkshopServicePrice;
import com.ydz.entity.assignment.WorkingTaskLabelVO;
import com.ydz.entity.common.ComConfig;
import com.ydz.entity.common.Country;
import com.ydz.entity.system.PartnerVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.SystemEnum;
import com.ydz.exception.AssignException;
import com.ydz.service.advert.WorkingAssignTaskService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.PublicUtil;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.TotalSalesOrderDetailVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WorkingAssignTaskController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年7月18日 下午5:57:12 
 * @Description: 制作派工控制器
 */
@Controller
@RequestMapping(value = "order/workingassigntask", produces = "application/json;charset=UTF-8")
public class WorkingAssignTaskController extends BaseController{
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource private WorkingAssignTaskService workingAssignTaskService;
	@Resource private PartnerService partnerService;
	@Resource private CompanyService companyService;
	@Resource private CommonService commonService;
	
	@Resource private RedisUtil redisUtil;
	@Resource private DZConfig dzConfig;
	
	/**
	 * 
	 * @Title: openAssignWorking 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 开启制作派工
	 */
	@RequestMapping(value = "openAssignWorking")
	@ResponseBody
	public String openAssignWorking(){
		UserVo userVo = this.getSessionUservo();
		ComConfig comConfig = new ComConfig();
		comConfig.setComKey(userVo.getComKey());
		comConfig.setConfigKey(Const.COMPANY_CONFIG_ASSIGN_WORKING);
		comConfig.setConfigValue("1");
		int result = commonService.insertComConfig(comConfig);
		if (result<1) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(new Integer(SystemEnum.RETURN_INFO_ERROR.getCode()).intValue(), "开启失败"));
		}
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	
	/**
	 * 
	 * @Title: openWorkingProcedure 
	 * @return
	 * @return String
	 * @throws 
	 * @Description: 开启或关闭复杂工序
	 */
	@RequestMapping(value = "openOrCloseWorkingProcedure")
	@ResponseBody
	public String openOrCloseWorkingProcedure(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = workingAssignTaskService.openOrCloseWorkingProcedure(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new AssignException("开启或关闭复杂工序出错");
		}
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(
					new Integer(SystemEnum.RETURN_INFO_ERROR.getCode())
							.intValue(), "开启失败"));
		}
		return JsonUtil.toCompatibleJSONString(ResultUtil.successExec());
	}
	
//================	工作车间
	
	//查询工作车间及工序
	@RequestMapping(value = "listWorkshops")
	@ResponseBody
	public String listWorkshops(){
		Page page = this.getPage();
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		page.setPd(pd);
		page.setShowCount(300);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(workingAssignTaskService.listWorkshops(page)));
	}
	
	//修改工作车间及工序
	@RequestMapping(value = "updateWorkshops")
	@ResponseBody
	public String updateWorkshops(@RequestBody AssignWorkingProcedure assignWorkingProcedure){
		if (assignWorkingProcedure == null
				||StringUtil.isEmpty(assignWorkingProcedure.getWorkshop())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		assignWorkingProcedure.setComKey(userVo.getComKey());
		workingAssignTaskService.updateWorkshop(assignWorkingProcedure);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("修改成功"));
	}
	
	//修改工作车间及工序
	@RequestMapping(value = "insertWorkshops")
	@ResponseBody
	public String insertWorkshops(@RequestBody AssignWorkingProcedure assignWorkingProcedure){
		if (assignWorkingProcedure == null
				||StringUtil.isEmpty(assignWorkingProcedure.getWorkshop())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(1, "保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.clear();
		pd.put("comKey", userVo.getComKey());
		pd.put("workshop", assignWorkingProcedure.getWorkshop());
		AssignWorkingProcedure workshop = workingAssignTaskService.selectOneWorkshop(pd);
		if (workshop!=null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(0, "工作车间已存在，不能重复创建"));
		}
		assignWorkingProcedure.setComKey(userVo.getComKey());
		assignWorkingProcedure.setIndustryId(userVo.getDetailIndustryId());
		assignWorkingProcedure.setCreateTime(new Date());
		assignWorkingProcedure.setCreator(userVo.getUserKey());
		workingAssignTaskService.insertWorkshop(assignWorkingProcedure);
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("保存成功"));
	}
	
	
	//工作车间工序及服务内容的设置
	@RequestMapping(value = "settingWorkshopProcedureForProductService")
	@ResponseBody
	public String settingWorkshopProcedureForProductService(@RequestBody List<AssignWorkshopServicePrice> servicePrices) throws Exception{
		UserVo userVo = this.getSessionUservo();
		int result = 0;
		if (servicePrices!=null
				&&servicePrices.size()>0) {
			result = workingAssignTaskService.insertAndUpdateBatchServicePrice(servicePrices, userVo.getComKey(),userVo.getDetailIndustryId());
		}
		if(result<=0){
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(0, "保存失败"));
		}
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("设置成功"));
	}
	
	@RequestMapping(value = "listWorkshopProcedureForProductService")
	@ResponseBody
	public String listWorkshopProcedureForProductService() throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		List<AssignWorkshopServicePrice> assignWorkshopServicePrices = workingAssignTaskService.listComProPriceAndWorkshop(userVo.getDetailIndustryId(), userVo.getComKey(), 
				CompanyEnum.PRICING_TYPE_SERVICE.getCode(), pd.getString("pCode"), "1",Integer.parseInt(pd.getString("tier")),pd.getString("searchKey"));
		return JsonUtil.toCompatibleJSONString(ResultUtil.successQuery(assignWorkshopServicePrices));
	}
	
	
//================	制作派工
	
	@RequestMapping(value = "listAssignWorkingTaskAndDetailsByOrder")
	@ResponseBody
	public String listAssignWorkingTaskAndDetailsByOrder(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		Page page = this.getPageWithParameter();
		pd.put("comKey", userVo.getComKey());
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		if (StringUtil.isEmpty(pd.getString("startDate"))) {
			pd.put("startDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("endDate"))) {
			pd.put("endDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("searchKey"))) {
			pd.put("searchKey", null);
		}
		page.setPd(pd);
		List<TotalSalesOrderDetailVO> detailVOs = workingAssignTaskService.listAssignWorkingTaskDetailVOsByOrder(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(detailVOs);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "listAssignWorkingTaskAndDetails")
	@ResponseBody
	public String listAssignWorkingTaskAndDetails(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		Page page = this.getPageWithParameter();
//		page.setCurrentPage(0);
//		page.setShowCount(300);
		if (StringUtil.isEmpty(pd.getString("salesNo"))) {
			pd.put("comKey", userVo.getComKey());
		}
		if ("ALL".equalsIgnoreCase(pd.getString("partnerKey"))) {
			pd.put("partnerKey", null);
		}
		if (StringUtil.isEmpty(pd.getString("startDate"))) {
			pd.put("startDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("endDate"))) {
			pd.put("endDate", null);
		}
		if (StringUtil.isEmpty(pd.getString("searchKey"))) {
			pd.put("searchKey", null);
		}
		pd.put("detail", "1");
		page.setPd(pd);
		List<AssignWorkingTaskDetailVO> detailVOs = workingAssignTaskService.listAssignWorkingTaskDetailVOs(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(detailVOs);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	@RequestMapping(value = "forward-assignworkingtask")
	public ModelAndView forwardAssignWorkingTask(){
		PageData pd = this.getPageData();
		return new ModelAndView("jsp/assignment/work-procedure-list").addObject("workingProcedure", pd.getString("workingProcedure"));
	}
	
	@RequestMapping(value = "assignTask")
	@ResponseBody
	public String assignTask(){
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		try {
			workingAssignTaskService.updateAssignTask(pd);
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtil.toCompatibleJSONString(ResultUtil.error(0, "操作失败"));
		}
		
		return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("已完工"));
	}
	
	@RequestMapping(value = "workingTaskLabel")
	@ResponseBody
	public String getWorkingTaskLabel() throws Exception{
		ResultMap resultMap = ResultUtil.getResultMap();
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		if (StringUtil.isNotEmpty(pd.getString("uidIns"))) {
			pd.put("uidIns", Tools.strSqlIn(pd.getString("uidIns")));
		}
		String partnerKey = pd.getString("partnerKey");
		PartnerVO partnerVO = partnerService.selectOnePartnerAndContacterByPartnerKey(pd);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(userVo.getComKey(), partnerKey);
		
		List<AssignWorkingTaskDetail> details = workingAssignTaskService.selectListAssignWorkingTaskDetail(pd);
		List<WorkingTaskLabelVO> labelVOs = null;
		WorkingTaskLabelVO labelVO = null;
		if (details!=null) {
			labelVOs = new ArrayList<>();
			for (AssignWorkingTaskDetail detail : details) {
				labelVO = new WorkingTaskLabelVO();
				String partnerShortname = partnerVO.getPartnerShortname();
				labelVO.setPartnerShortname(partnerShortname.length()>6?partnerShortname.substring(0, 6):partnerShortname);
				labelVO.setContacterName(partnerVO.getContacterName());
				labelVO.setMobile(StringUtil.isEmpty(partnerVO.getTel1())?"":partnerVO.getTel1());
				labelVO.setTel(StringUtil.isEmpty(partnerVO.getPartnerTel())?"":partnerVO.getPartnerTel());
				labelVO.setBusinessDesc(detail.getBusinessDesc());
				labelVO.setRequirement(detail.getRequirements());
				labelVO.setSpecification(detail.getSpecification());
				labelVO.setQuantity(detail.getQuantity().intValue());
				String countryStr =""; 
				Object countryObject = redisUtil.get(Const.COUNTRY_REDIS+partnerVO.getPartnerCountry());
				if (countryObject!=null) {
					countryStr = ((Country)countryObject).getCountryName();
				}
				String addr = StringUtil.isNotEmpty(partnerVO.getPartnerAddress())?partnerVO.getPartnerAddress():"";
				if (StringUtil.isEmpty(countryStr)&&StringUtil.isEmpty(addr)) {
					addr = "无";
				}else{
					addr = countryStr+" "+addr;
				}
				labelVO.setAddress(addr);
				labelVO.setComShortname(companyVO.getComShortname());
				labelVO.setComTel(companyVO.getComTel());
				String taskUrl = dzConfig.webPath+"/code/working-assign-label-code.html";
				labelVO.setTaskurl(PublicUtil.getInstance().getShortUrl(taskUrl));
				
				labelVOs.add(labelVO);
			}
		}
		resultMap.setData(labelVOs);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}

}
