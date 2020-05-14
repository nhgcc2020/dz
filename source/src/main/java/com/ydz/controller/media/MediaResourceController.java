package com.ydz.controller.media;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import sun.tools.tree.ThisExpression;

import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.UploadFile;
import com.ydz.entity.media.MediaPointLocation;
import com.ydz.entity.media.MediaResource;
import com.ydz.entity.media.MediaRunPlan;
import com.ydz.entity.media.MediaRunPlanDetail;
import com.ydz.entity.media.MediaRunPlanVO;
import com.ydz.exception.MediaException;
import com.ydz.exception.ProjectException;
import com.ydz.service.advert.MediaService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.CompanyVO;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: MediaResourceController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 28, 2017 5:42:48 PM 
 * @Description: 媒体资源管理控制器
 */
@Controller
@RequestMapping(value = "ydz/mediaresource", produces = "application/json; charset=UTF-8")
public class MediaResourceController extends BaseController{
	private Logger logger  = Logger.getLogger(this.getClass());
	
	private final String mediaPointFilePath="picture/media/point/";
	
	@Autowired
	private MediaService mediaService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private DZConfig dzConfig;
	@Autowired
	private CompanyService companyService;
	
	//新建媒体
	@RequestMapping(value = "insertMediaResource",method = RequestMethod.POST)
	@ResponseBody
	public String insertMediaResource(@RequestBody MediaResource mediaResource)
			throws Exception {
		if (mediaResource == null
				|| StringUtil.isEmpty(mediaResource.getMediaDesc())) {
			return JsonUtil
					.toCompatibleJSONString(ResultUtil.error("新建媒体资源失败"));
		}
		try {
			UserVo userVo = this.getSessionUservo();
			mediaResource.setComKey(userVo.getComKey());
			mediaResource.setIndustryId(userVo.getDetailIndustryId());
			mediaResource
					.setMediaNo(CodeBuilderUtil.getInstance().getAnyId(10));
			mediaResource.setIsDel("0");
			mediaResource.setCreator(userVo.getUserKey());
			mediaResource.setCreateTime(new Date());
			mediaResource.setPointNum(0);
			int result = mediaService.insertOneMediaResource(mediaResource);
			if (result > 0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.successMsg("新建成功"));
			} else {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.error("新建媒体资源失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("新建媒体资源失败");
		}
	}
	
	//跳转修改媒体资源
	@RequestMapping(value="forward-mediaresource-update", method = RequestMethod.GET)
	public ModelAndView forwardMediaResourceUpdate(){
		return new ModelAndView("jsp/media/media-resource-add").addObject("mediaNo", this.getPageData().getString("mediaNo"));
	}
	
	//修改媒体资源
	@RequestMapping(value = "updateMediaResource", method = RequestMethod.PUT)
	@ResponseBody
	public String updateMediaResource(@RequestBody MediaResource mediaResource) throws Exception {
		if (mediaResource == null
				|| StringUtil.isEmpty(mediaResource.getMediaDesc())) {
			return JsonUtil
					.toCompatibleJSONString(ResultUtil.error("修改媒体资源失败"));
		}
		
		try {
			mediaResource.setComKey(this.getSessionUservo().getComKey());
			int result = mediaService.updateMediaResource(mediaResource);
			if (result > 0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.successMsg("修改成功"));
			} else {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.error("修改媒体资源失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("修改媒体资源失败");
		}
	}
	
	//查看媒体资源明细
	@RequestMapping(value = "getMediaResourcesDetais",method = RequestMethod.GET)
	@ResponseBody
	public String getMediaResourcesDetails(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("mediaNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有记录"));
		}
		pd.put("comKey", this.getSessionUservo().getComKey());
		MediaResource mediaResource = mediaService.selectOneMediaResource(pd);
		return JsonUtil.toCompatibleJSONString(mediaResource);
	}
	
