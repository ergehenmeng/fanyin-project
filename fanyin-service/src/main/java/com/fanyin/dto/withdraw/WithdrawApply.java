package com.fanyin.dto.withdraw;

import lombok.Data;

import java.io.Serializable;

/**
 * 提现申请
 * @author 二哥很猛
 * @date 2018/11/23 11:03
 */
@Data
public class WithdrawApply implements Serializable {

    private static final long serialVersionUID = 885405948911846142L;
    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 用户类型
     */
    private Byte userType;


    /**
     * 提现金额
     */
    private Double amount;


}
