package com.fanyin.service.system;

import com.fanyin.dto.security.AccessToken;
import com.fanyin.dto.task.Async;

/**
 * @author 二哥很猛
 * @date 2018/11/21 16:19
 */
public interface RedisCacheService {

    /**
     * 缓存投标异步结果
     * @param response 对象
     */
    void cacheAsyncResponse(Async response);

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
    void cacheAccessToken(AccessToken token);
}

