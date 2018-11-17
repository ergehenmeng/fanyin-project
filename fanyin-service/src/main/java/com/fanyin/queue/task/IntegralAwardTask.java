package com.fanyin.queue.task;

import com.fanyin.dto.user.IntegralAward;
import com.fanyin.queue.AbstractTask;
import com.fanyin.service.user.IntegralLogService;
import com.fanyin.utils.SpringContextUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 积分发放任务
 * @author 二哥很猛
 * @date 2018/11/17 10:52
 */
@Slf4j
public class IntegralAwardTask extends AbstractTask<IntegralAward> {

    public IntegralAwardTask(IntegralAward data) {
        super(data);
    }

    @Override
    protected void execute(IntegralAward data) {
        try {
            IntegralLogService  integralLogService = (IntegralLogService)SpringContextUtil.getBean("integralLogService");
            integralLogService.awardScore(data.getUserId(),data.getScore(),data.getIntegral());
        }catch (Exception e){
            log.error("积分发放任务异常",e);
        }
    }
}
