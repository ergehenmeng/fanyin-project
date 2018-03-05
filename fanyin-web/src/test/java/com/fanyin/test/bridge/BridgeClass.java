package com.fanyin.test.bridge;

/**
 * @author 王艳兵
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
