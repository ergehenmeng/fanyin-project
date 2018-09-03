package com.fanyin.test.sort;

import java.util.Random;

/**
 * 奇偶交换排序
 * @author 二哥很猛
 * @date 2018/6/22 9:49
 */
public class JOJiaoHuan {

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
        int execFlag = 1;
        int start = 0;
        while (execFlag == 1 || start == 0){
            execFlag = 0;
            int length = before.length;
            for (int i = start; i < length -1; i += 2){
                if (before[i] > before[i+1]){
                    int temp = before[i];
                    before[i] = before[i+1];
                    before[i+1] = temp;
                    execFlag = 1;
                }
            }
            if (start == 0){
                start = 1;
            }else{
                start = 0;
            }
        }
    }
}