	//查看媒体列表
	@RequestMapping(value = "listMediaResources",method = RequestMethod.GET)
	@ResponseBody
	public String listMediaResources(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		
		pd.put("comKey", userVo.getComKey());
		if (StringUtil.isEmpty(pd.getString("mediaType"))) {
			pd.put("mediaType", null);
		}
		if (StringUtil.isEmpty(pd.getString("showType"))) {
			pd.put("showType", null);
		}
		
		page.setPd(pd);
		List<MediaResource> mediaResources = mediaService.listMediaResource(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(mediaResources);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//新建点位
	@RequestMapping(value="insertNewMediaPointLocation", method = RequestMethod.POST)
	@ResponseBody
	public String insertNewMediaPointLocation(
			@RequestBody List<MediaPointLocation> locations) throws Exception {
		if (locations == null || locations.size() <= 0) {
			return JsonUtil.toJsonString(ResultUtil.error("新建点位失败"));
		}
		UserVo userVo = this.getSessionUservo();
		int result = 0;
		try {
			result = mediaService.insertListLocations(locations, userVo);
			if (result > 0) {
				return JsonUtil.toJsonString(ResultUtil.successMsg("新建点位成功"));
			} else {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.error("新建点位失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建点位失败"));
		}
	}
	//跳转修改点位
	@RequestMapping(value="forward-mediapointlocation-update", method = RequestMethod.GET)
	public ModelAndView forwardMediaPointLocationUpdate() {
		return new ModelAndView("jsp/media/media-point-add").addObject(
				"pointNo", this.getPageData().getString("pointNo")).addObject(
				"mediaNo", this.getPageData().getString("mediaNo"));
	}
	
	//查看点位明细
	@RequestMapping(value="getMediaPointLocationDetail", method = RequestMethod.GET)
	@ResponseBody
	public String getMediaPointLocationDetail(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("mediaNo"))
				|| StringUtil.isEmpty("pointNo")) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无记录"));
		}
		pd.put("comKey", this.getSessionUservo().getComKey());
		MediaPointLocation location = mediaService.selectOneMediaPointLocation(pd);
		return JsonUtil.toCompatibleJSONString(location);
	}
	
	//修改点位
	@RequestMapping(value = "updateMediaPointLocaiton", method = RequestMethod.PUT)
	@ResponseBody
	public String updateMediaPointLocaiton(@RequestBody MediaPointLocation location) throws Exception {
		if (location == null || StringUtil.isEmpty(location.getPointNo())) {
			return JsonUtil.toJsonString(ResultUtil.error("修改点位失败"));
		}
		
		try {
			int result = mediaService.updateMediaPointLocation(location);
			if (result > 0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.successMsg("修改成功"));
			} else {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.error("修改点位失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("修改点位失败");
		}
	}
	
	//修改点位状态
	@RequestMapping(value = "updateStatusForMediaPointLocaiton", method = RequestMethod.PUT)
	@ResponseBody
	public String updateStatusForMediaPointLocaiton() throws Exception{
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("pointNo"))||StringUtil.isEmpty(pd.getString("mediaNo"))) {
			return JsonUtil.toJsonString(ResultUtil.error("修改失败"));
		}
		try {
			int result = mediaService.updateStatusForMediaPointLocation(pd);
			if (result > 0) {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.successMsg("修改成功"));
			} else {
				return JsonUtil.toCompatibleJSONString(ResultUtil
						.error("修改失败"));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("修改失败");
		}
	}
	
	//查看点位
	@RequestMapping(value="listMediaPointLocations", method = RequestMethod.GET)
	@ResponseBody
	public String listMediaPointLocations(){
		UserVo userVo = this.getSessionUservo();
		Page page = this.getPageWithParameter();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("belongsType", StringUtil.isEmpty(pd.getString("belongsType"))?null:pd.getString("belongsType"));
		pd.put("status", StringUtil.isEmpty(pd.getString("status"))?null:pd.getString("status"));
		pd.put("pointProvince", StringUtil.isEmpty(pd.getString("pointProvince"))?null:pd.getString("pointProvince"));
		pd.put("pointCity", StringUtil.isEmpty(pd.getString("pointCity"))?null:pd.getString("pointCity"));
		pd.put("pointCountry", StringUtil.isEmpty(pd.getString("pointCountry"))?null:pd.getString("pointCountry"));
		page.setPd(pd);
		List<MediaPointLocation> locations = mediaService.listMediaPointLocations(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(locations);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//跳转查看排期
	@RequestMapping(value="forward-media-point-period", method = RequestMethod.GET)
	public ModelAndView forwardMediaPointPeriod() {
		return new ModelAndView("jsp/media/media-resource-schedule-list")
				.addObject("pointNo", this.getPageData().getString("pointNo"))
				.addObject("planNo", this.getPageData().getString("planNo"))
				.addObject("type", this.getPageData().getString("type"));
	}
	
	//查看排期
	@RequestMapping(value="getMediaPointPeriod", method = RequestMethod.GET)
	@ResponseBody
	public String getMediaPointPeriod(){
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("type"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有排期"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		pd.put("planNo", StringUtil.isEmpty(pd.getString("planNo"))?null:pd.getString("planNo"));
		pd.put("pointNo", StringUtil.isEmpty(pd.getString("pointNo"))?null:pd.getString("pointNo"));
		//查看点位的所有排期
		return JsonUtil.toCompatibleJSONString(mediaService.queryMediaRunPlanPointPeriod(pd));
	}
	
	//新建投放计划
	@RequestMapping(value="insertNewMediaRunPlan", method = RequestMethod.POST)
	@ResponseBody
	public String insertNewMediaRunPlan(
			@RequestBody MediaRunPlanVO mediaRunPlanVO) throws Exception {
		if (mediaRunPlanVO==null||mediaRunPlanVO.getMediaRunPlan()==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建投放计划失败"));
		}
		int result = mediaService.insertMediaRunPlanAndDetail(mediaRunPlanVO, this.getSessionUservo());
		if (result > 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("已新建投放计划"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("新建投放计划失败"));
		}
	}
	//修改投放计划
	@RequestMapping(value="updateMediaRunPlan", method = RequestMethod.PUT)
	@ResponseBody
	public String updateMediaRunPlan(
			@RequestBody MediaRunPlanVO mediaRunPlanVO) throws Exception {
		if (mediaRunPlanVO==null||mediaRunPlanVO.getMediaRunPlan()==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改投放计划失败"));
		}
		mediaRunPlanVO.getMediaRunPlan().setComKey(this.getSessionUservo().getComKey());
		mediaRunPlanVO.getMediaRunPlan().setCreator(this.getSessionUservo().getUserKey());
		int result = mediaService.updateMediaRunPlanAndDetail(mediaRunPlanVO);
		if (result > 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("已修改投放计划"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改投放计划失败"));
		}
	}
	//查看投放计划列表
	@RequestMapping(value="listMediaRunPlans", method = RequestMethod.GET)
	@ResponseBody
	public String listMediaRunPlans(){
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		Page page = this.getPageWithParameter();
		pd.put("comKey", userVo.getComKey());
		pd.put("partnerKey", StringUtil.isEmpty(pd.getString("partnerKey"))
				|| "ALL".equalsIgnoreCase(pd.getString("partnerKey")) ? null
				: pd.getString("partnerKey"));
		pd.put("planStatus",
				StringUtil.isEmpty(pd.getString("planStatus")) ? null : pd
						.getString("planStatus"));
		pd.put("startDate",
				StringUtil.isEmpty(pd.getString("startDate")) ? null : pd
						.getString("startDate"));
		pd.put("endDate", StringUtil.isEmpty(pd.getString("endDate")) ? null
				: pd.getString("endDate"));
		
		page.setPd(pd);
		List<MediaRunPlan> plans = mediaService.listMediaRunPlans(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.setRows(plans);
		resultMap.setTotalCount(page.getTotalResult());
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
	//跳转新建或修改投放计划页面
	@RequestMapping(value="forward-mediarunplan-add-update", method = RequestMethod.GET)
	public ModelAndView forwardMediaRunPlanDetailAddOrUpdate(){
		return new ModelAndView("jsp/media/media-run-plan-add-update").addObject("planNo", this.getPageData().getString("planNo"));
	}
	
	//跳转查看投放计划详情页面
	@RequestMapping(value="forward-media-run-plan-detail", method = RequestMethod.GET)
	public ModelAndView forwardMediaRunPlanDetail(){
		return new ModelAndView("jsp/media/media-run-plan-detail").addObject("planNo", this.getPageData().getString("planNo"));
	}
	
	
	/**
	 * 
	 * @Title: getMediaRunPlansAndDetail 
	 * @return
	 * @return String
	 * @throws Exception 
	 * @throws 
	 * @Description: 获取单条投放计划单及明细
	 */
	@RequestMapping(value="getMediaRunPlansAndDetail", method = RequestMethod.GET)
	@ResponseBody
	public String getMediaRunPlansAndDetail() throws Exception{
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("planNo"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("无法查询投放计划"));
		}
		pd.put("comKey", userVo.getComKey());
		MediaRunPlan mediaRunPlan = mediaService.selectOneMediaRunPlan(pd);
		Page page = this.getPage();
		page.setShowCount(10000);
		page.setPd(pd);
		List<MediaRunPlanDetail> details = mediaService.listMediaRunPlanDetails(page);
		ResultMap resultMap = ResultUtil.getResultMap();
		resultMap.put("order", mediaRunPlan);
		resultMap.put("details", details);
		CompanyVO companyVO = companyService.selectOrderDetailCompany(
				userVo.getComKey(), mediaRunPlan.getPartnerKey()); // 详情页底部信息
		resultMap.put("bottomComInfo", companyVO);
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	
    //事项提醒
	@RequestMapping(value="getMediaRunPlansTodo", method = RequestMethod.GET)
	@ResponseBody
	public String getMediaRunPlansTodo(){
		PageData pd = this.getPageData();
		pd.put("comKey", this.getSessionUservo().getComKey());
		ResultMap resultMap = mediaService.queryMediaTodoList(pd);
		
		return JsonUtil.toCompatibleJSONString(resultMap);
	}
	//实景图列表查看
	@RequestMapping(value = "listPictureFile", method = RequestMethod.GET)  
	@ResponseBody
	public String listPictureFile() {
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("orderNo", pd.getString("pointNo"));
		List<UploadFile> uploadFiles = commonService.listUploadFiles(pd);
		for (UploadFile uploadFile : uploadFiles) {
			uploadFile.setShowPath("/"+this.mediaPointFilePath+userVo.getComKey()+"/"+uploadFile.getOrderNo()+"/"+uploadFile.getFileName());
		}
		
		return JsonUtil.toCompatibleJSONString(uploadFiles);
	}
	
	//跳转查看点位实景图
	@RequestMapping(value="forward-media-point-picture-view", method = RequestMethod.GET)
	public ModelAndView forwardMediaPointPicture(){
		return new ModelAndView("jsp/media/media-image-view").addObject("pointNo", this.getPageData().getString("pointNo"));
	}
	
	//实景图上传
	@RequestMapping(value = "fileUpload", method = RequestMethod.POST)  
	@ResponseBody
	public String fileUpload(MultipartHttpServletRequest multipartRequest) 
		throws Exception{  
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("userKey", userVo.getUserKey());
		String filePath = dzConfig.ydzHome+this.mediaPointFilePath+userVo.getComKey()+"/"+multipartRequest.getParameter("pointNo")+"/";
		pd.put("filePath", filePath);
		pd.put("fileType", "MT"); //媒体
		pd.put("orderNo", multipartRequest.getParameter("pointNo"));
		String result = "";
        try {  
        	result = commonService.insertMultiFileUpload(multipartRequest.getFileMap(), pd);
        } catch (IllegalStateException e) {  
            logger.error(e);
            throw new ProjectException("上传附件失败");
        } catch (Exception e) {  
            logger.error(e);  
            throw new ProjectException("上传附件失败");
        }  
        return result;  
    }  
	
	@RequestMapping(value = "deletefile", method = RequestMethod.DELETE)  
	@ResponseBody
	public String deleteFile() throws Exception {
		PageData pd = this.getPageData();
		if (StringUtil.isEmpty(pd.getString("fileId"))) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除实景图片失败"));
		}
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = commonService.deleteAttachmentFile(pd);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new ProjectException("删除实景图片失败");
		}
		if (result>0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.successMsg("删除实景图片成功"));
		}else{
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除实景图片失败"));
		}
	}
	
}
