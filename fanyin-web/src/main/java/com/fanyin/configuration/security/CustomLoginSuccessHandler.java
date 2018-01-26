package com.fanyin.configuration.security;

import com.fanyin.ext.ResultJson;
import com.fanyin.utils.IpUtils;
import com.fanyin.utils.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: 登陆校验通过的后置处理器
 * @author: 二哥很猛
 * @date: 2018/1/25
 * @time: 10:28
 */
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
        super.clearAuthenticationAttributes(request);
        SecurityOperator principal = (SecurityOperator)authentication.getPrincipal();
        LOGGER.info("用户:[{}]登陆系统,登陆IP:[{}]",principal.getName(), IpUtils.getIpAddress(request));
        WebUtils.printJson(response, ResultJson.getInstance());
    }
}
