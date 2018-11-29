package com.fanyin.service.user.impl;

import com.fanyin.constants.ConfigConstant;
import com.fanyin.enums.Integral;
import com.fanyin.mapper.user.IntegralLogMapper;
import com.fanyin.model.operation.IntegralType;
import com.fanyin.model.user.IntegralLog;
import com.fanyin.service.operation.IntegralTypeService;
import com.fanyin.service.system.impl.SystemConfigApi;
import com.fanyin.service.user.IntegralLogService;
import com.fanyin.service.user.UserExtendService;
import com.fanyin.utils.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:16
 */
@Service("integralLogService")
@Slf4j
public class IntegralLogServiceImpl implements IntegralLogService {

    @Autowired
    private IntegralTypeService integralTypeService;

    @Autowired
    private UserExtendService userExtendService;

    @Autowired
    private IntegralLogMapper integralLogMapper;

    @Autowired
    private SystemConfigApi systemConfigApi;

    @Override
    public void doAwardScore(int userId, int score, Integral integral) {
        if(score == 0){
            log.warn("积分奖励为零,userId:{},type:{}",userId,integral);
            return;
        }
        userExtendService.updateScore(userId,score);
        this.addScoreLog(userId,score,integral.name().toLowerCase());
    }

    @Override
    public int calcScore(Integral integral) {
        IntegralType integralType = integralTypeService.getByNid(integral);
        if(integralType == null){
            log.warn("积分类型未查询到,nid:{}", integral.name());
            return 0;
        }
        int score = integralType.getScore();
        if(integralType.getRandom()){
            Random random = new Random();
            score = random.nextInt(score);
            //随机数是 [0,score),防止为零的情况发生
            score += 1;
        }
        return score;
    }

    @Override
    public int calcTenderScore(double amount) {
        int multiple = this.calcScore(Integral.TENDER);
        int tenderAmount = systemConfigApi.getIntByNid(ConfigConstant.INTEGRAL_TENDER);
        int score = (int) amount / tenderAmount;
        return score * multiple;
    }

    /**
     * 添加积分日志信息
     * @param userId 用户id
     * @param score 发放或扣除的积分数
     * @param nid 积分类型
     */
    private void addScoreLog(int userId, int score, String nid) {
        IntegralLog log = new IntegralLog();
        log.setAddTime(DateUtil.getNow());
        log.setNum(score);
        log.setType(nid);
        log.setUserId(userId);
        integralLogMapper.insertSelective(log);
    }
}
