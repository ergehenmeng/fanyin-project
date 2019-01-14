package com.fanyin.service.borrower.impl;

import com.fanyin.mapper.borrower.BorrowerMapper;
import com.fanyin.model.borrower.Borrower;
import com.fanyin.service.borrower.BorrowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 二哥很猛
 * @date 2018/11/23 17:48
 */
@Service("borrowerService")
@Transactional(rollbackFor = RuntimeException.class)
public class BorrowerServiceImpl implements BorrowerService {

    @Autowired
    private BorrowerMapper borrowerMapper;

    @Override
    public Borrower getById(int borrowerId) {
        return borrowerMapper.selectByPrimaryKey(borrowerId);
    }

    @Override
    public byte getDepositStatus(int borrowerId) {
        Borrower borrower = borrowerMapper.selectByPrimaryKey(borrowerId);
        return borrower.getDepositStatus();
    }
}
