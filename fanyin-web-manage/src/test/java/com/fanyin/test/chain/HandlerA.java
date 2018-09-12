package com.fanyin.test.chain;

/**
 * @author 二哥很猛
 * @date 2018/9/3 10:25
 */
public class HandlerA implements Handler {

    @Override
    public void doHandler(ChainHandler chainHandler) {
        System.out.println("A");
        chainHandler.process();
    }
}
