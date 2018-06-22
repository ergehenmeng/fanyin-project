package com.fanyin.test.java8;

import java.time.LocalDate;

/**
 * ChronoUnit:类可用于在单个时间单位内测量一段时间，例如天数或秒。
 * Duration
 * Period
 * @author 王艳兵
 * @date 2018/3/30 17:44
 */
public class LocalTimeTest {

    public static void main(String[] args) {
        LocalDate of = LocalDate.of(2017, 11, 11);
        System.out.println(of.getDayOfYear());
    }
}
