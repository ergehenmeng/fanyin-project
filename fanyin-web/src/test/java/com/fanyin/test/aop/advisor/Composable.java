package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.GreetingBeforeAdvice;
import com.fanyin.test.aop.before.NaiveWaiter;
import com.fanyin.test.aop.before.Waiter;
import org.springframework.aop.Pointcut;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.ComposablePointcut;
import org.springframework.aop.support.ControlFlowPointcut;
import org.springframework.aop.support.StaticMethodMatcher;

import java.lang.reflect.Method;

/**
 * 复合切面
 * @author 王艳兵
 * @date 2018/7/13 17:59
 */
public class Composable {

    public static Pointcut getPointcut(){
        ComposablePointcut composablePointcut = new ComposablePointcut();
        Pointcut pointcut = new ControlFlowPointcut(NaiveWaiter.class,"greetTo");
        StaticMethodMatcher matcher = new StaticMethodMatcher() {
            @Override
            public boolean matches(Method method, Class<?> targetClass) {
                return "serviceTo".equals(method.getName());
            }
        };
        return composablePointcut.intersection(pointcut).intersection(matcher);
    }

    public static void main(String[] args) {
        ProxyFactory factory = new ProxyFactory();
        NaiveWaiter waiter = new NaiveWaiter();
        Pointcut pointcut = Composable.getPointcut();
        GreetingBeforeAdvice advice = new GreetingBeforeAdvice();

        factory.setOptimize(true);
        factory.setTarget(waiter);

        Waiter naiveWaiter = (NaiveWaiter)factory.getProxy();
        naiveWaiter.greetTo("死板");
        naiveWaiter.serviceTo("死板");


    }

}
