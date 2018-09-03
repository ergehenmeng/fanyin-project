package com.fanyin.test.cglib;



import org.springframework.cglib.proxy.Enhancer;
import org.springframework.cglib.proxy.MethodInterceptor;
import org.springframework.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

/**
 * @author 二哥很猛
 * @date 2018/7/12 15:27
 */
public class CglibProxy implements MethodInterceptor {

    private Enhancer enhancer = new Enhancer();

    public Object getProxy(Class<?> cls){
        enhancer.setSuperclass(cls);
        enhancer.setCallback(this);
        return enhancer.create();
    }

    @Override
    public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
        System.out.println("--------");
        Object result = proxy.invokeSuper(obj,args);
        System.out.println("--------");
        return result;
    }

    public static void main(String[] args) {
        CglibProxy cglibProxy = new CglibProxy();
        Proxy proxy = (Proxy)cglibProxy.getProxy(Proxy.class);
        proxy.say();
        System.out.println(proxy);
    }
}
