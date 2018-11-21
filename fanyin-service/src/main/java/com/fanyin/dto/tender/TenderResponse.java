package com.fanyin.dto.tender;

import com.fanyin.dto.task.Async;
import com.fanyin.model.user.DiscountCoupon;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/21 15:56
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TenderResponse extends Async implements Serializable {

    private static final long serialVersionUID = 5162892021400775338L;

    /**
     * 用户id
     */
    private int userId;

    /**
     * 产品id
     */
    private int projectId;

    /**
     * 投标金额
     */
    private double amount;

    /**
     * 实际投标金额
     */
    private double realAmount;

    /**
     * 优惠券信息
     */
    private List<DiscountCoupon> discountCoupon;
}
