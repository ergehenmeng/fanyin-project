package com.fanyin.inteceptor;

import com.fanyin.exception.SystemException;
import com.fanyin.ext.ResultJson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 全局统一异常处理器
 * @author 二哥很猛
 * @date 2018/1/18 16:20
 */
@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    /**
     * 系统未知异常默认400
     */
    public static final int CODE = 400;

    @ExceptionHandler(Exception.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ResultJson<String> exception(Exception e){
        log.error("controller处理异常",e);
        if (e instanceof SystemException){
            SystemException exception = (SystemException)e;
            return ResultJson.<String>getInstance().setCode(exception.getCode()).setMsg(exception.getMessage());
        }
        return ResultJson.<String>getInstance().setCode(CODE).setMsg("系统异常,请联系管理人员");
    }
}
