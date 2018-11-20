package com.fanyin.model.borrower;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 借款人账户表
 * @author 二哥很猛
 */
@Data
public class BorrowerAccount implements Serializable {

    private static final long serialVersionUID = -183103857225021818L;
    /**
     * 主键<br>
     * 表 : borrower_account<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人id<br>
     * 表 : borrower_account<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 借款总额(该值只会累加)<br>
     * 表 : borrower_account<br>
     * 对应字段 : total<br>
     */
    private BigDecimal total = BigDecimal.ZERO;

    /**
     * 可用余额(清算+未清算)<br>
     * 表 : borrower_account<br>
     * 对应字段 : available_balance<br>
     */
    private BigDecimal availableBalance = BigDecimal.ZERO;

    /**
     * 充值金额<br>
     * 表 : borrower_account<br>
     * 对应字段 : recharge<br>
     */
    private BigDecimal recharge = BigDecimal.ZERO;

    /**
     * 提现冻结金额<br>
     * 表 : borrower_account<br>
     * 对应字段 : withdraw_freeze<br>
     */
    private BigDecimal withdrawFreeze = BigDecimal.ZERO;

    /**
     * 已还金额<br>
     * 表 : borrower_account<br>
     * 对应字段 : repay<br>
     */
    private BigDecimal repay = BigDecimal.ZERO;

    /**
     * 未还金额<br>
     * 表 : borrower_account<br>
     * 对应字段 : un_repay<br>
     */
    private BigDecimal unRepay = BigDecimal.ZERO;

    /**
     * 已缴费金额<br>
     * 表 : borrower_account<br>
     * 对应字段 : pay<br>
     */
    private BigDecimal pay = BigDecimal.ZERO;


}