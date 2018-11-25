package com.fanyin.service.user;

import com.fanyin.model.user.UserExtend;

import java.util.Collection;

/**
 * @author 二哥很猛
 * @date 2018/10/11 13:41
 */
public interface UserExtendService {


    /**
     * 根据用户id查询用户附加信息
     * @param userId 用户id
     * @return 用户附加信息
     */
    UserExtend getByUserId(int userId);

    /**
     * 添加用户积分 score为负则是扣除积分
     * @param userId 用户id
     * @param score 积分
     */
    void updateScore(int userId,int score);

    /**
     * 计算并给更新用户等级
     * @param userId 用户id
     */
    void updateGrade(int userId);

    /**
     * 计算并更新用户等级
     * @param userIds 用户id列表
     */
    void updateGrades(Collection<Integer> userIds);
}

