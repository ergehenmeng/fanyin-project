package com.fanyin.test;

import org.springframework.util.ClassUtils;

import java.lang.reflect.Method;

/**
 * @author 二哥很猛
 * @date 2018/2/8 13:45
 */
public class SubClass extends SecondClass{
    @Override
    protected void say2() {
        System.out.println("second class");
    }

    @Override
    public void say() {
        System.out.println("super class");
    }

    public static void main(String[] args) {
        Method[] methods = SubClass.class.getDeclaredMethods();
        for (Method method : methods){
            Method mostSpecificMethod = ClassUtils.getMostSpecificMethod(method, SuperClass.class);
            /*System.out.println(method);
            System.out.println(mostSpecificMethod);*/
            System.out.println(method.getDeclaringClass());
        }
    }
}
