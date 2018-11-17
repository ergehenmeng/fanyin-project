package com.fanyin.dto.user;

import com.fanyin.enums.Integral;
import lombok.Data;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/11/17 13:54
 */
@Data
public class IntegralAward implements Serializable {

    private static final long serialVersionUID = -5492737328249661504L;

    /**
     * 用户id
     */
    private int userId;

    /**
     * 积分数
     */
    private int score;

    /**
     * 积分类型
     */
    private Integral integral;

    public IntegralAward(int userId, int score, Integral integral) {
        this.userId = userId;
        this.score = score;
        this.integral = integral;
    }
}
