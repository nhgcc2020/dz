/**   
 * @Title: CommonController.java 
 * @Package com.ydz.controller.common 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 29, 2017 9:56:01 AM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.common;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.ComSettingClass;
import com.ydz.entity.common.UploadFile;
import com.ydz.exception.ProjectException;
import com.ydz.service.common.CommonService;
import com.ydz.util.FileDownload;
import com.ydz.util.Logger;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: CommonController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Dec 29, 2017 9:56:01 AM 
 * @Description: 通用处理接口
 */
@RestController
@RequestMapping(value = "ydz/common", produces = "application/json;charset=UTF-8")
public class CommonController extends BaseController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	//公司参数配置——查询
	@RequestMapping(value="listComSettingClass", method = RequestMethod.GET)
	public String listComSettingClass(){
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		pd.put("comKey", userVo.getComKey());
		List<ComSettingClass> settings = commonService.listComSettingClasses(pd);
		return JsonUtil.toCompatibleJSONString(settings);
	}
	
	//公司参数配置——新建
	@RequestMapping(value="insertComSettingClass", method = RequestMethod.POST)
	public String insertComSettingClass(@RequestBody ComSettingClass comSettingClass)
		throws Exception{
		if (comSettingClass==null
				||StringUtil.isEmpty(comSettingClass.getTypeDesc())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		}
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		pd.put("settingClass", comSettingClass.getSettingClass());
		comSettingClass.setComKey(userVo.getComKey());
		comSettingClass.setIndustryId(userVo.getDetailIndustryId());
		comSettingClass.setCreateTime(new Date());
		comSettingClass.setIsDel("0");

		int maxTypeCode = commonService.selectMaxTypeCodeByPrimaryKey(pd);
		String typeCode = (maxTypeCode + 1) < 10 ? "0"
				+ Integer.toString(maxTypeCode + 1) : Integer
				.toString((maxTypeCode + 1));
		comSettingClass.setTypeCode(typeCode);
		int result = commonService.insertComSettingClass(comSettingClass);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("保存失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("保存成功"));
		}
	}
	//公司参数配置——修改
	@RequestMapping(value="updateComSettingClass", method = RequestMethod.PUT)
	public String updateOpportTypeDesc(@RequestBody ComSettingClass comSettingClass)
		throws Exception{
		if (comSettingClass==null
				||StringUtil.isEmpty(comSettingClass.getTypeDesc())) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		}
		UserVo userVo = this.getSessionUservo();
		comSettingClass.setComKey(userVo.getComKey());
		comSettingClass.setIndustryId(userVo.getDetailIndustryId());
		comSettingClass.setCreateTime(new Date());
		comSettingClass.setIsDel("0");
		int result = commonService.updateComSettingClass(comSettingClass);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("修改失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("修改成功"));
		}
	}
	//公司参数配置——删除
	@RequestMapping(value="deleteComSettingClass", method = RequestMethod.DELETE)
	public String deleteComSettingClass() throws Exception {
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		int result = commonService.deleteComSettingClass(pd);
		if (result <= 0) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("删除失败"));
		} else {
			return JsonUtil.toCompatibleJSONString(ResultUtil
					.successMsg("删除成功"));
		}
	}
	
	@RequestMapping(value = "deletefile")  
	public String deleteFile() throws Exception {
		UserVo userVo = this.getSessionUservo();
		PageData pd = this.getPageData();
		pd.put("comKey", userVo.getComKey());
		int result = 0;
		try {
			result = commonService.deleteAttachmentFile(pd);
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
}
