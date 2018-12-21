package com.fanyin.test.sort;

import java.util.Arrays;

/**
 * 并归排序
 * @author 二哥很猛
 * @date 2018/12/21 11:07
 */
public class Merge {

    public static void main(String[] args) {
        int[] merge = merge(new int[]{3, 43, 3, 1, 4, 6, 34, 83, 13, 41, 3, 5, 63});
        for (final int i : merge) {
            System.out.println(i);
        }
    }

    public static int[] merge(int[] arr){
        if(arr== null || arr.length == 1){
            return arr;
        }
        int mid = arr.length / 2;
        int[] left = Arrays.copyOfRange(arr,0,mid);
        int[] right = Arrays.copyOfRange(arr,mid,arr.length);

        left = merge(left);
        right = merge(right);

        return merge(left,right);
    }

    public static int[] merge(int[] left ,int[] right){
        if(left == null){
            left = new int[0];
        }
        if(right == null){
            right = new int[0];
        }
        int[] merge = new int[left.length + right.length];
        int mi = 0,a = 0,b = 0;
        while (a < left.length && b < right.length){
            if(left[a] < right[b]){
                merge[mi] = left[a];
                a++;
            }else{
                merge[mi] = right[b];
                b++;
            }
            mi ++;
        }

        if(a < left.length){
            for (int i = a;i < left.length;i++){
                merge[mi] = left[i];
                mi++;
            }
        }else{
            for(int i = b; i < right.length;i++){
                merge[mi] = right[i];
                mi++;
            }
        }
        return merge;
    }
}
