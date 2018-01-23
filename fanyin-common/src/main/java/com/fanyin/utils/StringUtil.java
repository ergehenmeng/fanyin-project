package com.fanyin.utils;

import java.util.Random;

/**
 * @description: 字符串日常工具类
 * @author: 二哥很猛
 * @date: 2018/1/8
 * @time: 14:56
 */
public class StringUtil extends org.apache.commons.lang3.StringUtils{

    /**
     * 随机字符串
     */
    private static final String NUMBER_LETTERS = "23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ";

    /**
     * 默认随机字符串长度
     */
    private static final int DEFAULT_RANDOM_LENGTH = 6;

    /**
     * 生成指定长度的随机字符串
     * @param length 长度
     * @return 定长字符串
     */
    public static String random(int length){
        if(length < 0){
            return null;
        }
        Random random = new Random();
        StringBuilder builder = new StringBuilder();
        do{
            length--;
            builder.append(NUMBER_LETTERS.charAt(random.nextInt(NUMBER_LETTERS.length())));
        }while (length > 0);
        return builder.toString();
    }

    /**
     * 生成6位随机字符串
     * @return 字符串
     */
    public static String random(){
        return random(DEFAULT_RANDOM_LENGTH);
    }

}
