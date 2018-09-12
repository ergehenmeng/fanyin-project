package com.fanyin.test.arithmetic.a20180615;

/**
 * @author 二哥很猛
 * @date 2018/6/15 11:39
 * \W表示非单词
 * \w表示单词
 */
public class EGHM {
    public static void main(String[] args) {
        System.out.println(zy("zs syz gsasdy"));
    }
    public static int  zy(String str){
        int count = 0;
        String temp = str.toUpperCase();
        //非单词或者空格
        String[] words = temp.split("\\W|\\d");
        for (String word : words) {
            if(word.endsWith("Z")||word.endsWith("Y")) {
                count++;
            }
        }
        return count;
    }
}
