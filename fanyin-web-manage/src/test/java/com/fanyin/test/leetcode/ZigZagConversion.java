package com.fanyin.test.leetcode;

import com.google.common.collect.Maps;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 王艳兵
 * @date 2018/9/25 14:48
 */
public class ZigZagConversion {

    public static void main(String[] args) {
        System.out.println(convert("PAYPALISHIRING",2));;
    }

    public static String convert(String s, int numRows) {
        if(numRows == 1){
            return s;
        }
        StringBuilder result = new StringBuilder();
        int length = s.length();
        final char[] chars = s.toCharArray();

        Map<Integer,StringBuilder> map = new HashMap<>();
        int end = numRows + numRows - 2;
        for (int i = 0 ; i < length;i++){
             int j = i % end;
             if(j >= numRows){
                 int index = end - j;
                 setVal(map,index,chars[i]);
             }else{
                 setVal(map,j,chars[i]);
             }
        }
        for (StringBuilder builder : map.values()){
            result.append(builder);
        }
        return result.toString();
    }

    private static void setVal(Map<Integer,StringBuilder> map,int index,char c){
        StringBuilder s = map.get(index);
        if(s == null){
            map.put(index,new StringBuilder().append(c));
        }else{
            s.append(c);
        }
    }
}
