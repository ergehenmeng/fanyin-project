package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 优惠券表
 * @author 二哥很猛
 */
@Data
public class DiscountCoupon implements Serializable {
    private static final long serialVersionUID = -6150724233487547961L;
    /**
     * 主键<br>
     * 表 : discount_coupon<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户id<br>
     * 表 : discount_coupon<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     *  优惠券类型 0:抵扣券 1:加息券
     *  表 : discount_coupon<br>
     *  对应字段 : classify<br>
     */
    private Byte classify;

    /**
     * 优惠券名称<br>
     * 表 : discount_coupon<br>
     * 对应字段 : title<br>
     */
    private String title;

    /**
     * 优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期<br>
     * 表 : discount_coupon<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 优惠券金额 抵扣券时表示元,加息券时表示%<br>
     * 表 : discount_coupon<br>
     * 对应字段 : face_value<br>
     */
    private BigDecimal faceValue;

    /**
     * 有效开始时间<br>
     * 表 : discount_coupon<br>
     * 对应字段 : start_time<br>
     */
    private Date startTime;

    /**
     * 失效时间 如果为空则永久有效<br>
     * 表 : discount_coupon<br>
     * 对应字段 : end_time<br>
     */
    private Date endTime;

    /**
     * 期限限制(月)<br>
     * 表 : discount_coupon<br>
     * 对应字段 : period_limit<br>
     */
    private Byte periodLimit;

    /**
     * 起投金额限制<br>
     * 表 : discount_coupon<br>
     * 对应字段 : amount_limit<br>
     */
    private BigDecimal amountLimit;

    /**
     * 发放时间<br>
     * 表 : discount_coupon<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;


}