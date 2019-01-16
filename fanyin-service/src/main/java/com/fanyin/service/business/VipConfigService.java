package com.fanyin.service.business;

import com.fanyin.enums.OrderType;
import com.fanyin.model.business.VipConfig;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/20 14:34
 */
public interface VipConfigService {

    /**
     * 根据等级获取vip配置信息
     * @param level 等级
     * @return 配置信息
     */
    VipConfig getByLevel(byte level);

    /**
     * 获取所有vip配置信息,过滤掉关闭的配置
     * @param type 排序规则
     * @return 列表
     */
    List<VipConfig> getConfigs(OrderType type);
}

