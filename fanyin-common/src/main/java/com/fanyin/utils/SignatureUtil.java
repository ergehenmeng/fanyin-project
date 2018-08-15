package com.fanyin.utils;

import com.fanyin.constant.CommonConstant;

/**
 * 签名工具类
 * @author 王艳兵
 * @date 2018/8/15 15:33
 */
public class SignatureUtil {

    /**
     * 时间戳签名
     * @param salt 盐
     * @return 签名后的数据
     */
    public static String sign(String salt){
        String md5 = Md5Util.md5(CommonConstant.APP_KEY + salt);
        return Sha256Util.sha256(md5 + CommonConstant.APP_KEY);
    }

}
