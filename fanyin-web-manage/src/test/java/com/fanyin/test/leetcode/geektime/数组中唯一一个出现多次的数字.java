package com.fanyin.test.leetcode.geektime;

/**
 * 两个相同的数 异或等于零,0与x异或等于x
 * @author 王艳兵
 * @date 2019/7/5 11:06
 */
public class 数组中唯一一个出现多次的数字 {

    public static void main(String[] args) {
        System.out.println(repeat(new int[]{1,2,3,4,5,6,7,8,8,9}));
    }

    public static int repeat(int[] str){
        int x = 0;
        for (int i = 0 ; i < str.length;i++){
            x ^= str[i];
        }
        for (int i = 1 ; i < 9;i++){
            x ^= str[i];
        }
        return x;
    }
}
