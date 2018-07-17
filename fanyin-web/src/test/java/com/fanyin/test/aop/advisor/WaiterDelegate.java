package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.Waiter;

/**
 * @author 王艳兵
 * @date 2018/7/16 9:28
 */
public class WaiterDelegate implements Waiter{

    private Waiter waiter;

    public WaiterDelegate(Waiter waiter){
        this.waiter = waiter;
    }

    @Override
    public void greetTo(String name) {
        waiter.greetTo(name);
    }

    @Override
    public void serviceTo(String name) {
        waiter.serviceTo(name);
    }
}
