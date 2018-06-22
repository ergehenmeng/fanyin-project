package com.fanyin.test.disruptor;

import com.lmax.disruptor.WorkHandler;

/**
 * @author 王艳兵
 * @date 2018/6/20 11:34
 */
public class Consumer implements WorkHandler<Data> {

    @Override
    public void onEvent(Data event) throws Exception {
        System.out.println(Thread.currentThread().getName() + ":" + event.getValue());
    }
}
