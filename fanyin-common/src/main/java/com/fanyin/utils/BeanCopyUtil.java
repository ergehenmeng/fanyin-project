package com.fanyin.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

/**
 * @author 二哥很猛
 * @date 2018/1/26 16:10
 */
public class BeanCopyUtil {

    private static final Logger LOGGER = LoggerFactory.getLogger(BeanCopyUtil.class);

    public static <T> T  copy(Object source,Class<T> cls){
        if(source == null){
            return null;
        }
        try {
            T t = cls.newInstance();
            BeanUtils.copyProperties(source,t);
            return t;
        }catch (Exception e){
            LOGGER.error("bean复制异常",e);
            return null;
        }
    }
}