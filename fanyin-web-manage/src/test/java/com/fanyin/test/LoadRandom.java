package com.fanyin.test;

import com.google.common.collect.Lists;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @author 王艳兵
 * @date 2019/6/13 17:21
 */
public class LoadRandom {

    public static void main(String[] args) {
        List<Load> list = Lists.newArrayListWithCapacity(100);
        list.add(Load.builder().weight(5).name("A").build());
        list.add(Load.builder().weight(2).name("B").build());
        list.add(Load.builder().weight(2).name("C").build());
        int totalWeight = list.stream().mapToInt(Load::getWeight).sum();
        reset(list,totalWeight);
    }

    private static void reset(List<Load> list, int totalWeight){
        List<Load> collect = list.stream().peek(load -> load.setCurrent(load.getCurrent() + load.getWeight())).collect(Collectors.toList());
        Optional<Load> optionalLoad = collect.stream().max(Comparator.comparing(Load::getCurrent));
        if(optionalLoad.isPresent()){
            Load current = optionalLoad.get();
            System.out.println(current.getName());
            current.setCurrent(current.getCurrent() - totalWeight);
            reset(collect, totalWeight);
        }
    }
}
