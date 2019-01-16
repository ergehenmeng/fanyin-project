package com.fanyin.service.business.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.enums.OrderType;
import com.fanyin.mapper.business.VipConfigMapper;
import com.fanyin.model.business.VipConfig;
import com.fanyin.service.business.VipConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * vip等级配置表
 * @author 二哥很猛
 * @date 2018/11/20 14:34
 */
@Service("vipConfigService")
@Transactional(rollbackFor = RuntimeException.class)
public class VipConfigServiceImpl implements VipConfigService {

    @Autowired
    private VipConfigMapper vipConfigMapper;

    @Override
    @Cacheable(cacheNames = RedisConstant.VIP_CONFIG,key = "#p0")
    public VipConfig getByLevel(byte level) {
        return vipConfigMapper.getByLevel(level);
    }

    @Override
    @Cacheable(cacheNames = RedisConstant.VIP_CONFIG,key = "#type.name()")
    public List<VipConfig> getConfigs(OrderType type) {
        return vipConfigMapper.getConfigs(type);
    }

}
