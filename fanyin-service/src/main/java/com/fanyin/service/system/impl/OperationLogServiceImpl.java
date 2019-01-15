package com.fanyin.service.system.impl;

import com.fanyin.mapper.system.OperationLogMapper;
import com.fanyin.model.system.OperationLog;
import com.fanyin.service.system.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 操作日期
 * @author 二哥很猛
 * @date 2019/1/15 17:55
 */
@Service("operationLogService")
@Transactional(rollbackFor = RuntimeException.class)
public class OperationLogServiceImpl implements OperationLogService {

    @Autowired
    private OperationLogMapper operationLogMapper;

    @Override
    public void insertOperationLog(OperationLog log) {
        operationLogMapper.insertSelective(log);
    }
}
