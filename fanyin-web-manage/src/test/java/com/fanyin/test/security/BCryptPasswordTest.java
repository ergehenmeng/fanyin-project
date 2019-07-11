package com.fanyin.test.security;

import com.fanyin.configuration.security.BcryptPasswordEncoder;
import com.fanyin.configuration.security.PasswordEncoder;

/**
 * @author 二哥很猛
 * @date 2018/7/8 14:07
 */
public class BCryptPasswordTest {

    public static void main(String[] args) {
        PasswordEncoder encoder = new BcryptPasswordEncoder();
        String encode = encoder.encode("e10adc3949ba59abbe56e057f20f883e");
        System.out.println(encode);
        boolean flag = encoder.matches("123456","$2a$10$Vd/6Dmvq77go9FsdEFa0p.xloUj30oIKuynNDTcQEo8fu0hwtQvGC");
        System.out.println(flag);
    }
}
