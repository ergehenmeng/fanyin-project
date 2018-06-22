package com.fanyin.test.java8;

/**
 * @author 王艳兵
 * @date 2018/4/2 14:31
 */
public class CompilationTest {

    private static final int SUM = 10000;

    public static void main(String[] args) {
        for (int i = 0; i < SUM; i++) {
            calcSum();
        }
    }

    public static int doubleValue(int i){
        for (int j = 0; j < 10000; j++) {

        }
        return i * 2;
    }

    public static long calcSum(){
        long sum = 0;
        for (int i = 0; i < 100; i++) {
            sum += doubleValue(i);
        }
        return sum;
    }
}
