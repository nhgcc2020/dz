package com.ydz.controller.common;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.ydz.entity.Page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.LoginLog;
import com.ydz.entity.system.ComEmployee;
import com.ydz.entity.workbench.TodoCountVO;
import com.ydz.enums.CompanyEnum;
import com.ydz.service.advert.PurchaseOrderService;
import com.ydz.service.common.CommonService;
import com.ydz.service.report.ReportWorkBenchService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.ResultUtil;
import com.ydz.util.StringUtil;
import com.ydz.vo.UserVo;
import com.ydz.wechat.util.JsonUtil;

/** 
 * @ClassName: WorkBenchController 
 * @Description: 工作台控制器
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月24日 下午4:37:09 
 * 
 */

@Controller
@RequestMapping(value = "common/workbench", produces = "plain/text; charset=UTF-8")
public class WorkBenchController extends BaseController{
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="purchaseOrderService")
	private PurchaseOrderService purchaseOrderService;
	
	@Resource(name="reportWorkBenchService")
	private ReportWorkBenchService reportWorkBenchService;

	@RequestMapping(value="info")
	@ResponseBody
	public String getWorkBenchInfo(HttpServletRequest request) throws Exception{
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		UserVo userVo = this.getSessionUservo();
		if (userVo==null) {
			return JsonUtil.toCompatibleJSONString(ResultUtil.error("需要重新登录"));
		}
		
		PageData pdPara = new PageData();
		//获取上次登陆日志
		pdPara.put("userKey", userVo.getUserKey()); 
//		jsonMap.put("loginLog", this.getLoginLog(pdPara));
		
		//获取待办列表
		pdPara.put("comKey", userVo.getComKey());
//		jsonMap.put("todo", this.getTodo(pdPara));

		Page page = new Page();
		page.setCurrentPage(1);
		page.setShowCount(12);
		page.setPd(pdPara);
		jsonMap.put("callfriend", commonService.listPageMsgComVo(page));
		jsonMap.put("callfriendcount", page.getTotalResult());
		
		/**
		 * 1. 个人的不能升级。
		 * 2. 已升级的不能再升级。
		 * 3. 不是老板不是管理员的不能升级
		 */
		if(CompanyEnum.COM_TYPE_PERSONAL.getCode().equalsIgnoreCase(userVo.getComType())
				||!Const.INDUSTRY_GENERAL.equalsIgnoreCase(userVo.getDetailIndustryId())){
			jsonMap.put("upgrade", "0"); //不能升级
		}else{
			if("1".equalsIgnoreCase(userVo.getIsAdmin())
					||"1".equalsIgnoreCase(userVo.getIsBoss())){
					jsonMap.put("upgrade", "1"); //可以升级
			}else{
				jsonMap.put("upgrade", "0");
			}
		}
		
		
		
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}
	
	private LoginLog getLoginLog(PageData pdPara) throws Exception{
		LoginLog log= commonService.getLoginLog(pdPara);
		if(log!=null){
			log.setLoginCity(StringUtil.isEmpty(log.getLoginCity())
					||"null null".equalsIgnoreCase(log.getLoginCity())?"**省**市":log.getLoginCity());
		}else{
			log = new LoginLog();
			log.setLoginCity("");
			log.setLoginTime(new Date());
		}
		return log;
	}
	
	private List<TodoCountVO> getTodo(PageData pdPara) throws Exception{
		return commonService.getTodoList(pdPara);
	}
	
	@RequestMapping(value="report/chart")
	@ResponseBody
	public String getReportChart(HttpServletRequest request) throws Exception{
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		UserVo userVo = this.getSessionUservo();
		
		PageData pdPara = this.getPageData();
		
		//销售待对账订单
		jsonMap.put("daiduizhang",reportWorkBenchService.getDaiduizhangAmount(userVo.getComKey()));
		//销售待收款对账单
		jsonMap.put("daishoukuan", reportWorkBenchService.getDaishoukuanAmount(pdPara.getString("year"), userVo.getComKey()));
		
		return JsonUtil.toCompatibleJSONString(jsonMap);
	}
	
}
