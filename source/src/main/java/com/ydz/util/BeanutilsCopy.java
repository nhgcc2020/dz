/**
 * 
 */
package com.ydz.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

/** 
 * @ClassName: BeanutilsCopy 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年7月22日 下午9:48:34 
 * @Description: 对象拷贝工具类
 *  
 */
public class BeanutilsCopy<T> {
    private static Logger log = Logger.getLogger("BeanutilsCopy");

    /**
     * 
     * 
     * apacheCopyProperties(单个对象拷贝)
     * 
     * @Title: apacheCopyProperties
     * @param @param dest
     * @param @param orig
     * @return void
     * @throws
     */
    public static void apacheCopyProperties(Object dest, Object orig) {
        try {
            BeanUtils.copyProperties(dest, orig);
        } catch (Exception e) {
            log.error("apacheCopyProperties 异常：" + e);
        }

    }

    @SuppressWarnings("unchecked")
    public static <T, D> T populateTbyDBySpring(D sourceObj, Class<T> clazz)
      {
        if (sourceObj == null) {
          return null;
        }
        Object t = null;
        try {
          t = clazz.newInstance();
        } catch (IllegalAccessException e) {
            log.error("自动转换失败", e);
        } catch (InstantiationException exx) {
            log.error("自动转换失败", exx);
        }
        org.springframework.beans.BeanUtils.copyProperties(sourceObj, t);

        return (T) t;

      }

      @SuppressWarnings({ "rawtypes", "unchecked" })
    public static <T, D> List<T> populateTListbyDListBySpring(List<D> sourceObjs, Class<T> clazz)
      {
        if (sourceObjs == null) {
          return null;
        }
        int len = sourceObjs.size();
        List ts = new ArrayList(len);
        Object t = null;
        for (int i = 0; i < len; i++) {
          Object d = sourceObjs.get(i);
          t = populateTbyDBySpring(d, clazz);
          ts.add(t);
        }
        return ts;
      }

}
