package com.fanyin.test.leetcode.geektime;

import java.util.Arrays;

/**
 * 归并排序
 * @author 王艳兵
 * @date 2019/7/5 9:37
 */
public class GuiBingSort {

    public static void main(String[] args) {
        int[] ints = mergeSort(new int[]{2,33,24,34,18,46,3,94,4,45,31,88,12});
        for (int i : ints) {
            System.out.println(i);
        }
    }

    private static int[] mergeSort(int[] sort){
        if(sort == null){
            return new int[0];
        }

        if(sort.length == 1){
            return sort;
        }

        int mid = sort.length / 2;

        int[] left = Arrays.copyOfRange(sort, 0, mid);
        int[] right = Arrays.copyOfRange(sort,mid,sort.length);
        left = mergeSort(left);
        right = mergeSort(right);

        return merge(left,right);

    }

    /**
     * 对有序集合进行排序,只需要取最小的值依次放入到新数组中即可
     * @param left 有序集合
     * @param right 有序集合
     */
    private static int[] merge(int[] left,int[] right){
        if (left == null ){
            left = new int[0];
        }
        if(right == null){
            right = new int[0];
        }

        int[] result = new int[left.length + right.length];

        int l =0 ,r = 0,mid = 0;

        while (l < left.length && r < right.length){
            if(left[l] < right[r]){
                result[mid++] = left[l++];
            }else{
                result[mid++] = right[r++];
            }
        }
        if(l < left.length){
            for (int i = l ;i < left.length;i++){
                result[mid++] = left[i];
            }
        }else{
            for (int i = r; i < right.length ;i++){
                result[mid++] = right[i];
            }
        }
        return result;
    }
}
