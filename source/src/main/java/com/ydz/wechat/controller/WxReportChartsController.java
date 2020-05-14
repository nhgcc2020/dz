package com.ydz.wechat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ydz.controller.base.BaseController;
import com.ydz.entity.report.ReportSalesOrderYMDAmount;
import com.ydz.service.report.ReportSalesOrderService;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WxReportChartsController 
 * @Description: 微信报表图标控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年5月15日 下午2:31:51 
 * 
 */
@Controller
@RequestMapping(value = "wx/reportcharts",produces = "plain/text; charset=UTF-8")
public class WxReportChartsController extends BaseController{
	
	@Resource
	private ReportSalesOrderService reportSalesOrderService;
	
	@RequestMapping(value="salestrend")
	@ResponseBody
	public String getSalesTrend(HttpServletRequest request) throws Exception{
		UserVo userVo = this.getWxCurrentUserVo();
		PageData pd = this.getPageData();
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ReportSalesOrderYMDAmount> amounts = null;
		if (StringUtil.isEmpty(pd.getString("month"))) {
			amounts = reportSalesOrderService.getSalesOrderMonthsAmounts(userVo.getComKey(), pd.getString("year"));
		}else{
			amounts = reportSalesOrderService.getSalesOrderDaysAmounts(userVo.getComKey(), pd.getString("year"), pd.getString("month"));
		}
		jsonMap.put("total", amounts.size());
		jsonMap.put("rows", amounts);
		
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}

}
