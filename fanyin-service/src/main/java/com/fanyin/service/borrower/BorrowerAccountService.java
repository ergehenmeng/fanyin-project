package com.fanyin.service.borrower;

import com.fanyin.model.borrower.BorrowerAccount;

/**
 * @author 二哥很猛
 * @date 2018/11/20 13:43
 */
public interface BorrowerAccountService {

    /**
     * 初始化借款人资金账户
     * @param borrowerId 借款人id
     */
    void insertAccount(int borrowerId);

    /**
     * 更新借款人资金账户信息
     * @param account 资金账户
     */
    void updateAccount(BorrowerAccount account);

    /**
     * 获取借款人资金账户信息
     * @param borrowerId 借款人id
     * @return 资产信息
     */
    BorrowerAccount getByBorrowerId(int borrowerId);
}

