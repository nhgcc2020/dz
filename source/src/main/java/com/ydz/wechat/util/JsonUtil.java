package com.ydz.wechat.util;


import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.ydz.util.StringUtil;

/**
 * Created by pxy on 2016/5/11.
 */
public class JsonUtil {

	private static JsonUtil jsonUtil = new JsonUtil();
	
	private JsonUtil(){}
	
	public static JsonUtil getInstance(){
		return jsonUtil;
	}
	
	private static final SerializeConfig  config;

	static
	{
	    config= new SerializeConfig();
//	    config.put(java.util.Date.class,new JSONLibDataFormatSerializer());
//	    config.put(java.sql.Date.class, new	JSONLibDataFormatSerializer());
	}


	private static final SerializerFeature[] features = { SerializerFeature.WriteMapNullValue, SerializerFeature.WriteNullListAsEmpty,SerializerFeature.WriteNullNumberAsZero,
	SerializerFeature.WriteNullBooleanAsFalse,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.DisableCircularReferenceDetect};


    public static String mapToJson(Map<String,Object> map) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        String jsonfromMap =  mapper.writeValueAsString(map);
        return jsonfromMap;
    }

    @SuppressWarnings("unchecked")
	public static Map<String,Object> jsonToMap(String jsonStr) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        if(StringUtil.isNotEmpty(jsonStr)){
        	return  mapper.readValue(jsonStr, Map.class);
        }
        return null; 
    }
    
    public <E> String listToJson(List<E> list){
    	JSONArray.toJSON(list);    	
    	return null;
    }
    
    public static <E> String toJsonString(Object object){
    	return JSONArray.toJSONString(object);
    }
    
    // 序列化为和JSON-LIB兼容的字符串
   public static String toCompatibleJSONString(Object object) {
       return JSON.toJSONString(object, config, features);
   }
}
