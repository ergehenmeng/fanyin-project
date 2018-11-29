package com.fanyin.service.borrower.impl;

import com.fanyin.dto.borrower.BorrowerAccountDetailLog;
import com.fanyin.enums.BorrowerAccountLogType;
import com.fanyin.mapper.borrower.BorrowerAccountLogMapper;
import com.fanyin.model.borrower.BorrowerAccount;
import com.fanyin.model.borrower.BorrowerAccountLog;
import com.fanyin.model.project.Project;
import com.fanyin.model.withdraw.WithdrawLog;
import com.fanyin.service.borrower.BorrowerAccountLogService;
import com.fanyin.service.borrower.BorrowerAccountService;
import com.fanyin.utils.BigDecimalUtils;
import com.fanyin.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 借款人资金记录
 * @author 二哥很猛
 * @date 2018/11/20 13:52
 */
@Service("borrowerAccountLogService")
public class BorrowerAccountLogServiceImpl implements BorrowerAccountLogService {

    @Autowired
    private BorrowerAccountLogMapper borrowerAccountLogMapper;

    @Autowired
    private BorrowerAccountService borrowerAccountService;

    @Override
    public void loanSuccess(Project project) {
        BorrowerAccountDetailLog accountDetailLog = new BorrowerAccountDetailLog();
        accountDetailLog.setType(BorrowerAccountLogType.BORROWER_LOAN.getType());
        accountDetailLog.setBorrowerId(project.getBorrowerId());
        accountDetailLog.setAvailableBalance(project.getAmount());
        accountDetailLog.setTotal(project.getAmount());
        accountDetailLog.setUnRepay(project.getAmount());
        accountDetailLog.setAmount(project.getAmount());
        this.capitalOperation(accountDetailLog);
    }

    @Override
    public void capitalOperation(BorrowerAccountDetailLog accountDetailLog) {
        BorrowerAccount account = borrowerAccountService.getByBorrowerId(accountDetailLog.getBorrowerId());
        //计算并更新借款人资金,更新数据有传入数据决定
        account.setAvailableBalance(account.getAvailableBalance().add(accountDetailLog.getAvailableBalance()));
        account.setPay(account.getPay().add(accountDetailLog.getPay()));
        account.setRecharge(account.getRecharge().add(accountDetailLog.getRecharge()));
        account.setRepay(account.getRepay().add(accountDetailLog.getRepay()));
        account.setTotal(account.getTotal().add(accountDetailLog.getTotal()));
        account.setUnRepay(account.getUnRepay().add(accountDetailLog.getUnRepay()));
        account.setWithdrawFreeze(account.getWithdrawFreeze().add(accountDetailLog.getWithdrawFreeze()));
        borrowerAccountService.updateAccount(account);

        //借款人资金记录
        BorrowerAccountLog accountLog = new BorrowerAccountLog();
        accountLog.setType(accountDetailLog.getType());
        accountLog.setProjectId(accountDetailLog.getProjectId());
        accountLog.setBorrowerId(accountDetailLog.getBorrowerId());
        accountLog.setAmount(accountDetailLog.getAmount());
        accountLog.setAddTime(DateUtil.getNow());
        borrowerAccountLogMapper.insertSelective(accountLog);
    }

    @Override
    public void withdrawFreeze(WithdrawLog log) {
        BorrowerAccountDetailLog accountDetailLog = new BorrowerAccountDetailLog();
        accountDetailLog.setType(BorrowerAccountLogType.BORROWER_WITHDRAW.getType());
        accountDetailLog.setBorrowerId(log.getUserId());
        accountDetailLog.setAvailableBalance(BigDecimalUtils.negation(log.getAmount()));
        accountDetailLog.setAmount(log.getAmount());
        accountDetailLog.setWithdrawFreeze(log.getAmount());
        accountDetailLog.setOrderNo(log.getOrderNo());
        this.capitalOperation(accountDetailLog);
    }
}
