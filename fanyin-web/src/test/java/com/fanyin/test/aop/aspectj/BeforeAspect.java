package com.fanyin.test.aop.aspectj;

import com.fanyin.test.aop.before.NaiveWaiter;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.aop.aspectj.annotation.AspectJProxyFactory;

/**
 * @author 王艳兵
 * @date 2018/7/16 11:03
 */
@Aspect
public class BeforeAspect {

    @Before("execution(* greetTo(..))")
    public void before(){
        System.out.print("哈哈");
    }

    public static void main(String[] args) {
        NaiveWaiter waiter = new NaiveWaiter();
        AspectJProxyFactory factory = new AspectJProxyFactory();
        factory.setTarget(waiter);
        factory.addAspect(BeforeAspect.class);
        NaiveWaiter proxy = factory.getProxy();
        proxy.greetTo("二哥");
    }

}
