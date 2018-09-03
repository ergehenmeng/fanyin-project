package com.fanyin.test.chain;

/**
 * @author 二哥很猛
 * @date 2018/9/3 10:25
 */
public class HandlerC implements Handler {
    @Override
    public void doHandler(ChainHandler chainHandler) {
        System.out.println("C");
        chainHandler.process();
    }
}
