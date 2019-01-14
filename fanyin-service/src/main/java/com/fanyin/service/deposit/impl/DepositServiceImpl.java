package com.fanyin.service.deposit.impl;

import com.fanyin.constants.SystemConstant;
import com.fanyin.enums.DepositStatus;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.model.borrower.Borrower;
import com.fanyin.model.user.User;
import com.fanyin.service.borrower.BorrowerService;
import com.fanyin.service.deposit.DepositService;
import com.fanyin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 二哥很猛
 * @date 2018/11/23 17:55
 */
@Service("depositService")
@Transactional(rollbackFor = RuntimeException.class)
public class DepositServiceImpl implements DepositService {

    @Autowired
    private UserService userService;

    @Autowired
    private BorrowerService borrowerService;

    @Override
    public String getDepositNo(int userId, byte userType) {
        if(SystemConstant.BORROWER == userType){
            Borrower borrower = borrowerService.getById(userId);
            this.verifyDeposit(borrower.getDepositStatus());
            return borrower.getDepositNo();
        }
        User user = userService.getById(userId);
        this.verifyDeposit(user.getDepositStatus());
        return user.getDepositNo();
    }

    @Override
    public byte getDepositStatus(int userId, byte userType) {
        if(SystemConstant.BORROWER == userType){
            return borrowerService.getDepositStatus(userId);
        }
        return userService.getDepositStatus(userId);
    }

    @Override
    public void verifyDeposit(int userId, byte userType) {
        byte status = this.getDepositStatus(userId, userType);
        this.verifyDeposit(status);
    }

    @Override
    public void verifyDeposit(int status) {
        if(status == DepositStatus.DEFAULT.getCode() || status == DepositStatus.FAIL.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_NOT_OPEN);
        }
        if(status == DepositStatus.APPLY.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_ACTIVATING);
        }
        if(status == DepositStatus.AUTH.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_AUTH);
        }
        if(status == DepositStatus.MODIFY_MOBILE.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_MOBILE_MODIFY);
        }
        if(status == DepositStatus.MODIFY_BANK.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_BANK_MODIFY);
        }
        if(status == DepositStatus.MODIFY_ENTERPRISE.getCode()){
            throw new BusinessException(ErrorCodeEnum.DEPOSIT_ENTERPRISE_MODIFY);
        }
    }
}
