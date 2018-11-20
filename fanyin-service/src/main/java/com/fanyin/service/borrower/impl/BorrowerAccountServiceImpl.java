package com.fanyin.service.borrower.impl;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.borrower.BorrowerAccountMapper;
import com.fanyin.model.borrower.BorrowerAccount;
import com.fanyin.service.borrower.BorrowerAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * 借款人账户
 * @author 二哥很猛
 * @date 2018/11/20 13:44
 */
@Service("borrowerAccountService")
public class BorrowerAccountServiceImpl implements BorrowerAccountService {

    @Autowired
    private BorrowerAccountMapper borrowerAccountMapper;

    @Override
    public void insertAccount(int borrowerId) {
        BorrowerAccount account = new BorrowerAccount();
        account.setBorrowerId(borrowerId);
        borrowerAccountMapper.insertSelective(account);
    }

    @Override
    public void updateAccount(BorrowerAccount account) {
        this.checkAccount(account);
        borrowerAccountMapper.updateByPrimaryKeySelective(account);
    }

    @Override
    public BorrowerAccount getByBorrowerId(int borrowerId) {
        return borrowerAccountMapper.getByBorrowerId(borrowerId);
    }

    private void checkAccount(BorrowerAccount account){
        BigDecimal zero = BigDecimal.ZERO;
        if(account.getAvailableBalance().compareTo(zero) < 0
                || account.getPay().compareTo(zero) < 0
                || account.getRecharge().compareTo(zero) < 0
                || account.getRepay().compareTo(zero) < 0
                || account.getTotal().compareTo(zero) < 0
                || account.getUnRepay().compareTo(zero) < 0
                || account.getWithdrawFreeze().compareTo(zero) < 0){
            throw new BusinessException(ErrorCodeEnum.ACCOUNT_CHECK_ERROR);
        }
    }
}
