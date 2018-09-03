package com.fanyin.service.user;

import com.fanyin.dto.AccessToken;

/**
 * 投资人service
 * @author 二哥很猛
 * @date 2018/8/15 17:18
 */
public interface UserService {

    /**
     * 创建登陆后的token,并将token放入缓存中
     * @param userId 用户id
     * @param source 登陆来源 ANDROID,IOS
     * @return token
     */
    AccessToken createAccessToken(int userId, String source);
}

