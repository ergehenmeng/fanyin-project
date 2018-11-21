package com.fanyin.queue;

import com.fanyin.dto.task.Async;
import com.fanyin.dto.task.Key;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;



/**
 * @author 二哥很猛
 * @param <T> 业务对象
 */
@Slf4j
public abstract class AbstractTask<T extends Key> implements Runnable{

    private T data;

    public AbstractTask(T data){
        this.data = data;
    }

    @Override
    public void run() {
        log.debug("队列任务开始执行");
        execute(data);
        log.debug("队列任务执行结束");
    }

    public T getData() {
        return data;
    }

    /**
     * 异常信息解析
     * @param e 任务异常
     * @param codeEnum 未知异常定义
     * @param async 结果封装对象
     */
    protected  void exceptionParse(Exception e, ErrorCodeEnum codeEnum,Async async){
        if(e instanceof BusinessException){
            BusinessException exception = (BusinessException)e;
            async.setCode(exception.getCode());
            async.setMsg(exception.getMessage());
        }else{
            async.setCode(codeEnum.getCode());
            async.setMsg(codeEnum.getMsg());
        }
        async.setKey(data.getKey());
    }

    /**
     * 真实执行业务的逻辑
     * @param data 传入的对象
     */
    protected abstract void execute(T data);
}
