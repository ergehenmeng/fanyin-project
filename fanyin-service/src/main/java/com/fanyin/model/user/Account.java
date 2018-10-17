package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author 二哥很猛
 */
@Data
public class Account implements Serializable {

    private static final long serialVersionUID = -2831205572816775346L;
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



}