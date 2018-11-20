package com.fanyin.test.javassist;

import org.apache.ibatis.javassist.ClassPool;
import org.apache.ibatis.javassist.CtClass;

/**
 * @author 二哥很猛
 * @date 2018/11/19 9:45
 */
public class Base {
    public static void main(String[] args)throws Exception {
        ClassPool pool = ClassPool.getDefault();
        CtClass ctClass = pool.get("com.fanyin.test.javassist.Base");
        ctClass.setSuperclass(pool.get("com.fanyin.test.javassist.SuperBase"));
        //重新写入磁盘
        ctClass.writeFile();



    }
}
