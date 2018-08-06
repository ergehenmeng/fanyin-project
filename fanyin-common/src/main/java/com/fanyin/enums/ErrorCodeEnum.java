package com.fanyin.enums;

/**
 * 系统错误信息枚举 包含系统所以的异常信息
 * 1000-2000 PC异常,
 * 2000-3000 后台异常,
 * 3000-4000 APP异常,
 * 5000-6000 数据格式异常
 * @author 二哥很猛
 * @date 2018/1/12 16:46
 */
public enum ErrorCodeEnum {

    /**
     * json转换异常
     */
    JSON_FORMAT_ERROR(2000,"json转换异常"),

    /**
     * 系统配置信息未查询到
     */
    CONFIG_NOT_FOUND_ERROR(2001,"系统配置信息未查询到"),

    /**
     * 系统配置信息更新失败
     */
    UPDATE_CONFIG_ERROR(2002,"系统配置信息更新失败"),

    /**
     * 菜单信息更新失败
     */
    UPDATE_MENU_ERROR(2003,"菜单信息更新失败"),
    /**
     * 身份证格式校验错误
     */
    ID_CARD_ERROR(5001,"身份证格式校验错误"),
    /**
     * pbe加密失败
     */
    ENCRYPT_ERROR(5002,"数据加密失败"),

    /**
     * 数据解密失败
     */
    DECRYPT_ERROR(5003,"数据解密失败"),

    /**
     *数据加解密失败
     */
    ENCRYPT_DECRYPT_ERROR(5004,"数据加解密失败"),

    /**
     * 字符集转换错误
     */
    CHARSET_CONVERT_ERROR(5005,"字符集转换错误"),

    /**
     * 对象不能为空
     */
    NOT_NULL_ERROR(5006,"对象不能为空"),

    /**
     * 对象转换异常
     */
    BEAN_COPY_ERROR(5007,"对象转换异常"),

    /**
     * 验证码输入错误
     */
    IMAGE_CODE_ERROR(5008,"验证码输入错误"),

    /**
     * 账户或密码错误
     */
    ACCOUNT_PASSWORD_ERROR(5009,"账户或密码输入错误"),

    /**
     * 用户信息不存在
     */
    ACCOUNT_NOT_FOUND(5010,"用户信息不存在"),

    /**
     * 用户已锁定,请联系管理人员
     */
    ACCOUNT_LOCKED_ERROR(5011,"用户已锁定,请联系管理人员"),

    /**
     * 数据加密异常,请联系管理人员
     */
    SHA_256_ERROR(5012,"数据加密异常,请联系管理人员");

    /**
     * 构造方法
     * @param code 错误代码
     * @param msg 错误信息
     */
    ErrorCodeEnum(int code,String msg){
        this.code = code;
        this.msg = msg;
    }

    private int code;

    private String msg;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
