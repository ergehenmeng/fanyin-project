package com.fanyin.inteceptor;

import com.fanyin.constant.HeaderConstant;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.Source;
import com.fanyin.exception.SystemException;
import com.fanyin.model.system.Token;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.validation.annotation.AccessToken;
import com.google.common.collect.Lists;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登陆
 * @author 二哥很猛
 * @date 2018/1/23 12:02
 */
public class AccessHandlerInterceptor extends HandlerInterceptorAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(AccessHandlerInterceptor.class);

    @Autowired
    private AccessTokenService accessTokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //文件上传过滤掉
        if(ServletFileUpload.isMultipartContent(request)){
            LOGGER.debug("文件上传请求,不做处理");
            return true;
        }
        String requestType = request.getHeader(HeaderConstant.REQUEST_TYPE);
        if(!requestType(handler,requestType)){
            LOGGER.error("请求接口非法,requestType:{}",requestType);
            throw new SystemException(ErrorCodeEnum.REQUEST_INTERFACE_ERROR);
        }
        if(!access(handler)){
            LOGGER.debug("请求接口不需要验签");
            return true;
        }

        String accessKey = request.getHeader(HeaderConstant.ACCESS_KEY);

        String accessToken = request.getHeader(HeaderConstant.ACCESS_TOKEN);

        accessToken(accessKey,accessToken);

        return true;
    }


    /**
     * 校验请求登陆是否合法
     * @param accessKey accessKey
     * @param accessToken 令牌
     */
    private void accessToken(String accessKey,String accessToken){
        if (accessKey == null || accessToken == null){
            LOGGER.error("令牌为空,accessKey:{},accessToken:{}",accessKey,accessToken);
            throw new SystemException(ErrorCodeEnum.REQUEST_PARAM_ILLEGAL);
        }
        Token token = accessTokenService.getToken(accessKey);
        if (token == null || !accessToken.equals(token.getAccessToken())){
            LOGGER.error("令牌无效,accessKey:{}",accessKey);
            throw new SystemException(ErrorCodeEnum.ACCESS_TOKEN_TIMEOUT);
        }
        //重新放入刷新超时时间
        accessTokenService.saveToken(token);
    }

    /**
     * 是否需要登陆验签
     * @param handler handlerMethod
     * @return true:需要验签 false不需要
     */
    private boolean access(Object handler){
        AccessToken accessToken = getAccessToken(handler);
        if(accessToken != null){
            return accessToken.access();
        }
        return true;
    }

    /**
     * 请求类型判断
     * @param handler 处理器
     * @param requestType 请求类型 header传递过来
     * @return 是否为合法请求
     */
    private boolean requestType(Object handler,String requestType){
        AccessToken accessToken = getAccessToken(handler);
        if(accessToken != null){
            Source[] value = accessToken.value();
            return Lists.newArrayList(value).stream().anyMatch(source -> source.name().equals(requestType));
        }
        return true;
    }


    /**
     * 获取handlerMethod上的AccessToken注解
     * @param handler handlerMethod
     * @return AccessToken
     */
    private AccessToken getAccessToken(Object handler){
        if(handler instanceof HandlerMethod){
            HandlerMethod method = (HandlerMethod)handler;
            return method.getMethodAnnotation(AccessToken.class);
        }
        return null;
    }
}
