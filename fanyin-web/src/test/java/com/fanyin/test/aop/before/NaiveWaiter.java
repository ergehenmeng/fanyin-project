package com.fanyin.test.aop.before;

/**
 * @author 王艳兵
 * @date 2018/7/12 16:18
 */
public class NaiveWaiter implements Waiter {

    @Override
    public void greetTo(String name) {
        System.out.println("欢迎," + name);
    }

    @Override
    public void serviceTo(String name) {
        System.out.println("服务," + name);
    }
}
