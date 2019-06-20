package com.fanyin.test.java7;

import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.lang.reflect.Method;

/**
 * @author 王艳兵
 * @date 2019/6/19 20:57
 */
public class MethodTypeTest {

    private static void  bar(Object obj){
        System.out.println(obj);
    }

    public static MethodHandles.Lookup lookup(){
        return MethodHandles.lookup();
    }

    public static void main(String[] args) throws Throwable {
        MethodHandles.Lookup lookup = MethodTypeTest.lookup();
        Method method = MethodTypeTest.class.getDeclaredMethod("bar", Object.class);
        MethodHandle handle = lookup.unreflect(method);
        handle.invoke("二哥");

        MethodType methodType = MethodType.methodType(void.class, Object.class);
        MethodHandle bar = lookup.findStatic(MethodTypeTest.class, "bar", methodType);
        bar.invoke("三哥");

    }
}
