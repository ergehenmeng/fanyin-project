package com.fanyin.advice;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.ext.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author 二哥很猛
 * @date 2018/11/29 15:03
 */
@ControllerAdvice
@Slf4j
public class ExceptionHandlerAdvice {


    /**
     * 业务异常统一拦截
     * @param e 异常
     * @return 返回标准对象
     */
    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Response businessException(HttpServletRequest request, BusinessException e){
        log.error("业务异常地址:{}",request.getRequestURI());
        log.error("业务异常",e);
        return Response.getInstance().setCode(e.getCode()).setMsg(e.getMessage());
    }

    /**
     * 系统级异常统一拦截
     * @param e 异常
     * @return 返回标准对象
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Response exception(HttpServletRequest request,Exception e){
        log.error("系统异常地址:{}",request.getRequestURI());
        log.error("系统异常",e);
        return Response.getInstance().error(ErrorCodeEnum.SYSTEM_ERROR);
    }
}
