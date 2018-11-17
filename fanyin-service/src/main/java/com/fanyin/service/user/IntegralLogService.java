package com.fanyin.service.user;

import com.fanyin.enums.Integral;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:16
 */
public interface IntegralLogService {


    /**
     * 积分奖励发放,直接发放积分
     * @param userId   用户id
     * @param score 发放的积分
     * @param integral 积分类型
     */
    void awardScore(int userId,int score, Integral integral);

    /**
     * 根据积分类型计算应该发放或者扣除的积分,<br>
     * 主要是处理随机产生积分(例如签到积分等)
     * @param integral 积分类型
     * @return 积分数
     */
    int calcScore(Integral integral);

    /**
     * 计算投标应奖励的积分数=积分配置倍数 * 投标奖励积分
     * @param amount 投标金额
     * @return 积分个数
     */
    int calcTenderScore(double amount);


}

