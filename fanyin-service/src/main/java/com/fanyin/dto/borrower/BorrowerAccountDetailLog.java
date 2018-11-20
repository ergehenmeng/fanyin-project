package com.fanyin.dto.borrower;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 用于更新借款人资金账户,
 * 借款人没有资金详细信息表
 * @author 二哥很猛
 * @date 2018/11/20 14:00
 */
@Data
public class BorrowerAccountDetailLog implements Serializable {

    private static final long serialVersionUID = 8972001603021210842L;


    /**
     * 借款人id
     */
    private Integer borrowerId;

    /**
     * 操作资金
     */
    private BigDecimal amount = BigDecimal.ZERO;

    /**
     * 资金变动类型
     */
    private Byte type;

    /**
     * 借款总额(该值只会累加)
     */
    private BigDecimal total = BigDecimal.ZERO;

    /**
     * 可用余额(清算+未清算)
     */
    private BigDecimal availableBalance = BigDecimal.ZERO;

    /**
     * 充值金额
     */
    private BigDecimal recharge = BigDecimal.ZERO;

    /**
     * 提现冻结金额
     */
    private BigDecimal withdrawFreeze = BigDecimal.ZERO;

    /**
     * 已还金额
     */
    private BigDecimal repay = BigDecimal.ZERO;

    /**
     * 未还金额
     */
    private BigDecimal unRepay = BigDecimal.ZERO;

    /**
     * 已缴费金额
     */
    private BigDecimal pay = BigDecimal.ZERO;

    /**
     * 产品id
     */
    private Integer projectId;
}
