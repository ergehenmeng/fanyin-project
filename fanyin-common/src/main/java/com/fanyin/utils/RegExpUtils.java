package com.fanyin.utils;

import java.util.regex.Pattern;

/**
 * 正则表达式
 * @author 二哥很猛
 * @date 2018/2/23 11:17
 */
public class RegExpUtils {

    /**
     * 身份证校验正则表达式
     */
    private static final String REGEXP_ID_CARD = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}$)";

    /**
     * 校验身份证是否合法 只做较为基础的校验
     * @param idCard 身份证编号 15位或18位
     * @return boolean true:合法 false:不合法
     */
    public static boolean isIdCard(String idCard){
        return Pattern.matches(REGEXP_ID_CARD,idCard);
    }
}
