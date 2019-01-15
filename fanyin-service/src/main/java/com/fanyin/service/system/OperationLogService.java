package com.fanyin.service.system;

import com.fanyin.model.system.OperationLog;

/**
 * @author 二哥很猛
 * @date 2019/1/15 17:54
 */
public interface OperationLogService {

    /**
     * 添加操作日志
     * @param log 日志
     */
    void insertOperationLog(OperationLog log);

}

