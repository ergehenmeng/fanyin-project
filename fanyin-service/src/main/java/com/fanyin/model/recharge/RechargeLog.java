package com.fanyin.model.recharge;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 充值记录表
 * @author 二哥很猛
 */
@Data
public class RechargeLog implements Serializable {
    private static final long serialVersionUID = -710390097631891181L;
    /**
     * 主键<br>
     * 表 : recharge_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户id<br>
     * 表 : recharge_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;


    /**
     * 用户类型 0:投资人 1:借款人<br>
     * 表 : recharge_log<br>
     * 对应字段 : user_type<br>
     */
    private Byte userType;

    /**
     * 充值方式 0:快捷充值 1:网银充值<br>
     * 表 : recharge_log<br>
     * 对应字段 : manner<br>
     */
    private Byte manner;

    /**
     * 状态 0:订单生成 1:充值成功 2:充值失败<br>
     * 表 : recharge_log<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 充值金额<br>
     * 表 : recharge_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 实际到账金额<br>
     * 表 : recharge_log<br>
     * 对应字段 : real_amount<br>
     */
    private BigDecimal realAmount;

    /**
     * 订单号<br>
     * 表 : recharge_log<br>
     * 对应字段 : order_no<br>
     */
    private String orderNo;

    /**
     * 订单生成时间<br>
     * 表 : recharge_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 订单更新时间<br>
     * 表 : recharge_log<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;


    /**
     * 关联的用户手机号
     */
    private String mobile;

}