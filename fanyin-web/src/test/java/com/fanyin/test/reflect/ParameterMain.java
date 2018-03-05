package com.fanyin.test.reflect;

import com.fanyin.test.SubClass;

import java.lang.reflect.Method;
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
    }
}
