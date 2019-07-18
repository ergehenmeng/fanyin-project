package com.fanyin.interceptor;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.SystemException;
import com.fanyin.ext.RespBody;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 全局统一异常处理器,返回前台的数据格式由ReturnJson包装
 * @author 二哥很猛
 * @date 2018/1/18 16:20
 */
@ControllerAdvice
@Slf4j
public class ControllerExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public RespBody exception(Exception e){
        log.error("controller处理异常",e);
        if (e instanceof SystemException){
            SystemException exception = (SystemException)e;
            return RespBody.<String>getInstance().setCode(exception.getCode()).setMsg(exception.getMessage());
        }
        return RespBody.getInstance().error(ErrorCodeEnum.SYSTEM_ERROR);
    }
}
