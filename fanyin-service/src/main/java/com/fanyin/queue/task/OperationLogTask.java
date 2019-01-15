package com.fanyin.queue.task;

import com.fanyin.model.system.OperationLog;
import com.fanyin.queue.AbstractTask;
import com.fanyin.service.system.OperationLogService;
import com.fanyin.utils.SpringContextUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 操作日志任务
 * @author 二哥很猛
 * @date 2019/1/15 17:58
 */
@Slf4j
public class OperationLogTask extends AbstractTask<OperationLog> {

    public OperationLogTask(OperationLog data) {
        super(data);
    }

    @Override
    protected void execute(OperationLog data) {
        try{
            OperationLogService service = (OperationLogService) SpringContextUtil.getBean("operationLogService");
            service.insertOperationLog(data);
        }catch (Exception e){
            log.error("操作日志写入异常",e);
        }
    }
}
