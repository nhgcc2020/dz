package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.IndustryInit;
import com.ydz.util.PageData;

/** 
 * @ClassName: IndustryInitMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年10月14日 上午10:42:46 
 * 
 */
public interface IndustryInitMapper {
	
	IndustryInit selectByIndId(PageData pd);
	
	List<IndustryInit> listAllIndusInit(PageData pd);

}
