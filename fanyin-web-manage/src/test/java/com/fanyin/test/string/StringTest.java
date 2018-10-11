package com.fanyin.test.string;

/**
 * @author 二哥很猛
 * @date 2018/10/9 17:54
 */
public class StringTest {
    public static void main(String[] args) {
        String str = "/WEB-INF/**/*.xml";
                      //////////////////
        System.out.println(str.lastIndexOf('/',str.length() - 9));
    }
}
