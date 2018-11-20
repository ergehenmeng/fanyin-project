package com.fanyin.service.user;

import com.fanyin.model.user.Account;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:58
 */
public interface AccountService {

    /**
     * 新增投资人资金账户
     * @param userId 投资人id
     */
    void insertAccount(int userId);

    /**
     * 根据用户id查询资产信息
     * @param userId 用户id
     * @return 资产信息
     */
    Account getByUserId(int userId);

    /**
     * 更新用户资产信息
     * @param account 新的资产信息
     */
    void updateAccount(Account account);
}

