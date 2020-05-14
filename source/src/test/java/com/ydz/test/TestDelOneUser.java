/**   
 * @Title: TestDelOneUser.java 
 * @Package com.ydz.test 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月25日 下午4:50:23 
 * @version  
 */
package com.ydz.test;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

/** 
 * @ClassName: TestDelOneUser 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年4月25日 下午4:50:23 
 * 
 */
@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/ApplicationContext.xml","classpath:spring/ApplicationContext-mvc.xml","classpath:redis/spring-redis.xml"})
@Transactional
public class TestDelOneUser extends AbstractJUnit4SpringContextTests{
	
	@Resource
	private DataSource dataSource;
	
	@Test
	public void execDeleteOneUser(){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;
		CallableStatement cst = null;
		try {
			String userId = null;
			String userKey = null;
			String comKey = null;
			
			/**
			 *  13034612478、13621883859、18918526726 13732377909，13661629332
			 */
			
			userId = "18674061012";
			
			conn= dataSource.getConnection();
			conn.setAutoCommit(false);
			String sql1 = "select USER_KEY from YDZ_USER where USER_ID = '"+userId+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql1);
			while(rs.next()){
				userKey = rs.getString("USER_KEY");
				String sql2 = "select COM_KEY from YDZ_COMPANY where CREATOR = '"+userKey+"'";
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(sql2);
				while(rs2.next()){
					comKey = rs2.getString("COM_KEY");
					String callString = "{call proDelOneUserAllCompany(?,?)}";
					cst = conn.prepareCall(callString);
					cst.setString(1, comKey);
					cst.setString(2, userKey);
					cst.execute();
				}
			}
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs2!=null) {
				try {
					rs2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2!=null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (cst!=null) {
				try {
					cst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
		}
	}

}
