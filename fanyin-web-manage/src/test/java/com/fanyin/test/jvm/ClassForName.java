package com.fanyin.test.jvm;

/**
 * @author 王艳兵
 * @date 2018/10/12 10:21
 */
public class ClassForName {



    public static void main(String[] args) throws Exception{
        Class.forName("com.fanyin.test.jvm.A");
        new B();
    }

}

 class A{
    static {
        System.out.println("A初始化");
    }
    public A(){

    }
}

 class B{
    static{
        System.out.println("B初始化");
    }
    public B(){

    }
}
