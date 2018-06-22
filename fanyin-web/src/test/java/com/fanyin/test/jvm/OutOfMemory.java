package com.fanyin.test.jvm;

import java.util.ArrayList;
import java.util.List;

/**
 * -Xms20m -Xmx20m
 * @author 王艳兵
 * @date 2018/3/21 18:21
 */
public class OutOfMemory {
    public static void main(String[] args) {
        List<Object> list = new ArrayList<>();
        while (true){
            list.add(new Object());
        }
    }
}
