package com.fanyin.service.recharge.impl;

import com.fanyin.dto.recharge.RechargeAsync;
import com.fanyin.dto.recharge.RechargeRequest;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.RechargeStatus;
import com.fanyin.exception.DepositoryException;
import com.fanyin.mapper.recharge.RechargeLogMapper;
import com.fanyin.model.recharge.RechargeLog;
import com.fanyin.service.recharge.RechargeService;
import com.fanyin.service.user.AccountDetailLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * 充值记录
 * @author 二哥很猛
 * @date 2018/11/22 19:03
 */
@Service("rechargeLogService")
@Slf4j
@Transactional(rollbackFor = RuntimeException.class)
public class RechargeServiceImpl implements RechargeService {

    @Autowired
    private RechargeLogMapper rechargeLogMapper;

    @Autowired
    private AccountDetailLogService accountDetailLogService;

    @Override
    public RechargeLog getByOrderNo(String orderNo) {
        return rechargeLogMapper.getByOrderNo(orderNo);
    }

    @Override
    public BigDecimal getTotalRecharge(int userId) {
        return rechargeLogMapper.getTotalRecharge(userId);
    }

    @Override
    public PageInfo<RechargeLog> getByPage(RechargeRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<RechargeLog> list = rechargeLogMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public void rechargeAsync(RechargeAsync async) {
        RechargeLog rechargeLog = rechargeLogMapper.getByOrderNo(async.getOrderNo());
        if(rechargeLog == null){
            log.error("充值订单号未查询到,orderNo:[{}]",async.getOrderNo());
            throw new DepositoryException(ErrorCodeEnum.RECHARGE_NOT_FOUND);
        }
        if(rechargeLog.getState() != RechargeStatus.APPLY.getCode()){
            log.warn("充值订单已更新,oldStatus:[{}],newStatus:[{}]",rechargeLog.getState(),async.getState());
            return;
        }
        rechargeLog.setRealAmount(BigDecimal.valueOf(async.getRealAmount()));
        rechargeLog.setState(async.getState());
        rechargeLogMapper.updateByPrimaryKeySelective(rechargeLog);

        if(async.getState() == RechargeStatus.SUCCESS.getCode()){
            //成功,更新资金账户
            accountDetailLogService.rechargeSuccess(rechargeLog);
        }
    }
}
