package com.fanyin.service.user.impl;

import com.fanyin.mapper.user.AccountLogMapper;
import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.user.AccountLog;
import com.fanyin.service.user.AccountLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 二哥很猛
 * @date 2018/11/19 11:06
 */
@Service("accountLogService")
public class AccountLogServiceImpl implements AccountLogService {

    @Autowired
    private AccountLogMapper accountLogMapper;

    @Override
    public void insertAccountLog(AccountLog accountLog) {
        accountLogMapper.insertSelective(accountLog);
    }
}
