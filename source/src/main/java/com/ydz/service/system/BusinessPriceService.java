package com.ydz.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.system.BusinessPriceInitMapper;
import com.ydz.entity.init.BusinessPriceInit;

/** 
 * @ClassName: BusinessPriceService 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月3日 上午11:46:29 
 * 
 */
@Service("businessPriceService")
public class BusinessPriceService {
	
	@Autowired private BusinessPriceInitMapper businessPriceInitMapper;

}
