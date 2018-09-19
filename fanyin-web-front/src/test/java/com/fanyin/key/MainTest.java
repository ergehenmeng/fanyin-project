package com.fanyin.key;

import io.shardingjdbc.core.keygen.DefaultKeyGenerator;

import java.util.Calendar;

/**
 * @author 二哥很猛
 * @date 2018/9/19 10:12
 */
public class MainTest {
    public static void main(String[] args) {
        DefaultKeyGenerator.setWorkerId(624);
        DefaultKeyGenerator generator = new DefaultKeyGenerator();
        Number number = generator.generateKey();
        Number number2 = generator.generateKey();
        System.out.println(number2);
        System.out.println(number);
        String s = Long.toBinaryString(249117752587976704L);

        Calendar calendar = Calendar.getInstance();
        calendar.set(2016, Calendar.NOVEMBER, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        long l = System.currentTimeMillis();
        long timeInMillis = calendar.getTimeInMillis();
        long fff = l - timeInMillis;
        System.out.println("结果:" + fff);

    }
}
