package com.fanyin.test.chain;

/**
 * 责任链模式
 * @author 二哥很猛
 * @date 2018/9/3 10:33
 */
public class Main {

    public static void main(String[] args) {
        ChainHandler chainHandler = new ChainHandler();
        Handler handlerA = new HandlerA();
        Handler handlerB = new HandlerB();
        Handler handlerC = new HandlerC();
        chainHandler.addHandler(handlerA);
        chainHandler.addHandler(handlerB);
        chainHandler.addHandler(handlerC);
        chainHandler.process();
    }
}
