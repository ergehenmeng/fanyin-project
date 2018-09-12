package com.fanyin.test;

/**
 * @author 二哥很猛
 * @date 2018/6/20 10:03
 */
public class StringTest {

    public static final String A;    // 常量A
    public static final String B;    // 常量B
    public static final String C;    // 常量C
    public static final String D;    // 常量D
    static {
        A = "ab";
        B = "cd";
        C = A+B;
        D = "abcd";
    }

    public static void main(String [] args){
        String string = "abcd";
        String string1 = "ab";
        String string2 = "cd";
        System.out.println(string == "abcd");


        System.out.println("abcd" == (A+B));
        System.out.println(string == (A+B));
        System.out.println("abcd" == C);
        System.out.println(string == C);


        System.out.println("abcd" == D);
        System.out.println(string == D);
        System.out.println(string1 == A);
        System.out.println(string2 == B);

        System.out.println(C == D);
    }
}
