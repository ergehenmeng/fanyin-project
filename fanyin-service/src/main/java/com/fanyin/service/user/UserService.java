package com.fanyin.service.user;

import com.fanyin.model.user.User;

/**
 * 投资人service
 * @author 二哥很猛
 * @date 2018/8/15 17:18
 */
public interface UserService {

    /**
     * 获取用户信息
     * @param userId 用户id
     * @return 用户信息
     */
    User getById(int userId);

    /**
     * 获取用户的存管状态
     * @param userId 用户id
     * @return 存管状态
     */
    byte getDepositStatus(int userId);

}

