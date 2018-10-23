package com.fanyin.test;

/**
 * @author 二哥很猛
 * @date 2018/10/22 14:29
 */
public class Rng {

    public static void main(String[] args) {
        System.out.println(prob(1000,10,0.1));
    }

    public static String prob(double left,double right,double rake){
        double max = left * (1 - rake);
        double min = right * (1 - rake);
        return min / left + "  " + (max / right);
    }
}
