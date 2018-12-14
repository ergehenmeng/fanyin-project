package com.fanyin.test.arithmetic;

/**
 * 找到数组中最小的元素与第一个元素交换位置,然后在剩余元素中找到最小元素与数组中第二元素交换位置,依次执行
 * @author 二哥很猛
 * @date 2018/12/12 9:56
 */
public class XuanZhe {

    public static void main(String[] args) {
        int[] result = sort(new int[]{12,3,4,51,14,3,9,3,2,5,1});
        for (final int i : result) {
            System.out.println(i);
        }
    }
    
    public static int[] sort(int[] arr){
        int length = arr.length;

        for (int i = 0;i < length ;i++){
            int min = arr[i];
            for (int j = i + 1;j < length;j++){
                if(arr[j] < min){
                    min = arr[j];
                    arr[j] = arr[i];
                    arr[i] = min;
                }
            }

        }
        return arr;
    }

}
