package com.fanyin.service.user.impl;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.OrderType;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.user.UserExtendMapper;
import com.fanyin.model.business.VipConfig;
import com.fanyin.model.user.Account;
import com.fanyin.model.user.UserExtend;
import com.fanyin.service.business.VipConfigService;
import com.fanyin.service.user.AccountService;
import com.fanyin.service.user.UserExtendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/10/11 13:52
 */
@Service("userExtendService")
@Transactional(rollbackFor = RuntimeException.class)
public class UserExtendServiceImpl implements UserExtendService {

    @Autowired
    private UserExtendMapper userExtendMapper;

    @Autowired
    private AccountService accountService;

    @Autowired
    private VipConfigService vipConfigService;

    @Override
    public UserExtend getByUserId(int userId) {
        return userExtendMapper.getByUserId(userId);
    }

    @Override
    public synchronized void updateScore(int userId, int score) {
        UserExtend userExtend = userExtendMapper.getByUserId(userId);
        int surplus = userExtend.getIntegralNum() + score;
        if(surplus < 0){
            throw new BusinessException(ErrorCodeEnum.INTEGRAL_NOT_ENOUGH);
        }
        userExtendMapper.updateScore(userId, surplus);
    }

    @Override
    public void updateGrade(int userId) {
        Account account = accountService.getByUserId(userId);
        BigDecimal totalAwait = account.getWaitCapital().add(account.getWaitInterest());
        List<VipConfig> configs = vipConfigService.getConfigs(OrderType.DESC);

        VipConfig config = getSuitableConfig(totalAwait, configs);
        userExtendMapper.updateGrade(userId,config.getGrade());
    }

    /**
     * 根据待收查询所处的vip配置信息
     * @param totalAwait 待收总额
     * @param vipConfigs vip配置信息
     * @return vip配置信息
     */
    private VipConfig getSuitableConfig(BigDecimal totalAwait,List<VipConfig> vipConfigs){
        for (VipConfig vipConfig : vipConfigs) {
            if(totalAwait.compareTo(vipConfig.getAmount()) >= 0){
                return vipConfig;
            }
        }
        //最小等级
        return vipConfigs.get(vipConfigs.size() - 1);
    }


    @Override
    public void updateGrades(Collection<Integer> userIds) {
        userIds.forEach(this::updateGrade);
    }

}
