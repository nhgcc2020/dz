/**   
 * @Title: UploadFilesMapper.java 
 * @Package com.ydz.dao.common 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 28, 2017 1:32:17 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.dao.common;

import java.util.List;

import com.ydz.entity.common.UploadFile;
import com.ydz.util.PageData;

/** 
 * @ClassName: UploadFilesMapper 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 28, 2017 1:32:17 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public interface UploadFilesMapper {
	
	List<UploadFile> listUploadFiles(PageData pd);
	
	int insertSelective(UploadFile uploadFile);
	
	int updateByPrimaryKeySelective(UploadFile uploadFile);
	
	int deleteByPrimaryKey(PageData pd);
}
