package com.fanyin.service.system.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.dto.security.AccessToken;
import com.fanyin.service.system.AccessTokenService;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * @author 二哥很猛
 * @date 2018/8/14 17:36
 */
@Service("accessTokenService")
public class AccessTokenServiceImpl implements AccessTokenService {

    @Override
    @Cacheable(cacheNames = RedisConstant.ACCESS_TOKEN,key = "#p0")
    public AccessToken getAccessToken(String accessKey) {
        return null;
    }

    @Override
    @CachePut(cacheNames = RedisConstant.ACCESS_TOKEN,key = "#token.accessKey",cacheManager = "longCacheManager")
    public void saveAccessToken(AccessToken token) {
    }
}
