package com.fanyin.service.system.impl;

import com.alibaba.fastjson.JSONObject;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.SystemException;
import com.fanyin.model.system.SystemConfig;
import com.fanyin.service.system.SystemConfigService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 系统参数公用Api接口
 * 主要原因缓存注解Aop同方法调用失效问题
 * @see SystemConfigServiceImpl
 * @author 王艳兵
 * @date 2018/9/12 14:36
 */
@Service("systemConfigApi")
@Transactional(rollbackFor = RuntimeException.class,readOnly = true)
@Slf4j
public class SystemConfigApi {

    @Autowired
    private SystemConfigService systemConfigService;

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值string
     */
    public String getStringByNid(String nid){
        SystemConfig config = systemConfigService.getConfigByNid(nid);
        if (config == null){
            throw new SystemException(ErrorCodeEnum.CONFIG_NOT_FOUND_ERROR);
        }
        return config.getValue();
    }

    /**
     * 根据nid获取系统参数配置信息的值,支持以下类型(yes,true,on,y,t,n,f,no,off,false)
     * @param nid 唯一nid
     * @return 系统参数结果值boolean
     */
    public boolean getBooleanByNid(String nid){
        String value = this.getStringByNid(nid);
        return BooleanUtils.toBoolean(value);
    }

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值int 如果转换失败为0
     */
    public int getIntByNid(String nid){
        String value = getStringByNid(nid);
        try {
            return Integer.parseInt(value);
        }catch (Exception e){
            log.error("字符串转int异常",e);
            return 0;
        }
    }

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值json,如果异常则抛出
     */
    public JSONObject getJsonByNid(String nid){
        String value = getStringByNid(nid);
        try {
            return JSONObject.parseObject(value);
        }catch (Exception e){
            log.error("字符串转json异常",e);
            throw new SystemException(ErrorCodeEnum.JSON_FORMAT_ERROR);
        }
    }

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @param cls 要转换的类型
     * @return 系统参数结果值class,如果异常则抛出
     */
    public <T> T getClassByNid(String nid, Class<T> cls){
        String value = getStringByNid(nid);
        try {
            return JSONObject.parseObject(value,cls);
        }catch (Exception e){
            log.error("字符串转对象异常",e);
            throw new SystemException(ErrorCodeEnum.JSON_FORMAT_ERROR);
        }
    }
}
