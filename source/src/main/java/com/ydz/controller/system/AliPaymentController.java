package com.ydz.controller.system;

import com.alibaba.fastjson.JSON;
import com.ydz.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by ydz on 2016/8/1.
 */
@Controller
@RequestMapping(value = "aliPay",produces = "plain/text; charset=UTF-8")
public class AliPaymentController extends BaseController {


    /**
     * 支付同步回调
     * @param request
     * @return
     */
    @RequestMapping(value = "synchro_url")
    public ModelAndView synchroUrl(HttpServletRequest request) {
        Map<String, String[]> map = request.getParameterMap();
        logger.info(map);
        logger.info(JSON.toJSONString(map));
        return new ModelAndView("../success");
    }


}
