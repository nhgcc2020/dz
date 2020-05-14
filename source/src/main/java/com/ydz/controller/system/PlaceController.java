package com.ydz.controller.system;

import com.alibaba.fastjson.JSONObject;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.common.Province;
import com.ydz.service.common.CommonService;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.SelectVo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

import java.util.List;

/**
 *
 * Created by pxy on 2016/6/5.
 */
@RestController
@RequestMapping(value = "place", produces = "plain/text; charset=UTF-8")
public class PlaceController extends BaseController{

    @Resource(name = "commonService")
    CommonService commonService;
    
    @Resource
    RedisUtil redisUtil;


    @RequestMapping(value = "allprovince")
    @ResponseBody
    public String allprovice(){
//        try {
//        	long provincesTime = System.currentTimeMillis();
//            List<Province> provinces = commonService.getAllProvince();
//            System.out.println("======================================provincesTime"+Long.toString(System.currentTimeMillis()-provincesTime));
//            return JSONObject.toJSONString(provinces);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "0";
//        }
    	return "0";
    }


    @RequestMapping(value = "citybyprovince")
    @ResponseBody
    public String getCityByProvince(String provinceId){
//        try {
//            return JSONObject.toJSONString(commonService.getAllCityByProvince(provinceId));
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "0";
//        }
    	return "0";
    }

    @RequestMapping(value = "countrybycity")
    @ResponseBody
    public String getAllCountryByCity(String cityId){
//        try {
//
//           return JSONObject.toJSONString(commonService.getAllCountryByCity(cityId));
//        } catch (Exception e) {
//           e.printStackTrace();
//           return "0";
//        }
    	return "0";
    }


}
