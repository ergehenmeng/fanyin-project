package com.fanyin.service.user.impl;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.user.AccountMapper;
import com.fanyin.model.user.Account;
import com.fanyin.service.user.AccountService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:58
 */
@Service("accountService")
@Slf4j
@Transactional(rollbackFor = RuntimeException.class)
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountMapper accountMapper;

    @Override
    public void insertAccount(int userId) {
        Account account = new Account();
        account.setUserId(userId);
        accountMapper.insertSelective(account);
    }

    @Override
    public Account getByUserId(int userId) {
        return accountMapper.getByUserId(userId);
    }

    @Override
    public void updateAccount(Account account) {
        this.checkAccount(account);
        int i = accountMapper.updateByPrimaryKeySelective(account);
        if(i != 1){
            log.error("用户资金账户更新异常,userId:[{}],count:[{}]",account.getUserId(),i);
            throw new BusinessException(ErrorCodeEnum.ACCOUNT_UPDATE_ERROR);
        }
    }

    /**
     * 校验资金账户是否正常
     * @param account 资产信息
     */
    private void checkAccount(Account account){
        BigDecimal zero = BigDecimal.ZERO;
        if(account.getAccumulatedIncome().compareTo(zero) < 0
                || account.getAvailableBalance().compareTo(zero) < 0
                || account.getRecharge().compareTo(zero) < 0
                || account.getTenderFreeze().compareTo(zero) < 0
                || account.getTotal().compareTo(zero) < 0
                || account.getWaitInterest().compareTo(zero) < 0
                || account.getWaitCapital().compareTo(zero) < 0
                || account.getWithdrawFreeze().compareTo(zero) < 0){
            throw new BusinessException(ErrorCodeEnum.ACCOUNT_CHECK_ERROR);
        }
    }
}
