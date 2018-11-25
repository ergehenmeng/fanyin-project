package com.fanyin.service.deposit;

/**
 * @author 王艳兵
 * @date 2018/11/23 17:55
 */
public interface DepositService {

    /**
     * 根据用户类型查询存管号,
     * 如果用户没有开通存管则跑异常
     * @param userId 用户id
     * @param userType 用户类型
     * @return 存管号
     */
    String getDepositNo(int userId,byte userType);

    /**
     * 查询用户存管开户状态
     * @param userId 用户id
     * @param userType 存管开户状态
     * @return 用户id
     */
    byte getDepositStatus(int userId,byte userType);

    /**
     * 校验用户是否开户成功
     * @param userId 用户id
     * @param userType 用户类型
     */
    void verifyDeposit(int userId,byte userType);

    /**
     * 校验存管状态是否可用
     * @param status 存管状态
     */
    void verifyDeposit(int status);
}

