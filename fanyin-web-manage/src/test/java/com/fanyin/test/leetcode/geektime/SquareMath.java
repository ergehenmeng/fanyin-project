package com.fanyin.test.leetcode.geektime;

/**
 * @author 王艳兵
 * @date 2019/7/3 16:24
 */
public class SquareMath {

    /**
     * @param n 开平方的数
     * @param deltaThreshold 误差的阀值
     * @param maxTry 迭代次数
     */
    public static double getSquareRoot(int n, double deltaThreshold, int maxTry) {

        if (n <= 1) {
            return -1.0;
        }

        double min = 1.0, max = (double)n;
        for (int i = 0; i < maxTry; i++) {
            double middle = (min + max) / 2;
            double square = middle * middle;
            double delta = Math.abs((square / n) - 1);
            if (delta <= deltaThreshold) {
                return middle;
            } else {
                if (square > n) {
                    max = middle;
                } else {
                    min = middle;
                }
            }
        }

        return -2.0;

    }

}
