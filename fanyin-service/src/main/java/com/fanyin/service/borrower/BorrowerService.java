package com.fanyin.service.borrower;

import com.fanyin.model.borrower.Borrower;

/**
 * 借款人基本信息
 * @author 二哥很猛
 * @date 2018/11/23 17:47
 */
public interface BorrowerService {


    /**
     * 获取借款人基本信息
     * @param borrowerId 借款人id
     * @return 借款人基本信息
     */
    Borrower getById(int borrowerId);

    /**
     * 获取用户的存管状态
     * @param borrowerId 用户id
     * @return 存管状态
     */
    byte getDepositStatus(int borrowerId);
}

