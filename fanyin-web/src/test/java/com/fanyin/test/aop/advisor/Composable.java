package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.GreetingBeforeAdvice;
import com.fanyin.test.aop.before.NaiveWaiter;
import com.fanyin.test.aop.before.Waiter;
import org.springframework.aop.Pointcut;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.ComposablePointcut;
import org.springframework.aop.support.ControlFlowPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;

/**
 * 复合切面 intersection交集 union合集
 * @author 王艳兵
 * @date 2018/7/13 17:59
 */
public class Composable {

    private static Pointcut getPointcut(){
        ComposablePointcut composablePointcut = new ComposablePointcut();
        Pointcut pointcut = new ControlFlowPointcut(WaiterDelegate.class,"greetTo");
        Pointcut pointcut2 = new ControlFlowPointcut(WaiterDelegate.class,"serviceTo");
        return composablePointcut.intersection(pointcut).union(pointcut2);
    }

    public static void main(String[] args) {
        ProxyFactory factory = new ProxyFactory();
        NaiveWaiter waiter = new NaiveWaiter();

        Pointcut pointcut = Composable.getPointcut();
        GreetingBeforeAdvice advice = new GreetingBeforeAdvice();

        DefaultPointcutAdvisor advisor = new DefaultPointcutAdvisor();
        advisor.setPointcut(pointcut);
        advisor.setAdvice(advice);

        factory.setOptimize(true);
        factory.setTarget(waiter);
        factory.addAdvisor(advisor);

        NaiveWaiter naiveWaiter = (NaiveWaiter)factory.getProxy();
        Waiter delegate = new WaiterDelegate(naiveWaiter);
        delegate.greetTo("死板");
        delegate.serviceTo("死板");
    }

}
