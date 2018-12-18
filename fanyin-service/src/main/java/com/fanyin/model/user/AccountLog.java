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

    private static final long serialVersionUID = -7752611523333822372L;
    /**
     * 主键<br>
     * 表 : account_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户id<br>
     * 表 : account_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 金额<br>
     * 表 : account_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount = BigDecimal.ZERO;

    /**
     * 资金变动类型 0:充值 1:投资 2:回款 3:提现 4:平台奖励 5:承接奖励 6:转让回款 7:撤标 <br>
     * 表 : account_log<br>
     * 对应字段 : classify<br>
     */
    private Byte classify;

    /**
     * 添加时间<br>
     * 表 : account_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 投标id<br>
     * 表 : account_log<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 备注信息<br>
     * 表 : account_log<br>
     * 对应字段 : remark<br>
     */
    private String remark;
}