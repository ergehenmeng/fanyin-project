package com.fanyin.test.java7;

import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodType;

import static java.lang.invoke.MethodHandles.lookup;

/**
 * @author 王艳兵
 * @date 2018/3/29 14:04
 */
public class Test {
    class GrandFather {

        void say(){
            System.out.println("我是爷爷");
        }
    }
    class Father extends GrandFather {
        @Override
        void say() {
            System.out.println("我是爸爸");
        }
    }

    class Son extends Father {
        @Override
        void say() {
            try {
                MethodType methodType = MethodType.methodType(void.class);
                MethodHandle say = lookup().findSpecial(GrandFather.class, "say", methodType, getClass());
                say.invoke(this);
            } catch (Throwable e) {
                e.printStackTrace();
            }
        }
    }
    public static void main(String[] args) {
        new Test().new Son().say();
    }
}
