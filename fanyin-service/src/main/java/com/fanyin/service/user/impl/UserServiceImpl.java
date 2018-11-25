package com.fanyin.service.user.impl;

import com.fanyin.mapper.user.UserMapper;
import com.fanyin.model.user.User;
import com.fanyin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @author 二哥很猛
 * @date 2018/8/15 17:28
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getById(int userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public byte getDepositStatus(int userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        return user.getDepositStatus();
    }
}
