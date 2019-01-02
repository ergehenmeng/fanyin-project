package com.fanyin.test.dubbo;

import com.google.common.collect.Lists;

import java.util.List;
import java.util.function.Supplier;

/**
 * @author 二哥很猛
 * @date 2018/12/29 11:20
 */
public class RoundRobin {


    public static void main(String[] args) {

        List<Weight> weightList = Lists.newArrayList();

        long totalWeight = weightList.stream().mapToLong(Weight::getWeight).count();

        Weight weight = weightList.stream().max((o1, o2) -> {
            if (o1.getWeight() > o2.getWeight()) {
                return 1;
            } else if (o1.getWeight() == o1.getWeight()) {
                return 0;
            }
            return -1;
        }).orElseGet(Weight::new);
        weight.setCurrent(weight.getWeight()-totalWeight);

    }
}
