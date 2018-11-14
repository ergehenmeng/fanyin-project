package com.fanyin.service.system;

import com.fanyin.dto.security.AccessToken;

/**
 * @author 二哥很猛
 * @date 2018/10/11 13:47
 */
public interface ProxyService {

    /**
     * 创建登陆后的token,并将token放入缓存中
     * @param userId 用户id
     * @param source 登陆来源 ANDROID,IOS
     * @return token
     */
    AccessToken createAccessToken(int userId, String source);

}

