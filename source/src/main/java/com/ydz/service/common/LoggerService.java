/**   
 * @Title: LoggerService.java 
 * @Package com.ydz.service.common 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 8:03:56 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.service.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.common.OperateLogMapper;
import com.ydz.entity.Page;
import com.ydz.entity.common.OperateLog;
import com.ydz.exception.YdzSystemRuntimeException;

/** 
 * @ClassName: LoggerService 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Nov 23, 2017 8:03:56 PM 
 * @Description: 日志处理Service
 */
@Service
public class LoggerService {
	
	@Autowired private OperateLogMapper operateLogMapper;
	
	public List<OperateLog> listOperateLog(Page page){
		return operateLogMapper.listPageOperateLogs(page);
	}
	
	public int insertOperatorLog(OperateLog operateLog) throws YdzSystemRuntimeException{
		return operateLogMapper.insertSelective(operateLog);
	}

}
