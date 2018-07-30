package com.fanyin.utils;

import java.util.Random;

/**
 * 字符串日常工具类
 * @author 二哥很猛
 * @date 2018/1/8 14:56
 */
public class StringUtil extends org.apache.commons.lang3.StringUtils{

    /**
     * 随机字符串
     */
    private static final String NUMBER_LETTERS = "23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ";

    /**
     * 随机数字
     */
    private static final String NUMBER = "1234567890";

    /**
     * 默认随机字符串长度
     */
    private static final int DEFAULT_RANDOM_LENGTH = 4;

    /**
     * 生成指定长度的随机字符串
     * @param length 长度
     * @return 定长字符串
     */
    public static String random(int length){
        return random(NUMBER_LETTERS,length);
    }

    /**
     * 生成指定长度的随机串,从指定字符串中生成
     * @param scope 字符串选择范围
     * @param length 长度
     * @return 随机码
     */
    private static String random(String scope,int length){
        if(length < 0){
            return null;
        }
        Random random = new Random();
        StringBuilder builder = new StringBuilder();
        do{
            length--;
            builder.append(scope.charAt(random.nextInt(scope.length())));
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

    /**
     * 生成指定长度的数字(短信验证码)
     * @param length 长度
     * @return 随机串
     */
    public static String randomNumber(int length){
        return random(NUMBER,length);
    }

    /**
     * 生成定长的数字(短信验证码) 默认长度 DEFAULT_RANDOM_LENGTH
     * @return 随机串
     */
    public static String randomNumber(){
        return randomNumber(DEFAULT_RANDOM_LENGTH);
    }
}
