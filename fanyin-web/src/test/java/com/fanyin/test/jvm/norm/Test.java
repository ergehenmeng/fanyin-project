package com.fanyin.test.jvm.norm;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 王艳兵
 * @date 2018/5/22 17:59
 */
public class Test {
    public static void main(String[] args) {
        BigDecimal waitingMatchAmount = BigDecimal.valueOf(100D);
        Map<String,Object> map = new HashMap<>();
        BigDecimal matchAmount = new BigDecimal(String.valueOf(map.get("amount")));
        waitingMatchAmount = waitingMatchAmount.subtract(matchAmount);
        System.out.println(waitingMatchAmount);
    }
}
