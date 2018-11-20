package com.fanyin.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;

/**
 * @author 二哥很猛
 * @date 2018/1/26 16:10
 */
@Slf4j
public class BeanCopyUtil {


    public static <T> T  copy(Object source,Class<T> cls,String... ignoreProperties){
        if(source == null){
            return null;
        }
        try {
            T t = cls.newInstance();
            if(ignoreProperties != null && ignoreProperties.length > 0){
                BeanUtils.copyProperties(source,t,ignoreProperties);
            }else{
                BeanUtils.copyProperties(source,t);
            }
            return t;
        }catch (Exception e){
            log.error("bean复制异常",e);
            return null;
        }
    }
}
