package com.fanyin.test.sort;

import java.util.Random;

/**
 * 冒泡 不算快
 * @author 二哥很猛
 * @date 2018/6/21 17:41
 */
public class MaoPao {
    public static void main(String[] args) {
        Random random = new Random(5000);
        int[] arr = new int[50000];
        int i = 0;
        while (i < 50000){
            arr[i] = random.nextInt();
            i++;
        }
        long start = System.currentTimeMillis();
        sort(arr);
        long end = System.currentTimeMillis();
        System.out.println(end - start);
    }

    private static void sort(int[] before){
        int length = before.length;
        for (int i = length - 1 ;i > 0; i--){
            for(int j = 0; j < i; j++){
                int last = before[i];
                int first = before[j];
                if(first > last){
                    before[i] = first;
                    before[j] = last;
                }
            }
        }
    }

    public static void sort2(int[] before){
        int length = before.length;
        for (int i = length - 1 ;i > 0; i--){
            for(int j = 0; j < i; j++){
                int first = before[j];
                int second = before[j+1];
                if(second < first){
                    before[j] = second;
                    before[j + 1] = first;
                }
            }
        }
    }
}
