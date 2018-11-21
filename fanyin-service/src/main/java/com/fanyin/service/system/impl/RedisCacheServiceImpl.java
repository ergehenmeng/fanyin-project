package com.fanyin.service.system.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.dto.tender.TenderResponse;
import com.fanyin.service.system.RedisCacheService;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * 用于缓存数据信息
 * @author 二哥很猛
 * @date 2018/11/21 16:28
 */
@Service("redisCacheService")
public class RedisCacheServiceImpl implements RedisCacheService {

    @Override
    @Cacheable(cacheNames = RedisConstant.TENDER_ASYNC,key = "#response.key",cacheManager = "shortCacheManager")
    public void cacheTenderAsyncResponse(TenderResponse response) {
    }
}
