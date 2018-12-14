package com.fanyin.test.jvm;

/**
 *
 * 1.确定类变量的初始值。
 * 在类加载的准备阶段，JVM 会为类变量初始化零值，
 * 这时候类变量会有一个初始的零值。如果是被 final 修饰的类变量，则直接会被初始成用户想要的值。
 * 2.初始化入口方法。
 * 当进入类加载的初始化阶段后，JVM 会寻找整个 main 方法入口，
 * 从而初始化 main 方法所在的整个类。当需要对一个类进行初始化时，
 * 会首先初始化类构造器，之后初始化对象构造器。
 * 3.初始化类构造器。
 * 初始化类构造器是初始化类的第一步，其会按顺序收集类变量的赋值语句、
 * 静态代码块，最终组成类构造器由 JVM 执行。
 * 4.初始化对象构造器。
 * 初始化对象构造器是在类构造器执行完成之后的第二部操作，
 * 其会按照执行类成员变成赋值、普通代码块、对象构造方法的顺序收集代码，
 * 最终组成对象构造器，最终由 JVM 执行。
 * @author 二哥很猛
 * @date 2018/12/11 9:51
 */
public class Book {
    public static void main(String[] args)
    {
        staticFunction();
        new Book();
    }
    static Book book = new Book();
    static
    {
        System.out.println("书的静态代码块");
    }
    {
        System.out.println("书的普通代码块");
    }
    Book()
    {
        System.out.println("书的构造方法");
        System.out.println("price=" + price +",amount=" + amount);
    }
    public static void staticFunction(){
        System.out.println("书的静态方法");
    }
    int price = 110;
    static int amount = 112;
}