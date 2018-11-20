package com.fanyin.service.operation.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.enums.OrderType;
import com.fanyin.mapper.operation.VipConfigMapper;
import com.fanyin.model.operation.VipConfig;
import com.fanyin.service.operation.VipConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * vip等级配置表
 * @author 二哥很猛
 * @date 2018/11/20 14:34
 */
@Service("vipConfigService")
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
