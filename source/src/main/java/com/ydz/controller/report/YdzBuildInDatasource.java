/**   
 * @Title: YdzBuildInDatasource.java 
 * @Package com.ydz.controller.report 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月14日 下午3:55:30 
 * @version  
 */
package com.ydz.controller.report;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//import com.bstek.ureport.definition.datasource.BuildinDatasource;

/** 
 * @ClassName: YdzBuildInDatasource 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月14日 下午3:55:30 
 * 
 */
//@Component
//public class YdzBuildInDatasource implements BuildinDatasource{
//	
//	@Autowired
//	private DataSource dataSource;
//
//	/** 
//	 * @Title: name 
//	 * @Description: (非 JavaDoc)
//	 * @return 
//	 * @see com.bstek.ureport.definition.datasource.BuildinDatasource#name() 
//	 */
//	@Override
//	public String name() {
//		// TODO Auto-generated method stub
//		return "ydzInds";
//	}
//
//	/** 
//	 * @Title: getConnection 
//	 * @Description: (非 JavaDoc)
//	 * @return 
//	 * @see com.bstek.ureport.definition.datasource.BuildinDatasource#getConnection() 
//	 */
//	@Override
//	public Connection getConnection() {
//		Connection connection = null;
//		try {
//			connection = dataSource.getConnection();
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//		return connection;
//	}

//}
