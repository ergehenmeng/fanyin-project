package com.fanyin.service.user;

import com.fanyin.enums.Integral;
import com.fanyin.model.operation.IntegralType;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:16
 */
public interface IntegralLogService {

    /**
     * 给用户发放或扣除积分
     * @param userId 用户id
     * @param integral 积分类型
     * @return 发放或扣除的积分数
     */
    int grantScore(int userId, Integral integral);

    /**
     * 根据积分类型计算应该发放或者扣除的积分,<br>
     * 主要是处理随机产生积分(例如签到积分等)
     * @param integralType 积分类型
     * @return 积分数
     */
    int calcScore(IntegralType integralType);

    /**
     * 添加积分日志信息
     * @param userId 用户id
     * @param score 发放或扣除的积分数
     * @param type 积分类型
     */
    void addScoreLog(int userId,int score,int type);
}

