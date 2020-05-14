package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.init.RoleInit;
import com.ydz.util.PageData;

/** 
 * @ClassName: RoleInitMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月30日 下午5:19:46 
 * 
 */
public interface RoleInitMapper {

	List<RoleInit> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(RoleInit roleInit);
	
	int updateByPrimaryKeySelective(RoleInit roleInit);
}
