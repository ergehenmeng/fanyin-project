package com.fanyin.ext;

import com.fanyin.enums.ErrorCodeEnum;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serializable;

/**
 * 用于返回前台的结果集
 * @author 二哥很猛
 * @date 2018/1/12 17:41
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Response<T> implements Serializable {

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
    
    private Response(){
    }

    public static <T> Response<T> getInstance(){
        return new Response<>();
    }

    public Response<T> error(ErrorCodeEnum error){
        this.code = error.getCode();
        this.msg = error.getMsg();
        return this;
    }

    public T getData() {
        return data;
    }

    public Response<T> setData(T data) {
        this.data = data;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public Response<T> setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public int getCode() {
        return code;
    }

    public Response<T> setCode(int code) {
        this.code = code;
        return this;
    }
}
