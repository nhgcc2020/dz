/**   
 * @Title: ReportCompanyController.java 
 * @Package com.ydz.controller.report 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:57:18 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.controller.report;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.report.ReportCompanySheet;
import com.ydz.service.report.ReportCompanyService;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: ReportCompanyController 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 27, 2017 8:57:18 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
@RestController
@RequestMapping(value = "report/company", produces = "application/json; charset=UTF-8")
public class ReportCompanyController extends BaseController{
	
	@Resource
	private ReportCompanyService reportCompanyService;
	
	@RequestMapping(value = "gross-profit")
	public String getGrossProfit(){
		PageData pd = this.getPageData();
		UserVo userVo = this.getSessionUservo();
		String orderDateString = pd.getString("orderDate");
		if (StringUtil.isEmpty(orderDateString)) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("没有数据"));
		}
		pd.put("comKey", userVo.getComKey());
		ReportCompanySheet sheet = reportCompanyService.getCompanyGrossProfit(pd);
		return JsonUtil.toCompatibleJSONString(sheet);
	}

}
