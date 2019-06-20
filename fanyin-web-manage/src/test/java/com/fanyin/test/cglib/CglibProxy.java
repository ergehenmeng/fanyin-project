package com.fanyin.test.cglib;



import org.springframework.cglib.proxy.Callback;
import org.springframework.cglib.proxy.Enhancer;
import org.springframework.cglib.proxy.MethodInterceptor;
import org.springframework.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

/**
 * @author 二哥很猛
 * @date 2018/7/12 15:27
 */
public class CglibProxy implements MethodInterceptor {

    private static final Callback callback = new CglibProxy();

    private Enhancer enhancer = new Enhancer();

    public Class<?> getProxy(Class<?> cls){
        enhancer.setSuperclass(cls);
        enhancer.setCallbackTypes(new Class[]{CglibProxy.class});
        Class aClass = enhancer.createClass();
        Enhancer.registerStaticCallbacks(aClass,new Callback[]{callback});
        return aClass;
    }

    @Override
    public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
        System.out.println("调用前");
        Object result = proxy.invokeSuper(obj,args);
        System.out.println("调用后");
        return result;
    }

    public static void main(String[] args)throws Exception {
        CglibProxy cglibProxy = new CglibProxy();
        Class<?> proxy = cglibProxy.getProxy(Proxy.class);
        Proxy xx = (Proxy)proxy.newInstance();
        xx.say();
    }
}
