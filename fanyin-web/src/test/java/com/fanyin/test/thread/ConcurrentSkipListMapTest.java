package com.fanyin.test.thread;

import java.util.Map;
import java.util.concurrent.ConcurrentSkipListMap;

/**
 * @author 王艳兵
 * @date 2018/6/13 9:24
 */
public class ConcurrentSkipListMapTest {

    public static void main(String[] args) {

        Map<Integer,Integer> map = new ConcurrentSkipListMap<>();
        for (int i = 0; i < 100; i++) {
            map.put(i,i);
        }

        for (Map.Entry<Integer,Integer> entry : map.entrySet()) {
            System.out.println(entry.getKey() + "--" + entry.getValue());
        }
    }
}
