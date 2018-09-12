package com.fanyin.test.bridge;

/**
 * @author 二哥很猛
 * @date 2018/2/8 15:21
 */
public class BridgeClass implements BridgeClassSuper<String>{

    @Override
    public void say(String s) {
        System.out.println(s);
    }
}
