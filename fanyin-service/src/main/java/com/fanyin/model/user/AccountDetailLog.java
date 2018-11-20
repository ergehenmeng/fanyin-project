package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 资金详细信息
 * @author 二哥很猛
 */
@Data
public class AccountDetailLog implements Serializable {
    private static final long serialVersionUID = -862313798421488243L;
    /**
     * <br>
     * 表 : account_detail_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : account_detail_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 实际操作金额<br>
     * 表 : account_detail_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount = BigDecimal.ZERO;

    /**
     * 资金变动类型 0:充值 1:投资 2:回款 3:提现 4:平台奖励 5:承接奖励 6:转让回款 7:撤标   <br>
     * 表 : account_detail_log<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 总资产 <br>
     * 表 : account_detail_log<br>
     * 对应字段 : total<br>
     */
    private BigDecimal total = BigDecimal.ZERO;

    /**
     * 可用余额(已清算+未清算)<br>
     * 表 : account_detail_log<br>
     * 对应字段 : available_balance<br>
     */
    private BigDecimal availableBalance = BigDecimal.ZERO;

    /**
     * 充值金额(未清算)<br>
     * 表 : account_detail_log<br>
     * 对应字段 : recharge<br>
     */
    private BigDecimal recharge = BigDecimal.ZERO ;

    /**
     * 投标冻结金额<br>
     * 表 : account_detail_log<br>
     * 对应字段 : tender_freeze<br>
     */
    private BigDecimal tenderFreeze = BigDecimal.ZERO;

    /**
     * 提现冻结金额<br>
     * 表 : account_detail_log<br>
     * 对应字段 : withdraw_freeze<br>
     */
    private BigDecimal withdrawFreeze = BigDecimal.ZERO;

    /**
     * 累计收益<br>
     * 表 : account_detail_log<br>
     * 对应字段 : accumulated_income<br>
     */
    private BigDecimal accumulatedIncome = BigDecimal.ZERO;

    /**
     * 待收本金<br>
     * 表 : account_detail_log<br>
     * 对应字段 : wait_capital<br>
     */
    private BigDecimal waitCapital = BigDecimal.ZERO;

    /**
     * 待收利息<br>
     * 表 : account_detail_log<br>
     * 对应字段 : wait_interest<br>
     */
    private BigDecimal waitInterest = BigDecimal.ZERO;

    /**
     * 发生时间<br>
     * 表 : account_detail_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 备注信息<br>
     * 表 : account_detail_log<br>
     * 对应字段 : remark<br>
     */
    private String remark;




}