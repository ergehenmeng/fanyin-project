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
 */
public class Md5Util {

    private static final Logger LOGGER = LoggerFactory.getLogger(Md5Util.class);



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
            return ByteUtil.byteArrayToHex(bytes);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.error("MD5加密异常",e);
            throw new ParameterException(ErrorCodeEnum.ENCRYPT_ERROR);
        }
    }




}
