package com.fanyin.test.arithmetic;

import java.util.Random;

/**
 * @author 二哥很猛
 * @date 2018/12/12 15:23
 */
public class Main {

    public static void main(String[] args) {
        int[] arr = new int[10000];
        Random random = new Random();
        for (int i =0;i < 10000;i++){
            arr[i] = random.nextInt(10000);
        }
        final long start = System.currentTimeMillis();
        XuanZhe.sort(arr);
        long millis = System.currentTimeMillis();
        int[] sort = ChaRu.sort(arr);
        for (final int i : sort) {
            System.out.println(i);
        }
        long end = System.currentTimeMillis();
        int[] ints = KuaiSu.sort(arr);
        long end2 = System.currentTimeMillis();
        for (final int anInt : ints) {
            System.out.println(anInt);
        }
        System.out.println("选择:" + (millis-start));
        System.out.println("插入:" + (end-millis));
        System.out.println("快速:" + (end2 - end));

    }

}
