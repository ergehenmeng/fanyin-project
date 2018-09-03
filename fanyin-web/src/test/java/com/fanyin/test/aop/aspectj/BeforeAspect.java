package com.fanyin.test.aop.aspectj;

import com.fanyin.test.aop.before.NaiveWaiter;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.DeclareParents;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.aop.aspectj.annotation.AspectJProxyFactory;

/**
 * @author 二哥很猛
 * @date 2018/7/16 11:03
 */
@Aspect
public class BeforeAspect {

    @Pointcut("execution(* greetTo(..))")
    public void greetTo(){
    }

    @Pointcut("execution(* serviceTo(..))")
    public void serviceTo(){
    }

    @Before("greetTo()||serviceTo()")
    public void before(){
        System.out.println("之前");
    }

    @DeclareParents(value = "com.fanyin.test.aop.before.Waiter+",defaultImpl = ExtImpl.class)
    private Ext ext;


    public static void main(String[] args) {
        NaiveWaiter waiter = new NaiveWaiter();
        AspectJProxyFactory factory = new AspectJProxyFactory();
        factory.setTarget(waiter);
        factory.addAspect(BeforeAspect.class);
        NaiveWaiter proxy = factory.getProxy();
        proxy.greetTo("二哥");
        proxy.serviceTo("三哥");
    }

}
