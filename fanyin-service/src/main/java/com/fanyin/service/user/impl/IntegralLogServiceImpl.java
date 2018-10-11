package com.fanyin.service.user.impl;

import com.fanyin.enums.Integral;
import com.fanyin.mapper.user.IntegralLogMapper;
import com.fanyin.model.operation.IntegralType;
import com.fanyin.model.user.IntegralLog;
import com.fanyin.service.operation.IntegralTypeService;
import com.fanyin.service.user.IntegralLogService;
import com.fanyin.service.user.UserExtendService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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

    @Override
    public int grantScore(int userId, Integral integral) {

        IntegralType integralType = integralTypeService.getByNid(integral);
        if(integralType == null){
            log.warn("积分类型未查询到,不奖励或扣除积分,nid:{}",integral.name());
            return 0;
        }
        int score = this.calcScore(integralType);
        userExtendService.updateScore(userId,score);
        this.addScoreLog(userId,score,integralType.getId());
        return score;
    }

    @Override
    public int calcScore(IntegralType integralType) {
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
    public void addScoreLog(int userId, int score, int type) {
        IntegralLog log = new IntegralLog();
        log.setAddTime(new Date());
        log.setNum(score);
        log.setType(type);
        log.setUserId(userId);
        integralLogMapper.insertSelective(log);
    }
}
