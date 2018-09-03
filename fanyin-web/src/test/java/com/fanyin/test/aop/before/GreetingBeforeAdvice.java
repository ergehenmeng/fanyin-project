package com.fanyin.test.aop.before;

import com.fanyin.test.aop.advisor.StaticMethodAdvisor;
import org.springframework.aop.BeforeAdvice;

import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.aop.framework.ProxyFactory;

import java.lang.reflect.Method;

/**
 * @author 二哥很猛
 * @date 2018/7/12 16:20
 */
public class GreetingBeforeAdvice implements MethodBeforeAdvice {

    @Override
    public void before(Method method, Object[] args, Object target) throws Throwable {
        System.out.print("微笑表情,");
    }

    public static void main(String[] args) {
        Waiter waiter = new NaiveWaiter();
        BeforeAdvice advice = new GreetingBeforeAdvice();
        ProxyFactory factory = new ProxyFactory();
        StaticMethodAdvisor advisor = new StaticMethodAdvisor();
        advisor.setAdvice(advice);
        factory.setTarget(waiter);
        factory.addAdvisor(advisor);
        factory.setOptimize(false);
        Waiter proxy = (Waiter)factory.getProxy();
        proxy.greetTo("二哥");
    }
}
