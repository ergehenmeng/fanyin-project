package com.fanyin.test.lambda;

import org.assertj.core.util.Lists;

import java.util.List;

/**
 * @author 王艳兵
 * @date 2018/6/26 19:47
 */
public class ConstantMethodRef {

    @FunctionalInterface
    interface UserFactory<U extends User>{
        U create(String name ,int age);
    }

    static UserFactory<User> factory = User::new;

    public static void main(String[] args) {
        List<User> userList = Lists.newArrayList();
        for (int i = 0; i < 10; i++) {
            userList.add(factory.create("二哥" + i,i));
        }
        userList.stream().map(User::getName).forEach(System.out::println);
    }
}
