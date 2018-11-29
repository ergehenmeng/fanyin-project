package com.fanyin.service.system.impl;

import com.fanyin.dto.security.AccessToken;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.service.system.RedisCacheService;
import com.fanyin.utils.Sha256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 二哥很猛
 * @date 2018/8/14 17:36
 */
@Service("accessTokenService")
public class AccessTokenServiceImpl implements AccessTokenService {

    @Autowired
    private RedisCacheService redisCacheService;

    @Override
    public AccessToken getAccessToken(String accessKey) {
        return redisCacheService.getAccessToken(accessKey);
    }

    @Override
    public void saveAccessToken(AccessToken token) {
        redisCacheService.cacheAccessToken(token);
    }

    @Override
    public AccessToken createAccessToken(int userId, String source) {
        String accessKey = Sha256Util.sha256Hmac(userId + source);
        String accessToken = Sha256Util.sha256Hmac(userId + accessKey);
        AccessToken token = new AccessToken();
        token.setAccessKey(accessKey);
        token.setAccessToken(accessToken);
        token.setUserId(userId);
        redisCacheService.cacheAccessToken(token);
        return token;
    }
}
