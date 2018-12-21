package com.fanyin.queue;

import com.fanyin.dto.task.Async;
import com.fanyin.dto.task.Key;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.service.system.RedisCacheService;
import com.fanyin.utils.SpringContextUtil;
import lombok.extern.log4j.Log4j;

/**
 * @author 二哥很猛
 * @date 2018/12/21 16:42
 */
@Log4j
public abstract class AbstractAsyncTask<T extends Key> extends AbstractTask<T> implements Runnable{

    public AbstractAsyncTask(T data){
        super(data);
    }

    /**
     * 解析并缓存<strong>结果</strong>异常信息
     * @param e 任务异常
     * @param codeEnum 未知异常定义
     * @param async 结果封装对象
     */
    protected void parseCacheException(Exception e, ErrorCodeEnum codeEnum, Async async){
        if(e instanceof BusinessException){
            BusinessException exception = (BusinessException)e;
            async.setCode(exception.getCode());
            async.setMsg(exception.getMessage());
        }else{
            async.setCode(codeEnum.getCode());
            async.setMsg(codeEnum.getMsg());
        }
        async.setKey(getData().getKey());
        RedisCacheService redisCacheService = (RedisCacheService) SpringContextUtil.getBean("redisCacheService");
        redisCacheService.cacheAsyncResponse(async);
    }
}
