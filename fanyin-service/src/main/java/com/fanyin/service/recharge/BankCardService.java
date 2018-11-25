package com.fanyin.service.recharge;

import com.fanyin.model.user.BankCard;

/**
 * @author 二哥很猛
 * @date 2018/11/23 17:21
 */
public interface BankCardService {

    /**
     * 获取投资人银行卡信息
     * @param userId 用户id
     * @return 银行卡信息
     */
    BankCard getByUserId(int userId);


    /**
     * 获取借款人银行卡信息
     * @param borrowerId 借款人id
     * @return 银行卡信息
     */
    BankCard getByBorrowerId(int borrowerId);

    /**
     * 根据用户类型查询用户银行卡信息
     * @param userId 用户id
     * @param userType 用户类型
     * @return 银行卡信息
     */
    BankCard getByUserType(int userId,byte userType);

}

