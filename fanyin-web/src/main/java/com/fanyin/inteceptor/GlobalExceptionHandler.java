package com.fanyin.inteceptor;

import com.fanyin.exception.SystemException;
import com.fanyin.ext.ResultJson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * @description: 全局统一异常处理器
 * @author: 二哥很猛
 * @date: 2018/1/18
 * @time: 16:20
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    /**
     * 系统未知异常默认400
     */
    private static final int CODE = 400;

    @ExceptionHandler(Exception.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ResultJson<String> exception(Exception e){
        LOGGER.error("未知系统异常",e);
        if (e instanceof SystemException){
            SystemException exception = (SystemException)e;
            return ResultJson.<String>getInstance().setCode(exception.getCode()).setMsg(exception.getMessage());
        }
        return ResultJson.<String>getInstance().setCode(CODE).setMsg("系统异常,请联系管理人员");
    }
}
