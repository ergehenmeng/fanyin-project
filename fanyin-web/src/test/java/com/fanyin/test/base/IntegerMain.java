package com.fanyin.test.base;

/**
 * @author 二哥很猛
 * @date 2018/8/9 11:20
 */
public class IntegerMain {
    public static void main(String[] args) {
        Integer a = new Integer(23);
        Integer b = new Integer(23);
        System.out.println(a == b);
        Integer c = 23;
        Integer d = 23;
        System.out.println(c == d);
        Integer e = 129;
        Integer f = 129;
        System.out.println(e == f);
        char g = 0xabef;
        System.out.println(Math.E);
        double s = Math.random() * 26 + 'a';
        System.out.println(s);
        char m = (char)(s);
        System.out.println(m);
    }
}
