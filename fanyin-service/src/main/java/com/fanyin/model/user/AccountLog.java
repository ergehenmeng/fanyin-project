package com.fanyin.model.user;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 二哥很猛
 */
public class AccountLog implements Serializable {
    /**
     * <br>
     * 表 : account_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : account_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 实际操作金额<br>
     * 表 : account_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 资金详细类型<br>
     * 表 : account_log<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 可用余额(已清算+未清算)<br>
     * 表 : account_log<br>
     * 对应字段 : available_balance<br>
     */
    private BigDecimal availableBalance;

    /**
     * 充值金额(未清算)<br>
     * 表 : account_log<br>
     * 对应字段 : recharge<br>
     */
    private BigDecimal recharge;

    /**
     * 投标冻结金额<br>
     * 表 : account_log<br>
     * 对应字段 : tender_freeze<br>
     */
    private BigDecimal tenderFreeze;

    /**
     * 提现冻结金额<br>
     * 表 : account_log<br>
     * 对应字段 : withdraw_freeze<br>
     */
    private BigDecimal withdrawFreeze;

    /**
     * 累计收益<br>
     * 表 : account_log<br>
     * 对应字段 : accumulated_income<br>
     */
    private BigDecimal accumulatedIncome;

    /**
     * 待收本金<br>
     * 表 : account_log<br>
     * 对应字段 : wait_capital<br>
     */
    private BigDecimal waitCapital;

    /**
     * 待收利息<br>
     * 表 : account_log<br>
     * 对应字段 : wait_interest<br>
     */
    private BigDecimal waitInterest;

    /**
     * 发生时间<br>
     * 表 : account_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 备注信息<br>
     * 表 : account_log<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    private static final long serialVersionUID = 1L;

    /**
     * @return 
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  
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
     * @return 实际操作金额
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * @param amount  实际操作金额
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * @return 资金详细类型
     */
    public Byte getType() {
        return type;
    }

    /**
     * @param type  资金详细类型
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * @return 可用余额(已清算+未清算)
     */
    public BigDecimal getAvailableBalance() {
        return availableBalance;
    }

    /**
     * @param availableBalance  可用余额(已清算+未清算)
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
     * @return 投标冻结金额
     */
    public BigDecimal getTenderFreeze() {
        return tenderFreeze;
    }

    /**
     * @param tenderFreeze  投标冻结金额
     */
    public void setTenderFreeze(BigDecimal tenderFreeze) {
        this.tenderFreeze = tenderFreeze;
    }

    /**
     * @return 提现冻结金额
     */
    public BigDecimal getWithdrawFreeze() {
        return withdrawFreeze;
    }

    /**
     * @param withdrawFreeze  提现冻结金额
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

    /**
     * @return 发生时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  发生时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * @return 备注信息
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark  备注信息
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     *
     * @param that
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        AccountLog other = (AccountLog) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getAmount() == null ? other.getAmount() == null : this.getAmount().equals(other.getAmount()))
            && (this.getType() == null ? other.getType() == null : this.getType().equals(other.getType()))
            && (this.getAvailableBalance() == null ? other.getAvailableBalance() == null : this.getAvailableBalance().equals(other.getAvailableBalance()))
            && (this.getRecharge() == null ? other.getRecharge() == null : this.getRecharge().equals(other.getRecharge()))
            && (this.getTenderFreeze() == null ? other.getTenderFreeze() == null : this.getTenderFreeze().equals(other.getTenderFreeze()))
            && (this.getWithdrawFreeze() == null ? other.getWithdrawFreeze() == null : this.getWithdrawFreeze().equals(other.getWithdrawFreeze()))
            && (this.getAccumulatedIncome() == null ? other.getAccumulatedIncome() == null : this.getAccumulatedIncome().equals(other.getAccumulatedIncome()))
            && (this.getWaitCapital() == null ? other.getWaitCapital() == null : this.getWaitCapital().equals(other.getWaitCapital()))
            && (this.getWaitInterest() == null ? other.getWaitInterest() == null : this.getWaitInterest().equals(other.getWaitInterest()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()));
    }

    /**
     *
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getAmount() == null) ? 0 : getAmount().hashCode());
        result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
        result = prime * result + ((getAvailableBalance() == null) ? 0 : getAvailableBalance().hashCode());
        result = prime * result + ((getRecharge() == null) ? 0 : getRecharge().hashCode());
        result = prime * result + ((getTenderFreeze() == null) ? 0 : getTenderFreeze().hashCode());
        result = prime * result + ((getWithdrawFreeze() == null) ? 0 : getWithdrawFreeze().hashCode());
        result = prime * result + ((getAccumulatedIncome() == null) ? 0 : getAccumulatedIncome().hashCode());
        result = prime * result + ((getWaitCapital() == null) ? 0 : getWaitCapital().hashCode());
        result = prime * result + ((getWaitInterest() == null) ? 0 : getWaitInterest().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
        return result;
    }

    /**
     *
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", amount=").append(amount);
        sb.append(", type=").append(type);
        sb.append(", availableBalance=").append(availableBalance);
        sb.append(", recharge=").append(recharge);
        sb.append(", tenderFreeze=").append(tenderFreeze);
        sb.append(", withdrawFreeze=").append(withdrawFreeze);
        sb.append(", accumulatedIncome=").append(accumulatedIncome);
        sb.append(", waitCapital=").append(waitCapital);
        sb.append(", waitInterest=").append(waitInterest);
        sb.append(", addTime=").append(addTime);
        sb.append(", remark=").append(remark);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}