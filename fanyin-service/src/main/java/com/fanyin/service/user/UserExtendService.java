package com.fanyin.service.user;

/**
 * @author 二哥很猛
 * @date 2018/10/11 13:41
 */
public interface UserExtendService {

    /**
     * 添加用户积分 score为负则是扣除积分
     * @param userId 用户id
     * @param score 积分
     */
    void updateScore(int userId,int score);

}

