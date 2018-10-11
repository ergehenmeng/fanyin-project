package com.fanyin.test.leetcode;

import java.util.HashMap;
import java.util.Map;

/**
 * Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
 * @author 二哥很猛
 * @date 2018/9/28 11:03
 */
public class Palindrome {

    public static void main(String[] args) {
        System.out.println(isPalindrome(0));
        System.out.println(reverse(1534236469));
        System.out.println(romanToInt("MCMXCIV"));
    }
    public static boolean isPalindrome(int x) {
        if(x < 0 || (x != 0 &&  x % 10 == 0 )){
            return false;
        }
        if(x < 10 ){
            return true;
        }
        int reveredNumber = 0;
        while (x > reveredNumber){
            reveredNumber = reveredNumber * 10 + x % 10;
            x /= 10;
        }
        return x == reveredNumber || x == reveredNumber / 10;
    }

    public static int reverse(int x) {
        int reveredNumber = 0;
        int s = Math.abs(x);
        while(s > 0){
            int suffix = s % 10;
            if( reveredNumber > Integer.MAX_VALUE /10 || (reveredNumber == Integer.MAX_VALUE /10 && suffix > 7 ) ){
                return 0;
            }
            reveredNumber = reveredNumber * 10 + suffix;

            s /= 10;
        }
        return x > 0 ? reveredNumber : -reveredNumber;
    }



    public static int romanToInt(String s) {
        Map<String,Integer> map = new HashMap<>();
        map.put("IV",4);
        map.put("IX",9);
        map.put("XL",40);
        map.put("XC",90);
        map.put("CD",400);
        map.put("CM",900);
        map.put("I",1);
        map.put("V",5);
        map.put("X",10);
        map.put("L",50);
        map.put("C",100);
        map.put("D",500);
        map.put("M",1000);
        if(s.length() == 1){
            return map.get(s);
        }
        int number = 0;
        while (s.length() > 1){
            String first = s.substring(0, 2);
            Integer value = map.get(first);
            if(value == null){
                first = s.substring(0,1);
                number += map.get(first);
                s = s.substring(1);
            }else{
                number += value;
                s = s.substring(2);
            }
        }
        if(s.length() == 1){
            number += map.get(s);
        }
        return number;

    }
}
