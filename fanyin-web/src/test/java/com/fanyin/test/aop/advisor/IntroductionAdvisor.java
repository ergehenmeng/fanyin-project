package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.GreetingBeforeAdvice;
import com.fanyin.test.aop.before.NaiveWaiter;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.DefaultIntroductionAdvisor;

/**
 * @author 王艳兵
 * @date 2018/7/16 9:55
 */
public class IntroductionAdvisor {
    public static void main(String[] args) {
        GreetingBeforeAdvice advice = new GreetingBeforeAdvice();
        DefaultIntroductionAdvisor advisor = new DefaultIntroductionAdvisor(advice);

        ProxyFactory factory = new ProxyFactory();
        NaiveWaiter waiter = new NaiveWaiter();
        factory.setOptimize(true);
        factory.setTarget(waiter);
        factory.addAdvisor(advisor);

        NaiveWaiter naiveWaiter = (NaiveWaiter)factory.getProxy();

        naiveWaiter.greetTo("死板");
        naiveWaiter.serviceTo("死板");
    }
}
