package com.fanyin.service.key.impl;

import com.fanyin.service.key.KeyGenerator;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class DefaultKeyGeneratorTest {

    @Autowired
    private KeyGenerator keyGenerator;

    @Test
    public void generateKey() {
        Number number = keyGenerator.generateKey();
        Number number1 = keyGenerator.generateKey();
        Number number2 = keyGenerator.generateKey();
        Number number3 = keyGenerator.generateKey();
        Number number4 = keyGenerator.generateKey();
        Number number5 = keyGenerator.generateKey();
        System.out.println(number);
        System.out.println(number1);
        System.out.println(number2);
        System.out.println(number3);
        System.out.println(number4);
        System.out.println(number5);
    }

    @Test
    public void generateKey1() {
    }
}