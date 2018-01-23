package com.fanyin.service.system.impl;


import com.alibaba.fastjson.JSONObject;
import com.fanyin.constant.RedisConstant;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.SystemException;
import com.fanyin.mapper.system.SystemConfigMapper;
import com.fanyin.model.system.SystemConfig;
import com.fanyin.request.system.SystemConfigSelectRequest;
import com.fanyin.request.system.SystemConfigUpdateRequest;
import com.fanyin.service.system.SystemConfigService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.apache.commons.lang3.BooleanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @description: 系统参数配置服务类,系统参数无权限删除
 * @author: 二哥很猛
 * @date: 2018/1/12
 * @time: 09:46
 */
@Service("systemConfigService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemConfigServiceImpl implements SystemConfigService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SystemConfigServiceImpl.class);

    @Autowired
    private SystemConfigMapper systemConfigMapper;

    @Override
    @CacheEvict(cacheNames = RedisConstant.SYSTEM_CONFIG,key = "T(com.fanyin.constant.RedisConstant).SYSTEM_CONFIG + #request.nid")
    public void updateConfig(SystemConfigUpdateRequest request) {
        int i = systemConfigMapper.updateConfig(request);
        if(i != 1){
            throw new SystemException(ErrorCodeEnum.UPDATE_CONFIG_ERROR);
        }
    }

    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public PageInfo<SystemConfig> getListByPage(SystemConfigSelectRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemConfig> list = systemConfigMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    @Cacheable(cacheNames = RedisConstant.SYSTEM_CONFIG,key = "T(com.fanyin.constant.RedisConstant).SYSTEM_CONFIG + #p0")
    public SystemConfig getConfigByNid(String nid) {
        return systemConfigMapper.getConfigByNid(nid);
    }

    @Override
    public String getStringByNid(String nid) {
        SystemConfig config = getConfigByNid(nid);
        if (config == null){
            throw new SystemException(ErrorCodeEnum.CONFIG_NOT_FOUND_ERROR);
        }
        return config.getValue();
    }

    @Override
    public boolean getBooleanByNid(String nid) {
        String value = getStringByNid(nid);
        return BooleanUtils.toBoolean(value);
    }

    @Override
    public int getIntByNid(String nid) {
        String value = getStringByNid(nid);
        try {
            return Integer.parseInt(value);
        }catch (Exception e){
            LOGGER.error("字符串转int异常,{}",e);
            return 0;
        }
    }

    @Override
    public JSONObject getJsonByNid(String nid) {
        String value = getStringByNid(nid);
        try {
            return JSONObject.parseObject(value);
        }catch (Exception e){
            throw new SystemException(ErrorCodeEnum.JSON_FORMAT_ERROR);
        }
    }

    @Override
    public <T> T getClassByNid(String nid, Class<T> cls) {
        String value = getStringByNid(nid);
        try {
            return JSONObject.parseObject(value,cls);
        }catch (Exception e){
            throw new SystemException(ErrorCodeEnum.JSON_FORMAT_ERROR);
        }
    }


}
