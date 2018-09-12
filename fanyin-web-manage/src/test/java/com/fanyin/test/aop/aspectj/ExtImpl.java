package com.fanyin.test.aop.aspectj;

/**
 * @author 二哥很猛
 * @date 2018/8/13 14:46
 */
public class ExtImpl implements Ext{
    @Override
    public void say() {
        System.out.println("我是额外增加的");
    }
}
