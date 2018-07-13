package com.fanyin.test.aop.advisor;

import com.fanyin.test.aop.before.GreetingBeforeAdvice;
import com.fanyin.test.aop.before.NaiveWaiter;
import com.fanyin.test.aop.before.Waiter;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.RegexpMethodPointcutAdvisor;

/**
 * 正则表达式匹配模式,setPattern方法匹配是全限定的方法名 即包含类名
 * @author 王艳兵
 * @date 2018/7/13 14:14
 */
public class RegexpAdvisor extends RegexpMethodPointcutAdvisor {

    public static void main(String[] args) {
        ProxyFactory factory = new ProxyFactory();
        NaiveWaiter waiter = new NaiveWaiter();

        RegexpAdvisor advisor = new RegexpAdvisor();
        GreetingBeforeAdvice advice = new GreetingBeforeAdvice();
        advisor.setAdvice(advice);
        advisor.setPattern(".*service.*");
        factory.addAdvisor(advisor);
        factory.setOptimize(true);
        factory.setTarget(waiter);

        Waiter naiveWaiter = (NaiveWaiter)factory.getProxy();
        naiveWaiter.greetTo("死板");
        naiveWaiter.serviceTo("死板");


    }
}
