package com.fanyin.dto.recharge;

import lombok.Data;

import java.io.Serializable;

/**
 * 充值异步数据
 * @author 二哥很猛
 * @date 2018/11/22 20:19
 */
@Data
public class RechargeAsync implements Serializable {

    private static final long serialVersionUID = -7736469227326071344L;

    /**
     * 订单号
     */
    private String orderNo;

    /**
     * 订单处理结果状态
     */
    private Byte status;

    /**
     * 实际充值金额
     */
    private double realAmount;
}
