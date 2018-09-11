package com.fanyin.test.timer;

import java.util.concurrent.TimeUnit;

/**
 * @author 王艳兵
 * @date 2018/9/11 9:52
 */
public class Time {
    public static long getHiresClockMs(){
        return TimeUnit.NANOSECONDS.toMillis(System.nanoTime());
    }
}
