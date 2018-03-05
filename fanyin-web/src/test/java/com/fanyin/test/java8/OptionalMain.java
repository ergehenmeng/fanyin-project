package com.fanyin.test.java8;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.function.Predicate;
import java.util.stream.Stream;

/**
 * @author 王艳兵
 * @date 2018/2/28 17:30
 */
public class OptionalMain {
    public static void main(String[] args) {
        Stream<String> stringStream = Stream.of("12312", "sxxx", "sdf");
        //Optional<String> s = stringStream.filter(name -> name.startsWith("s")).findFirst();
        stringStream.forEach(System.out::println);
        Predicate<String> startsWithJ = (n) -> n.startsWith("J");
        List<Integer> costBeforeTax = Arrays.asList(100, 200, 300, 400, 500);
        System.out.println(costBeforeTax.stream().map((cost) -> cost + .12 * cost).reduce((sum, cost) -> sum + cost).orElse(1D));

    }
}
