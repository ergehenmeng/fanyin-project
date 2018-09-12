package com.fanyin.test.java8;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2018/4/17 16:36
 */
public class BigDecimalTest {
    public static void main(String[] args) throws Exception{
        BigDecimal tenderFrost = BigDecimal.valueOf(100);
        BigDecimal test = BigDecimal.valueOf(99);
        System.out.println(tenderFrost.compareTo(test));
        Date date = DateUtils.parseDate("2018-04-25", "yyyy-MM-dd");
        Date date1 = DateUtils.addDays(date, 100);
        String format = DateFormatUtils.format(date1, "yyyy-MM-dd");
        System.out.println(format);
    }
}
