package com.fanyin.test;

/**
 * @author 王艳兵
 * @date 2018/2/8 13:44
 */
public abstract class SecondClass implements SuperClass {

    protected abstract void say2();

    @Override
    public void say() {
        System.out.println("我是一");
    }

    public void say3(){
        System.out.println("我是三");
    }
}
