package com.fanyin.service.user;


import com.fanyin.model.user.AccountLog;

/**
 * 资金记录信息
 * @author 二哥很猛
 * @date 2018/11/19 11:06
 */
public interface AccountLogService {

    /**
     * 添加投资人资金日志信息
     * @param accountLog 资金日志
     */
    void insertAccountLog(AccountLog accountLog);
}

