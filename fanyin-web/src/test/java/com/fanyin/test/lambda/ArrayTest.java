package com.fanyin.test.lambda;

import org.assertj.core.util.Lists;

import java.util.Arrays;
import java.util.List;
import java.util.OptionalDouble;

/**
 * @author 二哥很猛
 * @date 2018/6/25 11:14
 */
public class ArrayTest {
    public static void main(String[] args) {
        int[] arr = {12,3,4,5,1,5,123};
        Arrays.stream(arr).map(operand -> operand % 2 ==0 ? operand :operand +1 ).forEach(System.out::println);
        List<User> userList = Lists.newArrayList();
        userList.add(new User("二哥",1));
        userList.add(new User("二哥",3));
        userList.add(new User("二哥",4));
        userList.add(new User("二哥",6));
        OptionalDouble average = userList.stream().mapToInt(User::getAge).average();
        if(average.isPresent()){
            double asDouble = average.getAsDouble();
            System.out.println(asDouble);
        }
    }
}
