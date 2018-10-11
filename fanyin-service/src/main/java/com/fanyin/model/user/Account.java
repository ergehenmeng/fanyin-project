package com.fanyin.model.user;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author 二哥很猛
 */
public class Account implements Serializable {
    /**
     * 主键<br>
     * 表 : account<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : account<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 总资产<br>
     * 表 : account<br>
     * 对应字段 : total<br>
     */
    private BigDecimal total;

    /**
     * 可用余额(清算+未清算)<br>
     * 表 : account<br>
     * 对应字段 : available_balance<br>
     */
    private BigDecimal availableBalance;

    /**
     * 充值金额(未清算)<br>
     * 表 : account<br>
     * 对应字段 : recharge<br>
     */
    private BigDecimal recharge;

    /**
     * 投标冻结<br>
     * 表 : account<br>
     * 对应字段 : tender_freeze<br>
     */
    private BigDecimal tenderFreeze;

    /**
     * 提现冻结<br>
     * 表 : account<br>
     * 对应字段 : withdraw_freeze<br>
     */
    private BigDecimal withdrawFreeze;

    /**
     * 累计收益<br>
     * 表 : account<br>
     * 对应字段 : accumulated_income<br>
     */
    private BigDecimal accumulatedIncome;

    /**
     * 待收本金<br>
     * 表 : account<br>
     * 对应字段 : wait_capital<br>
     */
    private BigDecimal waitCapital;

    /**
     * 待收利息<br>
     * 表 : account<br>
     * 对应字段 : wait_interest<br>
     */
    private BigDecimal waitInterest;


    private static final long serialVersionUID = 1L;

    /**
     * @return 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 用户ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  用户ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 总资产
     */
    public BigDecimal getTotal() {
        return total;
    }

    /**
     * @param total  总资产
     */
    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    /**
     * @return 可用余额(清算+未清算)
     */
    public BigDecimal getAvailableBalance() {
        return availableBalance;
    }

    /**
     * @param availableBalance  可用余额(清算+未清算)
     */
    public void setAvailableBalance(BigDecimal availableBalance) {
        this.availableBalance = availableBalance;
    }

    /**
     * @return 充值金额(未清算)
     */
    public BigDecimal getRecharge() {
        return recharge;
    }

    /**
     * @param recharge  充值金额(未清算)
     */
    public void setRecharge(BigDecimal recharge) {
        this.recharge = recharge;
    }

    /**
     * @return 投标冻结
     */
    public BigDecimal getTenderFreeze() {
        return tenderFreeze;
    }

    /**
     * @param tenderFreeze  投标冻结
     */
    public void setTenderFreeze(BigDecimal tenderFreeze) {
        this.tenderFreeze = tenderFreeze;
    }

    /**
     * @return 提现冻结
     */
    public BigDecimal getWithdrawFreeze() {
        return withdrawFreeze;
    }

    /**
     * @param withdrawFreeze  提现冻结
     */
    public void setWithdrawFreeze(BigDecimal withdrawFreeze) {
        this.withdrawFreeze = withdrawFreeze;
    }

    /**
     * @return 累计收益
     */
    public BigDecimal getAccumulatedIncome() {
        return accumulatedIncome;
    }

    /**
     * @param accumulatedIncome  累计收益
     */
    public void setAccumulatedIncome(BigDecimal accumulatedIncome) {
        this.accumulatedIncome = accumulatedIncome;
    }

    /**
     * @return 待收本金
     */
    public BigDecimal getWaitCapital() {
        return waitCapital;
    }

    /**
     * @param waitCapital  待收本金
     */
    public void setWaitCapital(BigDecimal waitCapital) {
        this.waitCapital = waitCapital;
    }

    /**
     * @return 待收利息
     */
    public BigDecimal getWaitInterest() {
        return waitInterest;
    }

    /**
     * @param waitInterest  待收利息
     */
    public void setWaitInterest(BigDecimal waitInterest) {
        this.waitInterest = waitInterest;
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", userId=" + userId +
                ", total=" + total +
                ", availableBalance=" + availableBalance +
                ", recharge=" + recharge +
                ", tenderFreeze=" + tenderFreeze +
                ", withdrawFreeze=" + withdrawFreeze +
                ", accumulatedIncome=" + accumulatedIncome +
                ", waitCapital=" + waitCapital +
                ", waitInterest=" + waitInterest +
                '}';
    }
}