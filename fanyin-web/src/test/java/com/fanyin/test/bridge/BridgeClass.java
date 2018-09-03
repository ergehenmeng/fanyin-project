package com.fanyin.test.bridge;

/**
 * @author 二哥很猛
 * @date 2018/2/8 15:21
 */
public class BridgeClass {

    public void say(Object name){
        System.out.println(name);
    }

    public void say(Long aLong) {
        System.out.println(aLong);
    }
}
