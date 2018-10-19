package com.fanyin.test.javassist;

import javassist.ClassPool;
import javassist.CtClass;

/**
 * @author 王艳兵
 * @date 2018/10/18 11:50
 */
public class FirstDemo {
    public static void main(String[] args) throws Exception{
        ClassPool pool = ClassPool.getDefault();
        CtClass ctClass = pool.get("com.fanyin.test.javassist.UserAssist");

    }
}
