package com.fanyin.test.aop.before;

/**
 * @author 二哥很猛
 * @date 2018/7/13 11:41
 */
public class ConsiderateWaiter implements Waiter {
    @Override
    public void greetTo(String name) {
        System.out.println("热烈欢迎," + name);
    }

    @Override
    public void serviceTo(String name) {
        System.out.println("热烈服务," + name);
    }
}
