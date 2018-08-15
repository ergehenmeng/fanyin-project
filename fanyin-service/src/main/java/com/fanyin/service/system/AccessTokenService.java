package com.fanyin.service.system;

import com.fanyin.dto.AccessToken;

/**
 * 会话令牌service
 * @author 王艳兵
 * @date 2018/8/14 17:35
 */
public interface AccessTokenService {

    /**
     * 根据accessKey查找token
     * @param accessKey accessKey
     * @return token
     */
    AccessToken getAccessToken(String accessKey);

    /**
     * 保存token 30分钟超时时间
     * @param token token对象
     */
    void saveAccessToken(AccessToken token);
}

