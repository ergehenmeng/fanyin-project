package com.fanyin.service.recharge.impl;

import com.fanyin.constants.SystemConstant;
import com.fanyin.mapper.user.BankCardMapper;
import com.fanyin.model.user.BankCard;
import com.fanyin.service.recharge.BankCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 银行卡信息
 * @author 二哥很猛
 * @date 2018/11/23 17:21
 */
@Service("bankCardService")
public class BankCardServiceImpl implements BankCardService {

    @Autowired
    private BankCardMapper bankCardMapper;

    @Override
    public BankCard getByUserId(int userId) {
        return bankCardMapper.getByUserType(userId,SystemConstant.INVESTOR);
    }

    @Override
    public BankCard getByBorrowerId(int borrowerId) {
        return bankCardMapper.getByUserType(borrowerId,SystemConstant.BORROWER);
    }

    @Override
    public BankCard getByUserType(int userId, byte userType) {
        return bankCardMapper.getByUserType(userId,userType);
    }
}
