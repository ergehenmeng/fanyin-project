package com.fanyin.service.user.impl;

import com.fanyin.dto.AccessToken;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.service.user.UserService;
import com.fanyin.utils.Sha256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 王艳兵
 * @date 2018/8/15 17:28
 */
@Service("userService")
public class UserServiceImpl implements UserService {

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
