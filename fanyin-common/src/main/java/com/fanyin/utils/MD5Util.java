package com.fanyin.utils;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.ParameterException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5摘要算法
 * @author 二哥很猛
 * @date 2018/1/18 11:43
 */
public class MD5Util {

    private static final Logger LOGGER = LoggerFactory.getLogger(MD5Util.class);

    /**
     * 16进制数组
     */
    private static final String[] HEX_DIGITS = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

    /**
     * md5加密
     * @param str 待加密的字符串
     * @return 加密过后的字符串 大写
     */
    public static String md5(String str){
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(str.getBytes());
            byte[] bytes = digest.digest();
            return byteArrayToHex(bytes);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.error("MD5加密异常",e);
            throw new ParameterException(ErrorCodeEnum.ENCRYPT_ERROR);
        }
    }

    /**
     * 对bytes进行编码 16进制模式
     * @param bytes byte数组
     * @return 字符串
     */
    private static String byteArrayToHex(byte[] bytes){
        StringBuilder builder = new StringBuilder();
        for (byte b : bytes){
            builder.append(byteToHexString(b));
        }
        return builder.toString();
    }

    /**
     * byte转16进制字符串
     * @param bt byte
     * @return 字符串
     */
    private static String byteToHexString(byte bt){
        //byte转int
        int n = bt;
        if (n < 0){
            n += 256;
        }
        int tens = n/16;
        int unit = n%16;
        return HEX_DIGITS[tens] + HEX_DIGITS[unit];
    }
}
