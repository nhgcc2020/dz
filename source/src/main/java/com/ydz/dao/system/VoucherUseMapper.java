package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.VoucherUse;
import com.ydz.util.PageData;

/** 
 * @ClassName: VoucherUseMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月5日 下午9:12:30 
 * 
 */
public interface VoucherUseMapper {
	
	List<VoucherUse> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(VoucherUse record);
	
}
