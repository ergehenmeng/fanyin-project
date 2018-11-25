package com.fanyin.service.withdraw;

import com.fanyin.dto.withdraw.WithdrawApply;

import java.math.BigDecimal;

/**
 * @author 二哥很猛
 * @date 2018/11/23 10:46
 */
public interface WithdrawService {

    /**
     * 提现申请
     * @param apply 提现信息 前台传递
     */
    void withdrawApply(WithdrawApply apply);

    /**
     * 获取投资人剩余的免费提现次数 = vip对应提现次数-月已提现-月提现申请中
     * 借款人提现完全免费
     * @param userId 用户id
     * @return 免费提现次数
     */
    int freeWithdraw(int userId);

    /**
     * 根据提现金额计算提现手续费,计算投资人手续费<br>
     * 如果用户有免费次数则手续费为零<br>
     * 充值未投资部分根据收费比率计算<br>
     * 收费比率由系统参数控制,总收费金额不小于单笔手续费<br>
     * 单笔手续费有系统参数<br>
     * @param userId 用户id
     * @param amount 提现金额
     * @return 手续费 元
     */
    double getWithdrawFee(int userId,double amount);


    /**
     * 获取用户充值未投资金额
     * 总充值金额-总提现金额(申请中,提现成功)-总投资金额(投资本金+总投资利息)
     * 如果当前有募集中的投资,总利息未生成,不计入
     * @param userId 用户id
     * @return 充值未投资金额 元
     */
    BigDecimal getRechargeNoTender(int userId);
}

