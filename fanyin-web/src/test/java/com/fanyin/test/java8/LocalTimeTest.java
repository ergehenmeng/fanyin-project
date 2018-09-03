package com.fanyin.test.java8;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * ChronoUnit:类可用于在单个时间单位内测量一段时间，例如天数或秒。
 * Duration
 * Period
 * @author 二哥很猛
 * @date 2018/3/30 17:44
 */
public class LocalTimeTest {

    public static void main(String[] args) {
        LocalDate of = LocalDate.of(2018, 4, 25);
        LocalDate date = ChronoUnit.DAYS.addTo(of, 100);
        System.out.println(date);
        System.out.println(of.getDayOfYear());
    }
}
