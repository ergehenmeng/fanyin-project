package com.fanyin.service.recharge;

import com.fanyin.dto.recharge.RechargeAsync;
import com.fanyin.dto.recharge.RechargeLogRequest;
import com.fanyin.model.recharge.RechargeLog;
import com.github.pagehelper.PageInfo;

/**
 * @author 二哥很猛
 * @date 2018/11/22 19:02
 */
public interface RechargeLogService {

    /**
     * 根据订单号查询充值记录
     * @param orderNo 订单号
     * @return 充值记录
     */
    RechargeLog getByOrderNo(String orderNo);

    /**
     * 根据条件分页查询充值记录信息
     * @param request 前台参数
     * @return 分页充值记录
     */
    PageInfo<RechargeLog> getByPage(RechargeLogRequest request);

    /**
     * 充值成功或失败异步回调
     * @param async 结果信息
     */
    void rechargeAsync(RechargeAsync async);
}

