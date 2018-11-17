package com.fanyin.queue;

import lombok.extern.slf4j.Slf4j;



/**
 * @author 二哥很猛
 * @param <T> 业务对象
 */
@Slf4j
public abstract class AbstractTask<T> implements Runnable{

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
     * 真实执行业务的逻辑
     * @param data 传入的对象
     */
    protected abstract void execute(T data);
}
