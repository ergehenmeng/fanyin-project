package com.fanyin.dto.account;

import com.fanyin.enums.AccountLogType;
import lombok.Data;

import java.io.Serializable;

/**
 * 奖励
 * @author 二哥很猛
 * @date 2018/11/22 20:51
 */
@Data
public class PlatformAward implements Serializable {

    private static final long serialVersionUID = 1884110753067345044L;

    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 奖励金额
     */
    private double amount;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 奖励类型
     */
    private AccountLogType accountLogType;
}
