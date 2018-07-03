package com.fanyin.test.lambda;

import java.util.stream.IntStream;

/**
 * 是否为质数
 * @author 王艳兵
 * @date 2018/6/26 19:56
 */
public class PrimeUtil {

    public static boolean  isPrime(int number){
        int temp = number;
        if(temp < 2){
            return false;
        }
        for (int i = 2; i <= Math.sqrt(temp); i++){
            if(temp % i == 0){
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        long count = IntStream.range(1, 1000000).parallel().filter(PrimeUtil::isPrime).count();
        System.out.println(count);
        System.out.println(Math.sqrt(1000));;
    }
}
