/**   
 * @Title: MediaService.java 
 * @Package com.ydz.service.advert 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 27, 2017 7:46:39 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.advert;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSONArray;
import com.ydz.dao.media.MediaPointLocationMapper;
import com.ydz.dao.media.MediaResourceMapper;
import com.ydz.dao.media.MediaRunPlanDetailMapper;
import com.ydz.dao.media.MediaRunPlanMapper;
import com.ydz.entity.Page;
import com.ydz.entity.ResultMap;
import com.ydz.entity.common.City;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.common.Country;
import com.ydz.entity.common.Province;
import com.ydz.entity.common.UploadFile;
import com.ydz.entity.media.MediaPointLocation;
import com.ydz.entity.media.MediaResource;
import com.ydz.entity.media.MediaRunPlan;
import com.ydz.entity.media.MediaRunPlanDetail;
import com.ydz.entity.media.MediaRunPlanDetailPointLocationVO;
import com.ydz.entity.media.MediaRunPlanVO;
import com.ydz.entity.system.Partner;
import com.ydz.enums.MediaEnum;
import com.ydz.exception.MediaException;
import com.ydz.exception.ProjectException;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.Const;
import com.ydz.util.DateUtil;
import com.ydz.util.FileUpload;
import com.ydz.util.FileUtil;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.util.UuidUtil;
import com.ydz.util.redis.RedisUtil;
import com.ydz.util.sys.CodeBuilderUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: MediaService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 27, 2017 7:46:39 PM 
 * @Description: 媒体资源管理Service
 */
@Service
public class MediaService {
	private Logger logger  = Logger.getLogger(this.getClass());
	
	@Autowired
	private MediaResourceMapper mediaResourceMapper;
	@Autowired
	private MediaPointLocationMapper mediaPointLocationMapper;
	@Autowired
	private MediaRunPlanMapper mediaRunPlanMapper;
	@Autowired
	private MediaRunPlanDetailMapper mediaRunPlanDetailMapper;
	@Autowired
	private RedisUtil redisUtil;
	@Autowired
	private CommonService commonService;
	@Autowired
	private PartnerService partnerService;
	
	
	//媒体资源
	public MediaResource selectOneMediaResource(PageData pd){
		return mediaResourceMapper.selectByPrimaryKey(pd);
	}
	public List<MediaResource> listMediaResource(Page page){
		return mediaResourceMapper.listPageMediaResources(page);
	}
	public int insertOneMediaResource(MediaResource mediaResource) throws Exception{
		return mediaResourceMapper.insertSelective(mediaResource);
	}
	public int updateMediaResource(MediaResource mediaResource) throws Exception{
		return mediaResourceMapper.updateByPrimaryKeySelective(mediaResource);
	}
	public int deleteMediaResource(PageData pd) throws Exception{
		return mediaResourceMapper.deleteByPrimaryKey(pd);
	}
	
