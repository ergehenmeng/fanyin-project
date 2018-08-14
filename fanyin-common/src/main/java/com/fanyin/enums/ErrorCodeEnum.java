package com.fanyin.enums;

/**
 * 系统错误信息枚举 包含系统所以的异常信息
 * 1000-2000 系统异常
 * 2000-3000 数据格式异常
 * 3000-4000 业务异常
 * @author 二哥很猛
 * @date 2018/1/12 16:46
 */
public enum ErrorCodeEnum {

    /**
     * json转换异常
     */
    JSON_FORMAT_ERROR(1000,"json转换异常"),

    /**
     * pbe加密失败
     */
    ENCRYPT_ERROR(1001,"数据加密失败"),

    /**
     * 字符集转换错误
     */
    CHARSET_CONVERT_ERROR(1002,"字符集转换错误"),

    /**
     * 数据解密失败
     */
    DECRYPT_ERROR(1003,"数据解密失败"),

    /**
     *数据加解密失败
     */
    ENCRYPT_DECRYPT_ERROR(1004,"数据加解密失败"),

    /**
     * 对象转换异常
     */
    BEAN_COPY_ERROR(1005,"对象转换异常"),

    /**
     * 数据加密异常,请联系管理人员
     */
    SHA_256_ERROR(1006,"数据加密异常"),






    /**
     * 身份证格式校验错误
     */
    ID_CARD_ERROR(2000,"身份证格式校验错误"),

    /**
     * 对象不能为空
     */
    NOT_NULL_ERROR(2001,"对象不能为空"),



    /**
     * 系统配置信息未查询到
     */
    CONFIG_NOT_FOUND_ERROR(3000,"系统配置信息未查询到"),

    /**
     * 系统配置信息更新失败
     */
    UPDATE_CONFIG_ERROR(3001,"系统配置信息更新失败"),

    /**
     * 菜单信息更新失败
     */
    UPDATE_MENU_ERROR(3002,"菜单信息更新失败"),

    /**
     * 验证码输入错误
     */
    IMAGE_CODE_ERROR(3003,"验证码输入错误"),

    /**
     * 账户或密码错误
     */
    ACCOUNT_PASSWORD_ERROR(3004,"账户或密码输入错误"),

    /**
     * 用户信息不存在
     */
    OPERATOR_NOT_FOUND(3005,"用户信息不存在"),

    /**
     * 用户已锁定,请联系管理人员
     */
    OPERATOR_LOCKED_ERROR(3006,"用户已锁定,请联系管理人员"),

    /**
     * 用户超时,请重新登陆
     */
    OPERATOR_TIMEOUT(3007,"用户超时,请重新登陆"),


    /**
     * 请求接口非法
     */
    REQUEST_INTERFACE_ERROR(3008,"请求接口非法"),

    /**
     * 请求参数非法
     */
    REQUEST_PARAM_ILLEGAL(3009,"请求参数非法"),

    /**
     * 用户超时,请重新登陆
     */
    ACCESS_TOKEN_TIMEOUT(3010,"用户超时,请重新登陆"),


    ;
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
