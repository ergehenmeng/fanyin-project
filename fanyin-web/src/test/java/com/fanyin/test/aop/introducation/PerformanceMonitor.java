package com.fanyin.test.aop.introducation;

import org.aopalliance.intercept.MethodInvocation;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.DelegatingIntroductionInterceptor;

/**
 * @author 王艳兵
 * @date 2018/7/13 10:01
 */
public class PerformanceMonitor extends DelegatingIntroductionInterceptor implements Monitorable {

    private ThreadLocal<Boolean> threadLocal = ThreadLocal.withInitial(() -> false);

    @Override
    public void setMonitorActive(boolean active) {
        threadLocal.set(active);
    }

    @Override
    public Object invoke(MethodInvocation mi) throws Throwable {
        Object obj;
        if(threadLocal.get()){
            System.out.println("开始之前");
            obj = super.invoke(mi);
            System.out.println("开始之后");
        }else{
            obj = super.invoke(mi);
        }
        return obj;
    }

    public static void main(String[] args) {
        Performance performance = new Performance();
        ProxyFactory factory = new ProxyFactory();
        PerformanceMonitor monitor = new PerformanceMonitor();
        factory.setTarget(performance);
        factory.setOptimize(true);
        factory.addAdvice(monitor);
        Performance proxy = (Performance)factory.getProxy();
        proxy.say();
        monitor.setMonitorActive(true);
        proxy.say();

    }
}
