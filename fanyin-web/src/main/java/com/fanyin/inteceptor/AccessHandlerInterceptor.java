package com.fanyin.inteceptor;

import com.fanyin.constant.HeaderConstant;
import com.fanyin.dto.DataMessage;
import com.fanyin.dto.Token;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.Source;
import com.fanyin.exception.SystemException;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.utils.SignatureUtil;
import com.fanyin.validation.annotation.AccessToken;
import com.fanyin.validation.annotation.Signature;
import com.google.common.collect.Lists;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.annotation.Annotation;

/**
 * 登陆令牌验证,主要用于app,pc等前后端分离
 * @author 二哥很猛
 * @date 2018/1/23 12:02
 */
public class AccessHandlerInterceptor extends HandlerInterceptorAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(AccessHandlerInterceptor.class);

    /**
     * 存放用户信息
     */
    private static final ThreadLocal<DataMessage> TOKEN_LOCAL = new ThreadLocal<>();

    @Autowired
    private AccessTokenService accessTokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){

        String requestType = request.getHeader(HeaderConstant.REQUEST_TYPE);
        String version = request.getHeader(HeaderConstant.VERSION);
        String osVersion = request.getHeader(HeaderConstant.OS_VERSION);
        DataMessage message = new DataMessage(version,requestType,osVersion);
        TOKEN_LOCAL.set(message);

        //文件上传过滤掉
        if(ServletFileUpload.isMultipartContent(request)){
            LOGGER.debug("文件上传请求,不做处理");
            return true;
        }
        //访问来源
        if(!requestType(handler,requestType)){
            LOGGER.error("请求接口非法,requestType:{}",requestType);
            throw new SystemException(ErrorCodeEnum.REQUEST_INTERFACE_ERROR);
        }
        //签名
        if(sign(handler)){
            String timestamp = request.getHeader(HeaderConstant.TIMESTAMP);
            String sign = request.getHeader(HeaderConstant.SIGN);
            signVerify(sign,timestamp);
        }
        //登陆
        if(access(handler)){
            String accessKey = request.getHeader(HeaderConstant.ACCESS_KEY);
            String accessToken = request.getHeader(HeaderConstant.ACCESS_TOKEN);
            accessTokenVerify(accessKey,accessToken,message);
        }
        return true;
    }

    /**
     * 是否需要签名验证
     * @param handler 处理器
     * @return true:需要签名 false:不需要签名
     */
    private boolean sign(Object handler){
        Signature signature = getAnnotation(handler, Signature.class);
        if(signature != null){
            return signature.value();
        }
        return false;
    }

    /**
     * 登陆校验
     * @param accessKey accessKey
     * @param accessToken 令牌
     * @param message 存放用户信息的对象
     */
    private void accessTokenVerify(String accessKey,String accessToken,DataMessage message){
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
        //由于ThreadLocal是对象引用,可以直接设置附加值
        message.setAccessKey(token.getAccessKey());
        message.setAccessToken(token.getAccessToken());
        message.setUserId(token.getUserId());
    }


    /**
     * 校验签名信息,加密方式 sha256(md5(appKey+timestamp)+appKey)
     * @param sign 签名信息
     * @param timestamp 时间戳
     */
    private void signVerify(String sign,String timestamp){
        if(sign == null){
            throw new SystemException(ErrorCodeEnum.SIGN_NULL_ERROR);
        }
        String serverSign = SignatureUtil.sign(timestamp);
        if (sign.equals(serverSign)){
            LOGGER.warn("签名错误,sign:{},timestamp:{}",sign,timestamp);
            throw new SystemException(ErrorCodeEnum.SIGN_ERROR);
        }
    }

    /**
     * 是否需要登陆校验
     * @param handler handlerMethod
     * @return true:需要验签 false不需要
     */
    private boolean access(Object handler){
        AccessToken accessToken = getAnnotation(handler,AccessToken.class);
        if(accessToken != null){
            return accessToken.access();
        }
        return false;
    }

    /**
     * 请求类型判断
     * @param handler 处理器
     * @param requestType 请求类型 header传递过来
     * @return 是否为合法请求
     */
    private boolean requestType(Object handler,String requestType){
        AccessToken accessToken = getAnnotation(handler,AccessToken.class);
        if(accessToken != null){
            Source[] value = accessToken.value();
            return Lists.newArrayList(value).stream().anyMatch(source -> source.name().equals(requestType));
        }
        return true;
    }


    /**
     * 获取handlerMethod上的响应的注解
     * @param handler handlerMethod
     * @param cls 注解类型
     * @return AccessToken
     */
    private  <T extends Annotation> T getAnnotation(Object handler, Class<T> cls){
        if(handler instanceof HandlerMethod){
            HandlerMethod method = (HandlerMethod)handler;
            return method.getMethodAnnotation(cls);
        }
        return null;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
        TOKEN_LOCAL.remove();
    }

    /**
     * 获取线程中的变量
     * @return 线程中保存的对象
     */
    public static DataMessage getMessage(){
        return TOKEN_LOCAL.get();
    }
}
