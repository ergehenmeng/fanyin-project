package com.fanyin.test.arithmetic;

/**
 * 快速
 * 将一个数组切分成两个数组,切点左边的数组最大值小于切点右边的最小值,这样数组一定是有序的
 * 切点查找,取任意数组中元素(第一个),
 * 由左向右查找一个比它大的值,再
 * 由右向左反向查找一个比他小的值,
 * 如果第一个值的下标小于第二个值下标那么,这两个值一定没有排序,需要调换位置
 * 直到两个值相遇
 * 此时第一个元素小于 j 需要额外调换位置即可
 * @author 二哥很猛
 * @date 2018/12/12 15:40
 */
public class KuaiSu {
    public static void main(String[] args) {
        int[] sort = sort(new int[]{2,1,5,9,1,2,3,7});
        for (int i : sort) {
            System.out.println(i);
        }
    }
    
    public static int[] sort(int[] arr){
        sort(arr,0,arr.length-1);
        return arr;
    }

    private static void sort(int[] arr,int start,int end){
        if(end <= start){
            return;
        }
        int j = split(arr,start,end);
        sort(arr,start,j-1);
        sort(arr,j+1,end);
    }

    /**
     * 切分元素的下标
     * {2,1,5,9,1,2,3,7}
     *    j i
     * @param arr 数组
     * @param start 查找切分元素的起始位置
     * @param end 查找切分元素的结束位置
     * @return index
     */
    private static int split(int[] arr, int start, int end) {
        int i = start;
        int j = end + 1;
        int v = arr[i];
        while (true){
            while (arr[++i] < v){
                if(i == end){
                    break;
                }
            }
            while(arr[--j] > v){
                if(j == start){
                    break;
                }
            }
            if(i >= j){
                break;
            }
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
        int temp = arr[start];
        arr[start] = arr[j];
        arr[j] = temp;
        return j;
    }
}
