/**   
 * @Title: JUnit4ClassRunner.java 
 * @Package com.ydz.test 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 28, 2017 11:19:05 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.test;

import java.io.FileNotFoundException;

import org.junit.runners.model.InitializationError;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Log4jConfigurer;

/** 
 * @ClassName: JUnit4ClassRunner 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Oct 28, 2017 11:19:05 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class YdzJUnit4ClassRunner extends SpringJUnit4ClassRunner{
	static {
	      try {
	        Log4jConfigurer.initLogging("classpath:log4j-junit.properties");
	      } catch (FileNotFoundException ex) {
	        System.err.println("Cannot Initialize log4j");
	      }
	    }
	    public YdzJUnit4ClassRunner(Class<?> clazz) throws InitializationError {
	      super(clazz);
	    }
}
