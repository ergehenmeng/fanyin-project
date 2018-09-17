package com.fanyin.service.system.impl;


import com.alicp.jetcache.anno.Cached;
import com.fanyin.constant.RedisConstant;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.SystemException;
import com.fanyin.mapper.system.SystemConfigMapper;
import com.fanyin.model.system.SystemConfig;
import com.fanyin.request.system.config.ConfigInsertRequest;
import com.fanyin.request.system.config.ConfigSelectRequest;
import com.fanyin.request.system.config.ConfigUpdateRequest;
import com.fanyin.service.system.SystemConfigService;
import com.fanyin.utils.BeanCopyUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 系统参数配置服务类,系统参数无权限删除
 * @author 二哥很猛
 * @date 2018/1/12 09:46
 */
@Service("systemConfigService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemConfigServiceImpl implements SystemConfigService {

    @Autowired
    private SystemConfigMapper systemConfigMapper;

    @Override
    @CacheEvict(cacheNames = RedisConstant.SYSTEM_CONFIG,key = "#request.nid")
    public void updateConfig(ConfigUpdateRequest request) {
        int i = systemConfigMapper.updateConfig(request);
        if(i != 1){
            throw new SystemException(ErrorCodeEnum.UPDATE_CONFIG_ERROR);
        }
    }

    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public PageInfo<SystemConfig> getListByPage(ConfigSelectRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemConfig> list = systemConfigMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    @Cacheable(cacheNames = RedisConstant.SYSTEM_CONFIG,key = "#p0")
    public SystemConfig getConfigByNid(String nid) {
        return systemConfigMapper.getConfigByNid(nid);
    }

    @Override
    @Cached(name = RedisConstant.SYSTEM_CONFIG,key = "#id")
    public SystemConfig getConfigById(Integer id) {
        return systemConfigMapper.selectByPrimaryKey(id);
    }

    @Override
    public void addConfig(ConfigInsertRequest request) {
        SystemConfig copy = BeanCopyUtil.copy(request, SystemConfig.class);
        systemConfigMapper.insertSelective(copy);
    }

}
