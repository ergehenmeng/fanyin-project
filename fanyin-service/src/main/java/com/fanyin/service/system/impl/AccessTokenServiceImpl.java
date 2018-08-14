package com.fanyin.service.system.impl;

import com.fanyin.constant.RedisConstant;
import com.fanyin.model.system.Token;
import com.fanyin.service.system.AccessTokenService;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * @author 王艳兵
 * @date 2018/8/14 17:36
 */
@Service("accessTokenService")
public class AccessTokenServiceImpl implements AccessTokenService {

    @Override
    @Cacheable(cacheNames = RedisConstant.ACCESS_TOKEN,key = "T(com.fanyin.constant.RedisConstant).ACCESS_TOKEN + #p0")
    public Token getToken(String accessKey) {
        return null;
    }

    @Override
    @CachePut(cacheNames = RedisConstant.ACCESS_TOKEN,key = "T(com.fanyin.constant.RedisConstant).ACCESS_TOKEN + token.accessKey",cacheManager = "longCacheManager")
    public void saveToken(Token token) {
    }
}
