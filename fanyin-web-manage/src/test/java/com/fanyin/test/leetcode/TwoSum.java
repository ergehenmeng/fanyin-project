package com.fanyin.test.leetcode;

/**
 * @author 二哥很猛
 * @date 2018/9/25 11:37
 */
public class TwoSum {

    public int[] twoSum(int[] nums, int target) {
        for(int i = 0,length = nums.length;i < length;i++){
            for(int j = i + 1; j < length;j++){
                if(nums[i] + nums[j] == target){
                    return new int[]{i,j};
                }
            }
        }
        return null;
    }

    public static void main(String[] args) {
        TwoSum sum = new TwoSum();
        int[] s = {1,2,4,5,2,9,3,2,4,9,6};
        int[] ints = sum.twoSum(s, 9);
        for (int i : ints){
            System.out.println(i);
        }
    }
}
