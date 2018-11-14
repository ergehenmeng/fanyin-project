package com.fanyin.service.system.impl;

import com.fanyin.dto.security.AccessToken;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.service.system.ProxyService;
import com.fanyin.utils.Sha256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 该类为全局Bean在Aop中无效时,额外存放类
 * 由于@Async,@CachePut等相关aop注解在同一个类方法间进行调用时无法生效
 * 可全部放到本类中维护
 * @author 二哥很猛
 * @date 2018/10/11 13:47
 */
@Service("aopProxyService")
public class ProxyServiceImpl implements ProxyService {

    @Autowired
    private AccessTokenService accessTokenService;

    @Override
    public AccessToken createAccessToken(int userId, String source) {
        String accessKey = Sha256Util.sha256Hmac(userId + source);
        String accessToken = Sha256Util.sha256Hmac(userId + accessKey);
        AccessToken token = new AccessToken();
        token.setAccessKey(accessKey);
        token.setAccessToken(accessToken);
        token.setUserId(userId);
        accessTokenService.saveAccessToken(token);
        return token;
    }
}
