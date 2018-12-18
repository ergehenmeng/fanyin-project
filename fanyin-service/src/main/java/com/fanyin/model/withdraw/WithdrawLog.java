package com.fanyin.model.withdraw;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 提现记录表
 * @author 二哥很猛
 */
@Data
public class WithdrawLog implements Serializable {
    private static final long serialVersionUID = -5362750725926172776L;
    /**
     * 主键<br>
     * 表 : withdraw_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户id<br>
     * 表 : withdraw_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 用户类型 0:投资人 1:借款人<br>
     * 表 : withdraw_log<br>
     * 对应字段 : user_type<br>
     */
    private Byte userType;

    /**
     * 提现状态 0:录入中 1:提现申请 2:提现成功,3:提现审核失败,4:提现失败<br>
     * 表 : withdraw_log<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 提现金额<br>
     * 表 : withdraw_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 提现到账金额<br>
     * 表 : withdraw_log<br>
     * 对应字段 : real_amount<br>
     */
    private BigDecimal realAmount;


    /**
     * 提现手续费<br>
     * 表 : withdraw_log<br>
     * 对应字段 : fee<br>
     */
    private BigDecimal fee;

    /**
     * 是否为免费提现 0:否 1是<br>
     * 表 : withdraw_log<br>
     * 对应字段 : useFree<br>
     */
    private Boolean useFree;

    /**
     * 提现银行卡号<br>
     * 表 : withdraw_log<br>
     * 对应字段 : bank_num<br>
     */
    private String bankNum;

    /**
     * 提现银行卡编码<br>
     * 表 : withdraw_log<br>
     * 对应字段 : bank_code<br>
     */
    private String bankCode;

    /**
     * 添加时间<br>
     * 表 : withdraw_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : withdraw_log<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 订单号<br>
     * 表 : withdraw_log<br>
     * 对应字段 : order_no<br>
     */
    private String orderNo;


}