package com.fanyin.configuration.security;

import com.fanyin.ext.ResultJson;
import com.fanyin.inteceptor.GlobalExceptionHandler;
import com.fanyin.utils.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * 校验失败处理方式 直接返回前台json
 * @author 二哥很猛
 * @date 2018/1/25 18:21
 */
public class LoginFailureHandler implements AuthenticationFailureHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(SystemAuthenticationException.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        if (exception instanceof SystemAuthenticationException){
            SystemAuthenticationException exc = (SystemAuthenticationException) exception;
            ResultJson<Object> resultJson = ResultJson.getInstance().setCode(exc.getCode()).setMsg(exc.getMessage());
            WebUtils.printJson(response,resultJson);
        }else{
            LOGGER.error("权限校验异常",exception);
            ResultJson<Object> resultJson = ResultJson.getInstance().setCode(GlobalExceptionHandler.CODE).setMsg("权限校验异常,请联系管理人员");
            WebUtils.printJson(response,resultJson);
        }
    }
}
