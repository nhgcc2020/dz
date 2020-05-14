package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ydz.controller.base.BaseController;
import com.ydz.dao.invite.InviteRewardMapper;
import com.ydz.dao.system.RentalTradeMapper;
import com.ydz.entity.Page;
import com.ydz.entity.invite.InviteReward;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.Menu;
import com.ydz.entity.system.RentalTrade;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.advert.TradeService;
import com.ydz.service.common.CommonService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.MenuService;
import com.ydz.util.Const;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by pengxuyang on 16/10/11.
 */
@Controller
@RequestMapping(value ="callbackpay" )
public class PaymentCallbackController extends BaseController {

    @Resource(name="tradeService")
    private TradeService tradeService;
    @Resource
    private RentalTradeMapper rentalTradeMapper;
    @Resource(name="menuService")
    private MenuService menuService;
    @Resource
    private CommonService commonService;
    @Resource
    private CompanyService companyService;


    @RequestMapping(value = "notify")
    @ResponseBody
    public String successPay(HttpServletRequest request) {
        try {
            String eventStr = getStringFromFile(request);
            logger.info("body:" + eventStr);
            logger.info("header:" + request.getHeader("X-Pingplusplus-Signature"));
            JSONObject eventJson = JSON.parseObject(eventStr);
            JSONObject dataJson = eventJson.getJSONObject("data");
            JSONObject jsonObject = dataJson.getJSONObject("object");
            String orderNo = jsonObject.getString("order_no");
            PageData pd = new PageData();
            pd.put("tradeKey", orderNo);
            List<RentalTrade> rentalTrades = rentalTradeMapper.selectByPrimaryKey(pd);
            if (rentalTrades.size() == 0) {
                logger.warn("无此订单:" + orderNo);
                throw new RuntimeException("支付回调失败,无此订单:" + orderNo);
            }
            RentalTrade rentalTrade = rentalTrades.get(0);
            if (rentalTrade.getStatus() == null) {
                throw new RuntimeException("支付回调失败,此订单:" + orderNo + "的状态为null");
            }
            if (rentalTrade.getStatus().equals("0")) {
                logger.info("开始修改订单");
                //改变订单的状态
                PageData pdData = new PageData();
                pdData.put("tradeKey", rentalTrade.getTradeKey());
                pdData.put("status", RentalTradeEnum.PAID_YES.getCode()); //已支付
                int r = tradeService.updateStatusByTradeKey(pdData);
                logger.info("修改结果");
                if (r == 1) {
                	
            		Menu newMenu = new Menu();
            		newMenu.setComKey(rentalTrade.getComKey());
            		newMenu.setRentalVersion(rentalTrade.getRentalVersion());
            		newMenu.setChangedTime(new Date());
            		menuService.updateComMenu(newMenu);
            		
                    logger.info("订单完成:单号:" + orderNo);
                    //奖励操作
                    PageData pageDataCom = new PageData();
                    pageDataCom.put("comKey",rentalTrade.getComKey());
                    Company company = companyService.getCompanyByKey(pageDataCom);
                    if(StringUtil.isNotEmpty(company.getRefereeName())){
                        InviteReward inviteReward = new InviteReward();
                        inviteReward.setUserKey(company.getRefereeName());
                        inviteReward.setInvitedComKey(company.getComKey());
                        inviteReward.setRegisterTime(company.getCreateTime());
                        Date date = new Date();
                        inviteReward.setPayedTime(date);
                        inviteReward.setCreateTime(date);
                        Integer day = DateUtil.getIntervalDays(inviteReward.getRegisterTime(),inviteReward.getPayedTime());
                        inviteReward.setIntervalDays(day);
                        if(day <= Integer.valueOf(commonService.getDictValue("TRADE_TRIAL_MONTH"))){
                            inviteReward.setRewardMoney(new BigDecimal(100));
                            //奖金发放
                            inviteReward.setStatus("1");
                        }else{
                            inviteReward.setRewardMoney(new BigDecimal(0));
                            //过期无奖金
                            inviteReward.setStatus("N");
                        }
                        inviteReward.setIsValid("1");
                        commonService.insertInviteReward(inviteReward);
                    }
                    return "1";
                } else {
                    throw new RuntimeException("支付回调失败,此订单已成功:" + orderNo);
                }
            } else {
                logger.warn("此订单已成功:" + orderNo);
                return "1";
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("支付回调失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "go")
    public String testGo(){
        return "1";
    }

    /**
     * 读取文件, 部署 web 程序的时候, 签名和验签内容需要从 request 中获得
     *
     * @param
     * @return
     * @throws Exception
     */
    public static String getStringFromFile(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        int size = request.getContentLength();
        InputStream is = request.getInputStream();

        InputStreamReader inReader = new InputStreamReader(is, "UTF-8");
        BufferedReader bf = new BufferedReader(inReader);
        StringBuilder sb = new StringBuilder();
        String line;
        do {
            line = bf.readLine();
            if (line != null) {
                if (sb.length() != 0) {
                    sb.append("\n");
                }
                sb.append(line);
            }
        } while (line != null);

        return sb.toString();
    }
}
