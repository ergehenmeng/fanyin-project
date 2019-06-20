package com.fanyin.test.leetcode.assist;

/**
 * @author 王艳兵
 * @date 2019/6/17 17:32
 */
public class JzOffer {

    public static boolean duplicate(int[] nums, int length, int[] duplication) {
        if (nums == null || length <= 0)
            return false;
        for (int i = 0; i < length; i++) {
            while (nums[i] != i) {
                if (nums[i] == nums[nums[i]]) {
                    duplication[0] = nums[i];
                    return true;
                }
                swap(nums, i, nums[i]);
            }
        }
        return false;
    }

    private static void swap(int[] nums, int i, int j) {
        int t = nums[i];
        nums[i] = nums[j];
        nums[j] = t;
    }

    public static void main(String[] args) {
        int m[] = new int[7];
        duplicate(new int[]{2, 3, 1, 0, 8, 8},8,m);
    }

}
