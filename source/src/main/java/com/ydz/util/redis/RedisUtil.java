package com.ydz.util.redis;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.ydz.util.SerializeUtil;

import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;

/** 
 * @ClassName: RedisService 
 * @Description: redis 客户端类
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月17日 下午5:22:06 
 * 
 */

@Component
public class RedisUtil {

	@Resource(name="shardedJedisPool")
	ShardedJedisPool shardedJedisPool;
	
	/**
	 * 
	* @Title: set 
	* @param @param object
	* @param @param key
	* @param @return
	* @return String
	* @throws 
	* @Description: 插入redis缓存
	 */
    public String set(String key,Object object){
    	String result = null;
    	ShardedJedis jedis = null;
		try {
			jedis = shardedJedisPool.getResource();
			result = jedis.set(key.getBytes(), SerializeUtil.serialize(object));
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (jedis!=null) {
				jedis.close();
			}
		}
        return result;
    }
    
    /**
     * 
    * @Title: setIntervalSecond 
    * @param key
    * @param object
    * @param seconds
    * @return
    * @return long
    * @throws 
    * @Description: 设定指定秒数的redis对象
     */
    public long setIntervalSecond(String key,Object object,int seconds){
    	long result = 0L;
    	ShardedJedis jedis = null;
    	
    	this.set(key,object);
		try {
			jedis = shardedJedisPool.getResource();
	    	result = jedis.expire(key, seconds);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (jedis!=null) {
				jedis.close();
			}
		}
        return result;
    }
    
    /**
     * 
    * @Title: setIntervalMinute 
    * @param key
    * @param object
    * @param minutes
    * @return
    * @return long
    * @throws 
    * @Description: 设定指定分钟数的redis对象
     */
    public long setIntervalMinute(String key,Object object,int minutes){
    	long result = 0L;
    	ShardedJedis jedis = null;
    	
    	this.set(key,object);
    	try {
    		jedis = shardedJedisPool.getResource();
    		result = jedis.expire(key, minutes * 60);
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally{
    		if (jedis!=null) {
    			jedis.close();
    		}
    	}
    	return result;
    }
    
    /**
     * 
    * @Title: setIntervalHour 
    * @param key
    * @param object
    * @param hours
    * @return
    * @return long
    * @throws 
    * @Description: 设置指定保留小时数的redis对象
     */
    public long setIntervalHour(String key,Object object,int hours){
    	long result = 0L;
    	ShardedJedis jedis = null;
    	
    	this.set(key,object);
    	try {
    		jedis = shardedJedisPool.getResource();
    		result = jedis.expire(key, hours * 60 * 60);
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally{
    		if (jedis!=null) {
    			jedis.close();
    		}
    	}
    	return result;
    }
    
    /**
    * @Title: setIntervalDay 
    * @param key
    * @param object
    * @param days
    * @return
    * @return long
    * @throws 
    * @Description: 设置指定保留天数的redis对象
     */
    public long setIntervalDay(String key,Object object,int days){
    	long result = 0L;
    	ShardedJedis jedis = null;
    	
    	this.set(key,object);
    	try {
    		jedis = shardedJedisPool.getResource();
    		result = jedis.expire(key, days * 24 * 60 *60);
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally{
    		if (jedis!=null) {
    			jedis.close();
    		}
    	}
    	return result;
    }
    
    
   
    /**
     * 
    * @Title: get 
    * @param @param key
    * @param @return
    * @return Object
    * @throws 
    * @Description: 从redis缓存中读取对象
     */
    public Object get(String key){
    	byte[] value = null;
    	ShardedJedis jedis = null;
		try {
			jedis = shardedJedisPool.getResource();
			value = jedis.get(key.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (jedis!=null) {
				jedis.close();
			}
		}
		return SerializeUtil. unserialize(value);
    }
   
    /**
     * 
    * @Title: del 
    * @param @param key
    * @param @return
    * @return boolean
    * @throws 
    * @Description: 从redis中删除指定key的对象
     */
    public boolean del(String key){
        boolean result = false;
    	ShardedJedis jedis = null;
		try {
			jedis = shardedJedisPool.getResource();
			result = jedis.del(key.getBytes())>0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (jedis!=null) {
				jedis.close();
			}
		}
        return result;
    }
}
