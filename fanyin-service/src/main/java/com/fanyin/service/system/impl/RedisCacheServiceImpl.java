package com.fanyin.service.system.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.dto.security.AccessToken;
import com.fanyin.dto.task.Async;
import com.fanyin.service.system.RedisCacheService;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * 用于缓存数据信息,不涉及数据查询数据缓存
 * @author 二哥很猛
 * @date 2018/11/21 16:28
 */
@Service("redisCacheService")
public class RedisCacheServiceImpl implements RedisCacheService {

    @Override
    @Cacheable(cacheNames = RedisConstant.TENDER_ASYNC,key = "#response.key",cacheManager = "shortCacheManager")
    public void cacheAsyncResponse(Async response) {
    }

    @Override
    @Cacheable(cacheNames = RedisConstant.ACCESS_TOKEN,key = "#p0")
    public AccessToken getAccessToken(String accessKey) {
        return null;
    }

    @Override
    @CachePut(cacheNames = RedisConstant.ACCESS_TOKEN,key = "#token.accessKey",cacheManager = "longCacheManager")
    public void cacheAccessToken(AccessToken token) {
    }
}
