package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 优惠券+加息券关联表
 * @author 二哥很猛
 */
@Data
public class DiscountCouponTender implements Serializable {
    private static final long serialVersionUID = 5215898489670356365L;
    /**
     * 主键<br>
     * 表 : discount_coupon_tender<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 投标id<br>
     * 表 : discount_coupon_tender<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 优惠券id<br>
     * 表 : discount_coupon_tender<br>
     * 对应字段 : discount_coupon_id<br>
     */
    private Integer discountCouponId;

    /**
     * 添加时间(使用时间)<br>
     * 表 : discount_coupon_tender<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;


}