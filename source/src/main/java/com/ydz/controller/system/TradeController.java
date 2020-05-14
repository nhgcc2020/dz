package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.pingplusplus.exception.PingppException;
import com.pingplusplus.model.Charge;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.system.RentalTradeMapper;
import com.ydz.entity.Page;
import com.ydz.entity.system.RentalTrade;
import com.ydz.entity.system.Voucher;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.PaymentService;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.MenuService;
import com.ydz.util.Const;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.PaymentVo;
import com.ydz.vo.RentalTradeVO;
import com.ydz.vo.UserVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pxy on 2016/6/22.
 */
@Controller
@RequestMapping(value = "payment",produces = "plain/text; charset=UTF-8")
public class TradeController extends BaseController{

    @Resource(name = "tradeService")
    TradeService tradeService;

    @Resource(name = "companyService")
    CompanyService companyService;

    @Resource(name = "commonService")
    CommonService commonService;
    
    @Resource(name = "menuService")
    MenuService menuService;

    @Resource
    PaymentService paymentService;

    @Resource
    private RentalTradeMapper rentalTradeMapper;

    /**
     * 点击免费体验 升级试用版
     * industryId
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "upgradeTrialVersion")
    @ResponseBody
    public String upgradeTrialVersion(String industryId){
    	UserVo userVo = this.getSessionUservo();
    	Map<String, Object> result = new HashMap<String, Object>();
    	try {
    		tradeService.insertUpgradeTrialVersion(userVo, industryId);
    		userVo.setRentalVersion(RentalTradeEnum.VERSION_BASIC_EDITION.getCode());
    		userVo.setDetailIndustryId(industryId);
    		getShiroSession().setAttribute(Const.SESSION_USER, userVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	result.put("state", true);
        result.put("msg", "升级成功");
        return JSON.toJSONString(result);
    }

    @RequestMapping(value = "listRentalTrade")
    @ResponseBody
    public String listPageRentalTradeVO(){
        UserVo userVo = getSessionUservo();
        PageData pd = new PageData();
        Page page = getPageWithParameter();
        pd.put("comKey",userVo.getComKey());
        page.setPd(pd);
        List<RentalTradeVO> tradeVOs = tradeService.listPageRentalTradeVO(page);
        Map<String, Object> mapPage = new HashMap<>();
        mapPage.put("$entityCount", page.getTotalResult());
        mapPage.put("$data", tradeVOs);
        return JSON.toJSONString(mapPage);
    }

    /**
     * 跳转到付费页面(支付)
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "priceList")
    public ModelAndView priceList(HttpServletRequest request) throws Exception{
        UserVo userVo = getSessionUservo();

        PageData pd = this.getPageData();
        pd.put("comKey", userVo.getComKey());
        
        request.setAttribute("result", tradeService.getMapPriceList(pd));
        return new ModelAndView("/jsp/company/price-list");
    }

    /**
     *支付宝支付
     * @param duration 使用时长（月份）
     * @param rentalVersion 产品版本
     * @param voucherNo 代金券号码
     * @param rentalMoney 产品功能总金额
     * @param actualPayNum 实际支付金额
     * @param rentalKey 租用KEY
     * @param tradeType 交易类型
     * @throws Exception
     */
    @RequestMapping(value = "aliPay")
    @ResponseBody
    public String aliPay(PaymentVo paymentVo) throws Exception {
        PageData pd = this.getPageData();
        pd.put("paymentType", RentalTradeEnum.PAYMENT_ALIPAY.getCode()); //支付方式 1支付宝
        HashMap<String, Object> mapResult = this.insertPurchaseRental(pd, paymentVo.getDuration(), paymentVo.getRentalVersion(), paymentVo.getOldRentalVersion() 
        		,paymentVo.getVoucherNo(), paymentVo.getRentalMoney(), paymentVo.getActualPayNum(), paymentVo.getRentalKey(), paymentVo.getTradeType());
        
        if(mapResult == null){
        	return "0";
        }

        //内部流水号
        paymentVo.setTradeKey(mapResult.get("tradeKey").toString());
        //服务版本描述
        paymentVo.setRentalVersionValue(mapResult.get("rentalVersionValue").toString());
        Charge charge = null;
        Map<String, Object> chargeMap = paymentService.makeAliChargeMap(paymentVo);
        try {
            //发起交易请求
            charge = Charge.create(chargeMap);
            return JSON.toJSONString(charge);
        } catch (PingppException e) {
            e.printStackTrace();
            return "0";
        }
    }

