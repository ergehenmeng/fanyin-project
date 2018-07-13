package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.ConsiderateWaiter;
import com.fanyin.test.aop.before.GreetingBeforeAdvice;
import com.fanyin.test.aop.before.NaiveWaiter;
import com.fanyin.test.aop.before.Waiter;
import org.springframework.aop.ClassFilter;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.StaticMethodMatcherPointcutAdvisor;


import java.lang.reflect.Method;

/**
 * 静态方法切面类型
 * @author 王艳兵
 * @date 2018/7/13 11:37
 */
public class StaticMethodAdvisor extends StaticMethodMatcherPointcutAdvisor {

    private static final long serialVersionUID = 4348285386703233899L;

    @Override
    public boolean matches(Method method, Class<?> targetClass) {
        return "greetTo".equals(method.getName());
    }

    @Override
    public ClassFilter getClassFilter() {
        return NaiveWaiter.class::isAssignableFrom;
    }

    public static void main(String[] args) {
        ProxyFactory factory = new ProxyFactory();
        NaiveWaiter waiter = new NaiveWaiter();

        StaticMethodAdvisor advisor = new StaticMethodAdvisor();
        GreetingBeforeAdvice advice = new GreetingBeforeAdvice();
        advisor.setAdvice(advice);
        factory.addAdvisor(advisor);
        factory.setOptimize(true);
        factory.setTarget(waiter);

        Waiter naiveWaiter = (NaiveWaiter)factory.getProxy();
        naiveWaiter.greetTo("死板");
        naiveWaiter.serviceTo("死板");

        ConsiderateWaiter considerateWaiter  = new ConsiderateWaiter();
        factory.setTarget(considerateWaiter);
        Waiter proxy = (ConsiderateWaiter)factory.getProxy();
        proxy.greetTo("灵活");
        proxy.serviceTo("灵活");
    }
}
