package com.fanyin.service.withdraw.impl;

import com.fanyin.constant.SystemConfigConstant;
import com.fanyin.constants.SystemConstant;
import com.fanyin.dto.withdraw.WithdrawApply;
import com.fanyin.enums.WithdrawStatus;
import com.fanyin.mapper.withdraw.WithdrawLogMapper;
import com.fanyin.model.operation.VipConfig;
import com.fanyin.model.user.BankCard;
import com.fanyin.model.user.UserExtend;
import com.fanyin.model.withdraw.WithdrawLog;
import com.fanyin.service.deposit.DepositService;
import com.fanyin.service.operation.VipConfigService;
import com.fanyin.service.project.ProjectTenderService;
import com.fanyin.service.recharge.BankCardService;
import com.fanyin.service.recharge.RechargeService;
import com.fanyin.service.system.CommonService;
import com.fanyin.service.system.impl.SystemConfigApi;
import com.fanyin.service.user.UserExtendService;
import com.fanyin.service.withdraw.WithdrawService;
import com.fanyin.utils.BigDecimalUtils;
import com.fanyin.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 提现
 * @author 二哥很猛
 * @date 2018/11/23 10:47
 */
@Service("withdrawLogService")
public class WithdrawServiceImpl implements WithdrawService {

    @Autowired
    private WithdrawLogMapper withdrawLogMapper;

    @Autowired
    private UserExtendService userExtendService;

    @Autowired
    private VipConfigService vipConfigService;

    @Autowired
    private RechargeService rechargeService;

    @Autowired
    private ProjectTenderService projectTenderService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private BankCardService bankCardService;

    @Autowired
    private DepositService depositService;

    @Autowired
    private SystemConfigApi systemConfigApi;

    @Override
    public void withdrawApply(WithdrawApply apply) {
        String depositNo = depositService.getDepositNo(apply.getUserId(), apply.getUserType());
        //TODO 后期等待接入存管开发
        BankCard bankCard = bankCardService.getByUserType(apply.getUserId(), apply.getUserType());

        WithdrawLog log = new WithdrawLog();
        log.setUserId(apply.getUserId());
        log.setUserType(apply.getUserType());
        log.setAddTime(DateUtil.getNow());
        log.setAmount(BigDecimal.valueOf(apply.getAmount()));
        log.setState(WithdrawStatus.ENTRY.getCode());
        //借款人免费提现
        if(SystemConstant.BORROWER == apply.getUserType()){
            log.setUseFree(true);
        }else{
            //投资人查询是否有免费提现次数
            int freeWithdraw = this.freeWithdraw(apply.getUserId());
            if(freeWithdraw > 0){
                log.setUseFree(true);
            }else{
                double fee = this.getWithdrawFee(apply.getUserId(),apply.getAmount());
                log.setUseFree(false);
                log.setFee(BigDecimal.valueOf(fee));
            }
        }

        log.setBankCode(bankCard.getBankCode());
        log.setBankNum(bankCard.getBankNum());
        log.setOrderNo(commonService.getOrderNo());
    }

    @Override
    public int freeWithdraw(int userId) {
        UserExtend extend = userExtendService.getByUserId(userId);
        VipConfig vipConfig = vipConfigService.getByLevel(extend.getGrade());
        Date now = DateUtil.getNow();
        Date startTime = DateUtil.firstDayOfMonth(now);
        Date endTime = DateUtil.lastDayOfMonth(now);
        //已使用免费提现
        int usedWithdraw = withdrawLogMapper.countFreeWithdraw(userId, startTime, endTime);
        int withdraw = vipConfig.getWithdraw();
        int surplus = withdraw - usedWithdraw;
        return Math.max(0,surplus);
    }

    @Override
    public double getWithdrawFee(int userId, double amount) {
        int freeWithdraw = this.freeWithdraw(userId);
        if(freeWithdraw > 0){
            return 0D;
        }
        //待收费的提现金额
        BigDecimal noTender = getRechargeNoTender(userId);
        //单笔最小收费金额
        double minFee = systemConfigApi.getDouble(SystemConfigConstant.ONCE_WITHDRAW_FEE);
        if(noTender.compareTo(BigDecimal.ZERO) == 0){
            return systemConfigApi.getDouble(SystemConfigConstant.ONCE_WITHDRAW_FEE);
        }
        if(noTender.compareTo(BigDecimal.valueOf(amount)) > 0 ){
            //例如 待提现收费金额10000,本次提现5000 按5000的标准收费
            noTender = BigDecimal.valueOf(amount);
        }
        double rate = systemConfigApi.getDouble(SystemConfigConstant.RECHARGE_NO_TENDER_RATE);
        double fee = BigDecimalUtils.mul(BigDecimalUtils.centToYuan(rate), noTender.doubleValue());
        //取较大的,单次最小收费有限制
        return Math.max(minFee,fee);
    }



    @Override
    public BigDecimal getRechargeNoTender(int userId) {
        BigDecimal totalRecharge = rechargeService.getTotalRecharge(userId);
        BigDecimal totalWithdraw = withdrawLogMapper.getTotalWithdraw(userId);
        BigDecimal zero = BigDecimal.ZERO;
        BigDecimal subtract = totalRecharge.subtract(totalWithdraw);
        //充值金额小于等提现金额 已经没有充值未投资金额了
        if(subtract.compareTo(zero) <= 0){
            return zero;
        }

        BigDecimal totalTender = projectTenderService.getTotalTender(userId);
        subtract = subtract.subtract(totalTender);
        return subtract.compareTo(zero) <= 0 ? zero : subtract;
    }
}
