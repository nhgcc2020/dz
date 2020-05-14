package com.ydz.test;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.ydz.util.jwt.JWTUtil;
import com.ydz.vo.UserVo;


@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/ApplicationContext.xml",
		"classpath:spring/ApplicationContext-mvc.xml",
		"classpath:redis/spring-redis.xml" })
public class TestApp extends AbstractJUnit4SpringContextTests {

	public static void main(String[] args) {
		
	}
   
}
