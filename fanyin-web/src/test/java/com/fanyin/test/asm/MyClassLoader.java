package com.fanyin.test.asm;

/**
 * @author 王艳兵
 * @date 2018/3/9 18:02
 */
public class MyClassLoader extends ClassLoader {

    public MyClassLoader() {
        super(Thread.currentThread().getContextClassLoader());
    }

    public Class<?> defineClassForName(String name, byte[] data) {
        return this.defineClass(name, data, 0, data.length);
    }
}
