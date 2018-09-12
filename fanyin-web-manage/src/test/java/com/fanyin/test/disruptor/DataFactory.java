package com.fanyin.test.disruptor;

import com.lmax.disruptor.EventFactory;

/**
 * @author 二哥很猛
 * @date 2018/6/20 11:38
 */
public class DataFactory implements EventFactory<Data> {
    @Override
    public Data newInstance() {
        return new Data();
    }
}
