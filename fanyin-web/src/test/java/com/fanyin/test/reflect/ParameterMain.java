package com.fanyin.test.reflect;

import com.fanyin.test.SubClass;
import com.fanyin.test.SuperClass;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.Parameter;

/**
 * @author 王艳兵
 * @date 2018/2/24 11:51
 */
public class ParameterMain {
    public static void main(String[] args) {
        Method[] methods = SubClass.class.getMethods();
        for (Method method : methods){
            Parameter[] parameters = method.getParameters();
            for (Parameter parameter : parameters){
                System.out.println(parameter.getName());
                System.out.println(parameter.getType());
                System.out.println(method.getName() + ":" + parameter.isNamePresent());
            }
        }
        boolean anAbstract = Modifier.isAbstract(AbstractClass.class.getModifiers());
        boolean anInterface = Modifier.isInterface(SuperClass.class.getModifiers());
        System.out.println("是否为抽象类:" + anAbstract);
        System.out.println("是否为接口:" + anInterface);
    }
}
