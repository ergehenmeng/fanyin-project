package com.fanyin.ext;

import java.io.Serializable;

/**
 * 用于返回前台的结果集
 * @author 二哥很猛
 * @date 2018/1/12 17:41
 */
public class ResultJson<T> implements Serializable {

    private static final long serialVersionUID = 1574813862539970945L;

    /**
     * 代码 默认200为成功
     */
    private int code = 200;
    /**
     * 信息
     */
    private String msg;

    /**
     * 结果集 键值对或者非基本类型对象
     */
    private T data;

    public static <T> ResultJson<T> getInstance(){
        return new ResultJson<>();
    }

    public T getData() {
        return data;
    }

    public ResultJson<T> setData(T data) {
        this.data = data;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public ResultJson<T> setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public int getCode() {
        return code;
    }

    public ResultJson<T> setCode(int code) {
        this.code = code;
        return this;
    }
}
