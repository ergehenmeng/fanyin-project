package com.fanyin.inteceptor;

import com.fanyin.annotation.Access;
import com.fanyin.annotation.GroupAccess;
import com.fanyin.annotation.Signature;
import com.fanyin.constant.HeaderConstant;
import com.fanyin.dto.security.AccessToken;
import com.fanyin.dto.security.DataMessage;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.Source;
import com.fanyin.exception.ParameterException;
import com.fanyin.exception.SystemException;
import com.fanyin.exception.TokenException;
import com.fanyin.service.system.AccessTokenService;
import com.fanyin.utils.SignatureUtil;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.annotation.Annotation;

/**
 * 登陆令牌验证,主要用于app,pc等前后端分离
 * @author 二哥很猛
 * @date 2018/1/23 12:02
 */
@Slf4j
public class AccessHandlerInterceptor extends HandlerInterceptorAdapter {

    /**
     * 存放用户信息
     */
    private static final ThreadLocal<DataMessage> TOKEN_LOCAL = new ThreadLocal<>();

    @Autowired
    private AccessTokenService accessTokenService;

    /**
     * 请求头最大长度 默认256
     */
    private static final int MAX_HEADER_LENGTH = 256;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
        //app请求头信息
        String requestType = request.getHeader(HeaderConstant.REQUEST_TYPE);
        String version = request.getHeader(HeaderConstant.VERSION);
        String osVersion = request.getHeader(HeaderConstant.OS_VERSION);

        if(checkHeaderLength(requestType)
                || checkHeaderLength(version)
                || checkHeaderLength(osVersion)){
            //该信息会保存在Thread中,会占用一定内存,防止恶意攻击做此判断
            throw new SystemException(ErrorCodeEnum.REQUEST_PARAM_ILLEGAL);
        }

        DataMessage message = new DataMessage(version,requestType,osVersion);
        TOKEN_LOCAL.set(message);

        //访问来源
        if(!requestType(handler,requestType)){
            log.error("请求接口非法,requestType:{}",requestType);
            throw new SystemException(ErrorCodeEnum.REQUEST_INTERFACE_ERROR);
        }
        boolean haveGroup = haveGroup(handler);
        //签名
        if(haveGroup || sign(handler)){
            String timestamp = request.getHeader(HeaderConstant.TIMESTAMP);
            String sign = request.getHeader(HeaderConstant.SIGN);
            signVerify(sign,timestamp);
        }
        //登陆
        if(haveGroup || access(handler)){
            String accessKey = request.getHeader(HeaderConstant.ACCESS_KEY);
            String accessToken = request.getHeader(HeaderConstant.ACCESS_TOKEN);
            accessTokenVerify(accessKey,accessToken,message);
        }
        return true;
    }

    /**
     * 检查header请求参数是否过长,防止恶意攻击导致服务器挂掉,最大长度不能超过256
     * @param headerValue 字符串
     * @return true不合法 false合法
     */
    private boolean checkHeaderLength(String headerValue){
        return headerValue != null && headerValue.length() > MAX_HEADER_LENGTH;
    }


    /**
     * 是否需要签名验证
     * @param handler 处理器
     * @return true:需要签名 false:不需要签名
     */
    private boolean sign(Object handler){
        Signature signature = getAnnotation(handler, Signature.class);
        return signature != null;
    }

    /**
     * 是否包含组合注解
     * @param handler 处理器
     * @return true:包含 false:包含
     */
    private boolean haveGroup(Object handler){
        return getAnnotation(handler,GroupAccess.class) != null;
    }

    /**
     * 登陆校验
     * @param accessKey accessKey
     * @param accessToken 令牌
     * @param message 存放用户信息的对象
     */
    private void accessTokenVerify(String accessKey,String accessToken,DataMessage message){
        if (accessKey == null || accessToken == null){
            log.error("令牌为空,accessKey:{},accessToken:{}",accessKey,accessToken);
            throw new ParameterException(ErrorCodeEnum.REQUEST_PARAM_ILLEGAL);
        }
        AccessToken token = accessTokenService.getAccessToken(accessKey);
        if (token == null || !accessToken.equals(token.getAccessToken())){
            log.error("令牌无效,accessKey:{}",accessKey);
            throw new ParameterException(ErrorCodeEnum.ACCESS_TOKEN_TIMEOUT);
        }
        token.setSource(message.getSource());
        //重新放入刷新超时时间
        accessTokenService.saveAccessToken(token);
        //由于ThreadLocal是对象引用,可以直接设置附加值
        message.setAccessKey(token.getAccessKey());
        message.setAccessToken(token.getAccessToken());
        message.setUserId(token.getUserId());
    }


    /**
     * 校验签名信息
     * @param sign 签名信息
     * @param timestamp 时间戳
     */
    private void signVerify(String sign,String timestamp){
        if(sign == null){
            throw new TokenException(ErrorCodeEnum.SIGN_NULL_ERROR);
        }
        String serverSign = SignatureUtil.sign(timestamp);
        if (sign.equals(serverSign)){
            log.warn("签名错误,sign:{},timestamp:{}",sign,timestamp);
            throw new TokenException(ErrorCodeEnum.SIGN_ERROR);
        }
    }

    /**
     * 是否需要登陆校验
     * @param handler handlerMethod
     * @return true:需要验签 false不需要
     */
    private boolean access(Object handler){
        Access accessToken = getAnnotation(handler,Access.class);
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
        Access accessToken = getAnnotation(handler,Access.class);
        if(accessToken != null){
            Source[] value = accessToken.value();
            return Lists.newArrayList(value).stream().anyMatch(source -> source.name().equals(requestType));
        }
        return true;
    }


    /**
     * 获取handlerMethod上指定类型的注解,如果类上有也会返回
     * @param handler handlerMethod
     * @param cls 注解类型
     * @return AccessToken
     */
    private  <T extends Annotation> T getAnnotation(Object handler, Class<T> cls){
        if(handler instanceof HandlerMethod){
            HandlerMethod method = (HandlerMethod)handler;
            T t = method.getMethodAnnotation(cls);
            return t != null ? t : method.getBeanType().getAnnotation(cls);
        }
        return null;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
        TOKEN_LOCAL.remove();
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
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
