package com.fanyin.service.user.impl;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.user.UserExtendMapper;
import com.fanyin.model.user.UserExtend;
import com.fanyin.service.user.UserExtendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 二哥很猛
 * @date 2018/10/11 13:52
 */
@Service("userExtendService")
public class UserExtendServiceImpl implements UserExtendService {

    @Autowired
    private UserExtendMapper userExtendMapper;

    @Override
    public synchronized void updateScore(int userId, int score) {

        UserExtend userExtend = userExtendMapper.getByUserId(userId);

        int surplus = userExtend.getIntegralNum() + score;

        if(surplus < 0){
            throw new BusinessException(ErrorCodeEnum.INTEGRAL_NOT_ENOUGH);
        }

        userExtendMapper.updateScore(userId, surplus);
    }

}
