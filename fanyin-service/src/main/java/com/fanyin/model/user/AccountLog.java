package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 二哥很猛
 */
@Data
public class AccountLog implements Serializable {
    private static final long serialVersionUID = -4402135811863759138L;
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


}