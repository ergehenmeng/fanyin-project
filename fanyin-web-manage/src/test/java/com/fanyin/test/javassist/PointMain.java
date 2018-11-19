package com.fanyin.test.javassist;

import org.apache.ibatis.javassist.ClassPool;
import org.apache.ibatis.javassist.CtClass;
import org.apache.ibatis.javassist.CtMethod;

/**
 * @author 王艳兵
 * @date 2018/11/19 10:06
 */
public class PointMain {
    public static void main(String[] args) throws Exception{
        ClassPool pool = ClassPool.getDefault();
        CtClass ctClass = pool.get("com.fanyin.test.javassist.Point");
        CtMethod move = ctClass.getDeclaredMethod("move");
        move.insertAfter("System.out.print($1);System.out.print($2);");
        ctClass.writeFile();
    }
}
