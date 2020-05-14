package com.ydz.controller.system.order;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.advert.SalesOrderDetail;
import com.ydz.service.advert.OrderConfigService;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.BusinessTypeVO;
import com.ydz.vo.UserVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.*;

/**
 * Created by pxy on 2016/8/15.
 * 公用的订单控制器
 */
@Controller
@RequestMapping(value = "order")
public class OrderController extends BaseController {

    @Resource(name = "orderConfigService")
    OrderConfigService orderConfigService;

    /**
     *据行业获取订单明细业务类型及对应的订单明细格式列
     * @return
     */
    @RequestMapping("listBusinessTypeVO")
    @ResponseBody
    public String listBusinessTypeVO(HttpServletRequest request){
        String industryId = null;
        String way = this.getPageData().getString("way");
        if(StringUtil.isNotEmpty(way)&&way.equals("detail")){
        	industryId = this.getPageData().getString("industryId");
        }else{
        	industryId = this.getSessionUservo().getDetailIndustryId();
        }
        List<BusinessTypeVO> businessTypeVOs = orderConfigService.listBusinessTypeVO(industryId);
        for(BusinessTypeVO businessTypeVO : businessTypeVOs){
            List<String> list = new ArrayList<>(businessTypeVO.getBusinessTypeColsList());
            for(int i = 0; i<list.size(); i++){
                if("itemNo".equals(list.get(i))) { //去掉itemNo
                    list.remove(i);
                    i--;
                }
            }
            businessTypeVO.setBusinessTypeColsList(list);
            businessTypeVO.setType(businessTypeVO.getBusinessType());
            businessTypeVO.setBusinessType("model"+businessTypeVO.getBusinessType());

        }
        return JSON.toJSONString(businessTypeVOs);
    }

}
