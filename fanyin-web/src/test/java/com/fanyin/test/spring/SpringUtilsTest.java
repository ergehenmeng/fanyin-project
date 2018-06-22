package com.fanyin.test.spring;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.util.StringUtils;

/**
 * @author 王艳兵
 * 总结:与spring结合扫描包路径 分隔符支持 , ; 空格 回车
 * @date 2018/3/9 10:58
 */
public class SpringUtilsTest {

    public static void main(String[] args) {
        String abc = "com.fanyin;com.fanyin,com.fanin rxxbvb ";
        String[] strings = StringUtils.tokenizeToStringArray(abc, AbstractApplicationContext.CONFIG_LOCATION_DELIMITERS);
        for (String str : strings){
            System.out.println(str);
        }
    }
}
