package com.fanyin.test.sort;

import java.util.Random;

/**
 * 插入 最快
 * @author 王艳兵
 * @date 2018/6/22 11:54
 */
public class ChaRu {


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

    public static void sort(int[] array){
        for(int i = 1; i < array.length; i++){
            int j = i - 1;
            int key = array[i];
            //前一个大于后一个
            while (j >= 0 && array[j] > key){
                array[j+1] = array[j];
                j--;
            }
            array[j+1] = key;
        }
    }
}
