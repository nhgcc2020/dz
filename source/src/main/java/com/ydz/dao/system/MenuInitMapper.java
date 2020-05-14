package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.MenuInit;
import com.ydz.util.PageData;

/** 
 * @ClassName: MenuInitMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月30日 下午7:58:14 
 * 
 */
public interface MenuInitMapper {
	
	List<MenuInit> listMenuInitByIndustryId(PageData pd);
	
	List<MenuInit> selectLevelMenus(PageData pd);
	
	List<MenuInit> listMenuInitById(PageData pd);
	
}
