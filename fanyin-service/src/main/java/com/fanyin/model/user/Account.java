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
    private BigDecimal total = BigDecimal.ZERO;

    /**
     * 可用余额(清算+未清算)<br>
     * 表 : account<br>
     * 对应字段 : available_balance<br>
     */
    private BigDecimal availableBalance = BigDecimal.ZERO;;

    /**
     * 充值金额(未清算)<br>
     * 表 : account<br>
     * 对应字段 : recharge<br>
     */
    private BigDecimal recharge = BigDecimal.ZERO;;

    /**
     * 投标冻结<br>
     * 表 : account<br>
     * 对应字段 : tender_freeze<br>
     */
    private BigDecimal tenderFreeze = BigDecimal.ZERO;;

    /**
     * 提现冻结<br>
     * 表 : account<br>
     * 对应字段 : withdraw_freeze<br>
     */
    private BigDecimal withdrawFreeze = BigDecimal.ZERO;;

    /**
     * 累计收益<br>
     * 表 : account<br>
     * 对应字段 : accumulated_income<br>
     */
    private BigDecimal accumulatedIncome = BigDecimal.ZERO;;

    /**
     * 待收本金<br>
     * 表 : account<br>
     * 对应字段 : wait_capital<br>
     */
    private BigDecimal waitCapital = BigDecimal.ZERO;;

    /**
     * 待收利息<br>
     * 表 : account<br>
     * 对应字段 : wait_interest<br>
     */
    private BigDecimal waitInterest = BigDecimal.ZERO;;

}