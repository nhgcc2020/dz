package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.Voucher;
import com.ydz.util.PageData;

/** 
 * @ClassName: VoucherMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月5日 下午9:39:59 
 * 
 */
public interface VoucherMapper {

	List<Voucher> selectByPrimaryKey(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(Voucher record);
	
	int updateByPrimaryKeySelective(Voucher record);
}
