package com.fanyin.test.java8;

import com.google.common.collect.Maps;

import java.util.Map;

/**
 * @author 王艳兵
 * @date 2018/9/28 17:12
 */
public class HashMap8 {
    public Integer inner;

    public HashMap8(Integer inner) {
        this.inner = inner;
    }

    public HashMap8() {
    }

    public static void main(String[] args) {
        Integer inners;
        HashMap8 left = new HashMap8(1);
        HashMap8 right = new HashMap8();
        if((inners = left.inner = right.inner) != null){
            System.out.println(inners);
        }

        Map<String,Integer> map = Maps.newHashMap();
        for (int i = 0 ; i < 3000000;i++){
            map.put(i + "xxrrssff",i);
        }
        for (int i = 2000000 ; i > 1000000;i--){
            map.remove(i + "xxrrssff");
        }
    }
}