	//资源点位
	public MediaPointLocation selectOneMediaPointLocation(PageData pd){
		return mediaPointLocationMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	 * @Title: listMediaPointLocations 
	 * @param page
	 * @return
	 * @return List<MediaPointLocation>
	 * @throws 
	 * @Description: 查询媒体点位列表，格式化处理点位状态，省市县名称
	 */
	public List<MediaPointLocation> listMediaPointLocations(Page page){
		List<MediaPointLocation> locations = mediaPointLocationMapper.listPageMediaPointLocations(page);
		for (MediaPointLocation location : locations) {
			location.setStatusDesc(MediaEnum.codeOf(location.getStatus()).getDesc());
//			if (StringUtil.isNotEmpty(location.getPointProvince())) {
//				location.setPointProvinceName(((Province) redisUtil
//						.get(Const.PROVINCE_REDIS + location.getPointProvince()))
//						.getProvinceName());
//			}
//			if (StringUtil.isNotEmpty(location.getPointCity())) {
//				location.setPointCityName(((City) redisUtil
//						.get(Const.CITY_REDIS + location.getPointCity()))
//						.getCityName());
//			}
//			if (StringUtil.isNotEmpty(location.getPointCountry())) {
//				location.setPointCountryName(((Country) redisUtil
//						.get(Const.COUNTRY_REDIS + location.getPointCountry()))
//						.getCountryName());
//			}
		}
		return locations;
	}
	public int insertOneMediaPointLocation(MediaPointLocation location) throws Exception{
		return mediaPointLocationMapper.insertSelective(location);
	}
	private int insertListMediaPointLocations(List<MediaPointLocation> locations) throws Exception{
		return mediaPointLocationMapper.insertList(locations);
	}
	public int updateMediaPointLocation(MediaPointLocation location) throws Exception{
		return mediaPointLocationMapper.updateByPrimaryKeySelective(location);
	}
	public int updateStatusForMediaPointLocation(PageData pd) throws Exception{
		return mediaPointLocationMapper.updateStatusByPrimaryKey(pd);
	}
	
	public int deleteMediaPointLocation(PageData pd) throws Exception{
		return mediaPointLocationMapper.deleteByPrimaryKey(pd);
	}
	
	//投放计划
	public MediaRunPlan selectOneMediaRunPlan(PageData pd){
		return mediaRunPlanMapper.selectByPrimaryKey(pd);
	}
	public List<MediaRunPlan> listMediaRunPlans(Page page){
		return mediaRunPlanMapper.listPageMediaRunPlans(page);
	}
	private int insertOneMediaRunPlan(MediaRunPlan mediaRunPlan) throws Exception{
		return mediaRunPlanMapper.insertSelective(mediaRunPlan);
	}
	public int updateMediaRunPlan(MediaRunPlan mediaRunPlan) throws Exception{
		return mediaRunPlanMapper.updateByPrimaryKeySelective(mediaRunPlan);
	}
	public int deleteMediaRunPlan(PageData pd) throws Exception{
		return mediaRunPlanMapper.deleteByPrimaryKey(pd);
	}
	
	//投放计划明细
	public MediaRunPlanDetail selectOneMediaRunPlanDetail(PageData pd){
		return mediaRunPlanDetailMapper.selectByPrimaryKey(pd);
	}
	public List<MediaRunPlanDetail> listMediaRunPlanDetails(Page page){
		return mediaRunPlanDetailMapper.listPageMediaRunPlanDetails(page);
	}
	private int insertOneMediaRunPlanDetail(MediaRunPlanDetail detail) throws Exception{
		return mediaRunPlanDetailMapper.insertSelective(detail);
	}
	private int insertListMediaRunPlanDetails(List<MediaRunPlanDetail> details) throws Exception{
		return mediaRunPlanDetailMapper.insertList(details);
	}
	public int updateMediaRunPlanDetail(MediaRunPlanDetail detail) throws Exception{
		return mediaRunPlanDetailMapper.updateByPrimaryKeySelective(detail);
	}
	public int deleteMediaRunPlanDetail(PageData pd) throws Exception{
		return mediaRunPlanDetailMapper.deleteByPrimaryKey(pd);
	}
	
	public int insertListLocations(List<MediaPointLocation> locations,UserVo userVo) throws Exception{
		int itemNo = 1;
		for (MediaPointLocation location : locations) {
			if (StringUtil.isEmpty(location.getMediaNo())) {
				return 0 ;
			}
			location.setItemNo(itemNo++);
			location.setComKey(userVo.getComKey());
			location.setIndustryId(userVo.getDetailIndustryId());
			location.setPointNo(CodeBuilderUtil.getInstance().getAnyId(10));
			location.setStatus(MediaEnum.POINT_STATUS_NORMAL.getCode());
			location.setIsDel("0");
			location.setCreateTime(new Date());
			location.setCreator(userVo.getUserKey());
		}
		int result = 0;
		try {
			result = this.insertListMediaPointLocations(locations);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("新建点位失败");
		}
		return result;
	}
	
	public int insertMediaRunPlanAndDetail(MediaRunPlanVO mediaRunPlanVO,
			UserVo userVo) throws Exception {
		MediaRunPlan plan = mediaRunPlanVO.getMediaRunPlan();
		if (StringUtil.isEmpty(plan.getPartnerKey())) {
			return 0;
		}
		List<MediaRunPlanDetail> details = mediaRunPlanVO.getDetails();
		
		plan.setPlanNo(CodeBuilderUtil.getInstance().getAnyId(10));
		plan.setComKey(userVo.getComKey());
		plan.setIndustryId(userVo.getDetailIndustryId());
		plan.setCreator(userVo.getUserKey());
		plan.setCreateTime(new Date());
		plan.setIsDel("0");
		
		PageData pd = new PageData();
		pd.put("partnerKey", plan.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		if (partner!=null) {
			plan.setPartnerName(partner.getPartnerName());
			plan.setPartnerShortname(partner.getPartnerShortname());
		}
		
		int itemNo = 1;
		for (MediaRunPlanDetail detail : details) {
			detail.setItemNo(itemNo++);
			detail.setPlanNo(plan.getPlanNo());
			detail.setDays(DateUtil.getIntervalDays(detail.getStartDate(), detail.getEndDate())+1);
			detail.setCreator(plan.getCreator());
			detail.setCreateTime(plan.getCreateTime());
			detail.setIsDel("0");
		}
		plan.setPointNum(itemNo-1);
		int result = 0;
		try {
			result = this.insertListMediaRunPlanDetails(details);
			if (result>0) {
				pd.clear();
				pd.put("planNo", plan.getPlanNo());
				MediaRunPlan plan2 = mediaRunPlanMapper.selectMinStartMaxEnd(pd); //
				if (plan2!=null) {
					plan.setStartDate(plan2.getStartDate());
					plan.setEndDate(plan2.getEndDate());
				}
				result = this.insertOneMediaRunPlan(plan);
				if (result<=0) {
					return 0;
				}
			}else{
				return 0;
			}
			return result;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("新建投放计划失败");
		}
	}
	
	public int updateMediaRunPlanAndDetail(MediaRunPlanVO mediaRunPlanVO) throws Exception {
		MediaRunPlan plan = mediaRunPlanVO.getMediaRunPlan();
		List<MediaRunPlanDetail> details = mediaRunPlanVO.getDetails();
		
		PageData pd = new PageData();
		pd.put("comKey", plan.getComKey());
		pd.put("planNo", plan.getPlanNo());
		MediaRunPlan oldPlan = this.selectOneMediaRunPlan(pd);
		if (oldPlan==null) {
			return 0;
		}
		pd.clear();
		pd.put("partnerKey", plan.getPartnerKey());
		Partner partner = partnerService.findPartner(pd);
		if (partner!=null) {
			plan.setPartnerName(partner.getPartnerName());
			plan.setPartnerShortname(partner.getPartnerShortname());
		}
		
		int itemNo = 1;
		Date nowTime = new Date();
		for (MediaRunPlanDetail detail : details) {
			detail.setItemNo(itemNo++);
			detail.setPlanNo(plan.getPlanNo());
			detail.setDays(DateUtil.getIntervalDays(detail.getStartDate(), detail.getEndDate()));
			detail.setCreator(plan.getCreator());
			detail.setCreateTime(nowTime);
			detail.setIsDel("0");
		}
		plan.setPointNum(itemNo-1);
		int result = 0;
		try {
			pd.clear();
			pd.put("planNo", plan.getPlanNo());
			result = this.deleteMediaRunPlanDetail(pd);
			result = this.insertListMediaRunPlanDetails(details);
			MediaRunPlan plan2 = mediaRunPlanMapper.selectMinStartMaxEnd(pd); 
			if (plan2!=null) {
				plan.setStartDate(plan2.getStartDate());
				plan.setEndDate(plan2.getEndDate());
			}
			result = this.updateMediaRunPlan(plan);
			if (result<=0) {
				throw new MediaException("修改投放计划失败");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("修改投放计划失败");
		}
		return result;
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
				pd.put("orderNo", pd.getString("mediaNo"));
				pd.put("fileName", file.getOriginalFilename());
				int resultCount = this.insertUploadFile(pd); //插入数据库
				if (resultCount>0) {
					try {
						FileUpload.fileUpSimple(file, pd.getString("filePath"), file.getOriginalFilename()); //上传附件
					} catch (Exception e) {
						logger.error(e.getMessage());
						commonService.deleteUploadFiles(pd); //上传失败后删除插入的记录
						throw new ProjectException("上传图片失败");
					}
					fileIdList.add(pd.getString("fileId"));
				}
				
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new MediaException("上传图片失败");
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
	
	//查看点位的排期
	public ResultMap queryPointPeriod(PageData pd){
		ResultMap resultMap = ResultUtil.getResultMap();
		MediaPointLocation location= this.selectOneMediaPointLocation(pd);
		Page page = new Page();
		page.setShowCount(10000);
		page.setPd(pd);
		List<MediaRunPlanDetail> details = this.listMediaRunPlanDetails(page);
		resultMap.put("point", location);
		resultMap.put("runplans", details);
		return resultMap;
	}
	
	//查看投放计划的所有点位的排期
	public ResultMap queryMediaRunPlanPointPeriod(PageData pd){
		ResultMap resultMap = ResultUtil.getResultMap();
		List<MediaRunPlanDetailPointLocationVO> detailPointLocationVOs = mediaRunPlanDetailMapper.listMediaRunPlanDetailsAndPointLocation(pd);
		for (MediaRunPlanDetailPointLocationVO vo : detailPointLocationVOs) {
			vo.setStatus(vo.getPlanStatus());
			vo.setStatusDesc(MediaEnum.codeOf(vo.getPlanStatus()).getDesc());
		}
		resultMap.put("runplans", detailPointLocationVOs);
		return resultMap;
	}
	
	/**
	 * 
	 * @Title: queryMediaTodoList 
	 * @param pd
	 * @return
	 * @return ResultMap
	 * @throws 
	 * @Description: 
	 * 投放开始提醒：显示销售阶段【已确定】，投放状态为【投放未开始】的所有订单，显示投放开始时间，按照时间顺序（距开始投放由近到远）排列；点击后跳转到订单详情。
	   投放结束提醒：显示销售阶段【已确定】，投放状态为【投放中】的所有订单，显示投放结束时间，按照时间顺序（距投放结束由近到远）排列；点击后跳转到订单详情。
	 */
	public ResultMap queryMediaTodoList(PageData pd){
		ResultMap resultMap = ResultUtil.getResultMap();
		
		pd.put("nowDate", new Date());
		//投放开始提醒
		pd.put("start", "1");
		List<MediaRunPlan> start = mediaRunPlanMapper.selectMediaRunPlanNotify(pd);
		
		//投放结束提醒
		pd.put("start", null);
		pd.put("end", "1");
		List<MediaRunPlan> end = mediaRunPlanMapper.selectMediaRunPlanNotify(pd);
		resultMap.put("start", start);
		resultMap.put("end", end);
		return resultMap;
	}
	
	/**
	 * 
	 * @Title: listMediaSettingClasses 
	 * @param type
	 * @return
	 * @return List<ComSettingClass>
	 * @throws 
	 * @Description: 获取默认的媒体资源配置
	 * MEDIA_SHOW 表现形式
	 * MEDIA_TYPE 媒体资源类型
	 */
	public List<ComSettingClass> listMediaSettingClasses(String type){
		String mediaTypeJson = null;
		if ("MEDIA_TYPE".equalsIgnoreCase(type)) {
			mediaTypeJson = commonService.getDictValue("MEDIA_TYPE");
		}else if("MEDIA_SHOW".equalsIgnoreCase(type)){
			mediaTypeJson = commonService.getDictValue("MEDIA_SHOW");
		}
		if (StringUtil.isEmpty(mediaTypeJson)) {
			return null;
		}
		List<ComSettingClass> comSettingClasses = JSONArray.parseArray(mediaTypeJson, ComSettingClass.class);
		return comSettingClasses;
	}
	
}
