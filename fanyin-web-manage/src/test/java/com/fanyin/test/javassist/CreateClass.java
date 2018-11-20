package com.fanyin.test.javassist;

import org.apache.ibatis.javassist.*;

import java.lang.reflect.Method;

/**
 * @author 二哥很猛
 * @date 2018/11/19 9:58
 */
@SuppressWarnings("unchecked")
public class CreateClass {
    public static void main(String[] args) throws Exception{
        ClassPool pool = ClassPool.getDefault();
        CtClass cls = pool.makeClass("Create");
        CtMethod method = CtNewMethod.make("public int say(){ return 1;}", cls);
        cls.addMethod(method);

        Class aClass = cls.toClass();
        Object o = aClass.newInstance();
        Method say = aClass.getMethod("say");
        Object invoke = say.invoke(o);
        System.out.println(invoke);

    }
}