    //微信支付
    @RequestMapping(value = "wxPay")
    @ResponseBody
    public String wxPay(PaymentVo paymentVo)
            throws Exception{
        PageData pd = this.getPageData();
        pd.put("paymentType", RentalTradeEnum.PAYMENT_WECHAT.getCode()); //支付方式 2微信
        HashMap<String, Object> mapResult = this.insertPurchaseRental(pd, paymentVo.getDuration(), paymentVo.getRentalVersion(), paymentVo.getOldRentalVersion()
        		, paymentVo.getVoucherNo(), paymentVo.getRentalMoney(), paymentVo.getActualPayNum(), paymentVo.getRentalKey(), paymentVo.getTradeType());
        
        if(mapResult == null){
        	return "0";
        }
        
        //支付
        paymentVo.setTradeKey(mapResult.get("tradeKey").toString());
        paymentVo.setRentalVersionValue(mapResult.get("rentalVersionValue").toString());
        Charge charge = null;
        Map<String, Object> chargeMap = paymentService.makeWXChargeMap(paymentVo);
        try {
            //发起交易请求
            charge = Charge.create(chargeMap);

            String url = (String) charge.getCredential().get("wx_pub_qr");
            String orderNo = charge.getOrderNo();
            Map<String,String> callback = new HashMap<>();
            callback.put("url",url);
            callback.put("orderNo",orderNo);
            return JSON.toJSONString(callback);
        } catch (PingppException e) {
            e.printStackTrace();
            return "0";
        }

    }

	@SuppressWarnings("unused")
	private HashMap<String, Object> insertPurchaseRental(PageData pd,String duration,String rentalVersion,String oldRentalVersion,
    		String voucherNo,String rentalMoney,String actualPayNum,String rentalKey,String tradeType) throws Exception{
    	UserVo userVo = this.getSessionUservo();
    	 pd.put("isMaturity", userVo.getIsMaturity()); //0过期 1未过期
    	 pd.put("duration", duration);
         pd.put("rentalVersion", rentalVersion);
         pd.put("voucherNo", voucherNo);
         pd.put("rentalMoney", rentalMoney);
         pd.put("payedMoney", actualPayNum);
         pd.put("rentalKey", rentalKey);
         pd.put("comKey", userVo.getComKey());
         pd.put("industryId", userVo.getDetailIndustryId());
         pd.put("userKey", userVo.getUserKey());
         pd.put("tradeType", tradeType);
         pd.put("oldRentalVersion", oldRentalVersion);
         String cityId = companyService.getCompanyByUserKey(userVo.getComKey()).getComCity();
         PageData pdPara1_ = new PageData();
         pdPara1_.put("cityId", cityId);
         pd.put("cityLevel", tradeService.getCityLevel(pdPara1_).getCityLevel());

         return tradeService.insertPurchaseRental(pd);
    }

   /**
    * 
   * @Title: queryAndMod 
   * @param orderNo
   * @return
   * @return String
   * @throws 
   * @Description: 查询当前交易记录是否已支付完成
    */
    @RequestMapping(value = "queryAndMod")
    @ResponseBody
    public String queryAndMod(String orderNo){

        PageData pd = new PageData();
        pd.put("tradeKey", orderNo);
        List<RentalTrade> rentalTrades = rentalTradeMapper.selectByPrimaryKey(pd);
        int result = 0;
        if(rentalTrades.size()>0 && rentalTrades.get(0).getStatus().equals("1")){
            result =1;
        }
        return String.valueOf(result);
    }
    /**
     * 
    * @Title: insertFreeVersion 
    * @param request
    * @param response
    * @throws Exception
    * @return void
    * @throws 
    * @Description: 转为免费版并注销当前账户
     */
    @RequestMapping(value = "changeFreeVersion")
	@ResponseBody
    public String insertFreeVersion(HttpServletRequest request,HttpServletResponse response){
    	UserVo userVo = this.getSessionUservo();
    	PageData pd = this.getPageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("userKey", userVo.getUserKey());
        pd.put("roleKey",userVo.getRoleKeys());
        try {
			tradeService.insertFreeVersion(pd);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
        
        return "1";
    }

    
//=================代金券
    //代金券列表
    @RequestMapping(value = "listVoucher", produces = "plain/text; charset=UTF-8")
    @ResponseBody
    public String listVoucher(HttpServletRequest request){
        PageData pageData = this.getPageData();
        UserVo userVo = this.getSessionUservo();
        pageData.put("comKey",userVo.getComKey());
        
        //0-未使用 1-已使用  2-已过期
        pageData.put("status",StringUtil.isEmpty(request.getParameter("parameter"))?null:request.getParameter("parameter"));
        try {
            List<Voucher> list = tradeService.listVoucher(pageData);
            for (Voucher voucher : list) {
				voucher.setStatusValue(commonService.formatVoucherStatus(voucher.getStatus()));
			}
            return JSON.toJSONString(list);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }


    //可用代金券下拉框
    @RequestMapping(value = "effectiveVouchers")
    @ResponseBody
    public String effectiveVouchers(){
        UserVo userVo = (UserVo) this.getCurrentSession().getAttribute(Const.SESSION_USER);
        PageData pd = new PageData();
        pd.put("comKey", userVo.getComKey());
        pd.put("endDate", DateUtil.getDate(new Date()));
        pd.put("status", RentalTradeEnum.VOUCHER_STATUS_UNUSED.getCode());
        try {
            return tradeService.voucherInfo(pd);
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @RequestMapping(value = "changeVersion")
    @ResponseBody
    public String changeVersion(String newVersion)throws Exception{
        UserVo userVo = getSessionUservo();
        Map result = tradeService.saveChangeVersion(userVo,newVersion);
        return JSON.toJSONString(result);
    }

}
