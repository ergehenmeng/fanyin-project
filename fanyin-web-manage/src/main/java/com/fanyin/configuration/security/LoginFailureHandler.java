package com.fanyin.configuration.security;

import com.fanyin.constant.CommonConstant;
import com.fanyin.ext.ReturnJson;
import com.fanyin.utils.WebUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * 校验失败处理方式 直接返回前台json
 * @author 二哥很猛
 * @date 2018/1/25 18:21
 */
@Slf4j
public class LoginFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException{
        if (exception instanceof SystemAuthenticationException){
            SystemAuthenticationException exc = (SystemAuthenticationException) exception;
            ReturnJson<Object> returnJson = ReturnJson.getInstance().setCode(exc.getCode()).setMsg(exc.getMessage());
            WebUtil.printJson(response, returnJson);
        }else{
            log.error("权限校验异常",exception);
            ReturnJson<Object> returnJson = ReturnJson.getInstance().setCode(CommonConstant.CODE).setMsg("权限校验异常,请联系管理人员");
            WebUtil.printJson(response, returnJson);
        }
    }
}
