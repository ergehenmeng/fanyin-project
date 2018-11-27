package com.fanyin.controller;


import com.fanyin.configuration.security.SecurityOperator;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpSession;

/**
 * @author 二哥很猛
 */
@Slf4j
public class AbstractController {

    /**
     * 存放session
     * @param session session对象对象
     * @param key sessionKey
     * @param value session值
     */
    protected void putSession(HttpSession session, String key, Object value){
        session.setAttribute(key,value);
    }

    /**
     * 获取当前用户登陆的系统管理人员
     * @return 系统登陆的用户
     */
    protected SecurityOperator getOperator(){
        SecurityContext context = SecurityContextHolder.getContext();
        Object details = context.getAuthentication().getPrincipal();
        if(details != null){
            return (SecurityOperator)details;
        }
        return null;
    }

    /**
     * 获取当前登陆的系统管理人员,找不到抛异常
     * @return 系统用户
     */
    protected SecurityOperator getRequiredOperator(){
        SecurityOperator operator = getOperator();
        if(operator == null){
            throw new BusinessException(ErrorCodeEnum.OPERATOR_TIMEOUT);
        }
        return operator;
    }


}
