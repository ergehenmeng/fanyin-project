package com.fanyin.test.jvm.norm;

/**
 * @author 二哥很猛
 * @date 2018/4/9 14:28
 */
public class BinaryMain {
    public static void main(String[] args) {
        System.out.println(Integer.toBinaryString(Integer.MAX_VALUE) + " " + Integer.MAX_VALUE);
        System.out.println(Integer.toBinaryString(Integer.MIN_VALUE) + " " + Integer.MIN_VALUE);
        char s = '\u0124';
        char[] chars = "我".toCharArray();
        for (char c : chars){
            System.out.println(c);
        }
        System.out.println(s);
    }
}
