package com.fanyin.test.arithmetic;

/**
 * 将数组中arr[i] 插入到 arr[0]~arr[i-1]中比它小的所有元素依次有序交换
 * 插入
 * @author 二哥很猛
 * @date 2018/12/12 11:17
 */
public class ChaRu {
            //  j t
    public static void main(String[] args) {
        //3 12 12 3 4 56 1 9 64 13 5
        //3 23 3 23 4 56 1 9 64 13 5
        final int[] sort = sort(new int[]{12, 3, 12, 3, 4, 56, 1, 9, 64, 13, 5});
        for (int i : sort) {
            System.out.println(i);
        }

    }

    public static int[] sort(int[] arr){
        int length = arr.length;
        for (int i = 1 ; i < length;i++){
            int temp = arr[i];
            for (int j = i-1; j >= 0;j--){
                if(temp < arr[j]){
                    arr[j+1] = arr[j];
                    arr[j] = temp;
                }
            }
        }
        return arr;
    }
}
